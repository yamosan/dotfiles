-- https://github.com/tekezo/Karabiner/issues/814#issuecomment-337643019
-- HANDLE SCROLLING
local deferred = false

overrideRightMouseDown = hs.eventtap.new({ hs.eventtap.event.types.rightMouseDown }, function(e)
    --print("down"))
    deferred = true
    return true
end)

overrideRightMouseUp = hs.eventtap.new({ hs.eventtap.event.types.rightMouseUp }, function(e)
    -- print("up"))
    if (deferred) then
        overrideRightMouseDown:stop()
        overrideRightMouseUp:stop()
        hs.eventtap.rightClick(e:location())
        overrideRightMouseDown:start()
        overrideRightMouseUp:start()
        return true
    end

    return false
end)

local oldmousepos = {}
local scrollmult = -4   -- negative multiplier makes mouse work like traditional scrollwheel
dragRightToScroll = hs.eventtap.new({ hs.eventtap.event.types.rightMouseDragged }, function(e)
    -- print("scroll");

    deferred = false

    oldmousepos = hs.mouse.absolutePosition()

    local dx = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaX'])
    local dy = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaY'])
    local scroll = hs.eventtap.event.newScrollEvent({-dx * scrollmult, -dy * scrollmult},{},'pixel')

    -- put the mouse back
    hs.mouse.absolutePosition(oldmousepos)

    return true, {scroll}
end)

overrideRightMouseDown:start()
overrideRightMouseUp:start()
dragRightToScroll:start()
--EOF


-- Handle Window
local hyper = {"ctrl", "alt", "cmd"}

hs.loadSpoon("MiroWindowsManager")

hs.window.animationDuration = 0.2
spoon.MiroWindowsManager:bindHotkeys({
  up = {hyper, "up"},
  right = {hyper, "right"},
  down = {hyper, "down"},
  left = {hyper, "left"},
  fullscreen = {hyper, "f"}
})
--EOF


-- window switcher
switcher = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{})
switcher.ui.highlightColor = {0, 0, 0, 0.6}
switcher.ui.backgroundColor = {0.2, 0.2, 0.2, 0.5}
switcher.ui.titleBackgroundColor = {0.2, 0.2, 0.2, 0.0}
switcher.ui.textSize = 12
switcher.ui.thumbnailSize = 128
switcher.ui.selectedThumbnailSize = 212
switcher.ui.showThumbnails = false
switcher.ui.fontName = 'HiraginoSans-W2'
hs.hotkey.bind("alt","tab",function()switcher:next()end)
hs.hotkey.bind("alt-shift","tab",function()switcher:previous()end)
--EOF


-- key remap
local function pressFn(mods, key)
  if key == nil then
    key = mods
    mods = {}
  end
  return function() hs.eventtap.keyStroke(mods, key, 1000) end
end
local function remap(mods, key, pressFn)
  hs.hotkey.bind(mods, key, pressFn, nil, pressFn)
end
remap({'ctrl', 'shift'}, 'p', pressFn({'shift'}, 'up'))
remap({'ctrl', 'shift'}, 'b', pressFn({'shift'}, 'left'))
remap({'ctrl', 'shift'}, 'n', pressFn({'shift'}, 'down'))
remap({'ctrl', 'shift'}, 'f', pressFn({'shift'}, 'right'))
-- EOF

-- remap({'ctrl'}, 'i', pressFn('up'))
-- remap({'ctrl'}, 'j', pressFn('left'))
-- remap({'ctrl'}, 'k', pressFn('down'))
-- remap({'ctrl'}, 'l', pressFn('right'))

-- remap({'ctrl', 'shift'}, 'i', pressFn({'shift'}, 'up'))
-- remap({'ctrl', 'shift'}, 'j', pressFn({'shift'}, 'left'))
-- remap({'ctrl', 'shift'}, 'k', pressFn({'shift'}, 'down'))
-- remap({'ctrl', 'shift'}, 'l', pressFn({'shift'}, 'right'))
