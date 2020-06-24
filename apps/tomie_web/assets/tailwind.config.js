module.exports = {
  purge: {
  	content: [
  		"../**/*.html.eex",
  		"../**/*.html.leex",
  		"../**/views/**/*.ex",
  		"./js/**/*.js"
  	],
  	options: {
  		whitelist: ["active"]
  	}
  },
  plugins: [
    require('./theme.config.js')
  ]
}
