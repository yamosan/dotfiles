local wezterm = require 'wezterm'

local config = wezterm.config_builder()


config.colors = {
    background = '#142930',
    foreground = '#d1d3e0',
    cursor_bg = 'rgb(150 150 150 / 100%)',
    selection_bg = 'rgb(94 107 115 / 20%)',
    ansi = {
        '#282c36', -- black
        '#f1a1a1', -- red
        '#c7d9a8', -- green
        '#f5c089', -- yellow
        '#b0c4d9', -- blue
        '#b59cd0', -- magenta
        '#95c0d9', -- cyan
        '#d1d3e0', -- white
    },
    brights = {
        '#8b929c', -- bright black
        '#ec9898', -- bright red
        '#c9dcae', -- bright green
        '#f5c899', -- bright yellow
        '#b3cfe1', -- bright blue
        '#bfb6e0', -- bright magenta
        '#a1d0e0', -- bright cyan
        '#e6e8ef', -- bright white
    },
    scrollbar_thumb = '#7c7c7c',
    split = '#555555',

    tab_bar = {
        active_tab = {
            bg_color = '#142930',
            fg_color = '#d1d3e0',
            intensity = 'Normal',
            underline = 'None',
        },
        inactive_tab = {
            bg_color = '#1f1f1f',
            fg_color = '#8b929c',
            intensity = 'Normal',
            underline = 'None',
        },
        inactive_tab_hover = {
            bg_color = '#142930',
            fg_color = '#d1d3e0',
            intensity = 'Normal',
            underline = 'None',
        },
        new_tab  = {
            bg_color = '#1f1f1f',
            fg_color = '#d1d3e0',
            intensity = 'Normal',
            underline = 'None',
        }
    },
}
config.use_fancy_tab_bar = true
config.window_frame = {
  font_size = 13.0,
  active_titlebar_bg = '#1f1f1f',
  inactive_titlebar_bg = '#1f1f1f',
}


config.enable_scroll_bar = true
config.min_scroll_bar_height = "0.5cell"

config.font = wezterm.font("FiraCode Nerd Font Mono", { weight = "Medium" })
config.font_size = 12.5
config.line_height = 1.2
config.cell_width = 1.05


-- keybindings
wezterm.on('update-right-status', function(window, pane)
    local name = window:active_key_table()
    if name then
        name = 'TABLE: ' .. name
    end
    window:set_right_status(name or '')
end)
config.disable_default_key_bindings = true
config.leader = { key = 'k', mods = 'CMD', timeout_milliseconds = 1000 }
config.key_tables = {
    pane = {
        -- ペインを終了する
        {
            key = 'w',
            mods = "CTRL",
            action = wezterm.action.CloseCurrentPane { confirm = true }
        },
        -- ペインのサイズを変更する
        { key = 'LeftArrow',  action = wezterm.action.AdjustPaneSize { 'Left', 1 } },
        { key = 'RightArrow', action = wezterm.action.AdjustPaneSize { 'Right', 1 } },
        { key = 'UpArrow',    action = wezterm.action.AdjustPaneSize { 'Up', 1 } },
        { key = 'DownArrow',  action = wezterm.action.AdjustPaneSize { 'Down', 1 } },
        -- ペインを移動する
        {
            key = 'b',
            mods = "CTRL",
            action = wezterm.action.ActivatePaneDirection 'Left',
        },
        {
            key = 'f',
            mods = "CTRL",
            action = wezterm.action.ActivatePaneDirection 'Right',
        },
        {
            key = 'p',
            mods = "CTRL",
            action = wezterm.action.ActivatePaneDirection 'Up',
        },
        {
            key = 'n',
            mods = "CTRL",
            action = wezterm.action.ActivatePaneDirection 'Down',
        },
        -- 上下にペイン分割する
        {
            key = 'h',
            mods = "CTRL",
            action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },
        -- 左右にペイン分割する
        {
            key = 'v',
            mods = "CTRL",
            action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
        },
        -- キーテーブルを終了する
        {
            key = 'Escape',
            action = 'PopKeyTable'
        },
        {
            key = 'q',
            mods = "CTRL",
            action = 'PopKeyTable'
        },
        {
            key = 'p',
            mods = "CMD",
            action = 'PopKeyTable'
        },
    },
    tab = {
        -- 新しいタブを開く
        {
            key = 't',
            mods = "CTRL",
            action = wezterm.action.SpawnTab 'CurrentPaneDomain',
        },
        -- タブを閉じる
        {
            key = 'w',
            mods = "CTRL",
            action = wezterm.action.CloseCurrentTab { confirm = true }
        },
        -- タブを移動する
        { key = 'LeftArrow',  action = wezterm.action.MoveTabRelative(-1) },
        { key = 'RightArrow', action = wezterm.action.MoveTabRelative(1) },
        -- タブを切り替える
        {
            key = 'b',
            mods = "CTRL",
            action = wezterm.action.ActivateTabRelativeNoWrap(-1)
        },
        {
            key = 'f',
            mods = "CTRL",
            action = wezterm.action.ActivateTabRelativeNoWrap(1)
        },
        -- タブのタイトルを変更する
        {
            key = 'm',
            mods = "CTRL",
            action = wezterm.action.PromptInputLine {
                description = 'Enter new name for tab',
                action = wezterm.action_callback(function(window, pane, line)
                    if line then
                        window:active_tab():set_title(line)
                    end
                end),
            },
        },
        -- キーテーブルを終了する
        {
            key = 'Escape',
            action = 'PopKeyTable'
        },
        {
            key = 'q',
            mods = "CTRL",
            action = 'PopKeyTable'
        },
        {
            key = 't',
            mods = "CMD",
            action = 'PopKeyTable'
        },
    }
}
config.keys = {
    -- フォントサイズを変更する
    {
        key = '-',
        mods = 'CMD',
        action = wezterm.action.DecreaseFontSize
    },
    {
        key = '=',
        mods = 'CMD',
        action = wezterm.action.IncreaseFontSize
    },
    -- ペイン関連のキーテーブルを開く
    {
        key = 'p',
        mods = 'CMD',
        action = wezterm.action.ActivateKeyTable {
            name = 'pane',
            one_shot = false,
        },
    },
    -- タブ関連のキーテーブルを開く
    {
        key = 't',
        mods = 'CMD',
        action = wezterm.action.ActivateKeyTable {
            name = 'tab',
            one_shot = false,
        },
    },
    -- コピー
    {
        key = 'c',
        mods = 'SUPER',
        action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
    },
    -- ペースト
    {
        key = 'v',
        mods = 'SUPER',
        action = wezterm.action.PasteFrom 'Clipboard',
    },
}


return config
