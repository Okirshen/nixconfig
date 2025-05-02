local wezterm = require 'wezterm'

local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')


local config = {
  color_scheme = 'Dracula (base16)',
  enable_wayland = true,
  -- fixes broken font rendering
  front_end = 'WebGpu',
  keys = {
    {
      key = 'T',
      mods = 'CTRL',
      action = wezterm.action.TogglePaneZoomState,
    },
    {
      key = 'S',
      mods = 'CTRL|ALT',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'V',
      mods = 'CTRL|ALT',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
  },
}

smart_splits.apply_to_config(config, {
  direction_keys = { 'h', 'j', 'k', 'l' },
  modifiers = {
    move = 'CTRL',
    resize = 'ALT',
  }
})

local term_pane
function toggle_term(window, pane)
  if term_pane then
    -- if term_pane:tab() == pane:tab() then
    --   local tab, _ = term_pane:move_to_new_tab()
    --   tab.set_title("Term")
    -- else
    --   term_pane:
    -- end
    -- term_pane:move_to_new_tab()
  end
end

return config
