# NeoVim 配置

> 简介：个人 NeoVim 配置文件，主要用于 Linux/WSL，如果在 Windows 下使用，可能会有些卡顿

- **注意：在将此配置使用之前，需要先修改一下这些设置，否则 NeoVim 使用会报错**

- 基础工具安装如下：

- 基础依赖:git

- lsp 的安装依赖 Node,Python

- treesitter 依赖 gcc/clang

- mason 依赖 unzip,gzip,wget,curl,tar,

- 搜索插件依赖:make,fd,rg,fzf

- 数据库依赖:sqlite3

1. nvim-genghis 插件：在 trashFile 的配置中改为自己的绝对目录

2. sqlite.lua 插件：由于 yanky.nvim，以及一些其它功能需要 SQLite，所以请在[sqlite.lua](https://github.com/kkharji/sqlite.lua)网站中查看详细配置

3. Windows 下推荐使用 msys2 安装基础工具，官网：[msys2](https://www.msys2.org)

4. 确保系统能正常连接国际互联网，即能正常访问 github

## 本配置的插件安装及其使用

### 安装插件

- linux:

- 打开终端输入：`git clone https://github.com/legbor/GionVim.git ~/.config/nvim`

- Windows:

- 打开 PowerShell 输入：`git clone https://github.com/legbor/GionVim.git $env:LOCALAPPDATA\nvim`

- 终端输入 nvim，插件便会自动安装

- 插件安装完成后，使用 checkhealth 命令查看有没有错误。注意：由于很多插件我使用了懒加载，要检查完成配置，需要全部启动插件。

## 基础插件介绍

### nvim-lspconfig

- 语言服务器可以自行安装，也可以通过 mason.nvim 插件安装。

- 使用 mason.nvim 安装语言服务

1. 具体需要安装的语言服务可以去 mason.nvim 插件的地址[mason.nvim](https://github.com/williamboman/mason.nvim)查看

2. 使用 mason.nvim 安装语言服务，在 plugins/lsp/init.lua 文件中查看语言的服务器，可以自行进行修改。

- 自行安装语言服务

1. 去 nvim-lspconfig 的语言服务列表[server](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)中查看

### completion

- 代码补全配置在 plugins/completion.lua，想要更加优化可以去[nvim-cmp](https://github.com/hrsh7th/nvim-cmp/wiki)查看

### nvim-dap

- Neovim 没有官方的 nvim-dapconfig 插件，插件来源于第三方作者，不是那么好用，本人只完成了 neovim/lua,c/c++,bash 的调试配置

- 自行配置

1. 在 debugger/lang/文件夹中，添加或删除调试器配置，可以看[dapInstall](https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation),自己选择自己需要的适配器，然后修改就可以了。

2. c/c++ 调试：来源于 lldb-vscode

3. lua 调试：来源于一个插件，luadap.lua 文件基本上不用修改。

4. bash 调试，使用的是 mason 安装调试器，毕竟作者推荐的就是这个。

5. 如果不想 NeoVim 实现调试功能，则可以删除 debugger 文件夹，plugins/dap.lua 文件，并且在 boot/bootstrap.lua 文件中删除`{import = "plugins.extras.dap.luadap"}`.

### Diagnostics

- 使用 none-ls.nvim 和 nvim-lint 插件来诊断，诊断程序及其配置在 plugins/linter/init.lua 文件，对于不用的诊断程序可以删除，也可以自行添加。

### Formatter

- 使用 conform.nvim 插件进行格式化，配置文件在 plugins/formatter.lua，不需要的格式化程序可以直接删除。

### tree-sitter

- treesitter 语法高亮感觉比自带的好多了，不过要感觉更好看，还需要搭配一套好看的主题。

- 如果想更换主题，可以去 treesitter 的插件官网[Colorschemes](https://github.com/nvim-treesitter/nvim-treesitter/wiki/Colorschemes)查看

### 更多 NeoVim 插件

- 插件集合[awesome-neovim](https://github.com/rockerBOO/awesome-neovim)

## 启动优化

- 在 WSL2 上使用 ArchLinux 上进行测试，基本打开时间在 70ms 左右

## 自定义配置

- 如果想自己安装插件或者修改配置只要在相应位置修改即可。
