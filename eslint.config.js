// eslint.config.cjs
const eslint = require('@eslint/js');
const prettier = require('eslint-config-prettier');
const prettierPlugin = require('eslint-plugin-prettier');
const securityPlugin = require('eslint-plugin-security');
const globals = require('globals');

module.exports = [
  {
    files: ['src/**/*.js'],
    languageOptions: {
      globals: {
        ...globals.node,
      },
    },
    plugins: {
      prettier: prettierPlugin,
      security: securityPlugin,
    },
    rules: {
      ...eslint.configs.recommended.rules,
      ...prettier.rules,
      'prettier/prettier': 'error',
      'no-console': 'warn',
      ...securityPlugin.configs.recommended.rules,
    },
  },
];
