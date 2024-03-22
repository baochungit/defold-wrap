local GuiScene = {}
GuiScene.__index = GuiScene
GuiScene.__name = "GuiScene"


function GuiScene.new()
	return setmetatable({}, GuiScene)
end

function GuiScene.extend()
	local extended = GuiScene.new()
	extended.__index = extended
	extended.new = function()
		return setmetatable({}, extended)
	end
	return extended
end

function GuiScene:new_object(object_class, props, settings)
	local object = object_class.new()
	object:setup(self, props, settings)
	object:init()
	table.insert(self._objects, object)
	return object
end

function GuiScene:setup(app)
	self.app = app
	self._objects = {}
	self.root = self.app.root:new_box():set_visible(false)
end

function GuiScene:init()
end

function GuiScene:update(dt)
end

function GuiScene:bg_update(dt)
	for _, object in ipairs(self._objects) do
		object:update(dt)
	end
end

function GuiScene:final()
end

function GuiScene:bg_final()
	for _, object in ipairs(self._objects) do
		object:delete()
	end
	self.root:delete()
end

function GuiScene:on_message(message_id, message, sender)
end

function GuiScene:on_input(action_id, action)
	for i = #self._objects, 1, -1 do
		local object = self._objects[i]
		local ret = object:on_input(action_id, action)
		if ret then return true end
	end
	return false
end


return GuiScene