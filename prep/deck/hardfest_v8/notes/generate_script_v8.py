"""Assemble the V8 rehearsal script from the preserved script and V8 slide notes.
Run from any directory. Does not edit source slides or the deck pipeline.
"""
from pathlib import Path
import html, json, re
ROOT=Path(__file__).resolve().parents[4]
DECK=ROOT/'prep/deck/hardfest_v8'
OUT=ROOT/'prep/script/full_script_v8.md'
old=(ROOT/'prep/script/full_script_v7_6.md').read_text()
config=json.loads((DECK/'deck.json').read_text())
order=config['order']
main_count=config['mainCount']
main=order[:main_count]
backup=order[main_count:]

def field(block,start,end=None):
    if start not in block:return ''
    result=block.split(start,1)[1]
    if end and end in result:result=result.split(end,1)[0]
    return result.strip()

notes={}
for match in re.finditer(r'^### \d+\. `([^`]+)` — (.*?)\n(.*?)(?=^### |^## |\Z)',old,re.M|re.S):
    id,title,block=match.groups()
    t=re.search(r'^\*(\d+):(\d+)',block,re.M)
    seconds=int(t[1])*60+int(t[2]) if t else 0
    short=field(block,'**Если отстаю','**Под рукой.**')
    short=re.sub(r'^\s*\([^)]*\)\.\*\*\s*|^\s*\.\*\*\s*','',short)
    notes[id]={
        'title':title,
        'screen':field(block,'**На экране.**','**Говорю.**'),
        'speech':field(block,'**Говорю.**','**Если отстаю'),
        'short':short,
        'reference':field(block,'**Под рукой.**'),
        'durationSeconds':seconds,
    }
for path in sorted((DECK/'notes').glob('*.json')):
    data=json.loads(path.read_text())
    if not isinstance(data,dict):continue
    for id,item in data.items():
        if isinstance(item,dict) and 'speech' in item:
            notes[id]={**notes.get(id,{}),**item}

missing=[id for id in main if id not in notes]
if missing:raise SystemExit('Missing V8 note topics: '+', '.join(missing))

def slide_html(id):return (DECK/'slides'/f'{id}.html').read_text()
def build_count(id):return len(set(re.findall(r'data-build-in="\S+\s+(\d+)"',slide_html(id))))
def word_count(speech):return len(re.findall(r'\S+',re.sub(r'\[[^]]*\]','',speech)))
def clock(seconds):return f'{int(seconds)//60}:{int(seconds)%60:02d}'
def clean(text):
    text=text.replace('V7.6','V8').replace('V7 после','В архиве после')
    text=re.sub(r'(?i)физ\. слайды?\s+\d+(?:[–-]\d+)?','тема',text)
    text=re.sub(r'Экранный номер темы \d+ сохраняется на вводном слайде и всех этапах\.\s*','',text)
    text=re.sub(r'Физические слайды \d+(?:[–-]\d+)?:\s*','Архивная последовательность: ',text)
    text=re.sub(r'Место: после flat, перед share-q; либо ответ на «Почему не radix\?»\.', 'Место: архив, ответ на «Почему не radix?»', text)
    text=re.sub(r'(?i)экранные номера тем обновлены под V8\.?','',text)
    return text

all_words=sum(word_count(notes[id]['speech']) for id in main)
all_builds=sum(build_count(id) for id in main)
seconds=sum(notes[id]['durationSeconds'] for id in main)
advances=all_builds+main_count-1
errors=[]
for id in main:
    clicks=notes[id]['speech'].count('[щелчок]')
    if clicks!=build_count(id):errors.append(f'{id}: speech={clicks}, HTML={build_count(id)}')
    if re.search(r'radix|поразряд',notes[id]['speech'],re.I):errors.append(f'{id}: radix in main speech')
    if '[щелчок: следующий этап]' in notes[id]['speech']:errors.append(f'{id}: video stage transition in main')
if errors:raise SystemExit('\n'.join(errors))

lines=[
'# Текст выступления — V8',
'',
'«O(n) проиграл O(n log n): ваш алгоритм не выбирал процессор, на котором работает» · Никита Нагорнов · HardFest 2026.',
'',
'История основана на реальной задаче. Детали обезличены и упрощены, замеры выполнены на тестовых данных. Основной маршрут ведёт одну задачу через M2 Pro, Xeon VM и iPhone 14 Pro. В каждом числовом сравнении сохраняются собственные N, U, режим и библиотека. Отсутствующая серия означает «не измерено».',
'',
'- **«Говорю»** — сценическая речь. Ремарки в квадратных скобках не произносятся. `[щелчок]` раскрывает следующий билд, `[→ следующий слайд]` переводит к следующей теме. В основном маршруте короткие учебные примеры состоят из редактируемого текста и появлений, без поэтапного просмотра роликов.',
'- **Короткие версии** сокращают комментарии и чтение чисел, сохраняя все щелчки и условия сравнения. Коэффициенты на `result`, `flat`, `share`, `x33` читаются с паузой. Остальные числа доступны на экране и в материалах.',
'- **Ритм** — прогноз зала, результат, короткое объяснение. Восемь переходов с бумажными иллюстрациями сохранены. Пауза после шутки около двух секунд, не ждать смеха и не объяснять реплику.',
'- **База сравнения** — C++ и конкретный `std::unordered_set`. Термин «хеш» не означает одинаковое устройство таблиц в разных языках. На iPhone QoS задавался C++-потоку через `pthread_set_qos_class_self_np`, Swift `Task(priority:)` в этих сериях не измерялся.',
'- **Наблюдение и объяснение** разделены. Лестница задержек даёт косвенные признаки режима ядра и поведения памяти, а не трассу обращений дедупа. Контроль повторяемых входов и аппаратные гипотезы привязаны к среде. Большой заявленный L3 в VM сам по себе не устанавливает источник конкретной загрузки.',
'- **Архив** начинается после `final`. Полные sort/hash/radix/merge сохранены с 22 видеоэтапами для вопросов. Их время не входит в основной рассказ. После ответа возвращаться к `final` с QR, не пролистывать весь архив.',
'',
f'**Объём и время.** В речи {all_words} слов без ремарок. Основной рассказ содержит {main_count} тем, по одному физическому слайду на тему, и {all_builds} обычных билдов. С учётом {main_count-1} переходов между темами это {advances} нажатий «Далее». Запуск первого слайда и выход после финала в счёт не входят. Сумма сценических бюджетов — **{clock(seconds)}**, включая паузы. Это ориентир до репетиции. Расчёт речи при 140–150 словах в минуту составляет {clock(round(all_words*60/150))}–{clock(round(all_words*60/140))}; оставшаяся часть бюджета отведена появлению результата, чтению экрана, ставкам зала и переходам.',
'',
'| № темы | Тема | Оценка с паузами | К концу | Слов в речи | Билды |',
'|---:|---|---:|---:|---:|---:|',
]
cumulative=0
checkpoints=[]
for no,id in enumerate(main,1):
    n=notes[id]; cumulative+=n['durationSeconds']
    lines.append(f'| {no} | `{id}` | {clock(n["durationSeconds"])} | {clock(cumulative)} | {word_count(n["speech"])} | {build_count(id)} |')
    if id in ['result','cost-model','flat','learned','flip','review','final']:checkpoints.append(f'`{id}` {clock(cumulative)}')
lines += [f'| **{main_count} тем** | **Итого** | **{clock(seconds)}** | | **{all_words}** | **{all_builds}** |','','**Расчётные контрольные метки:** '+ ' · '.join(checkpoints)+'.','']
section_start={v['start']:v['description'] for k,v in config.get('sections',{}).items()}
for no,id in enumerate(main,1):
    n=notes[id]
    if id in section_start:lines += ['## '+section_start[id],'']
    lines += [f'### {no}. `{id}` — {clean(n["title"])}',f'*{clock(n["durationSeconds"])} · {build_count(id)} билдов*','','**На экране.**',clean(n['screen']),'','**Говорю.**',clean(n['speech']),'','**Если отстаю.** '+clean(n['short']),'','**Под рукой.**',clean(n['reference']),'']
lines += ['## Архив для вопросов','','Слайды скрыты из основного показа. Выбирать тему через оглавление или навигатор. Финал с QR остаётся точкой возврата. Архивные условия не объединять с основными таблицами.','']
for id in backup:
    if id in notes:
        n=notes[id]
        lines += [f'### `{id}` — {clean(n["title"])}','','**На экране.**',clean(n.get('screen','')),'','**Говорю.**',clean(n['speech']),'','**Под рукой.**',clean(n.get('reference','')),'']
    else:
        text=slide_html(id)
        title=re.search(r'<h2[^>]*>(.*?)</h2>',text,re.S)
        title=html.unescape(re.sub('<[^>]+>','',title[1])) if title else id
        aside=re.search(r'<aside>(.*?)</aside>',text,re.S)
        aside=aside[1] if aside else ''
        aside=re.sub(r'<br\s*/?>','\n',aside)
        aside=html.unescape(re.sub(r'<[^>]+>','',aside))
        aside=re.sub(r'^Щелчки:.*$', '',aside,flags=re.M)
        aside=re.sub(r'(?m)^Тайминг:.*$', '',aside)
        aside=re.sub(r'(?m)^.*(?:основной слайд|backup) \d+.*$', '',aside)
        lines += [f'### `{id}` — {title}','','**Заметки для ответа.**',clean(aside.strip()),'','[после ответа вернуться к final]','']
lines += ['## Источники и условия','',
'Числа и полные условия: [apple.md](../research/apple.md), [bench.md](../research/bench.md), [summary.md](../../bench/results/summary.md). Код и таймер: [dedup_bench.cpp](../../bench/dedup_bench.cpp). Архив ответов: [qa.md](../research/qa.md). Источники устройства процессоров и коллекций перечислены у соответствующих тем. Учебные примеры объясняют механизм и не заменяют числовые серии.','',
'Девять бумажных иллюстраций сохранены из существующей колоды. Это визуальные метафоры, их подписи и технические метки остаются редактируемыми. Полные учебные видеодемонстрации sort, hash, radix, merge сохранены в архиве со всеми 22 этапами. Каждый этап содержит один неповторяющийся ролик и удерживает конечный кадр. Перед этапом назвать действие, после движения пояснить результат. Учебная сортировка слиянием использует дополнительный буфер; измеряемый std::sort устроен иначе.','']
OUT.write_text('\n'.join(lines))
print(json.dumps({'path':str(OUT),'mainTopics':main_count,'words':all_words,'builds':all_builds,'nextPresses':advances,'durationSeconds':seconds,'budget':clock(seconds),'backupTopics':len(backup)},ensure_ascii=False,indent=2))
