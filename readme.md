# NeoVim

![ezgif com-optimize](https://user-images.githubusercontent.com/266061/228981500-1af29fda-38b2-4bb7-aa2b-36d3eaf76e78.gif)

## Dependencies

Using CTAGS, it's optional to install:

```sh
sudo apt install -y universal-ctags ripgrep fzf
```

To use the custom icons, you need to install the [NerdFonts](https://www.nerdfonts.com).

To use the LSP, install the servers and configure on [lspconfig.lua](/euricovidal/nvim/blob/main/lua/plugins/lspconfig.lua#L7):

```sh
gem install --user-install solargraph solargraph-rails
```

## Install

Clone that repo as `~/.config/nvim`.

Open the `nvim` and run:

```
:TSInstall ruby python json bash php html javascript rust css markdown markdown_inline regex
```

For ruby in Coc
```
gem install solargraph solargraph-rails
```

For Javascript on Coc
```
npm install -g typescript typescript-language-server eslint
```

For python in Coc
```
npm install -g pyright
```

```
pip3 install neovim # or sudo apt install python3-neovim
```

## Post instalation

nvim --headless "+Lazy! update" +qa

To install the Coc dependencies, open the nvim and run:

```
:CocInstall coc-solargraph coc-json coc-tsserver coc-snippets coc-eslint
```

## Plugins


<details>

<summary>+ details</summary>

Are defined in [nvim/lua/plugins/](https://github.com/euricovidal/neovim/tree/main/lua/plugins).

|     Plugin    | Configs           | Description |
|----------------|------------------|-------------|
| [Yanky](https://github.com/gbprod/yanky.nvim) | [yanky.lua](https://github.com/euricovidal/neovim/blob/main/lua/plugins/yanky.lua) | Manage and store all the copies/deletes |
| [Wakatime](https://github.com/wakatime/vim-wakatime) | [wakatime.lua](https://github.com/euricovidal/neovim/blob/main/lua/plugins/wakatime.lua) | External data, register the infos about the working time and programming languages |
| [Trouble](https://github.com/folke/trouble.nvim) | [trouble.lua](https://github.com/euricovidal/neovim/blob/main/lua/plugins/trouble.lua) | TODO |
| [Tidy](https://github.com/euricovidal/neovim/blob/main/lua/plugins/tidy.lua) | [tidy.lua](https://github.com/euricovidal/neovim/blob/main/lua/plugins/tidy.lua) | Remove the spaces in empty lines |
| [Telescope](https://github.com/nvim-telescope/telescope.nvim) | [telescope.lua](https://github.com/euricovidal/neovim/blob/main/lua/plugins/telescope.lua) | TODO |
| [Snippy](https://github.com/euricovidal/neovim/blob/main/lua/plugins/telescope.lua) | [snippy.lua](https://github.com/euricovidal/neovim/blob/main/lua/plugins/snippy.lua) | Basic snippets |
| [Scrollbar](https://github.com/petertriho/nvim-scrollbar) | [scrollbar.lua](https://github.com/euricovidal/neovim/blob/main/lua/plugins/scrollbar.lua) | Set a minimal scrollbar to show the position, trouble and git changes |
| [Rails](https://github.com/tpope/vim-rails) | [rails.lua](https://github.com/euricovidal/neovim/blob/main/lua/plugins/rails.lua) | More details to snippets about the ruby on rails structure |
| [NeoTree](https://github.com/nvim-neo-tree/neo-tree.nvim) | [neo-tree.lua](https://github.com/euricovidal/neovim/blob/main/lua/plugins/neo-tree.lua) | Tree of files, like explorer or NERDTree, with infos about the buffer and git status |
| [Monokai](https://github.com/crusoexia/vim-monokai) | [monokai.lua](https://github.com/euricovidal/neovim/blob/main/lua/plugins/monokai.lua) | The theme/colorscheme as monokai |
| [Mini](https://github.com/echasnovski/mini.nvim) | [mini.lua](https://github.com/euricovidal/neovim/blob/main/lua/plugins/mini.lua) | TODO¹ |
| [Lualine]( https://github.com/nvim-lualine/lualine.nvim) | [lualine.lua](https://github.com/euricovidal/neovim/blob/main/lua/plugins/lualine.lua) | Use to set the statusline |
| [LspSaga](https://github.com/neoclide/coc.nvim) | [lspcoc.lua](https://github.com/euricovidal/neovim/blob/main/lua/plugins/lspcoc.lua) | Improve in the LSP |
| [LastPlace](https://github.com/farmergreg/vim-lastplace) | [lastplace.lua](https://github.com/euricovidal/neovim/blob/main/lua/plugins/lastplace.lua) | Preserve the last cursor position in the file |
| [Illuminate](https://github.com/RRethy/vim-illuminate) | [illuminate.lua](https://github.com/euricovidal/neovim/blob/main/lua/plugins/illuminate.lua) | Highlith the current method in the file |
| [Gitsigns](https://github.com/lewis6991/gitsigns.nvim) | [gitsigns.lua](https://github.com/euricovidal/neovim/blob/main/lua/plugins/gitsigns.lua) | Git infos, git blame in the current line will be display in 3s in the line |
| [Dashboard](https://github.com/glepnir/dashboard-nvim) | [dashboard.lua](https://github.com/euricovidal/neovim/blob/main/lua/plugins/dashboard.lua) | Init screen/dashboard |
| [Bufferline](https://github.com/akinsho/bufferline.nvim) | [bufferline.lua](https://github.com/euricovidal/neovim/blob/main/lua/plugins/bufferline.lua) | Buffer files display like tabs in the top |
| [Ale](https://github.com/dense-analysis/ale) | [ale.lua](https://github.com/euricovidal/neovim/blob/main/lua/plugins/ale.lua) | Async lint check |
| [RubyRefactoring](https://github.com/ecomba/vim-ruby-refactoring) | [ruby-refactor.lua](https://github.com/euricovidal/neovim/blob/main/lua/plugins/ruby-refactor.lua) | Keymaps for Ruby |


¹ TODO of mini

² current is using only the [solargraph](https://solargraph.org)

</details>

## Configs

<details>

<summary>+ details</summary>

|      Param     | Description |
|----------------|-------------|
| number         | Enable the line numbers |
| ruler          | Enable the highlight of the current line |
| cursorcolumn   | Enable the highlight of the current column |
| cursorline     | Enable the highlight of the current line |
| ruler          | Enable the highlight of the current line |
| ruler          | Enable the highlight of the current line |
| foldenable     | Enable the folding method (using key `za`) |
| foldlevelstart | Set the 3 level to start |
| foldmethod     | Set the folding method as defined by the `foldexp` |
| foldexp        | Set the folding expression as defined by plugin [nvim_treesitter](http://github.com/nvim-treesitter/nvim-treesitter) |
| undofile       | Enable the undo wehn you close the file, the changes are forever |
| backupdir      | Set backdir inside the nvim dir in a tmp folder¹ |
| undodir        | Set undodir inside the nvim dir in a tmp folder¹ |
| directory      | Set swapdir inside the nvim dir in a tmp folder¹ |
| expandtab      | Enable the expandtab to soft the TAB |
| shiftwidth     | Set the tab as two spaces |

¹ these directories are auto created as nvim/tmp/NAME

</details>

## Leader

Set as ` : `, but have the alias as ` ; `, só don't need to press **SHIFT** to use it.

## Keybinds

<details>

<summary>+ details</summary>

|   Keybind  | Description |
|------------|-------------|
| \<LEADER\>/  | Clear the highlight of the search |
| \<LEADER\>rt | Run the `ctags` to reload the tags |
| \<LEADER\>d  | Print a debugger in a new line |
| \<LEADER\>p  | Open the Telescope |
| \<LEADER\>ff | Open the Telescope in `find_files` mode |
| \<TAB\>      | Toggle the selection of file on Telescope |
| \<C-x\>      | Open the Telescope selected file on split |
| \<C-v\>      | Open the Telescope selected file on vertical split |
| \<C-t\>      | Open the Telescope selected file in a new tab |
| \<C-u\>      | Go to UP of preview pane on Telescope |
| \<C-d\>      | Go to DOWN of preview pane on Telescope |
| \<LEADER\>e  | Toggle the NeoTree explorer |
| \<LEADER\>ef | Toggle the NeoTree explorer with focus on the current file |
| \<LEADER\>ew | Toggle the NeoTree explorer in a popup floating window |
| \<LEADER\>eg | Toggle the NeoTree git status in a popup floating window |
| \<C-n\>      | Go to the forward item in the copies history|
| \<C-p\>      | Go to the backward item in the copies history|
| \<A-p\>      | Go to the previous occurrence of the method |
| \<A-n\>      | Go to the next occurrence of the method |
| \<LEADER\>hb | Show the `git blame` of the current line |
| [c         | Go to the previous change in the file |
| ]c         | Go to the next change in the file |
| \<C-h\>      | Go to the previous file in buffer |
| \<C-l\>      | Go to the next file in buffer |
| \<LEADER\>bd | Remove the current file from buffer |
| \<LEADER\>l  | Swap between the two files in buffer |
| gh         | Find references to the current method in project |
| gr         | Rename the current method/variable in the file |
| gd         | Show the definition of the class/method |
| \<LEADER\>o  | Toggle the sidebar with the class and methods |
| \<A-d\>      | Open the terminal floating window |
| za         | Toggle the folding |
| \<LEADER\>rap  | Add new parameter to the current method (RAddParameter) |
| \<LEADER\>rcpc | Convert the conditional (if/...) from the end of line to a block (RConvertPostConditional) |
| \<LEADER\>rel  | Move the current var to a `let` in RSpec (RExtractLet) |
| \<LEADER\>rit  | Remove the temp variable and use the value instead of the var (RInlineTemp) |
| \<LEADER\>ct   | Search for git conflict markers in file |

</details>

## Useful commands

| Command  | Description |
|----------|-------------|
| :A       | Toggle between the class and the test |

## Filetypes

The unkown filetypes can be defined the type in [nvim/filetype.lua](https://github.com/euricovidal/neovim/blob/main/filetype.lua).
