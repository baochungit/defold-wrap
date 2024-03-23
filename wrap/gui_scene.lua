local GuiScene = {}
GuiScene.__index = GuiScene
GuiScene.__name = "GuiScene"

local STATE_INITIALIZED = "initialized"
local STATE_DELETED = "deleted"
local STATE_READY = "ready"
local STATE_DOING_TRANSITION_IN = "doing-transition-in"
local STATE_DOING_TRANSITION_OUT = "doing-transition-out"


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
	table.insert(self._objects, object)
	return object
end

function GuiScene:setup(app)
	self.app = app
	self._objects = {}
	self._transitions = {}
	self.root = self.app.root:new_box():set_visible(false)
	self:init()
	self._state = STATE_INITIALIZED
end

function GuiScene:is_alive()
	return self._state and self._state ~= STATE_DELETED
end

function GuiScene:is_ready()
	return self._state == STATE_READY
end

function GuiScene:set_transitions(transitions)
	self._transitions = transitions or  {}
end

function GuiScene:transition_in(callback)
	if self._state == STATE_INITIALIZED then
		self.co_transition_in = coroutine.create(function()
			if self._transitions.transition_in then
				self._state = STATE_DOING_TRANSITION_IN
				self._transitions.transition_in(function()
					self:set_transition_in_done()
				end)
				coroutine.yield()
			end
			self._state = STATE_READY
			self:on_ready()
			if callback then callback() end
		end)
		coroutine.resume(self.co_transition_in)
	end
end

function GuiScene:set_transition_in_done()
	if not self._state == STATE_DOING_TRANSITION_IN then return end
	coroutine.resume(self.co_transition_in)
end

function GuiScene:transition_out(callback)
	if self._state == STATE_READY then
		self.co_transition_out = coroutine.create(function()
			if self._transitions.transition_out then
				self._state = STATE_DOING_TRANSITION_OUT
				self._transitions.transition_out(function()
					self:set_transition_out_done()
				end)
				coroutine.yield()
			end
			self:bg_final()
			if callback then callback() end
		end)
		coroutine.resume(self.co_transition_out)
	end
end

function GuiScene:set_transition_out_done()
	if not self._state == STATE_DOING_TRANSITION_OUT then return end
	coroutine.resume(self.co_transition_out)
end

function GuiScene:on_ready()
end

function GuiScene:init()
end

function GuiScene:update(dt)
end

function GuiScene:final()
end

function GuiScene:on_message(message_id, message, sender)
end

function GuiScene:on_input(action_id, action)
	return false
end

function GuiScene:bg_update(dt)
	if not self:is_alive() then return end
	self:update(dt)
	for _, object in ipairs(self._objects) do
		object:bg_update(dt)
	end
end

function GuiScene:bg_final()
	if not self:is_alive() then return end
	self._state = STATE_DELETED
	self:final()
	for _, object in ipairs(self._objects) do
		object:delete()
	end
	self.root:delete()
end

function GuiScene:bg_on_message(message_id, message, sender)
	if not self:is_ready() then return end
	self:on_message(message_id, message, sender)
end

function GuiScene:bg_on_input(action_id, action)
	if not self:is_ready() then return false end
	for i = #self._objects, 1, -1 do
		local object = self._objects[i]
		local ret = object:bg_on_input(action_id, action)
		if ret then return true end
	end
	return self:on_input(action_id, action)
end

-- Built-in transitions
function GuiScene:fade_in(time, wait, easing)
	return function(on_done)
		self.root:set_alpha(0):animate("color.w", 1, easing or gui.EASING_LINEAR, time or 0.5, wait or 0, on_done)
	end
end
function GuiScene:fade_out(time, wait, easing)
	return function(on_done)
		self.root:animate("color.w", 0, easing or gui.EASING_LINEAR, time or 0.5, wait or 0, on_done)
	end
end
function GuiScene:slide_in_top(time, wait, easing)
	return function(on_done)
		local app_size = self.app:get_size()
		self.root:set_position_y(app_size.y):animate("position.y", 0, easing or gui.EASING_LINEAR, time or 0.5, wait or 0, on_done)
	end
end
function GuiScene:slide_in_bottom(time, wait, easing)
	return function(on_done)
		local app_size = self.app:get_size()
		self.root:set_position_y(-app_size.y):animate("position.y", 0, easing or gui.EASING_LINEAR, time or 0.5, wait or 0, on_done)
	end
end
function GuiScene:slide_in_right(time, wait, easing)
	return function(on_done)
		local app_size = self.app:get_size()
		self.root:set_position_x(app_size.x):animate("position.x", 0, easing or gui.EASING_LINEAR, time or 0.5, wait or 0, on_done)
	end
end
function GuiScene:slide_in_left(time, wait, easing)
	return function(on_done)
		local app_size = self.app:get_size()
		self.root:set_position_x(-app_size.x):animate("position.x", 0, easing or gui.EASING_LINEAR, time or 0.5, wait or 0, on_done)
	end
end
function GuiScene:slide_out_top(time, wait, easing)
	return function(on_done)
		local app_size = self.app:get_size()
		self.root:animate("position.y", app_size.y, easing or gui.EASING_LINEAR, time or 0.5, wait or 0, on_done)
	end
end
function GuiScene:slide_out_bottom(time, wait, easing)
	return function(on_done)
		local app_size = self.app:get_size()
		self.root:animate("position.y", -app_size.y, easing or gui.EASING_LINEAR, time or 0.5, wait or 0, on_done)
	end
end
function GuiScene:slide_out_right(time, wait, easing)
	return function(on_done)
		local app_size = self.app:get_size()
		self.root:animate("position.x", app_size.x, easing or gui.EASING_LINEAR, time or 0.5, wait or 0, on_done)
	end
end
function GuiScene:slide_out_left(time, wait, easing)
	return function(on_done)
		local app_size = self.app:get_size()
		self.root:animate("position.x", -app_size.x, easing or gui.EASING_LINEAR, time or 0.5, wait or 0, on_done)
	end
end


return GuiScene