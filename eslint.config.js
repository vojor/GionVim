import js from "@eslint/js"

export default [
    {
        files: ["**./*.js", "**/*.ts", "**/*.cts", "**/*.cjs", "**/.*.mjs", "**./*.mts"],
        plugins: { js },
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
            ecmaVersion: "latest",
            sourceType: "module",
        },
    },
    {
        linterOptions: {
            noInlineConfig: true,
            reportUnusedDisableDirectives: "error",
        },
    },
]
