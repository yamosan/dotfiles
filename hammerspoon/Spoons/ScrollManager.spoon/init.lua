-- https://github.com/tekezo/Karabiner/issues/814#issuecomment-337643019

local obj={}
obj.name = "ScrollManager"



local deferred = false


overrideRightMouseDown = hs.eventtap.new({ hs.eventtap.event.types.rightMouseDown }, function(e)
    deferred = true
    return true
end)

overrideRightMouseUp = hs.eventtap.new({ hs.eventtap.event.types.rightMouseUp }, function(e)
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
    deferred = false

    oldmousepos = hs.mouse.absolutePosition()

    local dx = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaX'])
    local dy = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaY'])
    local scroll = hs.eventtap.event.newScrollEvent({-dx * scrollmult, -dy * scrollmult},{},'pixel')

    -- put the mouse back
    hs.mouse.absolutePosition(oldmousepos)

    return true, {scroll}
end)

function obj:start()
  overrideRightMouseDown:start()
  overrideRightMouseUp:start()
  dragRightToScroll:start()
end

return obj
