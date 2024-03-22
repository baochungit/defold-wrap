local GuiObject = {}
GuiObject.__index = GuiObject
GuiObject.__name = "GuiObject"


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
end

function GuiObject:new_box(position, size)
	return self.root:new_box(position, size)
end

function GuiObject:new_text(position, text)
	return self.root:new_text(position, text)
end

function GuiObject:new_object(object_class, props, settings)
	local object = object_class.new()
	object:setup(self.scene, props, settings)
	object:init()
	table.insert(self._objects, object)
	return object
end

function GuiObject:init()
end

function GuiObject:update(dt)
	for _, object in ipairs(self._objects) do
		object:update(dt)
	end
end

function GuiObject:final()
end

function GuiObject:delete()
	for _, object in ipairs(self._objects) do
		object:final()
	end
	self:final()
	self.root:delete()
end

function GuiObject:on_input(action_id, action)
end


return GuiObject