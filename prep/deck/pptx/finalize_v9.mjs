// Validate the exact packaged PPTX without re-exporting its preserved videos.
import fs from 'node:fs/promises';
import path from 'node:path';
import {createHash} from 'node:crypto';
import {pathToFileURL} from 'node:url';

const workspaceDir=path.resolve(import.meta.dirname,'../../..');
const skillDir=process.env.PRESENTATIONS_SKILL_DIR;
const runtimePython=process.env.RUNTIME_PYTHON;
if(!skillDir || !runtimePython)throw new Error('Set PRESENTATIONS_SKILL_DIR and RUNTIME_PYTHON from workspace dependencies');
process.env.RUNTIME_NODE_MODULES ||= process.env.NODE_PATH;
const build=path.resolve(workspaceDir,'prep/.v9-build');
const candidatePath=path.join(build,'v9-candidate.pptx');
const finalPath=path.resolve(process.argv[2] || path.join(workspaceDir,'prep/deck/hardfest2026_deck_v9.pptx'));
const referencePath=path.join(workspaceDir,'prep/deck/hardfest2026_deck_v8.pptx');
const referenceSha256=createHash('sha256').update(await fs.readFile(referencePath)).digest('hex');
const manifest=JSON.parse(await fs.readFile(path.join(build,'v9-candidate.manifest.json'),'utf8'));
const {finalizePresentation}=await import(pathToFileURL(path.join(skillDir,'container_tools/artifact_tool_utils.mjs')).href);
const result=await finalizePresentation({
  workspaceDir,candidatePath,finalPath,
  explicitTotalSlideCount:manifest.order.length,
  pythonExecutable:runtimePython,
  integrityValidatorPath:path.join(skillDir,'container_tools/inspect_presentation_package_integrity.py'),
  layoutValidatorPath:path.join(skillDir,'container_tools/inspect_presentation_layout_geometry.py'),
  layoutArgs:['--expected-slide-size-emu','9144000,5143500','--validate-bullet-geometry','--validate-heading-fit'],
  requiredNativeTableOwnerSlides:[],
  fontPolicy:{basis:'reference',families:['Montserrat','Montserrat ExtraBold','Montserrat SemiBold','Menlo'],referencePath,referenceSha256},
  verifyArtifactToolImport:true,
  receiptPath:path.join(build,`v9-validation-${Date.now()}.json`),
});
console.log(JSON.stringify({path:finalPath,sha256:result.finalSha256,slides:manifest.order.length,receipt:result.receiptPath},null,2));
