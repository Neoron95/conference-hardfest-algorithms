const {chromium}=require('/opt/node22/lib/node_modules/playwright');const fs=require('fs');
(async()=>{const pages=JSON.parse(fs.readFileSync('pages.json','utf8'));const OUT='A/';
const b=await chromium.launch({args:['--allow-file-access-from-files']});const p=await b.newPage({viewport:{width:1920,height:1080}});
const res=[];
for(const pg of pages){
 await p.goto('file://'+pg.page);await p.evaluate(()=>document.fonts.ready);await p.waitForTimeout(250);
 const info=await p.evaluate(()=>{const sec=document.querySelector('section');const kids=[...sec.children].filter(e=>e.tagName!=='ASIDE');
  const R=e=>{const r=e.getBoundingClientRect();return {x:r.left,y:r.top,w:r.width,h:r.height}};
  const hit=(a,c)=>a.x<c.x+c.w&&a.x+a.w>c.x&&a.y<c.y+c.h&&a.y+a.h>c.y;
  const items=kids.map((e,i)=>{const bi=e.getAttribute('data-build-in')||'';const m=bi.match(/(\d+)/);
    return {i,tag:e.tagName,order:m?+m[1]:(bi?1:0),auto:/\bauto\b/.test(bi),effect:bi.split(' ')[0]||'',video:e.getAttribute('data-video')||'',poster:e.tagName==='IMG'?e.getAttribute('src'):'',rect:R(e),above:false}});
  const vids=items.filter(t=>t.video);
  for(const t of items){ if(t.video) continue; for(const v of vids){ if(v.i<t.i && hit(t.rect,v.rect)) t.above=true; } }
  // object-fit contain rect for videos
  for(const v of vids){const e=kids[v.i];const nw=e.naturalWidth,nh=e.naturalHeight;const r=v.rect;const a=nw/nh;let w=r.w,h=r.h;if(r.w/r.h>a){w=r.h*a}else{h=r.w/a};v.fit={x:r.x+(r.w-w)/2,y:r.y+(r.h-h)/2,w,h};}
  return items;});
 const kidsSel='section > *:not(aside)';
 const show=async(pred,transparent)=>{await p.evaluate(([ids,tr])=>{const sec=document.querySelector('section');const kids=[...sec.children].filter(e=>e.tagName!=='ASIDE');
   kids.forEach((e,i)=>{e.style.visibility=ids.includes(i)?'visible':'hidden'});
   if(tr){sec.dataset.bg=sec.dataset.bg||sec.style.background;sec.style.background='transparent';document.body.style.background='transparent';}
   else{if(sec.dataset.bg!==undefined)sec.style.background=sec.dataset.bg;document.body.style.background='#000';}},[pred,transparent]);};
 const layers=[];
 const base=info.filter(t=>t.order===0&&!t.above&&!t.video).map(t=>t.i);
 await show(base,false);const bf=OUT+String(pg.n).padStart(2,'0')+'-base.png';await p.screenshot({path:bf});
 layers.push({kind:'base',order:0,file:bf});
 const orders=[...new Set(info.filter(t=>t.order>0).map(t=>t.order))].sort((a,b)=>a-b);
 for(const k of orders){const ids=info.filter(t=>t.order===k&&!t.above&&!t.video).map(t=>t.i);if(!ids.length)continue;
   await show(ids,true);const f=OUT+String(pg.n).padStart(2,'0')+`-L${k}.png`;await p.screenshot({path:f,omitBackground:true});layers.push({kind:'layer',order:k,file:f});}
 for(const k of [0,...orders]){const ids=info.filter(t=>t.order===k&&t.above&&!t.video).map(t=>t.i);if(!ids.length)continue;
   await show(ids,true);const f=OUT+String(pg.n).padStart(2,'0')+`-O${k}.png`;await p.screenshot({path:f,omitBackground:true});layers.push({kind:'over',order:k,file:f});}
 await show(info.map(t=>t.i),false);const ff=OUT+String(pg.n).padStart(2,'0')+'-final.png';await p.screenshot({path:ff});
 const steps=orders.map(k=>({order:k,auto:info.filter(t=>t.order===k).every(t=>t.auto)}));
 res.push({n:pg.n,id:pg.id,layers,final:ff,steps,videos:info.filter(t=>t.video).map(t=>({order:t.order,video:t.video,poster:t.poster.replace('file://',''),fit:t.fit,auto:t.auto}))});
}
fs.writeFileSync('A/layers.json',JSON.stringify(res,null,1));await b.close();console.log('ok',res.length);})();
