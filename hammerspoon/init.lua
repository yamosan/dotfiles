---- MiroWindowsManager
hs.loadSpoon("MiroWindowsManager")
hs.window.animationDuration = 0.2

local hyper = {"ctrl", "alt", "cmd"}
spoon.MiroWindowsManager:bindHotkeys({
  up = {hyper, "up"},
  right = {hyper, "right"},
  down = {hyper, "down"},
  left = {hyper, "left"},
  fullscreen = {hyper, "f"}
})


---- ScrollManager
hs.loadSpoon("ScrollManager")
spoon.ScrollManager:start()
