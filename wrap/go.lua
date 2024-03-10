
local Go = {}
Go.__index = Go


function Go.new(url)
	local self = setmetatable({}, Go)
	self.url = url
	return self
end

function Go:get(property, options)
	options = options or {}
	return go.get(self.url, property, options)
end

function Go:set(property, value, options)
	options = options or {}
	go.set(self.url, property, value, options)
	return self
end

function Go:get_id()
	return go.get_id(self.url)
end

function Go:delete(recursive)
	recursive = recursive or true
	go.delete(self.url, recursive)
	return self
end

function Go:animate(property, playback, to, easing, duration, delay, complete_function)
	delay = delay or 0
	if type(property) == "table" then
		for i, prop in pairs(property) do
			go.animate(self.url, prop, playback, to[i], easing, duration, delay, i == 1 and complete_function or nil)

		end
	else
		go.animate(self.url, property, playback, to, easing, duration, delay, complete_function)
	end
	return self
end

function Go:cancel_animations(property)
	if type(property) == "table" then
		for _, prop in pairs(property) do
			go.cancel_animations(self.url, prop)
		end
	else
		go.cancel_animations(self.url, property)
	end
	return self
end

function Go:set_position(position)
	go.set_position(position, self.url)
	return self
end

function Go:get_position()
	return go.get_position(self.url)
end

function Go:set_position(position)
	go.set_position(position, self.url)
	return self
end

function Go:add_position(value)
	local position = self:get_position()
	position.x = position.x + value.x
	position.y = position.y + value.y
	position.z = position.z + value.z
	return self
end

function Go:get_position_x()
	local position = self:get_position()
	return position.x
end

function Go:get_position_y()
	local position = self:get_position()
	return position.y
end

function Go:get_position_z()
	local position = self:get_position()
	return position.z
end

function Go:set_position_x(x)
	local position = self:get_position()
	position.x = x
	return self:set_position(position)
end

function Go:set_position_y(y)
	local position = self:get_position()
	position.y = y
	return self:set_position(position)
end

function Go:set_position_z(z)
	local position = self:get_position()
	position.z = z
	return self:set_position(position)
end

function Go:add_position_x(x)
	local position = self:get_position()
	position.x = position.x + x
	return self:set_position(position)
end

function Go:add_position_y(y)
	local position = self:get_position()
	position.y = position.y + y
	return self:set_position(position)
end

function Go:add_position_z(z)
	local position = self:get_position()
	position.z = position.z + z
	return self:set_position(position)
end

function Go:get_rotation()
	return go.get_rotation(self.url)
end

function Go:set_rotation(rotation)
	go.set_rotation(rotation, self.url)
	return self
end

function Go:add_rotation(value)
	local rotation = self:get_rotation()
	rotation.x = rotation.x + value.x
	rotation.y = rotation.y + value.y
	rotation.z = rotation.z + value.z
	return self
end

function Go:get_rotation_x()
	local rotation = self:get_rotation()
	return rotation.x
end

function Go:get_rotation_y()
	local rotation = self:get_rotation()
	return rotation.y
end

function Go:get_rotation_z()
	local rotation = self:get_rotation()
	return rotation.z
end

function Go:set_rotation_x(x)
	local rotation = self:get_rotation()
	rotation.x = x
	return self:set_rotation(rotation)
end

function Go:set_rotation_y(y)
	local rotation = self:get_rotation()
	rotation.y = y
	return self:set_rotation(rotation)
end

function Go:set_rotation_z(z)
	local rotation = self:get_rotation()
	rotation.z = z
	return self:set_rotation(rotation)
end

function Go:add_rotation_x(x)
	local rotation = self:get_rotation()
	rotation.x = rotation.x + x
	return self:set_rotation(rotation)
end

function Go:add_rotation_y(y)
	local rotation = self:get_rotation()
	rotation.y = rotation.y + y
	return self:set_rotation(rotation)
end

function Go:add_rotation_z(z)
	local rotation = self:get_rotation()
	rotation.z = rotation.z + z
	return self:set_rotation(rotation)
end

function Go:get_scale()
	return go.get_scale(self.url)
end

function Go:set_scale(scale)
	go.set_scale(scale, self.url)
	return self
end

function Go:add_scale(value)
	local scale = self:get_scale()
	scale.x = scale.x + value.x
	scale.y = scale.y + value.y
	scale.z = scale.z + value.z
	return self
end

function Go:get_scale_x()
	local scale = self:get_scale()
	return scale.x
end

function Go:get_scale_y()
	local scale = self:get_scale()
	return scale.y
end

function Go:get_scale_z()
	local scale = self:get_scale()
	return scale.z
end

function Go:set_scale_x(x)
	local scale = self:get_scale()
	scale.x = x
	return self:set_scale(scale)
end

function Go:set_scale_y(y)
	local scale = self:get_scale()
	scale.y = y
	return self:set_scale(scale)
end

function Go:set_scale_z(z)
	local scale = self:get_scale()
	scale.z = z
	return self:set_scale(scale)
end

function Go:add_scale_x(x)
	local scale = self:get_scale()
	scale.x = scale.x + x
	return self:set_scale(scale)
end

function Go:add_scale_y(y)
	local scale = self:get_scale()
	scale.y = scale.y + y
	return self:set_scale(scale)
end

function Go:add_scale_z(z)
	local scale = self:get_scale()
	scale.z = scale.z + z
	return self:set_scale(scale)
end

function Go:get_parent()
	return go.get_parent(self.url)
end

function Go:set_parent(parent, keep_world_transform)
	go.set_parent(self.url, parent, keep_world_transform)
	return self
end

function Go:get_scale_uniform()
	return go.get_scale_uniform(self.url)
end

function Go:get_world_position()
	return go.get_world_position(self.url)
end

function Go:get_world_rotation()
	return go.get_world_rotation(self.url)
end

function Go:get_world_scale()
	return go.get_world_scale(self.url)
end

function Go:get_world_scale_uniform()
	return go.get_world_scale_uniform(self.url)
end

function Go:get_world_transform()
	return go.get_world_transform(self.url)
end


return Go