local GuiObject = require("wrap.gui_object")
local Object = GuiObject.extend()

function Object:init()
	self.root:set_position(self.props.position):set_size(self.props.size)
		:set_color(self.props.color or "#ffffff"):set_visible(true)
end

function Object:update(dt)
end

function Object:final()
end

function Object:animate_rotate()
	self.root:animate("rotation.z", 360, gui.EASING_LINEAR, 3, 0, nil, gui.PLAYBACK_LOOP_FORWARD)
end

return Object