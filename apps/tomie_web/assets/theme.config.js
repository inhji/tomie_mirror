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
    'danger': '#F56565',
    'on-danger': '#FFF5F5'
  });

const darkTheme = new Theme()
  .colors({
    'on-surface': '#CBD5E0',
    'surface': '#2D3748'
  });

module.exports = new ThemeBuilder()
  .asDataThemeAttribute()
  .default(mainTheme)
  .dark(darkTheme);
