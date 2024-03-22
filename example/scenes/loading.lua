local Box = require("example.objects.box")
local Text = require("example.objects.text")
local GuiScene = require("wrap.gui_scene")
local Scene = GuiScene.extend()

function Scene:init()
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