return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")
        mason.setup({
            python = {
                python_path = "/usr/bin/python3", -- Explicitly set to the correct python3
            },
        })
        mason_lspconfig.setup({
            ensure_installed = {
                "bashls",
                "clangd",
                "cssls",
                "dockerls",
                "gradle_ls",
                "html",
                "jdtls",
                "eslint",
                "lua_ls",
                "pyright",
            },
        })
        mason_tool_installer.setup({
            ensure_installed = {
                "prettier",
                "stylua",
                "eslint_d",
                -- "pylint",
                -- "isort",
                -- "black",
            },
        })
    end,
}
