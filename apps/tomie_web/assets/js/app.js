// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

import "phoenix_html"
import NProgress from "nprogress"
import {Socket} from "phoenix"
import LiveSocket from "phoenix_live_view"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})

liveSocket.connect()

window.liveSocket = liveSocket

// Theme Switch

const toggleButton = document.querySelector(".theme-toggle")

toggleButton.addEventListener("click", function (e) {
  e.preventDefault()

  const body = document.querySelector("body")
  const theme = body.dataset.theme

  body.dataset.theme = (theme === "light" ? "dark" : "light")
})

NProgress.configure({ showSpinner: false })
// Show progress bar on live navigation and form submits
window.addEventListener("phx:page-loading-start", info => NProgress.start())
window.addEventListener("phx:page-loading-stop", info => NProgress.done())
