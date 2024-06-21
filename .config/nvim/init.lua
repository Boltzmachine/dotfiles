vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = "o"
vim.g.neovide_scale_factor = 1.5

local set = vim.opt
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.number = true
set.termguicolors = true
set.guifont = "SauceCodePro Nerd Font:h14"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"rebelot/kanagawa.nvim",
	{ "CRAG666/code_runner.nvim", config = true },
	"nvim-tree/nvim-web-devicons",
	{
	  'nvimdev/dashboard-nvim',
	  event = 'VimEnter',
	  config = function()
	    require('dashboard').setup {
	      -- config
	    }
	  end,
	  dependencies = { {'nvim-tree/nvim-web-devicons'}}
	},
	"neovim/nvim-lspconfig",
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}
	},
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-vsnip",
	"hrsh7th/vim-vsnip",
	"nvim-tree/nvim-tree.lua",
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	"mg979/vim-visual-multi",
	"numToStr/Comment.nvim",
	{
		"simrat39/symbols-outline.nvim",
		config = function() 
			require("symbols-outline").setup()
		end
	},
})

require("Comment").setup({
	toggler = {
		line = '<leader>/',
		block = '<leader>/',
	},
	opleader = {
		line = '<leader>/',
		block = '<leader>/',
	}
})

vim.cmd("colorscheme kanagawa")

local lspconfig = require("lspconfig")
lspconfig.rust_analyzer.setup {
	settings = {
		['rust-analyzer'] = {}
	}
}
lspconfig.lua_ls.setup {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }
			}
		}
	}
}

lspconfig.clangd.setup {}

local function global_keymap(opts)
	local colemak_maps = {
		{'f', 'e'},
		{'p', 'r'},
		{'g', 't'},
		{'j', 'y'},
		{'l', 'u'},
		{'u', 'i'},
		{'y', 'o'},
		{';', 'p'},
		{'r', 's'},
		{'s', 'd'},
		{'t', 'f'},
		{'d', 'g'},
		{'n', 'j'},
		{'e', 'k'},
		{'i', 'l'},
		{'o', ';'},
		{'k', 'n'},
	}

	local function key_upper(c)
		if c == ";" then
			return ":"
		end

		return string.upper(c)
	end

	for _, colemak_map in ipairs(colemak_maps) do
		local ksrc = colemak_map[1]
		local ktgt = colemak_map[2]
		vim.keymap.set('', ksrc, ktgt, opts)
		vim.keymap.set('', key_upper(ksrc), key_upper(ktgt), opts)
	end
	vim.keymap.set('', 'dd', 'gg', opts)
	vim.keymap.set('n', '<Tab>', require("nvim-tree.api").tree.toggle, opts)
end

global_keymap {}
vim.keymap.set('t', '<ESC>', "<C-\\><C-n>")

local function nvim_tree_attach(bufnr)
	local api = require "nvim-tree.api"

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap=true, nowait=true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
	global_keymap(opts("None"))
end

require("nvim-tree").setup {on_attach = nvim_tree_attach}

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require "cmp"
local cmp_autopairs = require "nvim-autopairs.completion.cmp"

cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
	preselect = cmp.PreselectMode.None,
	mapping = {
	["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
	},
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
sources = cmp.config.sources({
  { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
}, {
  { name = 'buffer' },
})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
mapping = cmp.mapping.preset.cmdline(),
sources = {
  { name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
mapping = cmp.mapping.preset.cmdline(),
sources = cmp.config.sources({
  { name = 'path' }
}, {
  { name = 'cmdline' }
})
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
-- capabilities = capabilities
-- }

cmp.event:on(
	"confirm_done",
	cmp_autopairs.on_confirm_done()
)

local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})


require('code_runner').setup({
  filetype = {
    java = {
      "cd $dir &&",
      "javac $fileName &&",
      "java $fileNameWithoutExt"
    },
    python = "python3 -u",
    typescript = "deno run",
    rust = {
      "cd $dir &&",
      "rustc $fileName &&",
      "$dir/$fileNameWithoutExt"
    },
	c = {
		"cd $dir &&",
		"gcc $fileName -o $fileNameWithoutExt&&",
		"$dir/$fileNameWithoutExt"
	}
  },
})
