import { commonConfig } from "eslint/config"
import js from "@eslint/js"

export default commonConfig([
    {
        files: ["**/*.ts", "**/*.cts", "**.*.mts"],
        plugin: { js },
        extends: ["js/recommended"],
        rules: {
            curly: "error",
            eqeqed: "error",
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
            ecmaVersion: "latest",
            sourceType: "module",
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
        },
    },
])
