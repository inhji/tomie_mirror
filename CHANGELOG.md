# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](Https://conventionalcommits.org) for commit guidelines.

<!-- changelog -->

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



