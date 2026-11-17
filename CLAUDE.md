# CLAUDE.md: PR & Social weekly site

## What this is
A single-page internal site ("PR & Social") for the weekly marketing managers update, hosted on
Netlify and deployed from this GitHub repo. Tabs: Dashboard, Updates, Current Partnerships ▾,
Strategy ▾, Partnership Timeline. Brands today: NewAge Products, Wilder Home, RST.

## Structure
```
index.html              The whole site: CSS, HTML and script. Design lives here. Don't change it
                        during a weekly update.
updates/
  index.json            The list of weekly files. Every file in updates/ must be listed here,
                        or the page won't see it (a website can't list a folder by itself).
  YYYY-MM-DD.md         One file per week, named by the week's Monday.
.claude/
  launch.json           "weekly-site-preview" local preview (http://localhost:8765)
  preview-server.ps1    The tiny server behind it
```

- No build step and nothing to install. Netlify serves the repo as is.
- The page loads `updates/index.json` and the weekly files in the browser.
- The **newest** file (by date in the name) shows on the Dashboard under "This week".
- **Every older** file shows in the Updates tab as the archive, newest first, one expandable row per week.
- **Archiving is automatic.** Adding a newer file pushes the previous week into the archive.
  Never move, rename or edit past weeks unless asked.
- Opening `index.html` by double-clicking won't load the updates (the browser blocks it).
  Use Netlify or the local preview.

## Weekly file format
```markdown
# Week of November 24, 2026

Optional one-line summary of the week (shown above the brands).

## NewAge Products
### Weekly highlights
- Short, plain sentence per item
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
  order. A new brand is just a new `##` heading. Keep the order NewAge Products, Wilder Home, RST,
  then any new brands.
- List **every** brand each week. A brand with nothing under its heading shows
  "No updates this week". Don't write "None" or "N/A": leave it empty.
- The three standard groups are `### Weekly highlights`, `### New partners signed`,
  `### Content that went live`. Leave out a group that has nothing that week.
  Other `###` groups are allowed if the notes need one.
- Supported formatting: `- ` bullets, `[text](https://url)` links, `**bold**`. Nothing else.
- The date shown on the page comes from the file name, not the `#` title. Keep both in sync.
- The Dashboard brand filter matches brand names exactly ("NewAge Products", "Wilder Home", "RST").

## Weekly routine
1. The user pastes their notes (any format, possibly messy).
2. Pull `main` first, then create `updates/<Monday's date>.md` in the format above. Sort each
   note under the right brand and group. Keep the user's facts, names, handles and links exactly.
   Don't invent details, numbers or links. If something is ambiguous (which brand, which group),
   ask instead of guessing.
3. Add the new file name to `updates/index.json`.
4. Don't touch the previous week's file. It moves to the archive automatically.
5. Check it in the local preview (`weekly-site-preview`): Dashboard shows the new week, the Updates tab
   shows last week, and there are no console errors.
6. Show the user a short summary of what went in. Commit (`Weekly update: YYYY-MM-DD`) and push
   when they approve. Use a branch + pull request if they want a Netlify deploy preview first.

## Don't
- Don't change colors, fonts, layout or the timeline data during a weekly update.
- Don't hardcode weekly content in `index.html`.
- Brand names in the nav menus, brand switchers and Dashboard filter are still written in
  `index.html`. Adding a brand to the weekly updates doesn't need them, but its own Current
  Partnerships / Strategy pages would. Ask before adding those.
