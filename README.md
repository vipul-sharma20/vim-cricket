vim-cricket
===========

Vim plugin to get scores and commentary of live cricket matches

![Demo](https://i.imgur.com/5gsiiSa.gif)

Installation
============

| Plugin Manager | Install with... |
| ------------- | ------------- |
| [Pathogen][1] | `git clone https://github.com/vipul-sharma20/vim-cricket ~/.vim/bundle/vim-cricket`<br/>Remember to run `:Helptags` to generate help tags |
| [NeoBundle][2] | `NeoBundle 'vipul-sharma20/vim-cricket'` |
| [Vundle][3] | `Plugin 'vipul-sharma20/vim-cricket'` |
| [Plug][4] | `Plug 'vipul-sharma20/vim-cricket'` |
| [VAM][5] | `call vam#ActivateAddons([ 'vim-cricket' ])` |
| [Dein][6] | `call dein#add('vipul-sharma20/vim-cricket')` |
| [minpac][7] | `call minpac#add('vipul-sharma20/vim-cricket')` |
| manual | copy all of the files into your `~/.vim` directory |

Documentation
=============

`:h vim-cricket`

or check [here][9]

Commands
========

| Command              | List                                                              |
| ---                  | ---                                                               |
| `GetMatches`         | Fetches a list of live matches                                    |
| `GetMatchesFZF`      | Fetches a list of live matches (Note: this command needs fzf.vim) |
| `GetScore`           | Fetches score of the match set as `g:match_id`                    |
| `ShowMatchInBrowser` | Opens the match set as `g:match_id` in browser                    |

I recommend you to check documentation for better understanding

### FZF Example

```vim
command! -bang -nargs=* GetLiveMatches call fzf#run({
            \ 'source': GetMatchesFZF(),
            \ 'sink': function('GetScoreFZF'),
            \ 'options': '-x',
            \ 'down': '30%'})
nnoremap <leader>gm :GetLiveMatches<cr>
```

Source
======

[Cricbuzz][8]

LICENSE
=======

MIT

[1]: https://github.com/tpope/vim-pathogen
[2]: https://github.com/Shougo/neobundle.vim
[3]: https://github.com/VundleVim/Vundle.vim
[4]: https://github.com/junegunn/vim-plug
[5]: https://github.com/MarcWeber/vim-addon-manager
[6]: https://github.com/Shougo/dein.vim
[7]: https://github.com/k-takata/minpac/
[8]: https://cricbuzz.com
[9]: https://github.com/vipul-sharma20/vim-cricket/tree/master/doc/vim-cricket.txt
