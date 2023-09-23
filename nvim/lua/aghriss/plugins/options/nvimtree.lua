local options = {
  filters = {
    dotfiles = false,
    -- exclude = { vim.fn.stdpath("config") .. "/lua/custom" },
  },
  respect_buf_cwd = false,
  reload_on_bufenter = false,
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  sync_root_with_cwd = false,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    hide_root_folder = false,
    adaptive_size = true,
    side = "left",
    width = 20,
    preserve_window_proportions = true,
    float = {
      enable = true,
      open_win_config = function()
        return {
          relative = "editor",
          -- border = "rounded",
          border = "none",
          -- border = "shadow",
          width = 30,
          height = vim.api.nvim_win_get_height(0),
          row = 1,
          col = 0,
        }
      end,
    },
  },
  git = {
    enable = false,
    ignore = true,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    root_folder_label = function(path) return vim.fn.fnamemodify(path, ":t") end,
    highlight_git = false,
    highlight_opened_files = "none",

    indent_markers = {
      enable = false,
    },

    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = false,
      },

      glyphs = {
        default = "󰈚",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
}
local function wrap_node(f)
  return function(node, ...)
    node = node or require("nvim-tree.lib").get_node_at_cursor()
    f(node, ...)
  end
end
local change_cwd_to_node = wrap_node(function(node)
  if node.name == ".." then
    require("nvim-tree.actions.root.change-dir").fn("..")
    return
  end
  -- elseif node.nodes ~= nil then
  -- require("nvim-tree.actions.root.change-dir").fn(
  -- require("nvim-tree.lib").get_last_group_node(node).absolute_path
  -- )
  -- end
  if node.fs_stat.type == "directory" then
    vim.cmd(":cd " .. node.absolute_path)
  else
    vim.cmd(":cd " .. node.parent.absolute_path)
  end
end)

options.on_attach = function(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end

  -- default mappings
  -- api.config.mappings.default_on_attach(bufnr)

  -- local function next_sibling()
  -- local node = api.tree.get_node_under_cursor()
  -- node.navigate.sibling.next()
  -- end
  -- custom mappings
  -- vim.keymap.set("n", "e", api.tree.node.navigate.sibling.prev, opts("Move Up"))
  -- vim.keymap.set("n", "e", api.node.navigate.sibling.prev, opts("Previous Sibling"
  vim.keymap.set("n", "o", api.tree.change_root_to_node, opts("set parent"))
  vim.keymap.set("n", "c", change_cwd_to_node, opts("CD"))
  -- vim.keymap.set(
  --   "n",
  --   "<C-e>",
  --   api.node.open.replace_tree_buffer,
  --   opts("Open: In Place")
  -- )
  vim.keymap.set("n", "<C-e>", function(...)
    api.node.open.edit(...)
    api.tree.open(...)
  end, opts("Open: In Place"))
  -- vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
  vim.keymap.set("n", "R", api.fs.rename_sub, opts("Rename: Omit Filename"))
  vim.keymap.set("n", "T", api.node.open.tab, opts("Open: New Tab"))
  vim.keymap.set("n", "V", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "H", api.node.open.horizontal, opts("Open: Horizontal Split"))
  vim.keymap.set(
    "n",
    "<BS>",
    api.node.navigate.parent_close,
    opts("Close Directory")
  )
  -- vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
  -- vim.keymap.set("n", "n", api.node.navigate.sibling.next, opts("Next Sibling"))
  -- vim.keymap.set("n", "e", api.node.navigate.sibling.prev, opts("Previous Sibling"))
  -- vim.keymap.set("n", ".", api.node.run.cmd, opts("Run Command"))
  vim.keymap.set("n", "m", api.tree.change_root_to_parent, opts("Up"))
  vim.keymap.set("n", "a", api.fs.create, opts("Create"))
  -- vim.keymap.set("n", "bd", api.marks.bulk.delete, opts("Delete Bookmarked"))
  -- vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
  -- vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle Filter: No Buffer"))
  vim.keymap.set("n", "y", api.fs.copy.node, opts("Copy"))
  -- vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Filter: Git Clean"))
  -- vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
  -- vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
  -- vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
  vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
  -- vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
  -- vim.keymap.set("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
  -- vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
  -- vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
  -- vim.keymap.set("n", "F", api.live_filter.clear, opts("Clean Filter"))
  vim.keymap.set("n", "/", api.live_filter.start, opts("Filter"))
  -- vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
  -- vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
  -- vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Filter: Dotfiles"))
  vim.keymap.set(
    "n",
    "gh",
    api.tree.toggle_gitignore_filter,
    opts("Toggle Filter: Git Ignore")
  )
  vim.keymap.set("n", "N", api.node.navigate.sibling.last, opts("Last Sibling"))
  vim.keymap.set("n", "E", api.node.navigate.sibling.first, opts("First Sibling"))
  vim.keymap.set("n", "'", api.marks.toggle, opts("Toggle Bookmark"))
  vim.keymap.set("n", "i", api.node.open.edit, opts("Open"))
  -- vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
  vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
  -- vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
  vim.keymap.set("n", "q", api.tree.close, opts("Close"))
  vim.keymap.set("n", "<ESC>", api.tree.close, opts("Close"))
  vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
  -- vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
  -- vim.keymap.set("n", "s", api.node.run.system, opts("Run System"))
  vim.keymap.set("n", "/", api.tree.search_node, opts("Search"))
  -- vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Filter: Hidden"))
  -- vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
  vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
  -- vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
  -- vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
  -- vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
  -- vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
end

-- options.on_attach = my_on_attach
return options
