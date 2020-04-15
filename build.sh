#!/usr/bin/env bash

mix local.hex --if-missing --force
mix local.rebar --if-missing --force
mix deps.get --only prod
MIX_ENV=prod mix deps.compile

npm install --prefix ./apps/tomie_web/assets
npm run deploy --prefix ./apps/tomie_web/assets
MIX_ENV=prod mix phx.digest
MIX_ENV=prod mix release --overwrite
