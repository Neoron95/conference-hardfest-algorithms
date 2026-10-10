"""Read the editable speaker file without ever overwriting it."""
from pathlib import Path
import html,json,re
ROOT=Path(__file__).resolve().parents[3]
D=ROOT/'prep/deck/hardfest_v9'
file=ROOT/'prep/script/speaker_notes_v9.md'
if not file.exists():raise SystemExit('Missing editable speaker notes')
count=0
for match in re.finditer(r'^## \d+\. `([^`]+)`[^\n]*\n(.*?)(?=^## \d+\. |\Z)',file.read_text(),re.M|re.S):
 id,speech=match.groups();p=D/'slides'/f'{id}.html'
 if not p.exists():continue
 s=p.read_text();old=html.unescape(re.search(r'<aside>(.*?)</aside>',s,re.S).group(1)).replace('<br>','\n')
 tail=re.search(r'(?:[─━]+\s*)?Источники(?: и условия)?\s*\n[\s\S]*',old)
 note=speech.strip()+ ('\n\n'+tail.group(0).strip() if tail else '')
 p.write_text(re.sub(r'<aside>.*?</aside>','<aside>'+html.escape(note,quote=False).replace('\n','<br>')+'</aside>',s,flags=re.S));count+=1
print(f'Synced {count} speaker-note blocks from editable file')
