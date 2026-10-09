// First-party authoring/inspection draft; assemble_v9.py preserves native media.
import fs from 'node:fs/promises';
import path from 'node:path';
import {pathToFileURL} from 'node:url';
const runtime=process.env.ARTIFACT_TOOL_PATH;
if(!runtime)throw new Error('Set ARTIFACT_TOOL_PATH to the bundled module');
const {PresentationFile,FileBlob}=await import(pathToFileURL(runtime).href);
const root=path.resolve(import.meta.dirname,'../../..');
const work=path.join(root,'prep/.v9-build');
const p=await PresentationFile.importPptx(await FileBlob.load(path.join(root,'prep/deck/hardfest2026_deck_v8.pptx')));
const notes=JSON.parse(await fs.readFile(path.join(root,'prep/deck/hardfest_v9/reference/first_five.json'),'utf8'));
for(const [i,record] of notes.entries())p.slides.items[i].speakerNotes.textFrame.setText(record.speakerNotes);
for(const phrase of ['Что выбрать — и как проверить','Мозг ещё читает.']){
  const found=await p.inspect({kind:'textbox',search:phrase,maxChars:4000});
  const entries=found.ndjson.trim().split('\n').filter(Boolean).map(line=>JSON.parse(line));
  const target=entries.find(record=>record.kind==='textbox' && record.text.includes(phrase));
  if(!target)throw new Error(`Missing original label: ${phrase}`);
  p.resolve(target.id).text='';
}
await fs.mkdir(work,{recursive:true});
await(await PresentationFile.exportPptx(p)).save(path.join(work,'artifact-authoring-draft.pptx'));
await fs.writeFile(path.join(work,'first-party-inspection.ndjson'),(await p.inspect({kind:'slide,notes,textbox,layout',maxChars:8000})).ndjson);
console.log('Prepared V9 text edits with Artifact Tool; native preservation pass owns final package');
