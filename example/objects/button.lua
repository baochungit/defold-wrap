local GuiObject = require("wrap.gui_object")
local Object = GuiObject.extend()

function Object:init()
	local text = self:new_text(nil, self.props.text):set_font("default")
	text:set_color(self.props.text_color or "#ffffff")
	local metrics = text:get_text_metrics()
	self.root:set_position(self.props.position)
	self.root:set_size(vmath.vector3(metrics.width + 20, metrics.height + 10, 0)):set_color(self.props.color or "#dddddd"):set_visible(true)
end

function Object:update(dt)
end

function Object:final()
end

function Object:on_input(action_id, action)
	if self.root:is_enabled() then
		if self.root:in_bound(action.x, action.y) then
			self:_set_hover(true)
			if action_id == hash("touch") and action.pressed then
				if self.settings.on_click then self.settings.on_click() end
			end
			return true
		else
			self:_set_hover(false)
		end
	end
	return false
end

function Object:_set_hover(bool)
	if bool == self.hover then return end
	self.hover = bool
	if bool then
		self.root:animate("scale", 1.05, gui.EASING_LINEAR, 0.1)
	else
		self.root:set_scale(1)
	end
end

return Object