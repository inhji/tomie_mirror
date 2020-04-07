const { ThemeBuilder, Theme } = require('tailwindcss-theming');

const mainTheme = new Theme()
  .default()
  .colors({
    'primary': '#4C51BF',
    'primary-light': '#667EEA',
    'primary-dark': '#434190',
    'on-primary': '#EDF2F7',

    'surface': '#EDF2F7',
    'on-surface': '#2D3748',

    'navbar': '#4C51BF',
    'on-navbar': '#EDF2F7',

    'info': '#4299E1',
    'on-info': '#BEE3F8',
    'danger': '#FED7D7',
    'on-danger': '#C53030'
  })
  .opacityVariant('muted', .8, ['on-surface'])

const darkTheme = new Theme()
  .colors({
    'on-surface': '#CBD5E0',
    'surface': '#2D3748',

    'danger': '#9B2C2C',
    'on-danger': '#FEB2B2'
  });

module.exports = new ThemeBuilder()
  .asDataThemeAttribute()
  .default(mainTheme)
  .dark(darkTheme);
