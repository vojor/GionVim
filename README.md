<h1 align="center">GionVim</h1>

<div align="center">

[![Neovim Version](https://img.shields.io/badge/Neovim-0.10%2B-brightblue?style=flat&logo=neovim&logoColor=green)](https://github.com/neovim/neovim)
[![GitHub License](https://img.shields.io/github/license/vojor/GionVim?style=flat&logo=github&logoColor=orange&color=blue)](https://github.com/vojor/GionVim/blob/main/LICENSE)

</div>

> Summary: Excellent NeoVim Configuration, Applicable to Linux/WSL, If you are using a Windows system, there may be a slight lag.

## Features

- Development

  - C/C++, Java, javascript and typescript, lua, python, cmake, bash, vimscript, xml, json support.

- ColorScheme

  - Carefully selected themes.

- Custom

  - Highly customizable configuration.

## Requirement

- **Notice: After configuring from GitHub clone, it is necessary to modify the configuration content inside the configuration file before using it. Directly using it may result in errors.**

- Dependent

  - basic: git

  - lsp: Node, Python

  - treesitter: gcc or clang

  - mason: unzip, gzip, wget, curl, tar

  - telescope: make, fd, ripgrep, fzf

  - database: sqlite3

- Modify Configuration(plugin)

  - sqlite.lua: Go to [sqlite.lua](https://github.com/kkharji/sqlite.lua) to view detailed configurations.

- others

  - Windows system: Recommend using msys2 to install dependency tools, address: [msys2](https://www.msys2.org)

  - The system can access GitHub normally.

## Installation

- Linux:

  - Terminal command: `git clone https://github.com/vojor/GionVim.git ~/.config/nvim`

- Windows:

  - Windows PowerShell: `git clone https://github.com/vojor/GionVim.git $env:LOCALAPPDATA\nvim`

- Access the nvim directory: `rm -rf .git`, You can manage projects on your own.

- Terminal enter nvim, plugin will automatically install.

- After the plugin installation is completed, use the `checkhealth ` command in neovim to check for any errors. Note: Due to the use of lazy loading in many plugins, to complete the configuration check, all plugins need to be started.

## Introduction to Important Plugins

### nvim-lspconfig

- The language server can be installed using Mason, and the configuration file can be found in plugins/lsp/init.lua. You can first modify the configuration, delete unnecessary language servers, or add the necessary language servers yourself.

### nvim-treesitter

- Treesitter supports more advanced syntax highlighting and text object processing.

## Custiom Configuration

- Almost all files can be modified on their own to create the most suitable configuration for you.

## More Plugin

- Recommended plugin website: [awesome-neovim](https://github.com/rockerBOO/awesome-neovim)
