const pptxgen=require('pptxgenjs');const fs=require('fs');
const L=JSON.parse(fs.readFileSync('A/layers.json','utf8'));const pages=JSON.parse(fs.readFileSync('pages.json','utf8'));
const durs=JSON.parse(fs.readFileSync('A/durs.json','utf8'));
const pres=new pptxgen();pres.layout='LAYOUT_WIDE';pres.title='O(n) проиграл O(n log n) — HardFest 2026';pres.author='Никита Нагорнов';
const px=v=>v/144;const plan=[];
for(const s of L){
  const sl=pres.addSlide();sl.background={color:'000000'};const shapes=[];const byOrder={};
  const add=(kind,order,extra)=>{shapes.push({kind,order,...extra});const i=shapes.length-1;(byOrder[order]=byOrder[order]||[]).push(i);return i;};
  const base=s.layers.find(l=>l.kind==='base');sl.addImage({path:base.file,x:0,y:0,w:13.333,h:7.5,altText:'Слайд '+s.n});add('base',0);
  for(const l of s.layers.filter(l=>l.kind==='layer'&&!l.empty)){sl.addImage({path:l.cfile,x:px(l.x),y:px(l.y),w:px(l.w),h:px(l.h)});add('pic',l.order);}
  const vids=[];
  for(const v of s.videos){const f=v.fit;sl.addMedia({type:'video',path:v.video,x:px(f.x),y:px(f.y),w:px(f.w),h:px(f.h),cover:'image/png;base64,'+fs.readFileSync(v.poster).toString('base64')});
    const i=add('video',v.order,{dur:durs[v.video]});vids.push(i);}
  for(const l of s.layers.filter(l=>l.kind==='over'&&!l.empty)){sl.addImage({path:l.cfile,x:px(l.x),y:px(l.y),w:px(l.w),h:px(l.h)});add('pic',l.order);}
  const notes=pages.find(p=>p.n===s.n).notes;if(notes)sl.addNotes(notes);
  // blocks
  const blocks=[];
  const v0=shapes.map((x,i)=>[x,i]).filter(([x])=>x.kind==='video'&&x.order===0);
  if(v0.length)blocks.push({auto:true,steps:[v0.map(([x,i])=>['play',i,x.dur])]});
  for(const st of s.steps){const eff=[];
    for(const i of (byOrder[st.order]||[])){const x=shapes[i];eff.push(['fade',i,0]);if(x.kind==='video')eff.push(['play',i,x.dur]);}
    if(!eff.length)continue;
    if(st.auto&&blocks.length)blocks[blocks.length-1].steps.push(eff);else blocks.push({auto:st.auto,steps:[eff]});}
  plan.push({n:s.n,shapes:shapes.map(x=>x.kind),blocks,videos:vids.map(i=>[i,shapes[i].dur]),bld:[]});
}
fs.writeFileSync('A/plan.json',JSON.stringify(plan,null,1));
pres.writeFile({fileName:'A/raw.pptx'}).then(f=>console.log('wrote',f));
