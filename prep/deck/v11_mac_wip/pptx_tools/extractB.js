// Step 2B. Editable variant: text runs per line, boxes, borders, rasters (img/svg at 2x) -> build/B/prims.json
const {chromium}=require('./pw.js')();const fs=require('fs');const path=require('path');
const B=path.join(__dirname,'build');fs.mkdirSync(path.join(B,'B'),{recursive:true});
(async()=>{const pages=JSON.parse(fs.readFileSync(path.join(B,'pages.json'),'utf8'));
const b=await chromium.launch({args:['--allow-file-access-from-files']});
const p=await b.newPage({viewport:{width:1920,height:1080},deviceScaleFactor:2});
const all=[];
for(const pg of pages){
 await p.goto('file://'+pg.page);await p.evaluate(()=>document.fonts.ready);await p.waitForTimeout(250);
 const prim=await p.evaluate(()=>{
  const sec=document.querySelector('section');
  const kids=[...sec.children].filter(e=>e.tagName!=='ASIDE');
  const R=e=>{const r=e.getBoundingClientRect();return {x:r.left,y:r.top,w:r.width,h:r.height}};
  const isBlock=e=>{const d=getComputedStyle(e).display;return d!=='inline'};
  const out=[];let rid=0;
  const col=c=>c;
  function boxOf(el,group){
    const cs=getComputedStyle(el);const r=R(el);
    const bw=['Top','Right','Bottom','Left'].map(s=>({w:parseFloat(cs['border'+s+'Width'])||0,c:cs['border'+s+'Color'],s:cs['border'+s+'Style']}));
    const bg=cs.backgroundColor;const hasBg=bg&&!/rgba\(\d+, \d+, \d+, 0\)/.test(bg)&&bg!=='transparent';
    const vis=bw.filter(x=>x.w>0&&x.s!=='none'&&!/, 0\)$/.test(x.c));
    if(!hasBg&&!vis.length)return;
    out.push({type:'box',group,rect:r,bg:hasBg?bg:null,borders:bw,radius:parseFloat(cs.borderTopLeftRadius)||0,opacity:parseFloat(cs.opacity)});
  }
  function textOf(el,group){
    const cs=getComputedStyle(el);
    const chars=[];
    const tw=document.createTreeWalker(el,NodeFilter.SHOW_TEXT|NodeFilter.SHOW_ELEMENT,{acceptNode(n){if(n.nodeType===1){if(n!==el&&isBlock(n))return NodeFilter.FILTER_REJECT;return NodeFilter.FILTER_SKIP;}return NodeFilter.FILTER_ACCEPT;}});
    let n;const rg=document.createRange();
    while(n=tw.nextNode()){const pcs=getComputedStyle(n.parentElement);
      const st={ff:pcs.fontFamily,fw:pcs.fontWeight,fs:parseFloat(pcs.fontSize),fst:pcs.fontStyle,c:pcs.color,ls:pcs.letterSpacing,tt:pcs.textTransform,dec:pcs.textDecorationLine};
      for(let i=0;i<n.data.length;i++){rg.setStart(n,i);rg.setEnd(n,i+1);const rs=rg.getClientRects();if(!rs.length)continue;const q=rs[0];
        if(q.width===0&&/\s/.test(n.data[i]))continue;
        chars.push({ch:n.data[i],x:q.left,r:q.right,t:q.top,h:q.height,st});}}
    if(!chars.some(c=>!/\s/.test(c.ch)))return;
    const pad=k=>parseFloat(cs['padding'+k])||0, bd=k=>parseFloat(cs['border'+k+'Width'])||0;
    const r=R(el);
    const content={x:r.x+pad('Left')+bd('Left'),y:r.y+pad('Top')+bd('Top'),w:r.w-pad('Left')-pad('Right')-bd('Left')-bd('Right'),h:r.h-pad('Top')-pad('Bottom')-bd('Top')-bd('Bottom')};
    out.push({type:'text',group,rect:r,content,align:cs.textAlign,lh:cs.lineHeight,fs:parseFloat(cs.fontSize),ws:cs.whiteSpace,chars});
  }
  function walk(el,group){
    const cs=getComputedStyle(el);if(cs.display==='none')return;
    const tag=el.tagName.toLowerCase();
    if(tag==='img'||tag==='svg'||cs.transform!=='none'){const id='r'+(rid++);el.dataset.rid=id;
      out.push({type:el.hasAttribute('data-video')?'video':'raster',group,rid:id,rect:R(el),video:el.getAttribute('data-video')||'',poster:tag==='img'?el.getAttribute('src'):'',alt:(el.getAttribute('alt')||el.getAttribute('aria-label')||'').slice(0,250),nw:el.naturalWidth||0,nh:el.naturalHeight||0,fit:getComputedStyle(el).objectFit});return;}
    boxOf(el,group);textOf(el,group);
    for(const c of el.children){if(isBlock(c))walk(c,group);}
  }
  kids.forEach((e,i)=>{const bi=e.getAttribute('data-build-in')||'';const m=bi.match(/(\d+)/);const bo=e.getAttribute('data-build-out')||'';const mo=bo.match(/(\d+)/);
    walk(e,{order:m?+m[1]:(bi?1:0),auto:/\bauto\b/.test(bi),out:mo?+mo[1]:(bo?1:0),oauto:/\bauto\b/.test(bo),kid:i});});
  return {bg:getComputedStyle(sec).backgroundColor,prims:out};});
 // raster captures
 for(const pr of prim.prims.filter(x=>x.type==='raster')){
   await p.evaluate(rid=>{document.querySelectorAll('section *').forEach(e=>e.style.visibility='hidden');const t=document.querySelector(`[data-rid="${rid}"]`);t.style.visibility='visible';t.querySelectorAll('*').forEach(e=>e.style.visibility='visible');
     const s=document.querySelector('section');s.dataset.bg=s.dataset.bg||s.style.background;s.style.background='transparent';document.body.style.background='transparent';},pr.rid);
   const r=pr.rect;const clip={x:Math.max(0,Math.floor(r.x)-2),y:Math.max(0,Math.floor(r.y)-2)};clip.width=Math.min(1920,Math.ceil(r.x+r.w)+2)-clip.x;clip.height=Math.min(1080,Math.ceil(r.y+r.h)+2)-clip.y;
   const f=path.join(B,'B',`${String(pg.n).padStart(2,'0')}-${pr.rid}.png`);await p.screenshot({path:f,clip,omitBackground:true});pr.file=f;pr.clip=clip;
 }
 all.push({n:pg.n,id:pg.id,notes:pg.notes,...prim});
}
fs.writeFileSync(path.join(B,'B/prims.json'),JSON.stringify(all));await b.close();
const c={};for(const s of all)for(const x of s.prims)c[x.type]=(c[x.type]||0)+1;console.log('ok',all.length,c);})();
