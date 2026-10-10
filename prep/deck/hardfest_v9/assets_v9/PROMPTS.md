# Иллюстрации слайдов 6–7

Встроенный ImageGen, 09.10.2026. Референс: ../assets/meme_boxing_v7.png. Оба изображения с альфа-каналом. Текст вариантов A/B/C накладывается отдельными редактируемыми элементами.

## boxers_ab.png

Точная правка исходной бумажной сцены: удалить центрального рефери, скатерть и пьедестал. Сохранить внешность, позы и бумажную фактуру двух боксёров, бирюзовый слева и розовый справа. Только два полнофигурных боксёра лицом друг к другу, без текста, логотипов и дополнительных объектов. Прозрачный фон.

## referee_c.png

Тот же пожилой бумажный рефери с седыми усами, белой рубашкой и чёрной бабочкой. Поднять белую скатерть двумя руками, открыть большую пустую тёмную прямоугольную табличку на пьедестале для нативного текста C / Спросил бы условие. Без боксёров, букв и фона. Прозрачность сохранить.

## Сохранённые файлы

- [Боксеры A/B](/Users/nagornov/repo/conference-hardfest-algorithms/prep/deck/hardfest_v9/assets_v9/boxers_ab.png)
- [Рефери C](/Users/nagornov/repo/conference-hardfest-algorithms/prep/deck/hardfest_v9/assets_v9/referee_c.png)

## referee_closed_v2.png

Встроенный ImageGen, 09.10.2026. Точная правка `referee_c.png` с исходной сценой `meme_boxing_v7.png` как референсом закрытой скатерти. На обоих слайдах используется один и тот же `boxers_ab.png` в одинаковой позиции и размере. Центральный рефери меняет состояние скатерти.

Промпт:

```
Use case: precise-object-edit
Asset type: transparent paper-cut illustration for the center of two consecutive presentation slides.
Input image 1 is the EDIT TARGET: the elderly referee with an uncovered dark sign. Input image 2 is a supporting pose/reference: the original scene showing the cloth covering the sign.
Primary request: create the CLOSED-CLOTH state of the exact referee in image 1. Lower the white tablecloth so it completely covers the entire dark rectangular sign. His hands hold the top corners of the hanging cloth near his chest, as in the center character of image 2. The cloth must hang over the front face of the sign, with natural folds, leaving only its black pedestal stem and base visible beneath. No dark sign face should be visible.
Invariants: keep the same elderly man's head, gray mustache and hair, white shirt, black bow tie, paper textures, scale, central alignment, camera framing, pedestal position and base shape as image 1. Keep the same 3:2 canvas composition so this image can replace image 1 in exactly the same slide rectangle. Do not include the boxers from image 2.
Scene/backdrop: genuinely transparent background, no solid backdrop, no colored glow or halo.
Constraints: one central referee and covered sign only, full pedestal base in frame, no letters, no typography, no extra objects.
```

- [Рефери с закрытой скатертью](/Users/nagornov/repo/conference-hardfest-algorithms/prep/deck/hardfest_v9/assets_v9/referee_closed_v2.png)

## approve_paper_v1.png

Встроенный ImageGen, 10.10.2026. Вместо гладкой кнопки на слайде 4 используется бумажный коллаж с той же надписью. Референсы: пользовательский скриншот кнопки Approve и `meme_boxing_v7.png` для фактуры бумаги.

Промпт:

```
Use case: style-transfer
Asset type: one standalone transparent button illustration for an existing black presentation slide.
Input image 1 is the shape, palette, text and layout reference: a turquoise horizontal Approve button. Input image 2 is ONLY the paper-craft texture and handmade cutout style reference.
Primary request: recreate ONLY the button from image 1 as a tactile handmade paper collage matching image 2. One very wide turquoise / mint-green rectangular card with gently rounded hand-cut corners, visible fibrous crumpled colored paper texture, slightly irregular torn/cut pale paper edge and a thin layered dark paper backing. Keep a clean, readable horizontal silhouette and subtle shallow paper shadows.
Text (verbatim): "Approve ✓". Use large bold black paper-cut sans-serif letters and a bold black paper-cut checkmark, all centered together on one line. Spell Approve exactly with capital A and lowercase p p r o v e. The black letters and checkmark should have slight tactile paper grain while staying crisp and readable.
Composition: straight front view, button width about four times its height. Wide landscape canvas, button almost fills the canvas horizontally with only small transparent margins, no tilt, no perspective distortion.
Background: genuinely transparent alpha, no black rectangle or environment.
Constraints: button only, no cursor, no arrow, no movement trail, no footer number, no people, no extra text, no logos, no glow. Preserve the mint/turquoise color and black label from input image 1.
```

- [Бумажная кнопка Approve](/Users/nagornov/repo/conference-hardfest-algorithms/prep/deck/hardfest_v9/assets_v9/approve_paper_v1.png)
