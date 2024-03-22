local Box = require("example.objects.box")
local GuiObject = require("wrap.gui_object")
local Object = GuiObject.extend()

function Object:init()
	local text = self:new_text(nil, self.props.text):set_font("default")
	text:set_color(self.props.color or "#ffffff")
	self.root:set_position(self.props.position)
end

function Object:update(dt)
end

function Object:final()
end

function Object:animate_scale()
	self.root:animate("scale", 5, gui.EASING_LINEAR, 3, 0, nil, gui.PLAYBACK_LOOP_PINGPONG)
end

return Object