# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](Https://conventionalcommits.org) for commit guidelines.

<!-- changelog -->

## [v0.76.0](https://git.inhji.de/inhji/tomie/compare/0.75.3...v0.76.0) (2020-07-12)




### Features:

* add meta tag for csp nonce

## [v0.75.3](https://git.inhji.de/inhji/tomie/compare/0.75.2...v0.75.3) (2020-07-10)




### Bug Fixes:

* rename template dir, view

## [v0.75.2](https://git.inhji.de/inhji/tomie/compare/0.75.1...v0.75.2) (2020-07-09)




### Bug Fixes:

* add spacer for second row

### Tweaks:

* add font-display

* improve nginx config

## [v0.75.1](https://git.inhji.de/inhji/tomie/compare/0.75.0...v0.75.1) (2020-07-08)




### Bug Fixes:

* add avatar alt tag

* remove inspect calls

### Refactors:

* rename blogcontroller to postcontroller

## [v0.75.0](https://git.inhji.de/inhji/tomie/compare/0.74.0...v0.75.0) (2020-07-07)




### Features:

* add menu

* delete posts

### Tweaks:

* styles

## [v0.74.0](https://git.inhji.de/inhji/tomie/compare/0.73.2...v0.74.0) (2020-07-07)




### Features:

* self-host fonts

### Bug Fixes:

* order posts by date desc

## [v0.73.2](https://git.inhji.de/inhji/tomie/compare/0.73.1...v0.73.2) (2020-07-07)




### Bug Fixes:

* whitelist trix classes

* improve deploy script to actually restart service after deploy

## [v0.73.1](https://git.inhji.de/inhji/tomie/compare/0.73.0...v0.73.1) (2020-07-07)




### Bug Fixes:

* separate homepage styles from general styles

## [v0.73.0](https://git.inhji.de/inhji/tomie/compare/0.72.0...v0.73.0) (2020-07-06)




### Features:

* add link to public page from admin

### Refactors:

* refactor homepage styles

* load notes and articles separately

## [v0.72.0](https://git.inhji.de/inhji/tomie/compare/0.71.0...v0.72.0) (2020-07-06)




### Features:

* show posts on homepage

* customize trix editor

* first version of blog posts and notes

### Bug Fixes:

* filter bookmarks by type

### Refactors:

* rename wiki app to blog

### Tweaks:

* homepage styles

## [v0.71.0](https://git.inhji.de/inhji/tomie/compare/0.70.1...v0.71.0) (2020-07-04)




### Features:

* update to oban 2.0.0-rc3

### Bug Fixes:

* use TomieWeb.BookmarkWorker

* handle job duration for retryable jobs

### Refactors:

* move scraper functionality to http, move most workers to tomie_web

* remove scrape app

## [v0.70.1](https://git.inhji.de/inhji/tomie/compare/0.70.0...v0.70.1) (2020-07-04)




### Bug Fixes:

* make sure tesla is available in release

* update deploy script

### Refactors:

* put nginx and system configs into install folder

## [v0.70.0](https://git.inhji.de/inhji/tomie/compare/0.69.1...v0.70.0) (2020-07-02)




### Features:

* add nginx config

### Bug Fixes:

* bookmarks: add webmentions dep

## [v0.69.1](https://git.inhji.de/inhji/tomie/compare/0.69.0...v0.69.1) (2020-07-02)




### Bug Fixes:

* update tool-versions

* update deploy script

## [v0.69.0](https://git.inhji.de/inhji/tomie/compare/0.68.0...v0.69.0) (2020-07-02)




### Features:

* send webmentions from bookmark worker

## [v0.68.0](https://git.inhji.de/inhji/tomie/compare/0.67.1...v0.68.0) (2020-06-30)




### Features:

* show weekday in forecast

## [v0.67.1](https://git.inhji.de/inhji/tomie/compare/0.67.0...v0.67.1) (2020-06-28)




### Bug Fixes:

* prevent unloaded weather from crashing

* update grid columns for some pages

## [v0.67.0](https://git.inhji.de/inhji/tomie/compare/0.66.3...v0.67.0) (2020-06-27)




### Features:

* add forecast

## [v0.66.3](https://git.inhji.de/inhji/tomie/compare/0.66.2...v0.66.3) (2020-06-27)




### Bug Fixes:

* improve job details on index page

* improve tag index

* list_bookmarks_by_tag_id

### Tweaks:

* improve grid on jobs, listens, bookmarks

## [v0.66.2](https://git.inhji.de/inhji/tomie/compare/0.66.1...v0.66.2) (2020-06-26)




### Bug Fixes:

* button colors for light theme

* remove back button

## [v0.66.1](https://git.inhji.de/inhji/tomie/compare/0.66.0...v0.66.1) (2020-06-26)




### Bug Fixes:

* action bar item margin

### Tweaks:

* improve forms design GREATLY

## [v0.66.0](https://git.inhji.de/inhji/tomie/compare/0.65.0...v0.66.0) (2020-06-26)




### Features:

* make inbox default bookmark page

* centered, fixed width admin pages

### Refactors:

* rework bookmark listing functions

## [v0.65.0](https://git.inhji.de/inhji/tomie/compare/0.64.0...v0.65.0) (2020-06-26)




### Features:

* use css vars, fix spacing for header and footer

## [v0.64.0](https://git.inhji.de/inhji/tomie/compare/0.63.3...v0.64.0) (2020-06-25)




### Features:

* rework homepage styles

## [v0.63.3](https://git.inhji.de/inhji/tomie/compare/0.63.2...v0.63.3) (2020-06-24)




### Bug Fixes:

* round temp

## [v0.63.2](https://git.inhji.de/inhji/tomie/compare/0.63.1...v0.63.2) (2020-06-24)




### Bug Fixes:

* update copy-webpack-plugin, remove css-purge, use tailwind purging

## [v0.63.1](https://git.inhji.de/inhji/tomie/compare/0.63.0...v0.63.1) (2020-06-24)




### Bug Fixes:

* convert temp to celcius

## [v0.63.0](https://git.inhji.de/inhji/tomie/compare/0.62.6...v0.63.0) (2020-06-23)




### Features:

* switch to openweathermap onecall api

## [v0.62.6](https://git.inhji.de/inhji/tomie/compare/0.62.5...v0.62.6) (2020-06-21)




### Bug Fixes:

* update phoenix_live_view

## [v0.62.5](https://git.inhji.de/inhji/tomie/compare/0.62.4...v0.62.5) (2020-06-21)




### Bug Fixes:

* handle empty bookmark tags

* add tunnel config again

## [v0.62.4](https://git.inhji.de/inhji/tomie/compare/0.62.3...v0.62.4) (2020-06-20)




### Bug Fixes:

* hostname mismatch

## [v0.62.3](https://git.inhji.de/inhji/tomie/compare/0.62.2...v0.62.3) (2020-06-20)




### Bug Fixes:

* add oban to listens, scraper deps

## [v0.62.2](https://git.inhji.de/inhji/tomie/compare/0.62.1...v0.62.2) (2020-06-20)




### Bug Fixes:

* remove tunnel config

## [v0.62.1](https://git.inhji.de/inhji/tomie/compare/0.62.0...v0.62.1) (2020-06-20)




### Bug Fixes:

* attempt #1 to fix host mismatch

### Tweaks:

* mix format

## [v0.62.0](https://git.inhji.de/inhji/tomie/compare/0.61.3...v0.62.0) (2020-06-20)




### Features:

* first version of micropub for bookmarks

* add indie app, init micropub support

### Bug Fixes:

* add plug_micropub

### Refactors:

* read endpoints for micropub from config

### Tweaks:

* mix format

* read hostname from endpoint config

* leaner listen cards

## [v0.61.3](https://git.inhji.de/inhji/tomie/compare/0.61.2...v0.61.3) (2020-06-18)




### Bug Fixes:

* update useragent

## [v0.61.2](https://git.inhji.de/inhji/tomie/compare/0.61.1...v0.61.2) (2020-06-18)




### Bug Fixes:

* add dashboard page title

* make thumb size of avatar equal to homepage avatar size

* use tag_string function in home index

* bookmark mf2

### Tweaks:

* mix format

* add phoenix dashboard link to profile, dont show all user info

## [v0.61.1](https://git.inhji.de/inhji/tomie/compare/0.61.0...v0.61.1) (2020-06-16)




### Improvements:

* add refactor and tweaks for git_ops changelog

### Tweaks:

* improve bookmark page, cover basic mf2 props

## [v0.61.0](https://git.inhji.de/inhji/tomie/compare/0.60.1...v0.61.0) (2020-06-16)




### Features:

* add public bookmark route

* remove notes

## [v0.60.1](https://git.inhji.de/inhji/tomie/compare/0.60.0...v0.60.1) (2020-06-16)




### Bug Fixes:

* dont get user from pow for unauthenticated routes

## [v0.60.0](https://git.inhji.de/inhji/tomie/compare/0.59.10...v0.60.0) (2020-06-15)




### Features:

* add avatar and tag line

### Bug Fixes:

* active link for home

* revert profile routes to simple controller

* limit warnings in bookmarks

## [v0.59.10](https://git.inhji.de/inhji/tomie/compare/0.59.9...v0.59.10) (2020-06-15)




### Bug Fixes:

* typo

## [v0.59.9](https://git.inhji.de/inhji/tomie/compare/0.59.8...v0.59.9) (2020-06-15)




### Bug Fixes:

* update plug_cowboy

## [v0.59.8](https://git.inhji.de/inhji/tomie/compare/0.59.7...v0.59.8) (2020-06-15)




### Bug Fixes:

* image struct can be nil

## [v0.59.7](https://git.inhji.de/inhji/tomie/compare/0.59.6...v0.59.7) (2020-06-09)




### Bug Fixes:

* visual tweaks

## [v0.59.6](https://git.inhji.de/inhji/tomie/compare/0.59.5...v0.59.6) (2020-06-09)




### Bug Fixes:

* project pages

* rel=me links

* project links

* project routes

## [v0.59.5](https://git.inhji.de/inhji/tomie/compare/0.59.4...v0.59.5) (2020-06-08)




### Bug Fixes:

* smol improvements to homepage structure

* update favicon

## [v0.59.4](https://git.inhji.de/inhji/tomie/compare/0.59.3...v0.59.4) (2020-06-07)




### Bug Fixes:

* colors for a::before

* remove projects for now

* lighter background

## [v0.59.3](https://git.inhji.de/inhji/tomie/compare/0.59.2...v0.59.3) (2020-06-07)




### Bug Fixes:

* add p-note to subtitle

## [v0.59.2](https://git.inhji.de/inhji/tomie/compare/0.59.1...v0.59.2) (2020-06-07)




### Bug Fixes:

* add stupid subtitle

* add link to source

## [v0.59.1](https://git.inhji.de/inhji/tomie/compare/0.59.0...v0.59.1) (2020-06-07)




### Bug Fixes:

* actually use the new css lol

## [v0.59.0](https://git.inhji.de/inhji/tomie/compare/0.58.0...v0.59.0) (2020-06-07)




### Features:

* redesign homepage

## [v0.58.0](https://git.inhji.de/inhji/tomie/compare/0.57.0...v0.58.0) (2020-06-01)




### Features:

* initial homepage

* initial home styles

* initial home route

* add home css bundle

* add wiki app

### Improvements:

* move routes to /admin scope

## [v0.57.0](https://git.inhji.de/inhji/tomie/compare/0.56.0...v0.57.0) (2020-06-01)




### Features:

* add trix editor

### Bug Fixes:

* finally remove warning about list_bookmarks

### Improvements:

* more weather data

* handle opening note

## [v0.56.0](https://git.inhji.de/inhji/tomie/compare/0.55.0...v0.56.0) (2020-05-27)




### Features:

* add navigation to top level notes

### Bug Fixes:

* remove index

## [v0.55.0](https://git.inhji.de/inhji/tomie/compare/0.54.0...v0.55.0) (2020-05-26)




### Features:

* count tagged posts on tag index

### Bug Fixes:

* unused vars

## [v0.54.0](https://git.inhji.de/inhji/tomie/compare/0.53.0...v0.54.0) (2020-05-24)




### Features:

* prepare note navigation

* add note navigation helper

## [v0.53.0](https://git.inhji.de/inhji/tomie/compare/0.52.0...v0.53.0) (2020-05-24)




### Features:

* add queue overview page

### Bug Fixes:

* add focusable class to note card footer to have simple footers for queues

### Improvements:

* refactor album cover fetching

## [v0.52.0](https://git.inhji.de/inhji/tomie/compare/0.51.3...v0.52.0) (2020-05-23)




### Features:

* implement keyboard navigation for notebooks

### Bug Fixes:

* adapt nprogress to being at the bottom

* read pow cache backend from config

### Improvements:

* tweak nprogress bar

## [v0.51.3](https://git.inhji.de/inhji/tomie/compare/0.51.2...v0.51.3) (2020-05-23)




### Bug Fixes:

* remove theme toggle

### Improvements:

* show username in navbar

* make profile show a liveview

## [v0.51.2](https://git.inhji.de/inhji/tomie/compare/0.51.1...v0.51.2) (2020-05-23)




### Bug Fixes:

* run weather job every 5 minutes

## [v0.51.1](https://git.inhji.de/inhji/tomie/compare/0.51.0...v0.51.1) (2020-05-23)




### Bug Fixes:

* clean up scraper, add cachex dep

## [v0.51.0](https://git.inhji.de/inhji/tomie/compare/0.50.3...v0.51.0) (2020-05-22)




### Features:

* add weather worker, show weather on index page

### Improvements:

* new Scraper.Html module

## [v0.50.3](https://git.inhji.de/inhji/tomie/compare/0.50.2...v0.50.3) (2020-05-22)




### Bug Fixes:

* last_listen_timestamp not updating

## [v0.50.2](https://git.inhji.de/inhji/tomie/compare/0.50.1...v0.50.2) (2020-05-22)




### Bug Fixes:

* set listens per fetch to 50

## [v0.50.1](https://git.inhji.de/inhji/tomie/compare/0.50.0...v0.50.1) (2020-05-21)




### Bug Fixes:

* typo

## [v0.50.0](https://git.inhji.de/inhji/tomie/compare/0.49.0...v0.50.0) (2020-05-21)




### Features:

* add new light theme

### Bug Fixes:

* set genres/styles to empty list if nil

* discogs worker cache missing

### Improvements:

* account for empty cache for last_listen/timestamp

## [v0.49.0](https://git.inhji.de/inhji/tomie/compare/0.48.1...v0.49.0) (2020-05-21)




### Features:

* add job stats

## [v0.48.1](https://git.inhji.de/inhji/tomie/compare/0.48.0...v0.48.1) (2020-05-19)




### Bug Fixes:

* handle missing image

* error when mutiple tracks with same name exist after merge

## [v0.48.0](https://git.inhji.de/inhji/tomie/compare/0.47.3...v0.48.0) (2020-05-19)




### Features:

* rework, discogs_album worker, fetch genres/styles, show genres/styles

## [v0.47.3](https://git.inhji.de/inhji/tomie/compare/0.47.2...v0.47.3) (2020-05-18)




### Bug Fixes:

* source zshrc before building

## [v0.47.2](https://git.inhji.de/inhji/tomie/compare/0.47.1...v0.47.2) (2020-05-18)




### Bug Fixes:

* use zsh for deploy.sh

## [v0.47.1](https://git.inhji.de/inhji/tomie/compare/0.47.0...v0.47.1) (2020-05-18)




### Bug Fixes:

* use zsh for build.sh

## [v0.47.0](https://git.inhji.de/inhji/tomie/compare/0.46.4...v0.47.0) (2020-05-18)




### Features:

* add http app, consolidate http requests

### Bug Fixes:

* use releases endpoint if discogs_id exists

## [v0.46.4](https://git.inhji.de/inhji/tomie/compare/0.46.3...v0.46.4) (2020-05-17)




### Bug Fixes:

* show search link when album discogs_id is -1

* activate merge

## [v0.46.3](https://git.inhji.de/inhji/tomie/compare/0.46.2...v0.46.3) (2020-05-17)




### Bug Fixes:

* deep merge, closes #50

## [v0.46.2](https://git.inhji.de/inhji/tomie/compare/0.46.1...v0.46.2) (2020-05-16)




### Bug Fixes:

* checkbox is no longer centered

### Improvements:

* support image deletion

* link discogs id

* show discogs id

* make artists clickable, add title to top artists

## [v0.46.1](https://git.inhji.de/inhji/tomie/compare/0.46.0...v0.46.1) (2020-05-16)




### Bug Fixes:

* redirection after merge

## [v0.46.0](https://git.inhji.de/inhji/tomie/compare/0.45.0...v0.46.0) (2020-05-16)




### Features:

* merge albums

### Improvements:

* add page title for almost all routes

## [v0.45.0](https://git.inhji.de/inhji/tomie/compare/0.44.1...v0.45.0) (2020-05-16)




### Features:

* update page title

* add csharp/vbnet code, tweak colors

## [v0.44.1](https://git.inhji.de/inhji/tomie/compare/0.44.0...v0.44.1) (2020-05-16)




### Bug Fixes:

* TLS Handshake error

### Improvements:

* show more job details

## [v0.44.0](https://git.inhji.de/inhji/tomie/compare/0.43.1...v0.44.0) (2020-05-14)




### Features:

* add global earmark options

## [v0.43.1](https://git.inhji.de/inhji/tomie/compare/0.43.0...v0.43.1) (2020-05-14)




### Bug Fixes:

* prevent stripping syntax highlighting styles

* add listens to started apps

### Improvements:

* link to artist from album show

## [v0.43.0](https://git.inhji.de/inhji/tomie/compare/0.42.1...v0.43.0) (2020-05-11)




### Features:

* edit albums

* add iex.exs

### Improvements:

* link albums on album page

* new album empty image

## [v0.42.1](https://git.inhji.de/inhji/tomie/compare/0.42.0...v0.42.1) (2020-05-11)




### Bug Fixes:

* nicer listen bubbles for artists

* handle available jobs

* smol top margin for main nav

* profile works again, smol unused stuff

### Improvements:

* make series generation more modular

* nicer album overview

## [v0.42.0](https://git.inhji.de/inhji/tomie/compare/0.41.0...v0.42.0) (2020-05-10)




### Features:

* add by_day/2, nicer chart

### Bug Fixes:

* add z-index to navigation

### Improvements:

* nicer artists page

## [v0.41.0](https://git.inhji.de/inhji/tomie/compare/0.40.0...v0.41.0) (2020-05-10)




### Features:

* start queue when in iex and QUEUE=true

### Bug Fixes:

* remove queue tabs in job index

* tag default rules not being created when using Tags.create_tag/1

### Improvements:

* increate listen worker concurrency, preserving uniqueness

## [v0.40.0](https://git.inhji.de/inhji/tomie/compare/0.39.0...v0.40.0) (2020-05-09)




### Features:

* show msid/mbid for artists/albums

### Bug Fixes:

* remove unused params

* rename top artists/albums

* only add default tag rule on insert

## [v0.39.0](https://git.inhji.de/inhji/tomie/compare/0.38.0...v0.39.0) (2020-05-06)




### Features:

* use Report.top for artist chart

* show newest artists/albums

### Bug Fixes:

* cross link albums/artists

## [v0.38.0](https://git.inhji.de/inhji/tomie/compare/0.37.0...v0.38.0) (2020-05-05)




### Features:

* add prismjs highlighting

## [v0.37.0](https://git.inhji.de/inhji/tomie/compare/0.36.0...v0.37.0) (2020-05-05)




### Features:

* add icons to bookmark buttons

* add bookmark sidebar

* improve card meta

### Bug Fixes:

* main nav padding

### Improvements:

* give home link a title

* turn bookmark visit link into live_redirect

* use coffe icon for jobs

## [v0.36.0](https://git.inhji.de/inhji/tomie/compare/0.35.1...v0.36.0) (2020-05-05)




### Features:

* add icons to main nav

## [v0.35.1](https://git.inhji.de/inhji/tomie/compare/0.35.0...v0.35.1) (2020-05-05)




### Bug Fixes:

* back from edit leads to show

## [v0.35.0](https://git.inhji.de/inhji/tomie/compare/0.34.2...v0.35.0) (2020-05-04)




### Features:

* add icon to add bookmark button

* show tagged bookmarks on tag show page

### Bug Fixes:

* revert gzip to false

* use live_patch on tag show page

* job duration for discarded jobs

* card styles for job errors

### Improvements:

* turn on gzip for static assets

## [v0.34.2](https://git.inhji.de/inhji/tomie/compare/0.34.1...v0.34.2) (2020-05-04)




### Bug Fixes:

* use normal path for site.webmanifest

* add markdown class to note content

## [v0.34.1](https://git.inhji.de/inhji/tomie/compare/0.34.0...v0.34.1) (2020-05-04)




### Bug Fixes:

* use inserted_at as order column

## [v0.34.0](https://git.inhji.de/inhji/tomie/compare/0.33.2...v0.34.0) (2020-05-04)




### Features:

* add edit button to note component

* add markdown rendering to notes content

### Bug Fixes:

* order jobs by started_at

## [v0.33.2](https://git.inhji.de/inhji/tomie/compare/0.33.1...v0.33.2) (2020-05-03)




### Bug Fixes:

* correct mnesia dir syntax?

## [v0.33.1](https://git.inhji.de/inhji/tomie/compare/0.33.0...v0.33.1) (2020-05-03)




### Bug Fixes:

* add mnesia to extra_applications

## [v0.33.0](https://git.inhji.de/inhji/tomie/compare/0.32.2...v0.33.0) (2020-05-03)




### Features:

* use proper session cache :)))

## [v0.32.2](https://git.inhji.de/inhji/tomie/compare/0.32.1...v0.32.2) (2020-05-03)




### Bug Fixes:

* remove warnings

## [v0.32.1](https://git.inhji.de/inhji/tomie/compare/0.32.0...v0.32.1) (2020-05-03)




### Bug Fixes:

* listen card styles

### Improvements:

* inbox shows only untagged bookmarks

* artist/album card styles

## [v0.32.0](https://git.inhji.de/inhji/tomie/compare/0.31.1...v0.32.0) (2020-05-02)




### Features:

* show card footer only on focus

### Bug Fixes:

* excess spacing on notes

* fucked up closure_table dep

### Improvements:

* move navigation to separate file

## [v0.31.1](https://git.inhji.de/inhji/tomie/compare/0.31.0...v0.31.1) (2020-05-02)




### Bug Fixes:

* fucked up closure_table dep

## [v0.31.0](https://git.inhji.de/inhji/tomie/compare/0.30.0...v0.31.0) (2020-05-02)




### Features:

* delete note

* delete notebook

* add card footer, remote root note component

* add card content class

* add notes, initial ugly ui

* delete notes on notebook delete

* update notebooks

* edit notes

* add initial notes application

### Bug Fixes:

* missing content classes on jobs and tags

* return of the confirmation box on delete :)

* bookmark html missing content class

* rename notebook form

### Improvements:

* make either title or content required for note

## [v0.30.0](https://git.inhji.de/inhji/tomie/compare/0.29.0...v0.30.0) (2020-04-29)




### Features:

* add names to user, improve profile

* add listen charts route

* album show

### Improvements:

* add grid to tag index

## [v0.29.0](https://git.inhji.de/inhji/tomie/compare/0.28.0...v0.29.0) (2020-04-29)




### Features:

* update silly chart, load though hooks

* add chart.js and chartkick from npm

### Bug Fixes:

* add @babel/plugin-proposal-export-default-from

## [v0.28.0](https://git.inhji.de/inhji/tomie/compare/0.27.0...v0.28.0) (2020-04-29)




### Features:

* simple markdown styles

### Bug Fixes:

* increase textarea size in bookmark form

## [v0.27.0](https://git.inhji.de/inhji/tomie/compare/0.26.4...v0.27.0) (2020-04-28)




### Features:

* noodling

## [v0.26.4](https://git.inhji.de/inhji/tomie/compare/0.26.3...v0.26.4) (2020-04-28)




### Improvements:

* format chart date

* wrap chart in card

* artist/album pages span 2 weeks now

## [v0.26.3](https://git.inhji.de/inhji/tomie/compare/0.26.2...v0.26.3) (2020-04-28)




### Bug Fixes:

* remove inspects

* greatly improve silly chart

* nicer chart colors

## [v0.26.2](https://git.inhji.de/inhji/tomie/compare/0.26.1...v0.26.2) (2020-04-28)




## [v0.26.1](https://git.inhji.de/inhji/tomie/compare/0.26.0...v0.26.1) (2020-04-28)




## [v0.26.0](https://git.inhji.de/inhji/tomie/compare/0.25.0...v0.26.0) (2020-04-28)




### Features:

* add silly listen chart

### Bug Fixes:

* remove jobstate

* prevent listen image from shrinking

## [v0.25.0](https://git.inhji.de/inhji/tomie/compare/0.24.3...v0.25.0) (2020-04-27)




### Features:

* add top albums/artists :)

* add report module for listens

* add listen sidebar

### Improvements:

* add new job icons, move icon functions to jobview

## [v0.24.3](https://git.inhji.de/inhji/tomie/compare/0.24.2...v0.24.3) (2020-04-27)




### Bug Fixes:

* skip albums without msid

## [v0.24.2](https://git.inhji.de/inhji/tomie/compare/0.24.1...v0.24.2) (2020-04-26)




### Bug Fixes:

* improve card styles

## [v0.24.1](https://git.inhji.de/inhji/tomie/compare/0.24.0...v0.24.1) (2020-04-26)




### Improvements:

* icons on artist page

## [v0.24.0](https://git.inhji.de/inhji/tomie/compare/0.23.0...v0.24.0) (2020-04-26)




### Features:

* show last listens per album

### Improvements:

* more info on artist page

## [v0.23.0](https://git.inhji.de/inhji/tomie/compare/0.22.3...v0.23.0) (2020-04-26)




### Features:

* listens: add artist page

### Bug Fixes:

* support image sizes for artists, albums

* uploader default path

* warnings

## [v0.22.3](https://git.inhji.de/inhji/tomie/compare/0.22.2...v0.22.3) (2020-04-26)




### Bug Fixes:

* list listens by listened_at

## [v0.22.2](https://git.inhji.de/inhji/tomie/compare/0.22.1...v0.22.2) (2020-04-25)




### Bug Fixes:

* migrator

## [v0.22.1](https://git.inhji.de/inhji/tomie/compare/0.22.0...v0.22.1) (2020-04-25)




### Bug Fixes:

* make uploads directory configurable

## [v0.22.0](https://git.inhji.de/inhji/tomie/compare/0.21.0...v0.22.0) (2020-04-25)




### Features:

* listens: update listens on worker completion

* add initial listen overview page

* listens: add artist and album image workers

### Bug Fixes:

* upload path

* separate job errors

* handle_info without page nor queue params

* pass down job_id to pubsub

* reduce attempts of listenbrainz worker

* limit concurrency to 1 for listens

* payload string too long in NOTIFY trigger

* prevent merging unrelated albums

### Improvements:

* listen cards

* clean up logging in listenbrainz worker

* unified stats for listenbrainz worker

## [v0.21.0](https://git.inhji.de/inhji/tomie/compare/0.20.0...v0.21.0) (2020-04-24)




### Features:

* listens: add sidebar component

* add bookmark icon

### Bug Fixes:

* handle_info without page nor queue params

* pass down job_id to pubsub

* reduce attempts of listenbrainz worker

* limit concurrency to 1 for listens

* payload string too long in NOTIFY trigger

* prevent merging unrelated albums

* assign existing bookmark jobs to bookmark queue

* put bookmark worker in bookmark queue

### Improvements:

* clean up logging in listenbrainz worker

* unified stats for listenbrainz worker

## [v0.20.0](https://git.inhji.de/inhji/tomie/compare/0.19.0...v0.20.0) (2020-04-24)




### Features:

* listens: listenbrainz worker

* listens: add album functions, fix schemas

### Bug Fixes:

* duration crashes when completed_at is nil

* missing db references

### Improvements:

* limit jobs on dashboard to 50

## [v0.19.0](https://git.inhji.de/inhji/tomie/compare/0.18.0...v0.19.0) (2020-04-23)




### Features:

* listens: create tables, switch to waffle for uploading

### Bug Fixes:

* add ecto to formatter config

## [v0.18.0](https://git.inhji.de/inhji/tomie/compare/0.17.0...v0.18.0) (2020-04-23)




### Features:

* update jobs index when job is updated

## [v0.17.0](https://git.inhji.de/inhji/tomie/compare/0.16.0...v0.17.0) (2020-04-23)




### Features:

* update to phoenix 1.5

## [v0.16.0](https://git.inhji.de/inhji/tomie/compare/0.15.3...v0.16.0) (2020-04-22)




### Features:

* turn tag routes into live view thingies

### Bug Fixes:

* whitelist nprogress classes in purgecss

## [v0.15.3](https://git.inhji.de/inhji/tomie/compare/0.15.2...v0.15.3) (2020-04-22)




### Bug Fixes:

* make email field an actual email field lol

* tweak main#content nav hover styles

* tweak notification colors

* tweak divider colors

### Improvements:

* bring alerts back

## [v0.15.2](https://git.inhji.de/inhji/tomie/compare/0.15.1...v0.15.2) (2020-04-22)




### Bug Fixes:

* remove downtime in deploy script

## [v0.15.1](https://git.inhji.de/inhji/tomie/compare/0.15.0...v0.15.1) (2020-04-22)




### Bug Fixes:

* include date in job info

## [v0.15.0](https://git.inhji.de/inhji/tomie/compare/0.14.0...v0.15.0) (2020-04-22)




### Features:

* show retryable jobs in sidebar

### Improvements:

* show more job info on job show

## [v0.14.0](https://git.inhji.de/inhji/tomie/compare/0.13.1...v0.14.0) (2020-04-22)




### Features:

* add job sidebar

* add listen app

### Bug Fixes:

* whitelist active class in purgecss

## [v0.13.1](https://git.inhji.de/inhji/tomie/compare/0.13.0...v0.13.1) (2020-04-21)




### Bug Fixes:

* follow redirects in get_html/1

## [v0.13.0](https://git.inhji.de/inhji/tomie/compare/0.12.0...v0.13.0) (2020-04-21)




### Features:

* job show page

### Improvements:

* jobs index layout

## [v0.12.0](https://git.inhji.de/inhji/tomie/compare/0.11.0...v0.12.0) (2020-04-21)




### Features:

* search tags with ilike instead of equals

* order tags by name

### Improvements:

* tags and favorite status on bookmarks

* add iconview to render svg icons

## [v0.11.0](https://git.inhji.de/inhji/tomie/compare/0.10.0...v0.11.0) (2020-04-20)




### Features:

* make sidebar sticky :DDD

* make main nav scrollable on smol devices

### Improvements:

* nicer job overview

## [v0.10.0](https://git.inhji.de/inhji/tomie/compare/0.9.0...v0.10.0) (2020-04-20)




### Features:

* initial job dashboard

### Improvements:

* limit Bookmark worker to 5 attempts

* move telemetry to Tomie

## [v0.9.0](https://git.inhji.de/inhji/tomie/compare/0.8.0...v0.9.0) (2020-04-20)




### Features:

* replace que with oban :)

## [v0.8.0](https://git.inhji.de/inhji/tomie/compare/0.7.1...v0.8.0) (2020-04-20)




### Features:

* show archive in bookmark index, hide archived bookmarks elsewhere

* add archive action to bookmark

* Navigate to selected filter on Bookmark show backbutton, fixes #25

## [v0.7.1](https://git.inhji.de/inhji/tomie/compare/0.7.0...v0.7.1) (2020-04-20)




### Bug Fixes:

* make sub navigation scrollable on smol screens

## [v0.7.0](https://git.inhji.de/inhji/tomie/compare/0.6.1...v0.7.0) (2020-04-19)




### Features:

* add favorite action for bookmark

### Bug Fixes:

* expand scope of .icon class

* use Phoenix.PubSub.subscribe/3

## [v0.6.1](https://git.inhji.de/inhji/tomie/compare/0.6.0...v0.6.1) (2020-04-19)




### Bug Fixes:

* link to popular bookmarks

## [v0.6.0](https://git.inhji.de/inhji/tomie/compare/0.5.1...v0.6.0) (2020-04-19)




### Features:

* add telemetry and live_dashboard :))

* update to Phoenix 1.5 RC0 :))

### Improvements:

* show recent page as default

* only show host of bookmark source, hyphenate source & title

## [v0.5.1](https://git.inhji.de/inhji/tomie/compare/0.5.0...v0.5.1) (2020-04-18)




### Bug Fixes:

* rename home to popular

## [v0.5.0](https://git.inhji.de/inhji/tomie/compare/0.4.0...v0.5.0) (2020-04-18)




### Features:

* add inbox which shows untagged/unviewed bookmarks

* add icons to sidebar, hide text on smol devices

### Bug Fixes:

* add .button to all submit buttons to prevent stripping their styles

* incorrect App name in systemd service

### Improvements:

* swap id and slug in visit route

### Performance Improvements:

* run npm run deply with node env production

## [v0.4.0](https://git.inhji.de/inhji/tomie/compare/0.3.0...v0.4.0) (2020-04-17)




### Features:

* preserve search query when switching filters in sidebar

* add is_favorite, is_published, is_archived fields to bookmark

* initial sidebar for bookmark index

* favicon

## [v0.3.0](https://git.inhji.de/inhji/tomie/compare/0.2.2...v0.3.0) (2020-04-17)




### Features:

* search by tags

## [v0.2.2](https://git.inhji.de/inhji/tomie/compare/0.2.1...v0.2.2) (2020-04-17)




### Bug Fixes:

* redirect to bookmark source through LinkController

## [v0.2.1](https://git.inhji.de/inhji/tomie/compare/0.2.0...v0.2.1) (2020-04-16)




### Bug Fixes:

* add changeset error when content cannot be rendered

* dont render markdown inside p tag

## [v0.2.0](https://git.inhji.de/inhji/tomie/compare/0.1.1...v0.2.0) (2020-04-16)




### Features:

* show views and inserted at on bookmark show

## [v0.1.1](https://git.inhji.de/inhji/tomie/compare/0.1.1...v0.1.1) (2020-04-16)



