# CLAUDE.md: PR & Social weekly site

## What this is
A single-page site ("PR & Social") for the weekly marketing managers update, deployed from this
GitHub repo. Tabs: Dashboard, Updates, Current Partnerships ▾, Strategy ▾, Partnership Timeline.
Brands today: NewAge Products, Wilder Home, RST.

## Hosting
- **GitHub Pages (current):** https://bdunn97.github.io/weekly-mktg-managers-bd/ publishes from
  `main` / root on every push, usually within a minute or two. Set up 2026-11-25 because Netlify
  credits ran out.
- **Netlify:** https://weekly-mktg-managers-bd.netlify.app also deploys from `main`, but its builds
  fail until the Netlify billing cycle resets. Netlify deploy previews for pull requests don't
  work until then either; review changes in the local preview instead.
- **Everything is public.** The repo is public (required for free GitHub Pages) and the Pages site
  has no password. Anyone with the link can read the weekly notes and the repo history. Remind the
  user of this if notes include anything sensitive (pricing, contracts, unannounced launches).
- GitHub Pages runs Jekyll, which skips dot-folders, so `.claude/` is not published. Don't add a
  `.nojekyll` file (it would publish `.claude/`). The weekly `.md` files have no front matter, so
  Jekyll serves them as plain files, which is what the page needs. Don't add front matter to them.

## Structure
```
index.html              The whole site: CSS, HTML and script. Design lives here. Don't change it
                        during a weekly update.
updates/
  index.json            The list of weekly files. Every file in updates/ must be listed here,
                        or the page won't see it (a website can't list a folder by itself).
  YYYY-MM-DD.md         One file per week, named by the meeting date (the Weekly Marketing
                        Managers Meeting, Wednesdays at 8am MST).
.claude/
  launch.json           "weekly-site-preview" local preview (http://localhost:8765)
  preview-server.ps1    The tiny server behind it
```

- No build step and nothing to install. GitHub Pages (and Netlify) serve the repo as is.
- The page loads `updates/index.json` and the weekly files in the browser.
- Weekly updates live only on the **Updates tab**. The Dashboard is for performance numbers
  (Sprout Social, PR platform), not weekly notes.
- The **newest** file (by date in the name) shows at the top of the Updates tab under "This week".
- **Every older** file shows below it under "Past weeks" (the archive), newest first, one
  expandable row per week.
- **Archiving is automatic.** Adding a newer file pushes the previous week into the archive.
  Never move, rename or edit past weeks unless asked.
- Opening `index.html` by double-clicking won't load the updates (the browser blocks it).
  Use the hosted site or the local preview.

## Weekly file format
```markdown
# Weekly Marketing Managers Meeting: November 25, 2026

Optional one-line summary of the week (shown above the brands).

## General
### Topic from the notes
- Cross-brand items (agencies, budget, team)

## NewAge Products
### Weekly highlights
- Short, plain sentence per item
  - Sub-point, indented 2 spaces per level
### New partners signed
- Creator name (@handle), platform – what they'll make
### Content that went live
- [Post or article title](https://link) – creator, platform

## Wilder Home

## RST
### Weekly highlights
- ...
```

Rules:
- `## Brand name` = one brand section. The page shows exactly the brands in the file, in file
  order. A new brand is just a new `##` heading. Keep the order General (if any), NewAge Products,
  Wilder Home, RST, then any new brands.
- `## General` is for cross-brand items (agencies, budget, team). The user's notes usually start
  with a "General" section; keep it first. Include it only when the notes have some. It doesn't
  count toward "x of y brands updated" in the archive.
- List **every** brand each week. A brand with nothing under its heading shows
  "No updates this week". Don't write "None" or "N/A": leave it empty.
- The three standard groups are `### Weekly highlights`, `### New partners signed`,
  `### Content that went live`. Leave out a group that has nothing that week.
  Only put items under "New partners signed" if a contract is actually signed (a pipeline or
  prospect list is not). When the notes have their own topics (e.g. "Creator content timeline"),
  use those as `###` groups instead of forcing them into the standard three.
- Supported formatting: `- ` bullets, nested bullets (indent 2 spaces per level),
  `[text](https://url)` links, `**bold**`. Nothing else. The user's notes often come from Word/
  OneNote with •, o, ▪ markers: convert each marker level to a nesting level.
- **Images / sliders:** when the user attaches photos (e.g. "add slider of attached images"),
  copy them to `updates/images/<meeting date>/` with short descriptive names
  (`1-set-closed.webp`, ...), in the order given. Add each one as a sub-bullet
  `- ![short alt text](images/<meeting date>/<file>)` under the bullet it belongs to (paths are
  relative to `updates/`). Two or more images under the same bullet show as a slider with
  ‹ › buttons; one shows as a single image. Keep each photo under ~500 KB (webp/jpg).
  Don't put the instruction text ("ADD SLIDER...") on the page.
- **Link previews:** for "add a link with a preview", put the link in the bullet text and add a
  clickable screenshot as a sub-bullet: `- [![alt](images/<date>/<name>.jpg)](https://site)`.
  It shows after that bullet's sub-points, with an "Open site ↗" link. Capture the screenshot
  with headless Edge (`msedge --headless=new --window-size=1440,1080 --screenshot=<file> <url>`,
  with a scratch `--user-data-dir`), then crop it to the one part that shows what the site is
  (the user found a full-page screenshot messy; for the WH site they wanted only the first row of
  ad videos) and save it as a JPEG about 1200px wide (~100 KB).
- Sizes: photo sliders are capped at 440px wide and link previews at 560px (in `index.html`);
  the user asked for them to be smaller than full width.
- The user's other site, the Wilder Home Creator Content Strategy hub (including the competitor
  Ad Library), is https://bdunn97.github.io/content-strategy-hub-wh/ (repo
  `bdunn97/content-strategy-hub-wh`).
- Light cleanup only: fix spacing and punctuation, bold an option or label the notes already name.
  Keep names (Margaret, Bram, Bren...), figures and wording otherwise as written.
- The date shown on the page comes from the file name, not the `#` title. Keep both in sync.
- A brand whose notes say "No updates" gets an empty heading (it shows "No updates this week").

## Weekly routine
1. The user pastes their notes (any format, possibly messy).
2. Pull `main` first, then create `updates/<meeting date>.md` (the Wednesday the notes are for)
   in the format above. Sort each
   note under the right brand and group. Keep the user's facts, names, handles and links exactly.
   Don't invent details, numbers or links. If something is ambiguous (which brand, which group),
   ask instead of guessing.
3. Add the new file name to `updates/index.json`.
4. Don't touch the previous week's file. It moves to the archive automatically.
5. Check it in the local preview (`weekly-site-preview`): the Updates tab shows the new week under
   "This week", last week under "Past weeks", and there are no console errors.
6. Show the user a short summary of what went in. Commit (`Weekly update: YYYY-MM-DD`) and push
   to `main` when they approve. Then confirm the GitHub Pages site shows the new week.

## Don't
- Don't change colors, fonts, layout or the timeline data during a weekly update.
- Don't hardcode weekly content in `index.html`.
- Brand names in the nav menus, brand switchers and Dashboard filter are still written in
  `index.html`. Adding a brand to the weekly updates doesn't need them, but its own Current
  Partnerships / Strategy pages would. Ask before adding those.
