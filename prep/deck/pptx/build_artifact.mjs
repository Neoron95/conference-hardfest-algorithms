// Native editable slides authored with Artifact Tool; HTML is the layout source.
import fs from 'node:fs/promises';
import path from 'node:path';
import { pathToFileURL } from 'node:url';
import { createRequire } from 'node:module';
import { createHash } from 'node:crypto';
const pkg=process.env.ARTIFACT_TOOL_PATH || createRequire(import.meta.url).resolve('@oai/artifact-tool');
const {Presentation,PresentationFile}=await import(pathToFileURL(pkg).href);
const deckName=process.env.HARDFEST_DECK || 'hardfest';
const root=path.resolve(import.meta.dirname,'..',deckName);
const work=process.env.PPTX_WORK || '/tmp/hardfest-pptx';
const deck=JSON.parse(await fs.readFile(path.join(root,'deck.json'),'utf8'));
const ids=process.argv.slice(2).length?process.argv.slice(2):deck.order;
const p=Presentation.create({slideSize:{width:960,height:540}});
const manifest=[];
let serial=0;
const color=c=>c?('#'+c.hex+(c.a<1?'/'+Math.round(c.a*100):'')):'none';
const position=i=>({left:i.x/2,top:i.y/2,width:Math.max(.1,i.w/2),height:Math.max(.1,i.h/2)});
const font=s=>/Menlo|Mono|Courier/.test(s.family||'')?'Menlo':s.weight>=800?'Montserrat ExtraBold':s.weight>=600&&s.weight<700?'Montserrat SemiBold':'Montserrat';
for (const [index,id] of ids.entries()) {
  const data=JSON.parse(await fs.readFile(path.join(work,'extract-'+deckName,id+'.json'),'utf8'));
  if(deck.revision==='v8' || data.sourceSha256){
    const actual=createHash('sha256').update(await fs.readFile(path.join(root,'slides',id+'.html'))).digest('hex');
    if(data.sourceSha256!==actual)throw new Error(`${id}: extraction is stale; run extract.js again`);
  }
  const slide=p.slides.add();slide.background.fill='#000000';
  const entry={id,index,hidden:index>=deck.mainCount,objects:[]};manifest.push(entry);
  const tag=(build,type,extra={})=>{const name=`hf-${++serial}`;entry.objects.push({name,build:build?.order||0,type,...extra});return name;};
  const shape=(geometry,i,fill='none',lineFill='none',lineWidth=0,extra={})=>slide.shapes.add({geometry,name:tag(i.build,'shape'),position:position(i),fill,line:{fill:lineFill,width:lineWidth/2},...extra});
  const text=(i,runs,build=i.build)=>{
    if(!runs?.length)return;
    const s=shape('textbox',{...i,build});
    const max=Math.max(...runs.map(r=>(r.style||r).size||40));
    s.text=[{runs:runs.map(r=>{const st=r.style||r;return{run:r.t,textStyle:{fontSize:((st.size||40)/2)+'px',typeface:font(st),bold:st.weight>=700,italic:!!st.italic,color:color(st.color||{hex:'FFFFFF',a:1})}};})}];
    s.text.style={autoFit:'none',wrap:'none',verticalAlignment:'top',alignment:'left',insets:{left:0,right:0,top:0,bottom:0},lineSpacing:1};
    // A browser line is an explicit native paragraph. Preserve its line box.
    entry.objects.at(-1).textMetric={fontPx:max,heightPx:i.lineHeight||i.h};
  };
  const decoration=i=>{
    const d=i.deco;if(!d)return;
    const border=d.sides.find(Boolean);const same=d.sides.every(s=>!!s===!!border&&(!s||s.w===border.w&&s.c.hex===border.c.hex));
    if(d.bg||same)shape('rect',i,color(d.bg),same&&border?color(border.c):'none',same&&border?border.w:0,{borderRadius:parseFloat(d.radius)/2||0});
    if(!same) for(const [j,b] of d.sides.entries()){if(!b)continue;const a=[{x:i.x,y:i.y,w:i.w,h:0},{x:i.x+i.w,y:i.y,w:0,h:i.h},{x:i.x,y:i.y+i.h,w:i.w,h:0},{x:i.x,y:i.y,w:0,h:i.h}][j];shape('line',{...a,build:i.build},'none',color(b.c),b.w);}
  };
  const image=async(i,src,type='img')=>{
    const name=tag(i.build,type,type==='video'?{src:i.src,duration:i.dur,loop:i.loop}:{});
    const bytes=new Uint8Array(await fs.readFile(src));
    slide.images.add({blob:bytes,contentType:path.extname(src).toLowerCase()==='.jpg'?'image/jpeg':'image/png',alt:name,position:position(i),fit:i.fit==='cover'?'cover':'contain',borderRadius:parseFloat(i.radius)/2||0});
  };
  for(const i of data.items){
    if(i.type==='text'){
      decoration(i);
      for(const l of i.visualLines||[]){
        const size=Math.max(...l.runs.map(r=>r.style.size));
        const mono=l.runs.every(r=>/Menlo|Mono|Courier/.test(r.style.family||''));
        const asc=mono?1.02:.968, desc=mono?.27:.225;
        // Range bounds describe glyphs, not the CSS line box. Match its baseline.
        const y=l.y+asc*size-(i.lh-desc*size);
        text({...l,y,build:i.build,w:l.w+12,h:i.lh+4,lineHeight:i.lh},l.runs);
      }
    }else if(i.type==='rect')decoration(i);
    else if(i.type==='img')await image(i,i.src);
    else if(i.type==='video')await image(i,i.poster,'video');
    else if(i.type==='conn')shape('line',{x:Math.min(i.x1,i.x2),y:Math.min(i.y1,i.y2),w:Math.abs(i.x2-i.x1),h:Math.abs(i.y2-i.y1),build:i.build},'none',color(i.color),i.w,{position:{...position({x:Math.min(i.x1,i.x2),y:Math.min(i.y1,i.y2),w:Math.abs(i.x2-i.x1),h:Math.abs(i.y2-i.y1)}),verticalFlip:(i.x2-i.x1)*(i.y2-i.y1)<0}});
    else if(i.type==='svg'){
      for(const e of i.elements||[]){
        if(e.kind==='text'){text({x:e.x,y:e.y,w:e.w+8,h:e.h+5,build:e.build},[{t:e.text,style:{size:e.size,family:e.family,weight:e.weight,color:e.fill}}]);continue;}
        const pts=e.points;if(!pts?.length)continue;
        const minX=Math.min(...pts.map(t=>t.x)),minY=Math.min(...pts.map(t=>t.y)),w=Math.max(.1,Math.max(...pts.map(t=>t.x))-minX),h=Math.max(.1,Math.max(...pts.map(t=>t.y))-minY);
        const box={x:minX,y:minY,w,h,build:e.build};
        if(e.kind==='rect'||e.kind==='circle'||e.kind==='ellipse')shape(e.kind==='rect'?'rect':'ellipse',box,color(e.fill),color(e.stroke),e.strokeWidth,e.kind==='rect'?{borderRadius:(e.radius||0)/2}:{});
        else {
          shape('custom',box,e.closed?color(e.fill):'none',color(e.stroke),e.strokeWidth,{customPaths:[{width:w/2,height:h/2,commands:[{moveTo:{x:(pts[0].x-minX)/2,y:(pts[0].y-minY)/2}},...pts.slice(1).map(t=>({lineTo:{x:(t.x-minX)/2,y:(t.y-minY)/2}})),...(e.closed?[{close:{}}]:[])]}]});
          if(e.dash&&e.dash!=='none')entry.objects.at(-1).dash={lengths:e.dash.split(/[ ,]+/).map(parseFloat),width:e.strokeWidth};
        }
      }
    }
  }
  const lg=data.logo==='big'?{x:1436,y:127,w:380,h:131}:{x:1586,y:144,w:230,h:79};
  await image(lg,path.join(root,'assets/hardfest_logo.png'));
  if(!data.nonum)text({x:1760,y:960,w:90,h:34},[{t:String(index+1),style:{family:'Montserrat',weight:400,size:26.7,color:{hex:'EFEFEF',a:1}}}]);
  const notes=data.notes.replace(/<br\s*\/?\s*>/gi,'\n').replace(/<[^>]*>/g,'').replace(/&lt;/g,'<').replace(/&gt;/g,'>').replace(/&amp;/g,'&').replace(/&quot;/g,'"');
  slide.speakerNotes.textFrame.setText(notes);
  console.log(`${index+1}. ${id}: ${entry.objects.length} editable objects`);
}
await fs.mkdir(work,{recursive:true});
await(await PresentationFile.exportPptx(p)).save(path.join(work,'artifact-draft.pptx'));
await fs.writeFile(path.join(work,'artifact-manifest.json'),JSON.stringify({deck,slides:manifest},null,2));
