local GuiObject = {}
GuiObject.__index = GuiObject
GuiObject.__name = "GuiObject"

local STATE_INITIALIZED = "initialized"
local STATE_DELETED = "deleted"


function GuiObject.new()
	return setmetatable({}, GuiObject)
end

function GuiObject.extend()
	local extended = GuiObject.new()
	extended.__index = extended
	extended.new = function()
		return setmetatable({}, extended)
	end
	return extended
end

function GuiObject:setup(scene, props, settings)
	self.scene = scene
	self._objects = {}
	self.props = props or {}
	self.settings = settings or {}
	self.root = self.scene.root:new_box():set_visible(false)
	self:init()
	self._state = STATE_INITIALIZED
end

function GuiObject:is_alive()
	return self._state and self._state ~= STATE_DELETED
end

function GuiObject:new_box(position, size)
	return self.root:new_box(position, size)
end

function GuiObject:new_text(position, text)
	return self.root:new_text(position, text)
end

function GuiObject:new_pie(position, size)
	return self.root:new_pie(position, size)
end

function GuiObject:new_particlefx(position, particlefx)
	return self.root:new_particlefx(position, particlefx)
end

function GuiObject:new_object(object_class, props, settings)
	local object = object_class.new()
	object:setup(self.scene, props, settings)
	table.insert(self._objects, object)
	return object
end

function GuiObject:init()
end

function GuiObject:update(dt)
end

function GuiObject:final()
end

function GuiObject:on_input(action_id, action)
	return false
end

function GuiObject:bg_update(dt)
	if not self:is_alive() then return end
	self:update(dt)
	for _, object in ipairs(self._objects) do
		object:update(dt)
	end
end

function GuiObject:delete()
	if not self:is_alive() then return end
	self._state = STATE_DELETED
	self:final()
	for _, object in ipairs(self._objects) do
		object:delete()
	end
	self.root:delete()
end

function GuiObject:bg_on_input(action_id, action)
	if not self:is_alive() then return false end
	for i = #self._objects, 1, -1 do
		local object = self._objects[i]
		local ret = object:bg_on_input(action_id, action)
		if ret then return true end
	end
	return self:on_input(action_id, action)
end


return GuiObject