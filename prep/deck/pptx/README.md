# Сборка PowerPoint в стиле HardFest

Актуальный путь собирает редактируемый PPTX из HTML-источников `../hardfest` с помощью JavaScript и `@oai/artifact-tool`. Формат 1920×1080 соответствует 10×5,625 дюйма. Шаблон организаторов задаёт оформление, палитру, логотип и встроенные шрифты Montserrat.

1. `sync_notes.py` переносит сценическую речь и короткие версии из `../../script/full_script.md` в HTML-заметки и проверяет щелчки.
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

В `deck.json` первые 28 слайдов образуют основной показ; все последующие скрыты и доступны для ручного перехода. Три модуля (`radixmin`, `learned-table`, `nb-lang`) можно вставить в обозначенные точки. Их текст, входные и выходные переходы находятся в `../../script/modules.md`.

Исторический `build.py` оставлен для архивной колоды `project` и как источник проверенной OpenXML-схемы анимаций. Для актуальной колоды используйте JavaScript-сборку выше.
