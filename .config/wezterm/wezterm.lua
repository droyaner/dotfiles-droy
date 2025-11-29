-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 2000 }

config.keys = {
    -- Split
    { key = '-', mods = 'LEADER', action = wezterm.action.SplitVertical{ domain = 'CurrentPaneDomain' } },
    { key = '_', mods = 'LEADER|SHIFT', action = wezterm.action.SplitHorizontal{ domain = 'CurrentPaneDomain' } },

    -- Navigation
    {key = 'j', mods = 'ALT', action = wezterm.action { ActivatePaneDirection = 'Next' }},
    {key = 'k', mods = 'ALT', action = wezterm.action { ActivatePaneDirection = 'Prev' }},
    {key = 'Space', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Next'},

    -- Tabs
    { key = 'n', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(1) },
    { key = 'p', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(-1) },

    -- Pane-Resize
    { key = 'H', mods = 'CTRL|ALT|SHIFT', action = wezterm.action.AdjustPaneSize{ 'Left', 2 } },
    { key = 'L', mods = 'CTRL|ALT|SHIFT', action = wezterm.action.AdjustPaneSize{ 'Right', 2 } },
    { key = 'K', mods = 'CTRL|ALT|SHIFT', action = wezterm.action.AdjustPaneSize{ 'Up', 2 } },
    { key = 'J', mods = 'CTRL|ALT|SHIFT', action = wezterm.action.AdjustPaneSize{ 'Down', 2 } },

    -- Modi
    { key = 'c', mods = 'LEADER', action = wezterm.action.ActivateCopyMode },
    { key = 'f', mods = 'LEADER', action = wezterm.action.Search { Regex = '' } },
    
    -- QuickSelect (URLs oder Pfade markieren)
    { key = ' ', mods = 'LEADER', action = wezterm.action.QuickSelect },

}

config.colors = {
        foreground = "#CBE0F0",
        background = "#011423",
        cursor_bg = "#47FF9C",
        cursor_border = "#47FF9C",
        cursor_fg = "#011423",
        selection_bg = "#033259",
        selection_fg = "#CBE0F0",
        ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
        brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

-- config.font = wezterm.font("JetBrains Mono")
-- config.font = wezterm.font("Fira Code")
-- config.font = wezterm.font ("Iosevka")
config.font = wezterm.font ("Inconsolata")

config.font_size = 10

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.99

return config
