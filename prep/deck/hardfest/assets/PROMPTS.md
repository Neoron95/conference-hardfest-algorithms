# Промпты для внешнего генератора картинок и видео

Картинки нужны для настроения: обложка, история «вышел из метро», финал, раздел backup. Анимации с механикой
(узлы хеша в памяти, промахи «в полёте», поиск по группе меток, задача прыгает с P- на E-ядро) рисуются кодом по
реальным данным — их генерировать не нужно.

## Общий стиль — добавляйте к каждому промпту

```
pure black background (#000000), minimal, high contrast, cinematic lighting, sharp focus,
accent colors only turquoise (#46CDAE) and magenta-pink (#E2489B), everything else black, white or dark grey,
large clean negative space, edges fade to pure black, no text, no letters, no numbers, no logos, no watermark
```

Негативный промпт (если генератор его поддерживает):

```
text, letters, words, numbers, logo, watermark, frame, border, blue, orange, purple, yellow, green,
rainbow, clutter, busy background, low contrast, grey background, white background, cartoon, clip art
```

Почему так: фон слайдов шаблона чисто чёрный, акценты — бирюзовый и розовый; картинка с серым фоном
или текстом будет выглядеть чужеродно. Если фон получится не идеально чёрным, это я поправлю.

## Картинки

| Файл | Слайд | Формат | Промпт |
|---|---|---|---|
| `cover.png` | 1, обложка, справа от названия | 1:1, от 1536 px | см. 1 |
| `case.png` | 3, задача, слева | 3:2, от 1800×1200 | см. 2 |
| `learned.png` | 18, «мой бенчмарк врал», справа | 1:1, от 1024 px | см. 3 |
| `final.png` | 26, финал, фон справа | 1:1, от 1536 px | см. 4 |
| `backup.png` | 27, раздел backup, левая половина слайда | 2:3 портрет, от 1024×1536 | см. 5 |

1. **cover** — чип, у которого «две личности»:
   ```
   Extreme macro photograph of a smartphone system-on-chip die seen from above at a slight angle,
   one cluster of large processor cores glowing turquoise, a separate cluster of small cores glowing magenta-pink,
   thin glowing traces between them, tiny particles of light travelling along the traces,
   subject centered, floating in pure black, shallow depth of field
   ```
2. **case** — «человек вышел из метро, приложение ожило»:
   ```
   Cinematic night shot, a person stepping out of a metro station exit into a dark city street,
   seen from behind, holding a smartphone, the phone screen emits a soft turquoise glow,
   faint magenta-pink reflections on wet asphalt, streams of tiny glowing data particles flowing into the phone,
   subject in the left two thirds, right side fades to pure black, moody, no readable signs
   ```
3. **learned** — бенчмарк, который врёт:
   ```
   Studio product shot of a sleek black stopwatch on a pure black surface, its glass face cracked,
   the cracks glow turquoise, a magenta-pink glitch / double-exposure offset on the dial,
   dramatic rim light, centered, lots of black space around, no digits on the dial
   ```
4. **final** — «какой процессор вам достался»:
   ```
   A translucent glass die (dice) floating in pure black, inside each face a tiny glowing computer chip,
   one face lit turquoise, another magenta-pink, soft volumetric light, slow-shutter light trails,
   centered, minimal, elegant
   ```
5. **backup** — абстрактная обложка раздела:
   ```
   Abstract vertical composition: at the top neat rows of thin vertical light bars sorted by height in turquoise,
   lower down they break apart into scattered glowing magenta-pink dots connected by fine lines,
   like data dissolving into a network, pure black background, elegant, generative art
   ```

## Видео (по желанию, 5–8 секунд, без звука, зацикливание)

Лучше делать из готовой картинки (image-to-video), чтобы стиль совпал.

| Файл | Из картинки | Промпт движения |
|---|---|---|
| `cover.mp4` | `cover.png` | `very slow camera push-in, light pulses travel between the two core clusters, particles drift, seamless loop, no camera shake` |
| `final.mp4` | `final.png` | `the glass die slowly rotates a quarter turn, the glowing chip inside flickers from turquoise to magenta-pink, seamless loop, slow motion` |

Формат видео: MP4 (H.264), 1080p или выше, 24–30 fps. Чем спокойнее движение, тем лучше: видео играет за спиной
у спикера, пока он говорит.

## Что не стоит генерировать

- Видео с iPhone на слайде 20 (`x33`) — нужна настоящая запись экрана с вашего телефона, это главный аргумент доклада.
- Графики, таблицы, любые цифры — генераторы их искажают; они остаются нативными фигурами PowerPoint.

## Как отдать мне

Пришлите файлы в чат с теми же именами (`cover.png`, `case.png` …). Я положу их в `assets/ai/`,
подгоню под чёрный фон шаблона и пересоберу презентацию.
