#!/usr/bin/env bash

mix local.hex --force
mix local.rebar --force
mix deps.get --only prod
MIX_ENV=prod mix deps.compile

npm install --prefix ./apps/tomie_web/assets
npm run deploy --prefix ./apps/tomie_web/assets
MIX_ENV=prod mix phx.digest

rm -rf "_build"
MIX_ENV=prod mix release
