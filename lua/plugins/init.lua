-- Bootstrap lazy.nvim (auto-installs on first run)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

    -- colorscheme
    {
        "samharju/synthweave.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000,
        config = function()
                -- regular version:
                vim.cmd.colorscheme("synthweave")
                
                -- transparent version:
                -- vim.cmd.colorscheme("synthweave-transparent")
        end
    },

    -- fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files,    { desc = "Find files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep,     { desc = "Live grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers,         { desc = "Find buffers" })
        end,
    },

    -- highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
        require("nvim-treesitter").setup({
            ensure_installed = {
                "lua",
                "python",
                "javascript", "typescript",
                -- "rust",
                -- "tex", "latex",
            },
            highlight = { enable = true },
            indent        = { enable = true },
        })
        end,
    },

    -- autocomplete
    {
    "saghen/blink.cmp",
    version = "*",
    dependencies = { "saghen/blink.lib" },
    opts = {
        keymap = {
        preset = "default",
        ["<Tab>"]   = { "accept", "fallback" },  -- accept or normal tab
        ["<S-Tab>"] = { "select_prev", "fallback" },
        },
        sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        },
    },
    },

    -- lsp
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim",                     opts = {} },
            { "williamboman/mason-lspconfig.nvim", opts = {} },
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "pyright" },
            })

            local capabilities = require("blink.cmp").get_lsp_capabilities()

            -- New API: configure all servers with blink capabilities
            vim.lsp.config("*", { capabilities = capabilities })

            -- New API: enable servers by name instead of calling .setup()
            vim.lsp.enable({ "lua_ls", "pyright" })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
                    end

                    map("gd",                 vim.lsp.buf.definition,     "Go to definition")
                    map("gr",                 vim.lsp.buf.references,     "Find references")
                    map("K",                    vim.lsp.buf.hover,                "Hover docs")
                    map("<leader>rn", vim.lsp.buf.rename,             "Rename symbol")
                    map("<leader>ca", vim.lsp.buf.code_action,    "Code action")
                    map("[d",                 vim.diagnostic.goto_prev, "Previous diagnostic")
                    map("]d",                 vim.diagnostic.goto_next, "Next diagnostic")
                end,
            })
        end,
    },

})
