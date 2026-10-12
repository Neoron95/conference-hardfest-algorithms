const pptxgen=require('pptxgenjs');const fs=require('fs');
const spec=JSON.parse(fs.readFileSync('B/spec.json','utf8'));const durs=JSON.parse(fs.readFileSync('A/durs.json','utf8'));
const pres=new pptxgen();pres.layout='LAYOUT_WIDE';pres.title='O(n) проиграл O(n log n) — HardFest 2026';pres.author='Никита Нагорнов';
pres.theme={headFontFace:'Montserrat',bodyFontFace:'Montserrat'};
const plan=[];
for(const s of spec){
  const sl=pres.addSlide();sl.background={color:s.bg};const kinds=[];
  for(const sh of s.shapes){
    if(sh.t==='rect'||sh.t==='round'){const o={x:sh.x,y:sh.y,w:sh.w,h:sh.h};
      o.fill=sh.fill?{color:sh.fill,transparency:sh.fillT||0}:{type:'none'};
      o.line=sh.line?{color:sh.line,width:sh.lineW,transparency:sh.lineT||0,dashType:sh.dash||'solid'}:{type:'none'};
      if(sh.t==='round')o.rectRadius=sh.rad;
      sl.addShape(sh.t==='round'?pres.ShapeType.roundRect:pres.ShapeType.rect,o);kinds.push('sp');}
    else if(sh.t==='line'){sl.addShape(pres.ShapeType.line,{x:sh.x,y:sh.y,w:sh.w,h:sh.h,line:{color:sh.line,width:sh.lineW,transparency:sh.lineT||0,dashType:sh.dash||'solid'}});kinds.push('sp');}
    else if(sh.t==='text'){sl.addText(sh.runs,{x:sh.x,y:sh.y,w:sh.w,h:sh.h,margin:0,align:sh.align,valign:'top',lineSpacing:sh.ls,paraSpaceBefore:0,paraSpaceAfter:0,wrap:false,fit:'none',isTextBox:true});kinds.push('sp');}
    else if(sh.t==='img'){sl.addImage({path:sh.path,x:sh.x,y:sh.y,w:sh.w,h:sh.h});kinds.push('pic');}
    else if(sh.t==='video'){sl.addMedia({type:'video',path:sh.path,x:sh.x,y:sh.y,w:sh.w,h:sh.h,cover:'image/png;base64,'+fs.readFileSync(sh.poster).toString('base64')});kinds.push('video');}
  }
  if(s.notes)sl.addNotes(s.notes);
  // timing plan
  const byOrder={};s.shapes.forEach((sh,i)=>{(byOrder[sh.g.order]=byOrder[sh.g.order]||[]).push(i)});
  const orders=Object.keys(byOrder).map(Number).filter(k=>k>0).sort((a,b)=>a-b);
  const blocks=[];const vids=[];
  s.shapes.forEach((sh,i)=>{if(sh.t==='video')vids.push([i,durs[sh.path]])});
  const v0=vids.filter(([i])=>s.shapes[i].g.order===0);
  if(v0.length)blocks.push({auto:true,steps:[v0.map(([i,d])=>['play',i,d])]});
  for(const k of orders){const idx=byOrder[k];const auto=idx.every(i=>s.shapes[i].g.auto);const eff=[];
    for(const i of idx){eff.push(['fade',i,0]);if(s.shapes[i].t==='video')eff.push(['play',i,durs[s.shapes[i].path]]);}
    if(auto&&blocks.length)blocks[blocks.length-1].steps.push(eff);else blocks.push({auto,steps:[eff]});}
  const bld=s.shapes.map((sh,i)=>[sh,i]).filter(([sh])=>sh.g.order>0&&['rect','round','line','text'].includes(sh.t)).map(([,i])=>i);
  plan.push({n:s.n,shapes:kinds,blocks,videos:vids,bld});
}
fs.writeFileSync('B/plan.json',JSON.stringify(plan));
pres.writeFile({fileName:'B/raw.pptx'}).then(f=>console.log('wrote',f));
