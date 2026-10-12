// usage: node render.js A|B outdir [poseList comma-separated]
const {chromium}=require('/opt/node22/lib/node_modules/playwright');
const path=require('path');
(async()=>{
  const scene=process.argv[2], out=process.argv[3];
  const total = scene==='A'?72:60;
  const list = process.argv[4] ? process.argv[4].split(',').map(Number) : [...Array(total).keys()];
  const b=await chromium.launch({args:['--allow-file-access-from-files']});
  const p=await b.newPage({viewport:{width:1640,height:1120}});
  await p.goto('file://'+path.resolve(__dirname,'index.html'));
  await p.evaluate(async()=>{await document.fonts.load('800 60px Montserrat','ауд. № 0123456789 БИЛЕТЫ CPU ?');await document.fonts.ready;});
  const fonts=await p.evaluate(()=>[...document.fonts].filter(f=>f.status==='loaded').map(f=>f.family+' '+f.weight+' '+f.unicodeRange.slice(0,12)));
  console.log('loaded fonts:',fonts.join(' | '));
  for(const i of list){
    await p.evaluate(([s,t])=>window.drawScene(s,t),[scene,i/12]);
    await p.evaluate(()=>new Promise(r=>requestAnimationFrame(()=>requestAnimationFrame(r))));
    await p.screenshot({path:path.join(out,'p'+String(i).padStart(3,'0')+'.png'),clip:{x:0,y:0,width:1640,height:1120}});
  }
  await b.close();
})();
