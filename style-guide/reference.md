# Style guide reference

English names. Descriptions say where the token is used, not a synonym of the name.

## Collections

| Collection | Modes | Holds |
|---|---|---|
| Primitives | Value | Raw ramps. Scope `[]`. |
| Color | Light, Dark | Role aliases into Primitives. |
| Spacing | Value | The scale from the description, or a 4-based scale chosen in the proposal. |
| Radius | Value | Corner radii, including nested. |
| Typography | Value | Family, size, line height, weight, letter spacing. |
| Motion | Value | Durations (FLOAT, ms) and easing curves (STRING). Scope `[]`. |

Slash groups are groups, not extra collections.

### Primitives

- `brand/50` through `brand/950`. A mid color is `brand/500` exactly. A very light or very dark color sits on the step nearest its lightness (Color input in SKILL.md). A monochrome system has no brand ramp; see Monochrome. Lighter steps raise lightness and lower saturation. Darker steps lower lightness and shift hue slightly toward blue. `50` and `950` stay tinted, not pure white or black.
- `neutral/50` through `neutral/950`, same hue, low saturation. Keep chroma at about 0.003 (OKLCH) on `50`–`300` so the page and cards stay near white; a stronger tint turns the whole page pink, cream, or green. Darker steps can carry about 0.008.
- Status hues: `red`, `green`, `amber`, `blue`. Do not mix these from the brand hue. Each hue has `400`, `500`, and `700`, plus `red/600`, and a `tint` (the `500` at 12% alpha) for backgrounds:

| Hue | 400 | 500 | 600 | 700 |
|---|---|---|---|---|
| red | `#F87171` | `#EF4444` | `#DC2626` | `#B91C1C` |
| green | `#4ADE80` | `#22C55E` | | `#15803D` |
| amber | `#FBBF24` | `#F59E0B` | | `#B45309` |
| blue | `#60A5FA` | `#3B82F6` | | `#1D4ED8` |

  `500` is the signal color: error border on Dark, chips. It is never a text color, because on white it falls to about 3.8:1 or less. Status text uses the steps in Status roles.
- `white`, `black`.

On a monochrome system the status hues lose chroma so they do not shout against black and white: keep each hue, lower chroma to about two thirds, then rerun the Status roles check.

Description on every primitive: `Raw ramp step. Do not apply to a layer.`

### Monochrome

For a white, black, or gray input with no `accent #RRGGBB` in the description.

- No `brand/*` ramp. `brand/base` is one primitive holding the given hex exactly.
- `neutral/50` through `neutral/950` are pure gray, saturation 0. A tinted gray input (such as `#F7F7F5`) keeps its own faint hue on the ramp instead.
- Accent, focus, and surfaces, the only aliases that differ from the normal table:

| Token | Light | Dark |
|---|---|---|
| `color/accent/default` | `neutral/900` | `neutral/50` |
| `color/accent/hover` | `neutral/800` | `neutral/200` |
| `color/accent/pressed` | `neutral/950` | `neutral/300` |
| `color/text/on-accent` | `white` | `neutral/950` |
| `color/border/focus` | `neutral/900` | `neutral/50` |
| `color/bg/surface` | `neutral/50` | `neutral/950` |
| `color/bg/elevated` | `white` | `neutral/900` |
| `color/bg/sunken` | `neutral/100` | `black` |
| `color/bg/disabled` | `neutral/200` | `neutral/800` |
| `color/text/secondary` | `neutral/700` | `neutral/300` |
| `color/text/muted` | `neutral/600` | `neutral/400` |
| `color/border/strong` | `neutral/500` | `neutral/500` |
| `color/border/hover` | `neutral/700` | `neutral/400` |

- No blue anywhere except the info status. The focus ring is the accent color.
- Code output writes `--brand-base` and no `--brand-*` ramp.

### Color

Aliases only. Light and Dark point at different primitives.

| Name | Scope | Job |
|---|---|---|
| `color/bg/surface` | FRAME_FILL, SHAPE_FILL | Page background |
| `color/bg/elevated` | FRAME_FILL, SHAPE_FILL | Cards and menus |
| `color/bg/sunken` | FRAME_FILL, SHAPE_FILL | Inputs |
| `color/bg/disabled` | FRAME_FILL, SHAPE_FILL | Disabled controls |
| `color/text/primary` | TEXT_FILL | Body and titles |
| `color/text/secondary` | TEXT_FILL | Supporting text |
| `color/text/muted` | TEXT_FILL | Placeholders, captions, meta |
| `color/text/disabled` | TEXT_FILL | Disabled labels |
| `color/text/on-accent` | TEXT_FILL | Label on a brand button |
| `color/border/default` | STROKE_COLOR | Quiet dividers |
| `color/border/strong` | STROKE_COLOR | Field and secondary button edges |
| `color/border/hover` | STROKE_COLOR | Field and secondary button edge on hover |
| `color/border/focus` | STROKE_COLOR | Keyboard focus ring. Aliases the accent step, unless the brand hue is within 30° of the danger red (OKLCH hue about 25): then it aliases `neutral/950` on Light and `neutral/50` on Dark, so focus never reads as an error. 3:1 against the surface it sits on |
| `color/accent/default` | FRAME_FILL, SHAPE_FILL | Primary button fill. Darker brand step when `brand/500` fails contrast |
| `color/accent/hover` | FRAME_FILL, SHAPE_FILL | Primary button hover |
| `color/accent/pressed` | FRAME_FILL, SHAPE_FILL | Primary button pressed |
| `color/bg/danger` | FRAME_FILL, SHAPE_FILL | Error field background |
| `color/border/danger` | STROKE_COLOR | Error field border |
| `color/text/danger` | TEXT_FILL | Error message |
| `color/bg/success` | FRAME_FILL, SHAPE_FILL | Success badge |
| `color/text/success` | TEXT_FILL | Success badge label |
| `color/bg/warning` | FRAME_FILL, SHAPE_FILL | Warning badge |
| `color/text/warning` | TEXT_FILL | Warning badge label |
| `color/bg/info` | FRAME_FILL, SHAPE_FILL | Info badge |
| `color/text/info` | TEXT_FILL | Info badge label |
| `color/shadow` | EFFECT_COLOR | Shadow tint |
| `color/highlight` | EFFECT_COLOR | 1px top edge light on raised surfaces |

Code syntax: `var(--color-bg-surface)` and the same pattern for the rest.

### Contrast checks

Run these in both themes before the proposal. If a step fails, take the nearest step that passes and say so.

| Token | Against | Minimum |
|---|---|---|
| `color/text/primary`, `secondary` | surface, elevated, sunken | 4.5:1 |
| `color/text/muted` | surface, elevated, sunken | 4.5:1. It carries placeholders and captions, so it is real text |
| `color/border/strong` | surface and sunken | 3:1. It is the only edge of a field |
| `color/border/focus` | surface | 3:1 |
| `color/text/on-accent` | accent default, hover, pressed | 4.5:1 |

`color/text/secondary` sits one step closer to primary than muted, so the three stay in order. `color/border/default` is decorative and has no minimum. `color/bg/sunken` alone never marks a field: the border does.

### Status roles

| Token | Light | Dark |
|---|---|---|
| `color/text/danger` | `red/600` | `red/400` |
| `color/text/success` | `green/700` | `green/400` |
| `color/text/warning` | `amber/700` | `amber/400` |
| `color/text/info` | `blue/700` | `blue/400` |
| `color/border/danger` | `red/600` | `red/500` |
| `color/bg/danger`, `success`, `warning`, `info` | `{hue}/tint` | `{hue}/tint` |

Check every status text against its own `bg/{status}` laid over `color/bg/surface` and over `color/bg/elevated`. It must reach 4.5:1. If a step fails, move one step further from the background (darker on Light, lighter on Dark) and say so in the proposal. The same check applies to the error message under a field.

### Spacing

One token per step. Name by the pixel value: `space/2`, `space/4`, `space/8`. Scope `GAP`. Description is the job, for example `8 — gap between icon and label`. If the description did not assign jobs, assign one job per step and show that list in the proposal before building.

Inside a card, three different steps. The inset is the card-padding step. The gap from the image to the text group is one step smaller. The gap from the title to the body is the icon-to-label step, because those two lines are one group. Do not use one gap for the image, the title, and the body. On a scale whose card padding is 24, that is 24, then 16, then 8.

### Radius

Scope `CORNER_RADIUS`. Include `radius/none`, the scale used on controls, `radius/full` (9999) for pills, and `radius/nested`. Description of `radius/nested`: `Outer radius equals inner radius plus padding.`

### Typography

- `family/display`, `family/body` as STRING, scope `FONT_FAMILY`. They may hold the same family. Add `family/mono` when a mono carries captions and meta. Never more than two distinct families.
- One size variable per step named in the proposal, scope `FONT_SIZE`. A portfolio uses `h1` through `h5`, `body`, `label`, and `caption`. Other site types add the steps named in the skill. When the brief says desktop and mobile, each step has two sizes, `h1/desktop` and `h1/mobile`.
- Matching `line-height/*`, scope `LINE_HEIGHT`.
- Font size and line height are multiples of 4. Take them from the research for this site type, then snap to the nearest multiple of 4. A portfolio hero is display-sized. A dashboard, admin, or app keeps the smaller heading range. Label, caption, and control text stay in that smaller range even on a portfolio. An icon beside one line of text is the same size as that line height. Build the icon at 16, 20, and 24, and use the one that matches. If the line height is none of those, use the nearest.
- `weight/regular`, `weight/strong`, scope `FONT_WEIGHT`. Strong is whatever the face reads as bold at heading size: 500 for most grotesks, 600 or 700 for others.
- `tracking/{step}`, scope `LETTER_SPACING`, in percent. Large display steps are tighter (about -4% at 120, -2% at 48), body and label 0, mono captions slightly open (+2%).
- Every step differs from its neighbours. When snapping to 4 makes two steps the same size (common on a dense dashboard scale), keep the higher one and move the lower one down a step, or set it apart by weight; a step that still duplicates another is dropped, and the proposal says so.
- A heading step must read larger than `body` beside it. If the display face has a small x-height and `h5` looks smaller than body, raise `h5` one step or set it in the body face.

Create a text style for every step and bind its size, line height, family, weight, and letter spacing to these variables. The style guide writes the job next to the step.

### Motion

- `duration/instant` 80, `duration/fast` 160, `duration/base` 240, `duration/slow` 400. Jobs: hover color; buttons, fields, focus; cards, menus, theme switch; section reveal.
- `ease/standard` `cubic-bezier(0.2, 0, 0, 1)`, `ease/enter` `cubic-bezier(0, 0, 0, 1)`, `ease/exit` `cubic-bezier(0.3, 0, 1, 1)`.
- Code sets every duration to 0 under `prefers-reduced-motion: reduce`.

### Shadows

Effect styles `shadow/sm`, `shadow/md`, `shadow/lg`, `shadow/xl`, and `shadow/2xl`. Each is two effects: an inner shadow, y 1, blur 0, white at 8%, for the top edge, then the drop shadow. On Dark a drop shadow is invisible against a near-black page, so the highlight carries the elevation; on Light it disappears into white and the drop does the work. Paint a soft gray directly on the drop effect. Do not bind `color/shadow` onto it: a bound opaque color forces the alpha to 1 and the shadow turns black. There is no single shadow variable.

## Style guide page

Page name `Style guide`. The layout below is the same on every run. Specimen sizes change with the brief. The frames, the gaps, and the order do not.

Turn clip content off on every frame. A new auto-layout frame is white. Clear that fill on every section and every header. The page root is the only frame filled with `color/bg/surface`, in the theme the proposal shows first.

The page is one vertical frame, padding 64, gap 48, width 1200, counter axis fixed. Sections are its children, in this order: page title, Brand Palette, Neutral Palette, Semantic Tokens, Typography, Spacing, Shadows, Border Radius. Motion tokens are not drawn on the page; the components use them.

Section names and the page title use the display face at `weight/strong` (regular when the display face is a serif made for regular weight) with its tracking. When the system has a mono, every caption, chip label, and meta line on both pages is set in it. The job sentence uses the body face in `color/text/secondary`.

`color/bg/surface` and `color/bg/elevated` are never the same value in either theme. On Light the page is one step off white and cards are white.

Every section is a vertical frame, gap 16, counter axis fixed so it fills the column. Its first child is the header frame. The header is its own vertical frame, gap 8: the section name, then one job sentence. That gap of 8 is the gap from the title to the text. Do not leave the title and the sentence as loose siblings of the specimens. That widens the gap to 16 and the sections stop matching.

The page title uses the same header frame, with gap 16 instead of 8.

### Color chips

Do not draw a rectangle inside the chip. The frame's own fill is the swatch.

On a monochrome system the Brand Palette section keeps the same header and frame. Its ramp holds `brand/base`, then `neutral/900`, then `neutral/50`, dropping any chip whose hex repeats the one before it. The job sentence is `Monochrome brand. Accent is black on Light and white on Dark.`

Brand and Neutral are one ramp. One horizontal frame, gap 0, height 96, corner radius 8, a 1px stroke of `color/border/default`, content clipped. The chips share that width and fill the height. Each chip is horizontal, padding 8, gap 10, no radius of its own.

Semantic tokens are not a ramp. Each color is its own chip, corner radius 8, with a gap of 16 between chips. Surfaces and accents sit on the first row. Danger, success, warning, and info sit on the second. Same height, 96. No text samples or shadows in these rows.

Inside every chip the labels are a vertical frame that fills the chip and spaces the two lines apart. The step or the role (`50`, `surface`) is 12 / 16 at the top. The hex is 16 / 28 at the bottom.

On a light swatch the step is a muted gray and the hex is the primary text color, the same pair as Brand `50`. On a mid swatch both lines use the primary text color, because the muted gray disappears. On a dark swatch both lines are white. Do not use one text color for the whole ramp.

### Type scale

One vertical frame per step, gap 8, in this order:

1. The job sentence, in the body face.
2. The sample, set in the real face at the real size and line height.
3. The caption `{step} · {Family Name} {weight} · {size} / {line height} · {tracking}`.

The family name is required. In code the sample uses the fluid size, and the caption names both endpoints. A caption that only names the step and the numbers is incomplete. When the brief has desktop and mobile, the desktop sample and its caption come first, then the mobile sample and its caption, in the same frame. A portfolio lists `h1` through `h5`, `body`, `label`, and `caption`.

### Spacing

Leave the row as it is. One horizontal frame per step, gap 16: a bar whose width is the step and whose height is 16, then `{px} — {job}`. Do not replace the bars with a second kind of diagram.

### Shadows and radius

Shadows: one horizontal frame, height 96, gap 16, radius 12, the page surface behind five equal white cards. Each card fills the row, radius 8, and the name sits on the bottom. The soft gray is painted on the effect, not bound to a color variable. Do not retune the shadow.

Border radius: one horizontal frame, height 96, gap 16. `none` and `full` are squares. `sm`, `md`, and `lg` share the remaining width so the corner is visible. The nested example is its own full-width row below. The formula line sits inside the inner shape. Outer radius equals inner radius plus padding.


## Components page

Page name `Components`. The layout below is the same on every run. Token values change with the brief. The frames, the gaps, and the order do not.

One vertical frame, padding 64, gap 48. It hugs both axes. Clip content is off. Its fill is `color/bg/surface`, in the theme the proposal shows first, so a ghost label stays visible. Clear the default white fill on every inner frame.

Children, in this order, with no section headers between them:

1. The page title only, in the display face, the same size as the Style guide page title. No job sentence and no header frame.
2. Button.
3. Text field.
4. Card.
5. Badge.
6. `Icon / Search`, then `Icon / Plus`, then `Icon / Loader`. Each is a component set with one axis, Size: 16, 20, 24. These are the swap sources, not specimens. Loader is the Loading button's left icon.

Every button and text field variant is captioned with its state, so the grid reads without opening the variant panel. In Figma, each specimen sits in a vertical frame, gap 8: the instance, then a caption `{style} · {state}` for a button or `text field · {state}` for a field, at `caption` size in `color/text/muted`. The captions are not part of the component. The code page uses the same captions.

## Component construction

Third-layer variables alias `Color` and are the only fills and strokes on these components. Minimum button height 44. On Loading, hide the label and the right icon. The left slot stays. Every button, every style and every state, is the same width and the same height. That left icon is Lucide `loader-circle` at the size that matches the label line height. An icon in a button or a field is the same size as that text's line height.

Icons come from [Lucide](https://lucide.dev) (ISC). Import the SVG with `createNodeFromSvg`. Do not draw the glyph. Build every icon in three sizes, 16, 20, and 24: the same SVG, with the frame set to that size, so the stroke scales with the frame. One component set per icon, axis `Size`. Bind every stroke to `color/text/primary`. A button or field instance overrides that stroke to the label color and uses the size that matches its line height. If that line height is not 16, 20, or 24, use the nearest. The swap defaults are Lucide `search` and `plus`. The Loading state's left icon is Lucide `loader-circle`, named `Icon / Loader`. When a control needs another icon, take that name from the same set, in all three sizes. Do not add a Size axis to the button.

Padding comes from the spacing scale, not from a fixed file. The icon-to-label step is the gap inside a control. The next larger step is the button's horizontal padding. The step between those two, when the scale has one, is the field's horizontal padding. Vertical padding on a 44-tall control is 0. A badge uses the smallest step vertically and the icon-to-label step horizontally, and hugs both axes. On the scale whose card padding is 24, that is button padding 16, field padding 12, icon gap 8, badge padding 4 by 8.

The text field and the card share one reading width, fixed, not hugged. Use 320 unless the description names another. The field stacks label, control, and help with the icon-to-label gap. Zero horizontal padding is never a finished control.

A control's corner radius is `radius/sm`. A badge uses `radius/full`. The card depends on how sharp the system is. When `radius/sm` is 4 or less, the card uses `radius/md`, the image is full-bleed at the top with no radius of its own (the card clips it), and only the text group is padded. Otherwise the image is inset and the card uses the nested pair: outer radius equals inner radius plus the card padding. A 4px image inside a 28px card looks soft and off.

Use these property names. A boolean and a text value cannot share a name.

- Button: `Left icon` (boolean, on), `Left icon swap`, `Text` (boolean), `Button text` (text, default `Continue`), `Right icon`, `Right icon swap`. Import Lucide `search`, `plus`, and `loader-circle` as component sets `Icon / Search`, `Icon / Plus`, and `Icon / Loader`, each with Size 16, 20, and 24. Search and Plus are the two swap defaults. Loader is the Loading state's left icon. Use the size that matches the label line height. The label uses the label step.
- Text field: `Label` and `Help` default on. `Left icon`, `Prefix`, `Right icon`, and `Suffix` default off, each with its text or swap property. The specimen is the label, the control, and the help line. Label, value, prefix, and suffix use the label step. Help uses `caption`. The error sentence is its own text node.
- Card and badge have no extra properties. The badge's only child is its label at `caption` size. The card title uses the step whose job is a card title (`h5` on a portfolio). The card body uses `body`.

| Component | Variants |
|---|---|
| Button | The only variant axes are Style (primary, secondary, ghost) and State (default, hover, pressed, focus, disabled, loading). Do not add a Size axis. Left icon, the label, and right icon are boolean properties, each icon with a swap and the label with a text property. The swap icons are Lucide `search` and `plus` at the size that matches the label line height. Height is 44. Measure every variant and set all of them to the largest width, both axes fixed, content centered. Do not leave a style or a state on hug. `resize` sets the axis back to fixed, so set the shared width after it. The icon equals the label line height. Focus is a 2px ring of `button/focus/border` outside the button with a 2px gap of the page surface, on every style. Drawn inside, it disappears on a primary button whose fill is the accent. The ring is not a reason for a different width. Disabled uses the control tokens. Loading hides the label and the right icon, shows Lucide `loader-circle` at that same size in the left slot, and keeps this shared width. |
| Text field | The only variant axis is State: default, hover, focus, filled, disabled, error. Label, help, left icon, prefix, right icon, and suffix are boolean properties, with a text property and an icon swap for each one that shows. The control is 44 tall. Icons equal the value line height. Hover uses `field/border-hover`. Focus uses a 2px `field/border-focus` border, not a fill change. Error uses a danger border and a short how-to-fix sentence; do not bind that sentence to the shared help-text property. |
| Card | One component, no variant axis and no properties. Title uses the card-title step, body uses `body`. Elevated fill and `shadow/md`. Wrap the title and body in one group; title to body is the icon-to-label step. Inset image (soft system): pad the card with the card-padding step, image to text is the next smaller step, nested radius. Full-bleed image (sharp system): the text group is padded by the next smaller step on top and the card-padding step on the sides and bottom, card radius `radius/md`. |
| Badge | One variant axis, Tone: success, warning, danger, info. Read-only. No hover. |

Component variables, aliased:

- `button/primary/bg` → `color/accent/default`
- `button/primary/bg-hover` → `color/accent/hover`
- `button/primary/bg-pressed` → `color/accent/pressed`
- `button/primary/label` → `color/text/on-accent`
- `button/secondary/bg` → `color/bg/elevated`
- `button/secondary/border` → `color/border/strong`
- `button/secondary/border-hover` → `color/border/hover`
- `button/secondary/label` → `color/text/primary`
- `button/ghost/label` → `color/text/primary`
- `button/focus/border` → `color/border/focus`
- `field/bg` → `color/bg/sunken`
- `field/bg-danger` → `color/bg/danger`
- `field/border` → `color/border/strong`
- `field/border-hover` → `color/border/hover`
- `field/border-focus` → `color/border/focus`
- `field/border-danger` → `color/border/danger`
- `field/text` → `color/text/primary`
- `field/placeholder` → `color/text/muted`
- `field/message-danger` → `color/text/danger`
- `control/bg-disabled` → `color/bg/disabled`
- `control/text-disabled` → `color/text/disabled`
- `card/bg` → `color/bg/elevated`
- `badge/success/bg` → `color/bg/success` and `badge/success/text` → `color/text/success`. The same pair for warning, danger, and info.

Disabled beats hover. Do not draw a hover change on disabled or loading.
