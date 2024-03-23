local Text = require("example.objects.text")
local Button = require("example.objects.button")
local GuiScene = require("wrap.gui_scene")
local Scene = GuiScene.extend()

function Scene:init()
	self:set_transitions({
		transition_in = self:fade_in(2),
		-- transition_out = self:fade_out()
	})

	self:new_object(Text, {
		position = vmath.vector3(0, 100, 0),
		text = "Applet 2:\nDemo of switching scenes."
	})

	self.text = self:new_object(Text, {
		position = vmath.vector3(0, 30, 0),
		text = "Hello world!"
	})

	self:new_object(Button, {
		position = vmath.vector3(0, -70, 0),
		text = "Reload",
		text_color = "#ffff00",
		color = "#888888"
	}, {
		on_click = function()
			self.app:show_scene("loading")
		end
	})
end

function Scene:on_ready()
	self.text:animate_scale()
end

function Scene:update(dt)
end

function Scene:final()
end

return Scene