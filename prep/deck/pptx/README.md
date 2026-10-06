# Сборка PowerPoint в стиле HardFest

Актуальная V7.6 объединяет рабочую `6.5_test` с материалами V7 через `merge_v7_6.py`. Порядок и команды описаны в `../hardfest/V7_6.md`. Приведённый ниже HTML-конвейер остаётся сборкой исходной V7.

Актуальный путь собирает редактируемый PPTX из HTML-источников `../hardfest` с помощью JavaScript и `@oai/artifact-tool`. Формат 1920×1080 соответствует 10×5,625 дюйма. Шаблон организаторов задаёт оформление, палитру, логотип и встроенные шрифты Montserrat.

1. `sync_notes.py` переносит сценическую речь и источники из `../../script/full_script.md` в HTML-заметки и проверяет щелчки.
2. `extract.js` получает раскладку в Chromium: точные строки, стили, геометрию и элементы SVG.
3. `build_artifact.mjs` создаёт нативные редактируемые тексты, полосы графиков и диаграммы. Постеры и логотипы остаются изображениями.
4. `finish_package.py` сохраняет встроенные шрифты шаблона, добавляет существующую схему щелчков, настоящие MP4-анимации, разделы и скрытие дополнительных слайдов.
5. `export_pdf.js` делает резервную версию из той же HTML-раскладки с постерами вместо видео.

## Команды

Из корня репозитория:

```bash
python3 prep/deck/pptx/sync_notes.py
export PPTX_WORK=/tmp/hardfest-pptx
export CHROME_PATH='/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'
node prep/deck/pptx/extract.js --deck hardfest
node prep/deck/pptx/build_artifact.mjs
python3 prep/deck/pptx/finish_package.py /tmp/hardfest-pptx/candidate.pptx
node prep/deck/pptx/export_pdf.js prep/deck/hardfest2026_deck.pdf
```

Зависимости: Node.js, Playwright/Chromium, `@oai/artifact-tool`, Python 3 с lxml и pypdf. При необходимости укажите `NODE_PATH` для Playwright и `ARTIFACT_TOOL_PATH` к `dist/artifact_tool.mjs`. Шрифты Montserrat и Menlo должны разрешаться при раскладке HTML. Montserrat из шаблона также встроен в итоговый PPTX.

`extract.js --deck hardfest cover diff` и `build_artifact.mjs cover diff` поддерживают сборку выбранных слайдов для проверки. Рабочие JSON и PNG находятся в `$PPTX_WORK`, а не среди итоговых материалов.

Для рендера в комплектном LibreOffice задайте `FONTCONFIG_FILE`, включающий системные каталоги шрифтов: без него этот runtime может подставить другой шрифт. Рендер LibreOffice и геометрические проверки не заменяют проверку анимаций в PowerPoint.

## Сценарий и дополнительные модули

В `deck.json` основной показ занимает позиции 1–41; все последующие слайды скрыты и доступны для ручного перехода. Три модуля (`radixmin`, `learned-table`, `nb-lang`) можно вставить в обозначенные точки. Их текст, входные и выходные переходы находятся в `../../script/modules.md`.

Исторический `build.py` оставлен для архивной колоды `project` и как источник проверенной OpenXML-схемы анимаций. Для актуальной колоды используйте JavaScript-сборку выше.

V5 добавляет четыре учебных MP4. Они создаются из `../hardfest/assets/src/anim` командой `node render.js sort_unique_v5 hash_insert_v5 radix_pass_v5 merge_unique_v5`. На macOS кодирование H.264 использует `encode_frames.swift` и системный AVFoundation; на других системах укажите `FFMPEG_PATH`. Для Chromium поддерживается `CHROME_PATH`, для необязательных статических шрифтов — `ANIM_FONT_DIR`. Формат: 1800×720, 30 fps, звук отсутствует.

V7 использует девять иллюстраций в стиле бумажного коллажа на прозрачном фоне. Восемь — отдельные переходы; курсор Approve объединён с `diff` на слайде 4. Всего 41 основной и 24 скрытых слайда. Готовые версии: `../hardfest2026_deck_v7.pptx` и `.pdf`; файлы без суффикса совпадают с текущей V7. Подписи поверх изображений остаются редактируемыми. Изображения — `../hardfest/assets/meme_*_v7.png`, происхождение и запросы — `../hardfest/assets/src/img/memes_v7_*_prompts.txt`. V6 сохранена; все восемь MP4 и 64 шага появления перенесены в V7.
