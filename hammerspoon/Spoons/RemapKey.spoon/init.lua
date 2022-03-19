obj = {}

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

function obj:start()
  remap({'ctrl', 'shift'}, 'p', pressFn({'shift'}, 'up'))
  remap({'ctrl', 'shift'}, 'b', pressFn({'shift'}, 'left'))
  remap({'ctrl', 'shift'}, 'n', pressFn({'shift'}, 'down'))
  remap({'ctrl', 'shift'}, 'f', pressFn({'shift'}, 'right'))
end


return obj
