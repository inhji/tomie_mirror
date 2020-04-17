const { ThemeBuilder, Theme } = require('tailwindcss-theming');

const mainTheme = new Theme()
  .default()
  .colors({
    'primary': '#4C51BF',
    'primary-alt': '#667EEA',
    'on-primary': '#EDF2F7',

    'secondary': '#dd3344',

    'surface': '#EDF2F7',
    'on-surface': '#2D3748',

    'divider': '#CBD5E0',

    'navbar': '#4C51BF',
    'on-navbar': '#EDF2F7',

    'info': '#4299E1',
    'on-info': '#BEE3F8',
    'danger': '#FED7D7',
    'on-danger': '#C53030',
    'success': '#48BB78',
    'on-success': '#C6F6D5'
  })
  .opacityVariant('muted', .8)
  .opacityVariant('barely', .4)
  .opacityVariant('not-even', .05)
  .colorVariant('hover', '#EDF2F7', 'navbar')
  .colorVariant('hover', '#4C51BF', 'on-navbar')
  .colorVariant('alt', '#F7FAFC', 'surface')
  .colorVariant('border', '#EEEEEE', 'surface')

const darkTheme = new Theme()
  .colors({
    'primary-alt': '#434190',

    'surface': '#2D3748',
    'on-surface': '#CBD5E0',

    'divider': '#4A5568',

    'navbar': '#4C51BF',
    'on-navbar': '#EDF2F7',

    'danger': '#9B2C2C',
    'on-danger': '#FEB2B2'
  })
  .colorVariant('hover', '#2D3748', 'navbar')
  .colorVariant('hover', '#CBD5E0', 'on-navbar')
  .colorVariant('alt', '#1A202C', 'surface')

module.exports = new ThemeBuilder()
  .asDataThemeAttribute()
  .default(mainTheme)
  .dark(darkTheme);
