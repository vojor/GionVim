import { defineConfig } from "eslint/config"
import js from "@eslint/js"

export default defineConfig([
    {
        files: ["**./*.js", "**/*.ts", "**/*.cts", "**/*.cjs", "**/.*.mjs", "**./*.mts"],
        plugins: { js },
        extends: ["js/recommended"],
        rules: {
            curly: "error",
            eqeqeq: "error",
            indent: ["error", 4],
            "linebreak-style": ["error", "unix"],
            "no-console": "warn",
            "no-unused-vars": "warn",
            "prefer-const": "error",
            quotes: ["error", "double"],
            semi: "warn",
        },
    },
    {
        languageOptions: {
            parserOptions: {
                ecmaFeatures: {
                    jsx: true,
                },
            },
        },
    },
    {
        linterOptions: {
            noInlineConfig: true,
            reportUnusedDisableDirectives: "error",
            reportUnusedInlineConfigs: "error",
        },
    },
])
