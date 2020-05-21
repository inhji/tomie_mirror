const { ThemeBuilder, Theme } = require('tailwindcss-theming');

const mainTheme = new Theme()
  .name("light-purple")
  .assignable()
  .default()
  .colors({
    'primary': '#4C51BF',
    'primary-alt': '#667EEA',
    'on-primary': '#EDF2F7',

    'navbar': '#4C51BF',
    'on-navbar': '#EDF2F7',

    'secondary': '#dd3344',

    'surface': '#EDF2F7',
    'on-surface': '#2D3748',

    'divider': '#E2E8F0',

    'info': '#BEE3F8',
    'on-info': '#4299E1',
    'danger': '#FED7D7',
    'on-danger': '#C53030',
    'success': '#C6F6D5',
    'on-success': '#48BB78'
  })
  .opacityVariant('muted', .8)
  .opacityVariant('barely', .4)
  .opacityVariant('not-even', .05)
  .colorVariant('hover', '#EDF2F7', 'navbar')
  .colorVariant('hover', '#4C51BF', 'on-navbar')
  .colorVariant('alt', '#F7FAFC', 'surface')
  .colorVariant('border', '#EEEEEE', 'surface')

const redTheme = new Theme()
  .name('light-red')
  .assignable()
  .colors({
    'primary': '#B83280',
    'primary-alt': '#D53F8C',
    'on-primary': '#EDF2F7',

    'navbar': '#B83280',
    'on-navbar': '#EDF2F7',

    'secondary': '#dd3344',

    'surface': '#EDF2F7',
    'on-surface': '#2D3748',

    'divider': '#E2E8F0',

    'info': '#BEE3F8',
    'on-info': '#4299E1',
    'danger': '#FED7D7',
    'on-danger': '#C53030',
    'success': '#C6F6D5',
    'on-success': '#48BB78'
  })
  .opacityVariant('muted', .8)
  .opacityVariant('barely', .4)
  .opacityVariant('not-even', .05)
  .colorVariant('hover', '#EDF2F7', 'navbar')
  .colorVariant('hover', '#B83280', 'on-navbar')
  .colorVariant('alt', '#F7FAFC', 'surface')
  .colorVariant('border', '#EEEEEE', 'surface')

const darkTheme = new Theme()
  .colors({
    'primary-alt': '#434190',

    'surface': '#2D3748',
    'on-surface': '#CBD5E0',

    'divider': '#2D3748',

    'navbar': '#4C51BF',
    'on-navbar': '#EDF2F7',

    'info': '#90CDF4',
    'on-info': '#3182CE',
    'success': '#9AE6B4',
    'on-success': '#38A169',
    'danger': '#FEB2B2',
    'on-danger': '#9B2C2C'
  })
  .colorVariant('hover', '#2D3748', 'navbar')
  .colorVariant('hover', '#CBD5E0', 'on-navbar')
  .colorVariant('alt', '#1A202C', 'surface')

module.exports = new ThemeBuilder()
  .asDataThemeAttribute()
  .default(mainTheme)
  .theme(redTheme)
  .dark(darkTheme);
