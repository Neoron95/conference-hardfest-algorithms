// builds contact-A.png, contact-B.png and preview-slide.png in ../
const {chromium}=require('/opt/node22/lib/node_modules/playwright');
const path=require('path'), fs=require('fs');
const W=__dirname, OUT=path.resolve(W,'..');
const css='<link rel="stylesheet" href="../../../fonts/local.css">';
const fmt=t=>t.toFixed(2).replace('.',',');
const sheets={
 A:{title:'Сцена A — «в бенчмарке» · петля 6 с · 12 поз/с', picks:[
  [0,'постер: держит билет, рука поднята, ✓'],[12,'показывает «№ 7» крупно'],[19,'мгновенный ответ: ✓ и искорки'],
  [32,'контроль: табличка 101 → 205'],[36,'пересаживается за другую парту'],[43,'на новом месте снова сразу ✓'],
  [55,'билет возвращается в веер'],[64,'табличка снова 101, прыжок назад']]},
 B:{title:'Сцена B — «у пользователя» · петля 5 с · 12 поз/с', picks:[
  [0,'постер: разные номера, растерян'],[4,'тасует веер'],[12,'тянет «№ 41»'],[20,'«№ 41» крупно, облачко появляется'],
  [30,'думает: «…», капля стекает, глаза бегают'],[40,'всё ещё думает'],[48,'медленно — маленькая розовая ✓'],[57,'возврат к началу']]},
};
(async()=>{
 const b=await chromium.launch({args:['--allow-file-access-from-files']});
 for(const S of ['A','B']){
  const sh=sheets[S];
  const cells=sh.picks.map(([p,c])=>`<figure><img src="${S}/p${String(p).padStart(3,'0')}.png"><figcaption><b>${fmt(p/12)} с</b> · кадр ${Math.ceil(p*30/12)} — ${c}</figcaption></figure>`).join('');
  const html=`<!doctype html><html><head><meta charset="utf-8">${css}<style>
   body{margin:0;background:#141414;color:#eee;font-family:Montserrat;width:2000px;padding:28px 32px 20px;box-sizing:border-box}
   h1{font-size:30px;font-weight:800;margin:0 0 18px;color:${S==='A'?'#46CDAE':'#E2489B'}}
   .g{display:grid;grid-template-columns:repeat(4,1fr);gap:18px}
   figure{margin:0}img{width:100%;display:block;border:1px solid #333;background:#000}
   figcaption{font-size:17px;font-weight:600;margin-top:7px;line-height:1.3;color:#ddd}b{color:#F2C14E}
   </style></head><body><h1>${sh.title}</h1><div class="g">${cells}</div></body></html>`;
  fs.writeFileSync(path.join(W,'_sheet.html'),html);
  const p=await b.newPage({viewport:{width:2000,height:600}});
  await p.goto('file://'+path.join(W,'_sheet.html'));
  await p.evaluate(async()=>{await document.fonts.ready;});
  await p.waitForTimeout(200);
  await p.screenshot({path:path.join(OUT,`contact-${S}.png`),fullPage:true});
  await p.close();
 }
 // slide mock-up 1920x1080
 const logo='../../../assets261/b6170d036281930c1b9e04ec86d5f8b0.png';
 const html=`<!doctype html><html><head><meta charset="utf-8">${css}<style>
  body{margin:0;background:#000;width:1920px;height:1080px;position:relative;overflow:hidden;color:#fff}
  .a{position:absolute;margin:0}
 </style></head><body>
 <h2 class="a" style="left:117px;top:103px;width:1424px;font-family:Montserrat;font-size:58.67px;font-weight:800;line-height:65.71px">ВЫУЧИЛ ОДИН БИЛЕТ</h2>
 <img class="a" src="${logo}" style="left:1586px;top:144px;width:230px;height:79px;object-fit:contain">
 <p class="a" style="left:117px;top:262px;width:820px;font-family:'JetBrains Mono';font-size:42px;font-weight:700;line-height:50.4px;text-align:center;color:#46CDAE">в бенчмарке</p>
 <p class="a" style="left:983px;top:262px;width:820px;font-family:'JetBrains Mono';font-size:42px;font-weight:700;line-height:50.4px;text-align:center;color:#E2489B">у пользователя</p>
 <img class="a" src="../v1-exam-A.png" style="left:117px;top:310px;width:820px;height:560px;object-fit:contain">
 <img class="a" src="../v1-exam-B.png" style="left:983px;top:310px;width:820px;height:560px;object-fit:contain">
 <p class="a" style="left:117px;top:890px;width:1686px;font-family:Montserrat;font-size:35px;font-weight:700;line-height:44px;color:#F2C14E">Один вход на все прогоны — в 2,2 раза лучше правды</p>
 </body></html>`;
 fs.writeFileSync(path.join(W,'_slide.html'),html);
 const p=await b.newPage({viewport:{width:1920,height:1080}});
 await p.goto('file://'+path.join(W,'_slide.html'));
 await p.evaluate(async()=>{await document.fonts.load('700 42px "JetBrains Mono"','в бенчмарке у пользователя');await document.fonts.load('800 58px Montserrat','ВЫУЧИЛ');await document.fonts.ready;});
 const chk=await p.evaluate(()=>[document.fonts.check('700 42px "JetBrains Mono"','у пользователя'),document.fonts.check('800 58px Montserrat','ВЫУЧИЛ'),document.fonts.check('700 35px Montserrat','Один')]);
 console.log('fonts ok:',chk.join(','));
 await p.waitForTimeout(300);
 await p.screenshot({path:path.join(OUT,'preview-slide.png')});
 await b.close();
})();
