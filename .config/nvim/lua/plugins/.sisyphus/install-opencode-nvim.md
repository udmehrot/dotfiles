# Install opencode.nvim Plugin

## Objective
Install the `nickjvandyke/opencode.nvim` plugin for LazyVim distribution.

## Task
Create a new plugin configuration file at `/home/udmehrot/.config/nvim/lua/plugins/opencode.lua`

## Implementation

Create the file with the following content:

```lua
return {
  "nickjvandyke/opencode.nvim",
  version = "*", -- Latest stable release
  dependencies = {
    {
      ---@module "snacks"
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {},
        picker = {
          actions = {
            opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    vim.g.opencode_opts = {}
    vim.o.autoread = true

    vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })
    vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end, { desc = "Execute opencode action…" })
    vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })

    vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end, { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

    vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end, { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })

    vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
    vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
  end,
}
```

## Keybindings Summary
- `<C-a>` — Ask opencode (normal/visual mode)
- `<C-x>` — Execute opencode action (normal/visual mode)
- `<C-.>` — Toggle opencode panel (normal/terminal mode)
- `go` — Add range to opencode (operator)
- `goo` — Add current line to opencode
- `<S-C-u>` / `<S-C-d>` — Scroll opencode up/down
- `+` / `-` — Increment/decrement (remapped since `<C-a>`/`<C-x>` are taken)

## Post-Installation
After file is created, user should restart Neovim or run `:Lazy sync` to install the plugin.

## Verification
- File exists at correct path
- No Lua syntax errors (check with `:luafile %` or restart nvim)
