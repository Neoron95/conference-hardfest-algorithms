// Step 4A. Variant "clicks": layered pictures + videos -> build/A/raw.pptx and build/A/plan.json (animation plan for post.py).
// Env: MAXN=39 keeps only the first N slides, NONOTES=1 drops speaker notes, OUT=build/AP output dir.
const pptxgen=require('pptxgenjs');const fs=require('fs');const path=require('path');
const B=path.join(__dirname,'build');const MAXN=+(process.env.MAXN||999),NONOTES=!!process.env.NONOTES,OUT=path.resolve(process.env.OUT||path.join(B,'A'));fs.mkdirSync(OUT,{recursive:true});
const L=JSON.parse(fs.readFileSync(path.join(B,'A/layers.json'),'utf8')).filter(s=>s.n<=MAXN);
const pages=JSON.parse(fs.readFileSync(path.join(B,'pages.json'),'utf8'));const durs=JSON.parse(fs.readFileSync(path.join(B,'durs.json'),'utf8'));
const pres=new pptxgen();pres.layout='LAYOUT_WIDE';pres.title='O(n) проиграл O(n log n) — HardFest 2026';pres.author='Никита Нагорнов';
const px=v=>v/144;const plan=[];
for(const s of L){
  const sl=pres.addSlide();sl.background={color:'000000'};const shapes=[];const byOrder={};
  const byOut={};
  const add=(kind,order,extra)=>{shapes.push({kind,order,...extra});const i=shapes.length-1;(byOrder[order]=byOrder[order]||[]).push(i);
    if(extra&&extra.out)(byOut[extra.out]=byOut[extra.out]||[]).push(i);return i;};
  const base=s.layers.find(l=>l.kind==='base');sl.addImage({path:base.file,x:0,y:0,w:13.333,h:7.5,altText:'Слайд '+s.n});add('base',0);
  for(const l of s.layers.filter(l=>l.kind==='layer'&&!l.empty)){sl.addImage({path:l.cfile,x:px(l.x),y:px(l.y),w:px(l.w),h:px(l.h),altText:`Слайд ${s.n} · шаг ${l.order}`});add('pic',l.order,{out:l.out||0});}
  const vids=[];
  for(const v of s.videos){const f=v.fit;sl.addMedia({type:'video',path:v.video,x:px(f.x),y:px(f.y),w:px(f.w),h:px(f.h),cover:'image/png;base64,'+fs.readFileSync(v.poster).toString('base64')});
    vids.push(add('video',v.order,{dur:durs[v.video]||5000}));}
  for(const l of s.layers.filter(l=>l.kind==='over'&&!l.empty)){sl.addImage({path:l.cfile,x:px(l.x),y:px(l.y),w:px(l.w),h:px(l.h),altText:`Слайд ${s.n} · подписи поверх видео`});add('pic',l.order,{out:l.out||0});}
  const notes=pages.find(p=>p.n===s.n).notes;if(notes&&!NONOTES)sl.addNotes(notes);
  const blocks=[];const v0=vids.filter(i=>shapes[i].order===0);
  if(v0.length)blocks.push({auto:true,steps:[v0.map(i=>['play',i,shapes[i].dur])]});
  for(const st of s.steps){const eff=[];
    for(const i of (byOrder[st.order]||[])){eff.push(['fade',i,0]);if(shapes[i].kind==='video')eff.push(['play',i,shapes[i].dur]);}
    for(const i of (byOut[st.order]||[]))eff.push(['out',i,0]);
    if(!eff.length)continue;
    if(st.auto&&blocks.length)blocks[blocks.length-1].steps.push(eff);else blocks.push({auto:st.auto,steps:[eff]});}
  plan.push({n:s.n,shapes:shapes.map(x=>x.kind),blocks,videos:vids.map(i=>[i,shapes[i].dur]),bld:[]});
}
fs.writeFileSync(path.join(OUT,'plan.json'),JSON.stringify(plan));
pres.writeFile({fileName:path.join(OUT,'raw.pptx')}).then(f=>console.log('wrote',f));
