# Design system: SaaS analytics

Built by the style-guide skill on 2026-11-06 from `#E8553F` for a saas. Light and Dark; Light is the default.

Everything visual on this project comes from this system. Before you design, write UI code, or generate a page, read this file and the source of truth:

- Tokens: `./tokens.css`
- Specimens and component markup: `./style-guide.html`
- Figma: none.

## Use the tokens

1. Link `tokens.css` on every page, before any other stylesheet. In a framework, import it once at the root. With Tailwind, map the tokens into the theme (`colors`, `spacing`, `borderRadius`, `fontFamily`, `fontSize`, `boxShadow`, `transitionDuration`) and remove the default palette, so `bg-indigo-500` and friends do not exist.
2. Every color, font, size, line height, letter spacing, gap, padding, radius, shadow, and duration is a `var(--…)` from `tokens.css`. No raw hex, `rgb()`, `oklch()`, px font sizes, or ad-hoc shadows in components.
3. Use semantic tokens (`--color-bg-surface`, `--color-text-secondary`), or component tokens (`--button-primary-bg`), never primitives (`--neutral-500`) on a layer.
4. Theme switching is `data-theme="light|dark"` on `<html>`. Do not write separate colors for dark mode.
5. In Figma, apply variables, text styles, and effect styles, and use component instances. Never detach an instance or type a raw value.

## Use the components

Build controls from the components in `style-guide.html` (copy the markup and classes) or the Figma `Components` page. Do not restyle them per page.

- Button: primary (coral, brand/600 on Light, brand/500 with a dark label on Dark), secondary (outlined), ghost. Height 44px, radius `--radius-sm`, label at `button`. Every state is defined: default, hover, pressed, focus, disabled, loading. Focus is a 2px ring outside with a 2px gap.
- Text field: label, 44px control, help or error line. Border `--field-border`, focus 2px `--field-border-focus`. Error says how to fix it.
- Card: inset image + nested radius. Title at `h5`, body at `body`.
- Badge: tones success, warning, danger, info. Pill, caption size.
- Icons: Lucide only, at 16, 20, or 24, matching the line height of the text beside it.

A new component is built from the same tokens and gets every state the nearest existing component has.

## Type

Hanken Grotesk for headings and reading, JetBrains Mono for captions, overlines, and numbers in tables. No other fonts. Headings use their step's size, line height, and tracking. Desktop only: each step has one size.

## Do not

These are the patterns people now read as "an AI made this". None of them belong here unless this file says otherwise.

- Purple, indigo, or blue-to-purple gradients; gradient text; any color outside `tokens.css`.
- Colored or glowing shadows, neon outlines, `box-shadow` that is not a `--shadow-*` token.
- Emoji as icons, bullets, or in headings and buttons. ✨🚀 in copy.
- The default landing: centered hero with a pill badge above the H1, then three icon cards in a row, then a gradient CTA band.
- Glassmorphism and backdrop blur, rounded-2xl on everything, a radius that is not a token.
- Invented stats, logos, and testimonials. Template copy like "Unlock the power of…", "Seamless", "Elevate".
- A second accent color "for variety". Coral is the only brand color; focus is neutral because coral sits too close to the danger red.
- Replacing one default with another "tasteful" one (cream background, serif, sage accent). A pattern is a problem when nobody chose it.

## Motion

Durations and curves are `--duration-*` and `--ease-*`. Everything respects `prefers-reduced-motion`. One or two effects per page at most (for example, a hero reveal and a card hover). Effects from animation libraries are allowed only after they are ported onto these tokens.

## Before you finish

- Search the new code for `#`, `rgb(`, `oklch(`, `px` font sizes, and `box-shadow`. Each one must be a token.
- Check text contrast: 4.5:1 for text, 3:1 for field borders and focus rings.
- Check every interactive element has hover, focus, and disabled states from the components.
- If something needs a value the system lacks, add a token to `tokens.css` (and Figma) with a job comment. Do not hard-code it.
