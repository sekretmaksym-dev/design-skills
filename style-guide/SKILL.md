---
name: style-guide
description: >-
  Builds an English style guide from one brand color and a site type:
  primitive and semantic tokens (Light and Dark), spacing, radius, and type.
  Writes them to Figma, or to tokens.css plus a static browser page
  when the user does not want Figma.
  The Figma path also adds effect and text styles, a bound Style guide page,
  and basic components (button, text field, card, badge). Use when the user
  invokes /style-guide or asks to generate a style guide, design tokens, or
  a variable system from a color.
user-invocable: true
disable-model-invocation: true
---

# Style guide

Create a token system from a short brief. Write it to Figma, or to `tokens.css` when the user does not want Figma. All file text is English. The brief may be written in another language.

Read [reference.md](reference.md) before creating variables or components.

## Platform

The same skill runs in Claude Code, Cursor, and ChatGPT. Use the tools this host has. Do not name a tool the host lacks to the user.

| Need | Claude Code | Cursor | ChatGPT |
|---|---|---|---|
| Start | `/style-guide` | `/style-guide` | The user asks for a style guide or names this skill. Treat that as the command. |
| Choice window | AskUserQuestion | AskQuestion | A numbered list in chat. The user replies with the number. |
| Figma | `use_figma` from the Figma MCP server | Same | Only if a Figma connector with `use_figma` is enabled |
| Mobbin | Mobbin connector (`search_screens`, `search_flows`, `search_sections`) | Mobbin MCP | Usually missing. Use web search. |
| Web research | WebSearch, WebFetch | Web search | Web search |
| Code output | Files in the project root | Same | Downloadable files |

Before offering `figma`, check that `use_figma` is available. Where the host defers tools, load them first. If it is missing, say Figma is not connected here and offer only `code`. In Claude Code and Cursor, add that the Figma MCP server is `https://mcp.figma.com/mcp`.

Before every `use_figma` call, load the `figma-use` skill and pass `skillNames: "figma-use"`.

## Asking the user

Use the host's choice window (see Platform) only when the choice is between two or more different actions. Write the window title, prompt, and option labels in the language the user is writing in. File text stays English.

Description and links stay free text in a normal message. Do not open a choice window for them. Say what to type: the project description, and that "light only" or "dark only" limits the themes. Spacing stays on the default scale unless the description lists its own numbers. A font name in the description is the font to use.

Do not ask the user to change the proposal. They have not seen a result yet. After the proposal, ask where to put it: `figma` or `code`. Nothing is written until they answer.

Reply keywords (`figma`, `code`, `replace`, `skip`) are shown to the user in their own language, and both forms are accepted: for a Ukrainian user, `код` means `code`, `замінити` means `replace`, `немає` means `skip`. Treat any clear equivalent the same way.

When the file already has this system, that is the one choice window. Single choice, three options, labeled in the user's language: **Rebuild**, **Change one thing**, **Point out a mismatch**.

The command `/style-guide` takes no arguments. Every brief step is a normal chat message in the user's language. Do not open a choice window for it.

Each of those messages has four parts, so the step does not end without a next action:

1. Which step this is, and what is already known.
2. What to type in the next message.
3. One example they can copy.
4. If the step is optional, the exact word that skips it, and the name of the step that follows.

Ask one missing step at a time. If the user already supplied later steps, do not ask again.

## Brief

If the project has a `BRIEF.md`, take the color, site type, description, links, and screens from its "For /style-guide" section, and ask only for what is empty there.

1. **Color and site type.** Asked in chat after the command. A hex color and a short type, such as `#1DBF73 portfolio`. A color name (`white`, `black`, `білий`, `чорний`) counts as its hex. Classify it by Color input before the next step.
2. **Description.** Optional. Numbers, a font name, a radius, or "light only" / "dark only" written here are constraints. Research must not replace them.
3. **Links.** Optional. Similar sites for mood only.
4. **Screens.** Required. Ask whether the site is desktop, mobile, or both. One word in chat: `desktop`, `mobile`, or `desktop and mobile`. If the description already says which, do not ask again.

## Color input

Convert the hex to HSL and classify it:

| Kind | Rule | Examples |
|---|---|---|
| Achromatic | Saturation under 10%, or lightness above 95% or below 5% | `#FFFFFF`, `#000000`, `#808080`, `#F7F7F5` |
| Very light | Lightness 85–95% | Pastels such as `#F9D9E0` |
| Very dark | Lightness 5–20% | Navy `#0A1F44`, deep green `#0B3D2E` |
| Mid | Everything else | `#1DBF73` |

**Mid.** The hex is `brand/500`. The normal rules apply.

**Very light or very dark.** The hex sits on the brand step nearest its lightness, exactly: usually `brand/100`–`brand/300` for very light, `brand/800`–`brand/950` for very dark. Build the rest of the ramp around it. `color/accent/default` is the nearest step whose fill passes 4.5:1 with `color/text/on-accent`. When a very dark accent fails 3:1 against the Dark surface, Dark uses a lighter step of the same hue and on-accent turns to `neutral/950`.

**Achromatic.** The brand is monochrome. There is no `brand/*` ramp. Follow Monochrome in [reference.md](reference.md):

- The accent is black on Light and white on Dark.
- White or a light gray (lightness 50% or more) shows Light first. Black or a dark gray shows Dark first. "light only" or "dark only" in the description wins.
- Focus is the accent too: a black ring on Light, a white ring on Dark. No blue. The ring sits outside the control with a 2px gap, so it shows on a black or white button.
- If the description has `accent #RRGGBB`, that hex is the brand color and gets classified by this table. The achromatic input then only picks the first theme and keeps the neutral ramp untinted.

## Color scheme

One input color can carry a whole scheme. The scheme decides how many extra hues the system has, never how many accents: buttons, links, and focus always use the one accent from the input color.

| Scheme | Extra hues (OKLCH hue offset from the input) | Fits |
|---|---|---|
| Monochrome | none | Technical products, SaaS, dashboards, admin, most portfolios |
| Accent pop | none; neutrals carry the page and the accent appears only on key actions | Developer tools, fintech, minimal brands |
| Analogous | +30°, −30° | Calm marketing pages, lifestyle, food, wellness |
| Complementary | 180° | Bold launches, sport, events; one strong contrast |
| Split-complementary | 150°, 210° | Marketing landings with color-blocked sections |
| Triadic | 120°, 240° | Playful consumer brands, kids, games |
| Color coding | one hue per category the description names, spread around the wheel | Several services, courses, or product lines |

- The description wins: `scheme triadic` (or any name above) sets it, and research only checks it.
- Without one, research recommends the scheme: say which sites in the niche use which scheme, then pick one and give one sentence why. Monochrome is the default when the evidence is thin.
- An achromatic input only allows Monochrome or Accent pop, unless the description adds `accent #RRGGBB`.
- Never more than three hues in total, input included. Color coding may use more only when the description names that many categories.
- Monochrome writes no support layer, and the system stays exactly as without this section.

How extra hues are built, their roles, and their checks are in Support palettes in [reference.md](reference.md).

When the color is not mid, the step 2 message gets one extra line in the user's language: how the color was read and what that changes. For achromatic, say the system is monochrome and that an accent can be added in the description as `accent #RRGGBB`. Do not open a choice window for it.

## Type scale

Name the steps the way a document does, and write what each one is for.

Portfolio stays short: `h1`, `h2`, `h3`, `h4`, `h5`, `body`, `label`, `caption`.

Any other site type gets that set plus `h6`, `overline`, `body-sm`, and `button`. A shop also gets a `price` step.

One screen, one size per step. Desktop and mobile, two sizes per step, named `h1/desktop` and `h1/mobile`, and the same for the rest. The style guide shows both, with the job sentence once.

The site type also chooses how large the steps are. Read that from the research, then snap every size and line height to a multiple of 4. Large steps get tighter letter spacing (see Typography in reference.md). In code the sizes are fluid between the two endpoints; the endpoints are what snap to 4.

A portfolio hero is display type: the name or the sentence is the layout, clearly larger than a product page title. Do not reuse a dashboard or admin scale there. Body stays a reading size. Label, caption, buttons, and fields stay small, because they are controls. An icon beside one line of text is the same size as that line height.

A dashboard, admin, or app uses the smaller range those products actually use. Headings there sit well below a portfolio hero. The extra steps (`h6`, `overline`, `body-sm`, `button`, and `price` on a shop) follow that same smaller range.

## Fonts

Fonts come out of the research, never out of habit.

- Look at what the research sites set their headlines in (serif, neo-grotesk, condensed, mono) and what carries their meta. Choose free faces (Google Fonts) with that character.
- Do not reach for the pairings every generated site uses: Inter alone, Inter with Instrument Serif, Instrument Sans or Serif, Poppins, Montserrat, Playfair Display with a sans, or Geist, DM Sans, or Space Grotesk as the only face. Use one only when the research sites actually use it, and say so.
- Two families at most. Either a display face plus a body face, or one family for headings and body plus a mono for captions and meta.
- Name each face and the research site it came from in the proposal.

## Research

- Links and Mobbin: read the pages and search Mobbin for that product type.
- No links: Mobbin only, queried from the site type and description.
- Mobbin missing or empty: web search for that product type.

Tool names per host are in Platform. Say in the proposal whether Mobbin answered.

Take density, type character, corner mood, repeated blocks, and the color scheme each site uses (see Color scheme). Read real sizes and line heights from that site type. A portfolio search is for portfolio heroes and case studies, not for a product brand kit. Do not copy another brand's hex or logo. The palette is generated from the given color.

## Decide, then stop

Before any Figma write, post a short English proposal:

- Color role. Say which kind from Color input the hex is, and which step holds it (`brand/500`, another brand step, or `brand/base` on a monochrome system). If it fails contrast as a button fill, `color/accent/default` uses a darker step of the same hue.
- The color scheme, which research sites it came from (or that the description set it), each extra hue as hex with its offset, and the section roles it adds.
- Light and Dark, unless the description says only one.
- Which theme the canvas shows first.
- The two families and which research sites they came from, the type steps for this site type, the pixel size, line height, and tracking of each step, and whether each step has a desktop size, a mobile size, or both. Say which research those numbers came from.
- The spacing scale, the nested-radius formula, and whether the card image is full-bleed or inset.
- Any step that failed a contrast check in reference.md and what replaced it.
- A split list: **From the description** and **From research**.

Then ask in chat, in the user's language, where to put the result. Do not offer a change. One message covers it. Do not ask a second question for the file.

- `figma` plus the page name. Build on that page. If they type `figma` and name no page, create a new file, say what it is called, and build there.
- `code`. Do not call Figma. Follow Code output. A developer gets the same tokens as CSS, plus one static page they can open in a browser.

## Already there

If this file already has a **Style guide** page or collections named `Primitives`, `Color`, `Spacing`, `Radius`, or `Typography`, write nothing. Ask which one they want:

- **Rebuild.** Replace this system's variables and pages. Keep the same names so bindings survive.
- **Change one thing.** They name a color, step, font, radius, or component. Leave the rest.
- **Point out a mismatch.** They say what is wrong. Change only that, then list what changed.

Figma duplicates a variable name instead of erroring. Look up by name before creating. Never delete variables or pages that are not part of this system.

## Build

Follow [reference.md](reference.md). Order:

1. Primitives, one mode `Value`, scopes empty. A scheme with extra hues adds its `support-{n}` ramps here.
2. `Color`, modes `Light` and `Dark`, aliases only.
3. `Spacing`, `Radius`, `Typography`, `Motion`, one mode `Value`.
4. Text styles and shadow effect styles bound to those variables.
5. Page **Style guide**, built from the assembly recipe in reference.md. Same frames, same gaps, same order on every run. Specimens are bound to variables. A type caption includes the font family name.
6. Component variables that alias `Color`.
7. Page **Components**, built from the assembly recipe in reference.md. Same order, same gaps, same variant axes on every run. Do not add a Size axis or extra properties to Button, Text field, Card, or Badge. Icons come from Lucide in sizes 16, 20, and 24. A control uses the size that matches its text line height. Loading uses `loader-circle`.

Set a description, a specific scope, and WEB code syntax `var(--token-name)` on every variable. Never leave `ALL_SCOPES`.

If `addMode` fails because the plan allows one mode, stop. Say Dark needs a Professional plan or higher. Do not invent a second collection to fake it.

If a requested font is not in the file, load the nearest installed face, use it, and write the substitution at the top of **Style guide**.

Bind fills, text, gap, padding, radius, and effects on the pages to variables. The page background and titles use `color/bg/surface` and `color/text/primary`. Put the default theme on the root frame.

## Code output

Write three files in the project root unless they named a path: `tokens.css`, `style-guide.html`, and `DESIGN.md` (see Rules file). Do not also write JSON, Tailwind, SCSS, or a framework app.

`tokens.css`

- `:root` is the theme the proposal shows first. The other theme is `[data-theme="light"]` or `[data-theme="dark"]`.
- Names match the WEB syntax: `--color-bg-surface`, `--space-8`, `--radius-nested`, `--family-display`, `--size-body`.
- Primitives are `oklch()` with the sRGB hex in a comment. Semantic tokens alias primitives with `var()`, and a comment on each is its English job.
- Include spacing, radius, type, motion, and the five shadow values (`sm` to `2xl`, each with the top highlight).
- Type: keep `--size-{step}-desktop` and `-mobile` as the endpoints, and make `--size-{step}` and `--line-height-{step}` a `clamp()` from the mobile endpoint at 375px to the desktop endpoint at 1280px. Add `--tracking-{step}`.
- Motion durations go to 0 inside `@media (prefers-reduced-motion: reduce)`.

`style-guide.html`

- Copy [style-guide.template.html](style-guide.template.html) as `style-guide.html`. Edit only the JSON inside `<script id="system">`: title, input hex, site type, the `scheme` object (name, why, hues with angle and token, support ramps, section blocks; omit it or set the name to `monochrome` to hide the Color Scheme section), default theme and themes, the Google Fonts URL, intro and job sentences, brand chips (the ramp `brand/50`…`brand/950`, or the three monochrome chips), families, screens (`["desktop","mobile"]`, or one of them), the type steps with job, family, weight, and sample, the spacing jobs, radius steps, nested note, card image (`bleed` or `inset`), and field and button copy. Do not edit the HTML, CSS, or script below it, so every run produces the same page.
- When `screens` has one entry, write `--size-{step}` and `--line-height-{step}` as fixed values in `tokens.css` and skip the endpoint pairs.
- One static page. It links `tokens.css` and opens by double-click. No build step.
- The template follows the same assembly recipe as the Figma Style guide and Components pages in reference.md: same sections, order, gaps, chip layout, faces, and component grid. Sections: Brand Palette, Neutral Palette, Semantic Tokens, Typography, Spacing, Shadows, Border Radius. Then Components: button rows, text field grid, card, badges, icon sets.
- Every fill, text, gap, padding, radius, shadow, and transition uses a variable from `tokens.css`. No raw hex in the page. Chip labels resolve the live color to hex through a 1px canvas, because `getComputedStyle` returns `oklch()`.
- A control on the page switches the theme. The first theme matches the proposal.
- Page text is English. The background and titles use `--color-bg-surface` and `--color-text-primary`.

- Every control on the page, the theme switch included, is one of the page's own components with its tokens. No browser-default button or input anywhere.

If any of these files already exists, write nothing. Ask them to type `replace` (in their language), or to name what to change.

## Rules file

A style guide only helps if whoever builds next uses it. Every run, Figma or code, writes `DESIGN.md` from [design-rules.md](design-rules.md): fill the `{…}` parts from this system and keep the rest word for word. It tells any LLM or person to link `tokens.css`, use only tokens and the components, and avoid the patterns people now read as AI-made (purple gradients, glowing colored shadows, emoji icons, the centered-hero-plus-three-cards layout, invented stats).

Then, in the same reply, offer to connect it so the next session reads it without being asked. Do not write these without a yes:

- Claude Code: a line `@DESIGN.md` in the project's `CLAUDE.md`.
- Cursor: `.cursor/rules/design-system.mdc` with `alwaysApply: true` that points at `DESIGN.md`.
- Codex and other agents: a line in `AGENTS.md`.
- ChatGPT: attach `DESIGN.md` and `tokens.css` to the project, or paste `DESIGN.md` into the project instructions.

## When this system is used later

When this skill or any later request designs, codes, or vibecodes a page in a project that has `DESIGN.md` or `tokens.css`, read `DESIGN.md` first and follow it. Link `tokens.css`, build from the components, and run its "Before you finish" checks before replying.

## After

For Figma, reply with the file link, the `DESIGN.md` path, what was assumed, and which theme is on the canvas. For code, reply with the three file paths and what was assumed. Then offer the connection from Rules file. Do not start a second pass unless they ask.
