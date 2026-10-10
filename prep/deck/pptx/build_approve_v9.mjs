// Author the paper button as a native picture, for a focused package replacement.
import fs from 'node:fs/promises';
import path from 'node:path';
import {pathToFileURL} from 'node:url';
const root=path.resolve(import.meta.dirname,'../../..');
const assets=path.join(root,'prep/deck/hardfest_v9/assets_v9');
const out=path.join(root,'prep/.v9-build/review-approve');
const {Presentation,PresentationFile}=await import(pathToFileURL(process.env.ARTIFACT_TOOL_PATH).href);
const layout=JSON.parse(await fs.readFile(path.join(assets,'approve_paper_v1.layout.json'),'utf8'));
const bytes=await fs.readFile(path.join(assets,'approve_paper_v1.png'));
const p=Presentation.create({slideSize:{width:960,height:540}});
const s=p.slides.add();s.background.fill='#000000';
s.images.add({blob:bytes.buffer.slice(bytes.byteOffset,bytes.byteOffset+bytes.byteLength),contentType:'image/png',alt:'Бумажная бирюзовая кнопка Approve ✓',fit:'contain',position:Object.fromEntries(Object.entries(layout.position).map(([k,v])=>[k,v/2]))});
await fs.mkdir(out,{recursive:true});
await (await PresentationFile.exportPptx(p)).save(path.join(out,'button.pptx'));
console.log('Authored V9 paper Approve picture');
