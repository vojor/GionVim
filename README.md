<h1 align="center">GionVim</h1>

<div align="center">

[![Neovim Version](https://img.shields.io/badge/Neovim-0.11%2B-brightblue?style=flat&logo=neovim&logoColor=green)](https://github.com/neovim/neovim)
[![Github License](https://img.shields.io/github/license/vojor/GionVim?style=flat&logo=github&logoColor=orange&color=blue)](https://github.com/vojor/GionVim/blob/main/LICENSE)

</div>

> Summary: Excellent Neovim Configuration, Applicable to Linux/WSL, If you are using a Windows system, there may be a slight lag.

## Features

- Development

  - Language support: C/C++, Java, javascript and typescript, lua, python, cmake, bash, vim, xml, yaml.

- ColorScheme

  - Carefully selected themes.

- Custom

  - Highly liberalized configuration.

## Requirement

- **Notice: After configuring from github clone, it is necessary to modify the configuration content inside the configuration file before using it. Directly using it may result in errors.**

- Dependent

  - essential: git

  - lsp: Node and npm, Python and pip

  - treesitter: gcc or clang

  - mason: unzip, gzip, wget, curl, tar, bash, sh

  - database: sqlite3

  - tools: fd, fzf, ripgrep, ugrep

- Modify Configuration(plugin)

  - sqlite.lua: Go to [sqlite.lua](https://github.com/kkharji/sqlite.lua) to view detailed configurations.

- others

  - Windows system: Recommend using msys2 to install reliance tools, address: [msys2](https://www.msys2.org)

  - The system can access github normally.

## Installation

- Linux:

  - Terminal command: `git clone https://github.com/vojor/GionVim.git ~/.config/nvim`

- Windows:

  - Windows PowerShell: `git clone https://github.com/vojor/GionVim.git $env:LOCALAPPDATA\nvim`

- Access the nvim directory: `rm -rf .git`, You can manage projects on your own.

- Terminal enter nvim, plugin will automatically install.

- After the plugin installation is completed, use the `checkhealth ` command in neovim to check for any errors. Note: Due to the use of lazy loading in many plugins, to complete the configuration check, all plugins need to be started.

## Introduction to Important Plugins

### nvim-lsp

1. The language server can be installed using Mason.

2. The configuration file locate plugins/lsp/init.lua.

3.  You can delete unnecessary file, it orident plugins/lsp/lang, also add the demand language servers.

### nvim-treesitter

- Tree-sitter supports more advanced syntax highlight and text object processing.

## Own Allocation

- Almost all files can be modified on their own to create the most suitable configuration for you.

## Increasingly(Plugin)

- Recommended plugins website: [awesome-neovim](https://github.com/rockerBOO/awesome-neovim)
