# Research sources

Use the best source that actually responds. A connected tool can still refuse, so probe it before relying on it. When one fails, say so in one line and move to the next.

## Priority

1. **Paid SEO tools**, if the plan allows: Ahrefs, Semrush.
2. **Google Keyword Planner**, through a connected tool or an export from the user.
3. **Free SEO tools**, such as the free-seo MCP server.
4. **Web search and the browser.**

Nothing connected is a normal case. Continue with web search, and mark volumes `unverified`.

## Ahrefs

Do not trust the free test query (`keywords: "ahrefs"`): it passes even on plans that refuse real data. Probe with one real keyword from the brief and the target country in `keywords-explorer-overview`. It costs a few units. "Insufficient plan" means the connector works but the plan does not allow it: say so and move on.

Useful tools: `keywords-explorer-overview`, `keywords-explorer-matching-terms`, `keywords-explorer-related-terms`, `keywords-explorer-volume-history`, `serp-overview`, `site-explorer-metrics`, `site-explorer-top-pages`, `site-explorer-organic-competitors`. Most calls spend API units, so query only ideas that are still in the running.

## free-seo

- Demand wording: `suggest`, `expand_alphabet`, `expand_questions`, `expand_multilingual`
- Direction: `trends_compare`, `trends_related`, `trends_by_region`
- Rough volume: `bing_keyword`, `bing_related_keywords`, `bing_keyword_history` (need a free Bing Webmaster key), `estimate_volumes`
- Competitors: `sitemap_urls`, `page_outline`
- Keep results: `keywords_save`, `keywords_load`
- `reddit_search` is often refused on home and VPN networks. Use web search or the browser instead.

## Web and browser

- Pain: forums, Reddit, and reviews on G2, Capterra, app stores, and marketplaces
- Willingness to pay: competitor pricing, Fiverr and Upwork listings, long-running ads
- Momentum: Product Hunt, recent launches, dated articles

Open the page before citing it. A search snippet is not a source. Check the page's date. A page older than two years is cited with its year and is not used for prices or competitor status. For fees and rules (a platform's commission, a law), look for a newer version first; if none exists, cite the old one with its year.

Web search can be weighted to one country (often the US). For another market, search in the local language, add the country or city name, open local directories and maps in the browser, and write in the brief which sources were thin.

## When a page or tool refuses

- **403, bot check, or timeout:** open the page in the browser pane or browser extension, which loads it as a person would. Never try to get around a bot check with other request tricks.
- **Still blocked:** use a secondary source that quotes it (a law firm's summary, a legal database such as ligazakon, an archived copy), label it `secondary`, and name the original you could not open.
- **Google Trends returns 0 for everything:** the query is too narrow for the country. Try the broader term, the English term, or a neighbouring country; if all are 0, drop Trends and say so instead of reporting a flat line.

## Regulated niches

For health, finance, law, gambling, alcohol, children, and anything that needs a licence:

1. Find the law or regulation on the official source: the country's legislation portal (for Ukraine, zakon.rada.gov.ua) or the regulator's own site.
2. Quote the article number and what it allows or forbids for the page (reviews, before and after photos, prices, guarantees, named specialists).
3. Say whether the rule clearly covers the business's own site, or whether that is unsettled.
4. Label it `official`, write "not legal advice; check with a lawyer before launch", and put it under **Risks**.

A government summary or news item counts as `official` only when it is the regulator's own page; otherwise it is `anecdotal`.

## Labelling every number

| Label | Meaning |
|---|---|
| `measured` | From a paid tool or the user's own analytics |
| `official` | Statistics office, central bank, legislation, regulator |
| `observed` | Read directly on a page you opened: a feature, a price, a broken button |
| `vendor` | A company's own price page or claim about itself |
| `user-stated` | Said by the user or client, not checked |
| `secondary` | Someone else's summary of a source you could not open |
| `estimate` | Modelled from free data |
| `relative` | A trend index from 0 to 100, which is not a volume |
| `anecdotal` | Posts, reviews, a few examples |
| `assumption` | No source; a stated guess |

Record the source and the date beside the figure.

`measured` is only for data from a tool or an account. A few results seen once in a marketplace search are `anecdotal`.

Google Trends rounds rare queries to 0, so a 0 does not mean no demand. To claim a rise or fall, compare the same weeks year over year on a 5-year window. Comparing two parts of one year mixes trend with season.

A fact that only a reviewer found stays `secondary` until you open its page yourself.

Vendor blogs often repeat one another's figures, so count them as one source. A listing page changes daily, so record the figure and the date.
