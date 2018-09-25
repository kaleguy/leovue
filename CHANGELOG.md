# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### WIP
- header styles
- Export to JSON and LEO format
- @JSON array to subnodes
- @formio directive
- format @doc directive
- fix to inline formatting (@language htmlsource, text)
- @cover directive

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
