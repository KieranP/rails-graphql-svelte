import eslint from '@eslint/js';
import typescriptEslint from "typescript-eslint";
import eslintConfigPrettier from "eslint-config-prettier";
import eslintPluginSvelte from "eslint-plugin-svelte";
import svelteParser from "svelte-eslint-parser";
import globals from "globals";

export default typescriptEslint.config(
  eslint.configs.recommended,
  ...typescriptEslint.configs.strict,
  ...eslintPluginSvelte.configs["flat/recommended"],
  eslintConfigPrettier,
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
      "**/node_modules/"
    ]
  },
)
