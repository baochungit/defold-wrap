local Node = require("wrap.node")
local GuiScene = require("wrap.gui_scene")

local GuiApplet = {}
GuiApplet.__index = GuiApplet
GuiApplet.__name = "GuiApplet"


function GuiApplet.new(root, scene)
	local self = setmetatable({}, GuiApplet)
	self.root = Node.new(root)
	self.registered_scenes = {}
	self.current_scene = nil
	if scene then
		self:show_scene(scene)
	end
	return self
end

function GuiApplet:register_scene(name, scene)
	if scene.__name ~= "GuiScene" then
		local Scene = GuiScene.extend()
		for k, v in pairs(scene) do
			Scene[k] = v
		end
		scene = Scene
	end
	self.registered_scenes[name] = scene
end

function GuiApplet:unregister_scene(name)
	self.registered_scenes[name] = nil
end

function GuiApplet:show_scene(name_or_scene)
	local instance = nil
	if type(name_or_scene) == "string" then
		local scene = self.registered_scenes[name_or_scene]
		if scene then
			instance = scene.new()
		end
	else
		if name_or_scene.__name ~= "GuiScene" then
			instance = GuiScene.extend()
			for k, v in pairs(name_or_scene) do
				instance[k] = v
			end
		else
			instance = name_or_scene.new()
		end
	end
	if instance then
		if self.current_scene then
			self.current_scene:final()
			self.current_scene:bg_final()
		end
		instance:setup(self)
		instance:init()
		self.current_scene = instance
	end
end

function GuiApplet:get_size()
	return self.root:get_size()
end

function GuiApplet:update(dt)
	if self.current_scene then
		self.current_scene:update(dt)
		self.current_scene:bg_update(dt)
	end
end

function GuiApplet:final()
	if self.current_scene then
		self.current_scene:final()
		self.current_scene:bg_final()
	end
end

function GuiApplet:on_message(message_id, message, sender)
	if self.current_scene then
		self.current_scene:on_message(message_id, message, sender)
	end
end

function GuiApplet:on_input(action_id, action)
	if self.current_scene then
		return self.current_scene:on_input(action_id, action)
	end
	return false
end


return GuiApplet