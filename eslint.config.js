// eslint.config.cjs
const eslint = require('@eslint/js');
const prettier = require('eslint-config-prettier');
const prettierPlugin = require('eslint-plugin-prettier');
const globals = require('globals');

module.exports = [
  // Only apply config to src files (remove base recommended config)
  {
    files: ['src/**/*.js'], // Double-check this path matches your project
    languageOptions: {
      globals: {
        ...globals.node,
      },
    },
    plugins: {
      prettier: prettierPlugin,
    },
    rules: {
      ...eslint.configs.recommended.rules, // Include recommended rules here
      ...prettier.rules,
      'prettier/prettier': 'error',
      'no-console': 'warn',
      // 'no-unused-vars': 'warn',
    },
  },
];
