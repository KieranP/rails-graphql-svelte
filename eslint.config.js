import eslint from '@eslint/js';
import typescriptEslint from "typescript-eslint";
import eslintConfigPrettier from "eslint-config-prettier";
import eslintPluginSvelte from "eslint-plugin-svelte";
import svelteParser from "svelte-eslint-parser";
import globals from "globals";

export default typescriptEslint.config(
  eslint.configs.recommended,

  ...typescriptEslint.configs.strict,
  ...typescriptEslint.configs.stylistic,

  // ...typescriptEslint.configs.strictTypeChecked,
  // ...typescriptEslint.configs.stylisticTypeChecked,

  ...eslintPluginSvelte.configs["flat/recommended"],
  ...eslintPluginSvelte.configs['flat/prettier'],
  eslintConfigPrettier,

  {
    languageOptions: {
      parserOptions: {
        project: true,
        tsconfigRootDir: import.meta.dirname,
        parser: typescriptEslint.parser,
        extraFileExtensions: ['.svelte']
      },
    },
  },

  {
    files: ['**/*.svelte'],
    languageOptions: {
      parser: svelteParser,
      parserOptions: {
        parser: typescriptEslint.parser
      },
      globals: {
        ...globals.browser
      }
    },
  },

  {
    ignores: [
      "**/.DS_Store",
      "**/.env.*",
      "**/.svelte-kit/",
      "**/bun.lockb",
      "**/node_modules/",
      "app/frontend/app.d.ts"
    ]
  },
)
