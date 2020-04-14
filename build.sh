#!/usr/bin/env bash

mix deps.get --only prod
MIX_ENV=prod mix compile

npm install --prefix ./apps/tomie_web/assets
npm run deploy --prefix ./apps/tomie_web/assets
mix phx.digest

rm -rf "_build"
MIX_ENV=prod mix release
