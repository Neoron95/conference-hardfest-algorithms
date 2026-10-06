# Шрифты V7.6

Статические Montserrat скачаны из [репозитория авторов](https://github.com/JulietaUla/Montserrat/tree/master/fonts/ttf), Aptos — из [официального пакета Microsoft](https://www.microsoft.com/en-us/download/details.aspx?id=106087). На Mac установлены 8 начертаний Montserrat и 4 Aptos в `~/Library/Fonts`. Названия семейств SemiBold и ExtraBold соответствуют внутренним именам статических TTF.

`embed_fonts.py` заменяет старые записи Montserrat в PPTX точными полными начертаниями и добавляет Aptos для темы. Он сохраняет исходные TTF без изменений в контейнерах EOT и проверяет разрешение на редактируемое встраивание (`fsType`: Montserrat 0, Aptos 8). Видео, анимации, текст и заметки не пересобираются.

```bash
python3 prep/deck/pptx/embed_fonts.py /tmp/hardfest-v7_6-candidate.pptx /tmp/hardfest-v7_6-fonts.pptx
```

Для повторной сборки необходимы статические `Montserrat-{Regular,Bold,Italic,BoldItalic,SemiBold,SemiBoldItalic,ExtraBold,ExtraBoldItalic}.ttf` и `Aptos.ttf`, `Aptos-Bold.ttf`, `Aptos-Italic.ttf`, `Aptos-Bold-Italic.ttf`. Третий аргумент сборщика позволяет выбрать другую папку шрифтов. Исходные файлы Aptos в репозиторий отдельно не добавляются. Microsoft описывает [встраивание шрифтов в документы](https://learn.microsoft.com/en-us/typography/fonts/font-faq#document-embedding).
