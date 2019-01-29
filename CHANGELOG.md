# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### WIP
- vtitle on Graphical Tree
- Graphical tree resizing
- Export to JSON and LEO format
- @formio directive
- format @doc directive
- fix Accordion mode
- fix translatePath on settings page
- font/theme button
- @tab
- add lv component list to docs
- fix bookmarked charts
- remove font awesome cdn
- fix to wordcloud example
- @hide
- @m
- @tags

## [1.21.1] - 2018-01-28
### Changed
- remove vendor.js.map from dist


## [1.21.0] - 2018-01-22
### Added
- @from directive

## [1.20.0] - 2018-01-16
### Added
- groups param in chart components


## [1.19.1] - 2018-01-10
### Added
- from param in wordcloud component

### Patch
- Wordcloud fix

## [1.19.0] - 2018-01-09
### Added
- @group
- word-cloud component


## [1.18.2] - 2018-01-03
### Changed
- change params for node list (@json nodes)


## [1.18.1] - 2018-12-28
### Changed
- fix to summary-table sort


## [1.18.0] - 2018-12-28
### Added
- Export to JSON and LEO format
- summary-table

### Changed
- Fix to scroll on @board

## [1.17.1] - 2018-11-28
### Changed
- Fix to @page scroll

## [1.17.0] - 2018-11-27
### Added
- @page directive
- Vertical scrollbar added back to content window

## [1.16.4] - 2018-11-10
### Changed
- Fix to bug causing JSON table to not display when HTML entities in content

## [1.16.3] - 2018-11-10
### Added
- @board directive

### Changed
- Style fixes, center content pane


## [1.16.2] - 2018-11-03
### Changed
- Fix to Presentations page click

## [1.16.1] - 2018-11-03
### Changed
- Fix to Presentations

## [1.16.0] - 2018-11-03
### Added
- Arrow Key tree navigation

### Changed
- Fix to Section Links in Presentation

## [1.15.0] - 2018-10-14
### Changed
- Fix to subtree routes/bookmarking
- Fix to history buttons

### Added
- Nodelist from JSON array


## [1.14.3-5] - 2018-10-14
### Changed
- removed unneeded files from npm package

## [1.14.2] - 2018-10-14
### Changed
- patched sectionlinks in external html files

## [1.14.1] - 2018-10-05
### Changed
- patched replace url function
- fix to search index on subtree load

## [1.14.0] - 2018-10-02
### Added
- @cover directive: create cover page from first node

### Changed
- Fixed inline mode style

## [1.13.2] - 2018-09-25
### Changed
- Treeview scroll fix

## [1.13.1] - 2018-09-24
### Changed
- Main screen scroll fix

## [1.13.0] - 2018-09-23
### Added
- Added Bootstrap Vue

### Changed
- removed scrollbars
- fix to onsen popup (used in mermaid charts)
- Leaflet component fix
- main doc.leo file updates

## [1.12.6] - 2018-09-21
### Changed
- Fix to md IMG style

## [1.12.5] - 2018-09-21
### Added
- Style improvements
- lconfig options for node caret, leftPaneWidth, contentPaneWidth, highlightColor

## [1.12.4] - 2018-09-11
### Changed
- Patch to fix style issues

## [1.12.3] - 2018-09-11
### Changed
- Patch to fix directive highlighting

## [1.12.0] - 2018-09-08
### Added
- Github ribbon

### Changed
- Changed name from "Leo Vue" to "LeoVue"

## [1.11.0] - 2018-09-08
### Added
- Changelog
- @language htmlsource: displays html as source with highlighting. See
  https://github.com/kaleguy/formiojs-client for example.

### Changed
- highlight Leo directives in html.
- File extension class is added to iFrame content (e.g. "iframe-txt" adds margin to .txt files)
- package.json update

### Removed
- @outline directive temporarily removed pending changes.
