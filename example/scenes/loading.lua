local Box = require("example.objects.box")
local Text = require("example.objects.text")
local GuiScene = require("wrap.gui_scene")
local Scene = GuiScene.extend()

function Scene:init()
	self:set_transitions({
		transition_in = function(on_done)
			self.root:set_alpha(0):set_scale(0.5):animate({ "color.w", "scale" }, { 1, 1 }, gui.EASING_LINEAR, 0.5, 0, on_done)
		end,
		transition_out = self:fade_out()
	})

	local box = self:new_object(Box, {
		position = vmath.vector3(),
		size = vmath.vector3(80)
	})
	box:animate_rotate()
	
	self:new_object(Text, {
		position = vmath.vector3(),
		text = "Loading...",
		color = "#ff0000"
	})

	timer.delay(3, false, function()
		self.app:show_scene("lobby")
	end)
end

function Scene:update(dt)
end

function Scene:final()
end

return Scene