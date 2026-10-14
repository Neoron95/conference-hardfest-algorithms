// Step 2A. Per-click layers: build/A/NN-base.png (static), NN-L<k>.png (click k), NN-O<k>.png (drawn above a video), NN-final.png.
// Elements with data-build-out="fade M" go to their own layer NN-L<k>x<M>.png (NN-O<k>x<M>.png) that fades out on click M.
const {chromium}=require('./pw.js')();const fs=require('fs');const path=require('path');
const B=path.join(__dirname,'build');const OUT=path.join(B,'A');fs.mkdirSync(OUT,{recursive:true});
(async()=>{const pages=JSON.parse(fs.readFileSync(path.join(B,'pages.json'),'utf8'));
const b=await chromium.launch({args:['--allow-file-access-from-files']});const p=await b.newPage({viewport:{width:1920,height:1080}});
const res=[];const nn=n=>String(n).padStart(2,'0');
for(const pg of pages){
 await p.goto('file://'+pg.page);await p.evaluate(()=>document.fonts.ready);await p.waitForTimeout(250);
 const info=await p.evaluate(()=>{const sec=document.querySelector('section');const kids=[...sec.children].filter(e=>e.tagName!=='ASIDE');
  const R=e=>{const r=e.getBoundingClientRect();return {x:r.left,y:r.top,w:r.width,h:r.height}};
  const hit=(a,c)=>a.x<c.x+c.w&&a.x+a.w>c.x&&a.y<c.y+c.h&&a.y+a.h>c.y;
  const items=kids.map((e,i)=>{const bi=e.getAttribute('data-build-in')||'';const m=bi.match(/(\d+)/);const bo=e.getAttribute('data-build-out')||'';const mo=bo.match(/(\d+)/);
    return {i,order:m?+m[1]:(bi?1:0),auto:/\bauto\b/.test(bi),out:mo?+mo[1]:(bo?1:0),oauto:/\bauto\b/.test(bo),video:e.getAttribute('data-video')||'',poster:e.tagName==='IMG'?e.getAttribute('src'):'',rect:R(e),above:false}});
  const vids=items.filter(t=>t.video);
  for(const t of items){if(t.video)continue;for(const v of vids){if(v.i<t.i&&hit(t.rect,v.rect))t.above=true;}}
  for(const v of vids){const e=kids[v.i];const a=e.naturalWidth/e.naturalHeight;const r=v.rect;let w=r.w,h=r.h;if(r.w/r.h>a){w=r.h*a}else{h=r.w/a};v.fit={x:r.x+(r.w-w)/2,y:r.y+(r.h-h)/2,w,h};}
  return items;});
 const show=async(ids,tr)=>{await p.evaluate(([ids,tr])=>{const sec=document.querySelector('section');const kids=[...sec.children].filter(e=>e.tagName!=='ASIDE');
   kids.forEach((e,i)=>{e.style.visibility=ids.includes(i)?'visible':'hidden'});
   if(tr){if(sec.dataset.bg===undefined)sec.dataset.bg=sec.style.background;sec.style.background='transparent';document.body.style.background='transparent';}
   else{if(sec.dataset.bg!==undefined)sec.style.background=sec.dataset.bg;document.body.style.background='#000';}},[ids,tr]);};
 const layers=[];const f=s=>path.join(OUT,nn(pg.n)+s);
 await show(info.filter(t=>t.order===0&&!t.out&&!t.above&&!t.video).map(t=>t.i),false);await p.screenshot({path:f('-base.png')});layers.push({kind:'base',order:0,file:f('-base.png')});
 const orders=[...new Set(info.filter(t=>t.order>0).map(t=>t.order))].sort((a,b)=>a-b);
 const steps=[...new Set(info.flatMap(t=>[t.order,t.out]).filter(k=>k>0))].sort((a,b)=>a-b);
 // groups (in, out): base is (0,0); everything else is a separate picture, in z-order of the in-step
 const groups=[...new Set(info.filter(t=>!t.video).map(t=>t.order+'x'+t.out))].map(g=>g.split('x').map(Number)).sort((a,b)=>a[0]-b[0]||a[1]-b[1]);
 const sfx=(c,k,o)=>`-${c}${k}${o?'x'+o:''}.png`;
 for(const [k,o] of groups){if(!k&&!o)continue;const ids=info.filter(t=>t.order===k&&t.out===o&&!t.above&&!t.video).map(t=>t.i);if(!ids.length)continue;
   await show(ids,true);await p.screenshot({path:f(sfx('L',k,o)),omitBackground:true});layers.push({kind:'layer',order:k,out:o,file:f(sfx('L',k,o))});}
 for(const [k,o] of groups){const ids=info.filter(t=>t.order===k&&t.out===o&&t.above&&!t.video).map(t=>t.i);if(!ids.length)continue;
   await show(ids,true);await p.screenshot({path:f(sfx('O',k,o)),omitBackground:true});layers.push({kind:'over',order:k,out:o,file:f(sfx('O',k,o))});}
 await show(info.map(t=>t.i),false);await p.screenshot({path:f('-final.png')});
 res.push({n:pg.n,id:pg.id,layers,final:f('-final.png'),steps:steps.map(k=>({order:k,auto:info.filter(t=>t.order===k).every(t=>t.auto)&&info.filter(t=>t.out===k).every(t=>t.oauto)})),
   videos:info.filter(t=>t.video).map(t=>({order:t.order,video:t.video,poster:decodeURIComponent(t.poster.replace('file://','')),fit:t.fit}))});
}
fs.writeFileSync(path.join(OUT,'layers.json'),JSON.stringify(res,null,1));await b.close();console.log('layers',res.length);})();
