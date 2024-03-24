local Button = require("example.objects.button")
local GuiObject = require("wrap.gui_object")
local Object = GuiObject.extend()

function Object:init()
	self.overlay = self:new_box(nil, self.scene.app:get_size()):set_color("#000000"):set_alpha(0.7)
	self.box = self:new_box(nil, vmath.vector3(150, 120, 0)):set_color("#aaaaaa")
	self.title = self:new_text(vmath.vector3(0, 45, 0), self.props.title):set_font("default"):set_color("#000000")
	self.closebtn = self:new_object(Button, {
		position = vmath.vector3(0, -40, 0),
		color = "#888888",
		text = "Close"
	}, {
		on_click = function() self:close() end
	})
end

function Object:close()
	self:delete()
end

function Object:update(dt)
end

function Object:final()
end

function Object:on_input(action_id, action)
	if self.root:is_enabled() then
		if self.box:in_bound(action.x, action.y) then
			return true
		end
		if self.overlay:in_bound(action.x, action.y) then
			if action_id == hash("touch") and action.pressed then
				self:close()
			end
			return true
		end
	end
	return false
end

return Object