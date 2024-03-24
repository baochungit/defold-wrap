local Text = require("example.objects.text")
local Button = require("example.objects.button")
local Modal = require("example.objects.modal")
local GuiScene = require("wrap.gui_scene")
local Scene = GuiScene.extend()

function Scene:init()
	self:set_transitions({
		transition_in = self:slide_in_left(),
		transition_out = self:slide_out_right()
	})

	self:register_modal("modal", Modal, {
		title = "I'm a modal"
	})

	self:new_object(Text, {
		position = vmath.vector3(0, 100, 0),
		text = "Applet 2:\nDemo of switching scenes."
	})

	self.text = self:new_object(Text, {
		text = "Hello world!"
	})

	self:new_object(Button, {
		position = vmath.vector3(0, -100, 0),
		text = "Reload",
		text_color = "#ffff00",
		color = "#888888"
	}, {
		on_click = function()
			self.app:show_scene("loading")
		end
	})

	self:new_object(Button, {
		position = vmath.vector3(0, -40, 0),
		text = "Open Modal",
		text_color = "#ffff00",
		color = "#888888"
	}, {
		on_click = function()
			self:open_modal("modal")
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