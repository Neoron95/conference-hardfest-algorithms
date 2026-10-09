// A static emergency version of the same 26-slide HTML source.
const fs=require('fs'),path=require('path');
const {chromium}=require('playwright');
const root=path.resolve(__dirname,'..',process.env.HARDFEST_DECK || 'hardfest');
const deck=JSON.parse(fs.readFileSync(path.join(root,'deck.json')));
const out=path.resolve(process.argv[2]||path.join(root,'../hardfest2026_deck.pdf'));
const work=process.env.PPTX_WORK||'/tmp/hardfest-pptx';
(async()=>{
 const browser=await chromium.launch(process.env.CHROME_PATH?{executablePath:process.env.CHROME_PATH}:{});
 const page=await browser.newPage({viewport:{width:1920,height:1080},deviceScaleFactor:1});
 const css=fs.readFileSync(path.join(root,'hf.css'),'utf8');
 let slides='';
 for(const [i,id] of deck.order.slice(0,deck.mainCount).entries()){
  let s=fs.readFileSync(path.join(root,'slides',id+'.html'),'utf8').replace(/<aside>[\s\S]*?<\/aside>/,'');
  s=s.replace(/<video([^>]*)><\/video>/g,(_,attrs)=>{const poster=attrs.match(/poster="([^"]+)"/)?.[1];const style=attrs.match(/style="([^"]+)"/)?.[1];return `<img src="${poster}" style="${style}" alt="Статичный кадр анимации">`;});
  s=s.replace(/(src=")\.\.\/assets\//g,'$1file://'+path.join(root,'assets')+'/');
  const big=/data-logo="big"/.test(s),lg=big?'left:1436px;top:127px;width:380px;height:131px':'left:1586px;top:144px;width:230px;height:79px';
  const frame=`<img src="file://${path.join(root,'assets/hardfest_logo.png')}" style="position:absolute;${lg}">${/data-nonum/.test(s)?'':`<p style="position:absolute;left:1760px;top:960px;width:90px;text-align:right;font:400 26.7px Montserrat;color:#EFEFEF">${i+1}</p>`}`;
  slides+=s.replace('</section>',frame+'</section>');
 }
 const title=deck.title.replace(/&/g,'&amp;').replace(/</g,'&lt;');
 const doc=`<!doctype html><html><head><meta charset="utf-8"><title>${title}</title><style>${css}\n@page{size:1920px 1080px;margin:0}html,body{margin:0;padding:0;background:#000}section{break-after:page;page-break-after:always}section:last-child{break-after:auto;page-break-after:auto}*{-webkit-print-color-adjust:exact;print-color-adjust:exact}</style></head><body>${slides}</body></html>`;
 fs.mkdirSync(work,{recursive:true});const tmp=path.join(work,'static-deck.html');fs.writeFileSync(tmp,doc);
 await page.goto('file://'+tmp,{waitUntil:'load'});await page.evaluate(()=>document.fonts.ready);
 await page.pdf({path:out,printBackground:true,preferCSSPageSize:true});
 await browser.close();console.log(out);
})().catch(e=>{console.error(e);process.exitCode=1;});
