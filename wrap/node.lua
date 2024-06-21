
local Node = {}
Node.__index = Node


local function get_scale_recursive(node)
	local scale = gui.get_scale(node)
	local parent = gui.get_parent(node)
	if parent then
		local parent_scale = get_scale_recursive(parent)
		scale.x = scale.x * parent_scale.x
		scale.y = scale.y * parent_scale.y
		scale.z = scale.z * parent_scale.z
	end
	return scale
end

function Node.new(node)
	local self = setmetatable({}, Node)
	if type(node) == "string" then
		node = gui.get_node(node)
	end
	self.node = node
	return self
end

function Node:get_id()
	return gui.get_id(self.node)
end

function Node:set_id(new_id)
	gui.set_id(self.node, new_id)
	return self
end

function Node:get_index()
	return gui.get_index(self.node)
end

function Node:delete()
	gui.delete_node(self.node)
	return self
end

function Node:animate(property, to, easing, duration, delay, complete_function, playback)
	delay = delay or 0
	if type(property) == "table" then
		for i, prop in pairs(property) do
			gui.animate(self.node, prop, to[i], easing, duration, delay, i == 1 and complete_function or nil, playback)
		end
	else
		gui.animate(self.node, property, to, easing, duration, delay, complete_function, playback)
	end
	return self
end

function Node:cancel_animation(property)
	if type(property) == "table" then
		for _, prop in pairs(property) do
			gui.cancel_animation(self.node, prop)
		end
	else
		gui.cancel_animation(self.node, property)
	end
	return self
end

function Node:new_box_node(position, size)
	position = position or vmath.vector3()
	size = size or vmath.vector3()
	local node = gui.new_box_node(position, size)
	gui.set_inherit_alpha(node, true)
	gui.set_parent(node, self.node)
	return node
end

function Node:new_box(position, size)
	return Node.new(self:new_box_node(position, size))
end

function Node:new_text_node(position, text)
	position = position or vmath.vector3()
	text = text or ""
	local node = gui.new_text_node(position, text)
	gui.set_inherit_alpha(node, true)
	gui.set_parent(node, self.node)
	return node
end

function Node:new_text(position, text)
	return Node.new(self:new_text_node(position, text))
end

function Node:new_pie_node(position, size)
	position = position or vmath.vector3()
	size = size or vmath.vector3()
	local node = gui.new_pie_node(position, size)
	gui.set_inherit_alpha(node, true)
	gui.set_parent(node, self.node)
	return node
end

function Node:new_pie(position, size)
	return Node.new(self:new_pie_node(position, size))
end

function Node:new_particlefx_node(position, particlefx)
	position = position or vmath.vector3()
	local node = gui.new_particlefx_node(position, particlefx)
	gui.set_inherit_alpha(node, true)
	gui.set_parent(node, self.node)
	return node
end

function Node:new_particlefx(position, particlefx)
	return Node.new(self:new_particlefx_node(position, particlefx))
end

function Node:get_text()
	return gui.get_text(self.node)
end

function Node:set_text(text)
	gui.set_text(self.node, text)
	return self
end

function Node:get_line_break()
	return gui.get_line_break(self.node)
end

function Node:set_line_break(line_break)
	gui.set_line_break(self.node, line_break)
	return self
end

function Node:get_blend_mode()
	return gui.get_blend_mode(self.node)
end

function Node:set_blend_mode(blend_mode)
	gui.set_blend_mode(self.node, blend_mode)
	return self
end

function Node:get_texture()
	return gui.get_texture(self.node)
end

function Node:set_texture(texture)
	gui.set_texture(self.node, texture)
	return self
end

function Node:get_flipbook()
	return gui.get_flipbook(self.node)
end

function Node:play_flipbook(animation, complete_function, play_properties)
	play_properties = play_properties or {}
	gui.play_flipbook(self.node, animation, complete_function, play_properties)
	return self
end

function Node:cancel_flipbook()
	gui.cancel_flipbook(self.node)
	return self
end

function Node:get_material()
	return gui.get_material(self.node)
end

function Node:set_material(material)
	gui.set_material(self.node, material)
	return self
end

function Node:reset_material()
	gui.reset_material(self.node)
	return self
end

function Node:get_font()
	return gui.get_font(self.node)
end

function Node:set_font(font)
	gui.set_font(self.node, font)
	return self
end

function Node:get_layer()
	return gui.get_layer(self.node)
end

function Node:set_layer(layer)
	gui.set_layer(self.node, layer)
	return self
end

function Node:get_clipping_mode()
	return gui.get_clipping_mode(self.node)
end

function Node:set_clipping_mode(clipping_mode)
	gui.set_clipping_mode(self.node, clipping_mode)
	return self
end

function Node:get_clipping_visible()
	return gui.get_clipping_visible(self.node)
end

function Node:set_clipping_visible(visible)
	gui.set_clipping_visible(self.node, visible)
	return self
end

function Node:get_clipping_inverted()
	return gui.get_clipping_inverted(self.node)
end

function Node:set_clipping_inverted(inverted)
	gui.set_clipping_inverted(self.node, inverted)
	return self
end

function Node:get_xanchor()
	return gui.get_xanchor(self.node)
end

function Node:set_xanchor(anchor)
	gui.set_xanchor(self.node, anchor)
	return self
end

function Node:get_yanchor()
	return gui.get_yanchor(self.node)
end

function Node:set_yanchor(anchor)
	gui.set_yanchor(self.node, anchor)
	return self
end

function Node:get_pivot()
	return gui.get_pivot(self.node)
end

function Node:set_pivot(pivot)
	gui.set_pivot(self.node, pivot)
	return self
end

function Node:get_slice9()
	return gui.get_slice9(self.node)
end

function Node:set_slice9(values)
	gui.set_slice9(self.node, values)
	return self
end

function Node:get_perimeter_vertices()
	return gui.get_perimeter_vertices(self.node)
end

function Node:set_perimeter_vertices(vertices)
	gui.set_perimeter_vertices(self.node, vertices)
	return self
end

function Node:get_fill_angle()
	return gui.get_fill_angle(self.node)
end

function Node:set_fill_angle(angle)
	gui.set_fill_angle(self.node, angle)
	return self
end

function Node:get_inner_radius()
	return gui.get_inner_radius(self.node)
end

function Node:set_inner_radius(radius)
	gui.set_inner_radius(self.node, radius)
	return self
end

function Node:get_outer_bounds()
	return gui.get_outer_bounds(self.node)
end

function Node:set_outer_bounds(bounds_mode)
	gui.set_outer_bounds(self.node, bounds_mode)
	return self
end

function Node:get_leading()
	return gui.get_leading(self.node)
end

function Node:set_leading(leading)
	gui.set_leading(self.node, leading)
	return self
end

function Node:get_tracking()
	return gui.get_tracking(self.node)
end

function Node:set_tracking(tracking)
	gui.set_tracking(self.node, tracking)
	return self
end

function Node:in_bound(x, y)
	return gui.pick_node(self.node, x, y)
end

function Node:is_enabled()
	return gui.is_enabled(self.node)
end

function Node:set_enabled(bool)
	gui.set_enabled(self.node, bool)
	return self
end

function Node:get_visible()
	return gui.get_visible(self.node)
end

function Node:set_visible(visible)
	gui.set_visible(self.node, visible)
	return self
end

function Node:get_adjust_mode()
	return gui.get_adjust_mode(self.node)
end

function Node:set_adjust_mode(adjust_mode)
	gui.set_adjust_mode(self.node, adjust_mode)
	return self
end

function Node:get_size_mode()
	return gui.get_size_mode(self.node)
end

function Node:set_size_mode(size_mode)
	gui.set_size_mode(self.node, size_mode)
	return self
end

function Node:move_above(reference)
	if type(reference) == "table" then reference = reference.node end
	gui.move_above(self.node, reference)
	return self
end

function Node:move_below(reference)
	if type(reference) == "table" then reference = reference.node end
	gui.move_below(self.node, reference)
	return self
end

function Node:get_parent()
	return gui.get_parent(self.node)
end

function Node:set_parent(parent, keep_scene_transform)
	keep_scene_transform = keep_scene_transform or false
	if type(parent) == "table" then parent = parent.node end
	gui.set_parent(self.node, parent, keep_scene_transform)
	return self
end

function Node:add_child(node, keep_scene_transform)
	keep_scene_transform = keep_scene_transform or false
	if type(node) == "table" then node = node.node end
	gui.set_parent(node, self.node, keep_scene_transform)
	return self
end

function Node:clone()
	return gui.clone(self.node)
end

function Node:clone_tree()
	return gui.clone_tree(self.node)
end

function Node:get_tree()
	return gui.get_tree(self.node)
end

function Node:get_position()
	return gui.get_position(self.node)
end

function Node:set_position(position)
	position = position or vmath.vector3()
	gui.set_position(self.node, position)
	return self
end

function Node:add_position(value)
	local position = self:get_position()
	position.x = position.x + value.x
	position.y = position.y + value.y
	position.z = position.z + value.z
	return self
end

function Node:get_position_x()
	local position = self:get_position()
	return position.x
end

function Node:get_position_y()
	local position = self:get_position()
	return position.y
end

function Node:get_position_z()
	local position = self:get_position()
	return position.z
end

function Node:set_position_x(x)
	local position = self:get_position()
	position.x = x
	return self:set_position(position)
end

function Node:set_position_y(y)
	local position = self:get_position()
	position.y = y
	return self:set_position(position)
end

function Node:set_position_z(z)
	local position = self:get_position()
	position.z = z
	return self:set_position(position)
end

function Node:add_position_x(x)
	local position = self:get_position()
	position.x = position.x + x
	return self:set_position(position)
end

function Node:add_position_y(y)
	local position = self:get_position()
	position.y = position.y + y
	return self:set_position(position)
end

function Node:add_position_z(z)
	local position = self:get_position()
	position.z = position.z + z
	return self:set_position(position)
end

function Node:get_rotation()
	return gui.get_rotation(self.node)
end

function Node:set_rotation(rotation)
	gui.set_rotation(self.node, rotation)
	return self
end

function Node:add_rotation(value)
	local rotation = self:get_rotation()
	rotation.x = rotation.x + value.x
	rotation.y = rotation.y + value.y
	rotation.z = rotation.z + value.z
	return self
end

function Node:get_rotation_x()
	local rotation = self:get_rotation()
	return rotation.x
end

function Node:get_rotation_y()
	local rotation = self:get_rotation()
	return rotation.y
end

function Node:get_rotation_z()
	local rotation = self:get_rotation()
	return rotation.z
end

function Node:set_rotation_x(x)
	local rotation = self:get_rotation()
	rotation.x = x
	return self:set_rotation(rotation)
end

function Node:set_rotation_y(y)
	local rotation = self:get_rotation()
	rotation.y = y
	return self:set_rotation(rotation)
end

function Node:set_rotation_z(z)
	local rotation = self:get_rotation()
	rotation.z = z
	return self:set_rotation(rotation)
end

function Node:add_rotation_x(x)
	local rotation = self:get_rotation()
	rotation.x = rotation.x + x
	return self:set_rotation(rotation)
end

function Node:add_rotation_y(y)
	local rotation = self:get_rotation()
	rotation.y = rotation.y + y
	return self:set_rotation(rotation)
end

function Node:add_rotation_z(z)
	local rotation = self:get_rotation()
	rotation.z = rotation.z + z
	return self:set_rotation(rotation)
end

function Node:get_euler()
    return gui.get_euler(self.node)
end

function Node:set_euler(euler)
    gui.set_euler(self.node, euler)
    return self
end

function Node:add_euler(value)
    local euler = self:get_euler()
    euler.x = euler.x + value.x
    euler.y = euler.y + value.y
    euler.z = euler.z + value.z
    return self
end

function Node:get_euler_x()
    local euler = self:get_euler()
    return euler.x
end

function Node:get_euler_y()
    local euler = self:get_euler()
    return euler.y
end

function Node:get_euler_z()
    local euler = self:get_euler()
    return euler.z
end

function Node:set_euler_x(x)
    local euler = self:get_euler()
    euler.x = x
    return self:set_euler(euler)
end

function Node:set_euler_y(y)
    local euler = self:get_euler()
    euler.y = y
    return self:set_euler(euler)
end

function Node:set_euler_z(z)
    local euler = self:get_euler()
    euler.z = z
    return self:set_euler(euler)
end

function Node:add_euler_x(x)
    local euler = self:get_euler()
    euler.x = euler.x + x
    return self:set_euler(euler)
end

function Node:add_euler_y(y)
    local euler = self:get_euler()
    euler.y = euler.y + y
    return self:set_euler(euler)
end

function Node:add_euler_z(z)
    local euler = self:get_euler()
    euler.z = euler.z + z
    return self:set_euler(euler)
end

function Node:get_scale()
	return gui.get_scale(self.node)
end

function Node:set_scale(scale)
	if type(scale) == "number" then
		scale = vmath.vector3(scale)
	end
	gui.set_scale(self.node, scale)
	return self
end

function Node:add_scale(value)
	local scale = self:get_scale()
	if type(value) == "number" then
		scale.x = scale.x + value
		scale.y = scale.y + value
		scale.z = scale.z + value
	else
		scale.x = scale.x + value.x
		scale.y = scale.y + value.y
		scale.z = scale.z + value.z
	end
	return self
end

function Node:get_scale_x()
	local scale = self:get_scale()
	return scale.x
end

function Node:get_scale_y()
	local scale = self:get_scale()
	return scale.y
end

function Node:get_scale_z()
	local scale = self:get_scale()
	return scale.z
end

function Node:set_scale_x(x)
	local scale = self:get_scale()
	scale.x = x
	return self:set_scale(scale)
end

function Node:set_scale_y(y)
	local scale = self:get_scale()
	scale.y = y
	return self:set_scale(scale)
end

function Node:set_scale_z(z)
	local scale = self:get_scale()
	scale.z = z
	return self:set_scale(scale)
end

function Node:add_scale_x(x)
	local scale = self:get_scale()
	scale.x = scale.x + x
	return self:set_scale(scale)
end

function Node:add_scale_y(y)
	local scale = self:get_scale()
	scale.y = scale.y + y
	return self:set_scale(scale)
end

function Node:add_scale_z(z)
	local scale = self:get_scale()
	scale.z = scale.z + z
	return self:set_scale(scale)
end

function Node:get_color()
	return gui.get_color(self.node)
end

function Node:set_color(color)
	if type(color) == "string" then
		-- #rrggbbaa
		local r = tonumber('0x' .. string.sub(color, 2, 3), 16) / 255
		local g = tonumber('0x' .. string.sub(color, 4, 5), 16) / 255
		local b = tonumber('0x' .. string.sub(color, 6, 7), 16) / 255
		local a = 1
		if string.len(color) == 9 then a = tonumber('0x' .. string.sub(color, 8, 9), 16) / 255 end
		color = vmath.vector4(r, g, b, a)
	end
	gui.set_color(self.node, color)
	return self
end

function Node:get_outline()
	return gui.get_outline(self.node)
end

function Node:set_outline(color)
	gui.set_outline(self.node, color)
	return self
end

function Node:get_shadow()
	return gui.get_shadow(self.node)
end

function Node:set_shadow(color)
	gui.set_shadow(self.node, color)
	return self
end

function Node:get_size()
	return gui.get_size(self.node)
end

function Node:set_size(size)
	gui.set_size(self.node, size)
	return self
end

function Node:add_size(value)
	local size = self:get_size()
	size.x = size.x + value.x
	size.y = size.y + value.y
	size.z = size.z + value.z
	return self
end

function Node:get_size_x()
	local size = self:get_size()
	return size.x
end

function Node:get_size_y()
	local size = self:get_size()
	return size.y
end

function Node:get_size_z()
	local size = self:get_size()
	return size.z
end

function Node:set_size_x(x)
	local size = self:get_size()
	size.x = x
	return self:set_size(size)
end

function Node:set_size_y(y)
	local size = self:get_size()
	size.y = y
	return self:set_size(size)
end

function Node:set_size_z(z)
	local size = self:get_size()
	size.z = z
	return self:set_size(size)
end

function Node:add_size_x(x)
	local size = self:get_size()
	size.x = size.x + x
	return self:set_size(size)
end

function Node:add_size_y(y)
	local size = self:get_size()
	size.y = size.y + y
	return self:set_size(size)
end

function Node:add_size_z(z)
	local size = self:get_size()
	size.z = size.z + z
	return self:set_size(size)
end

function  Node:get_text_metrics(apply_scale)
	local metrics = resource.get_text_metrics(gui.get_font_resource(self:get_font()), self:get_text())
	if apply_scale then
		metrics.width = metrics.width * self:get_scale_x()
		metrics.height = metrics.height * self:get_scale_y()
	end
	return metrics
end

function Node:get_total_scale()
	return get_scale_recursive(self.node)
end

function Node:get_screen_position()
	return gui.get_screen_position(self.node)
end

function Node:set_screen_position(screen_position)
	gui.set_screen_position(self.node, screen_position)
	return self
end

function Node:screen_to_local(screen_position, ignore_scale)
	local pos = gui.screen_to_local(self.node, screen_position)
	if ignore_scale then
		local scale = self:get_total_scale()
		pos.x = pos.x / scale.x
		pos.y = pos.y / scale.y
		pos.z = pos.z / scale.z
	end
	return pos
end

function Node:get_flipbook_cursor()
	return gui.get_flipbook_cursor(self.node)
end

function Node:set_flipbook_cursor(cursor)
	gui.set_flipbook_cursor(self.node, cursor)
	return self
end

function Node:get_flipbook_playback_rate()
	return gui.get_flipbook_playback_rate(self.node)
end

function Node:set_flipbook_playback_rate(playback_rate)
	gui.set_flipbook_playback_rate(self.node, playback_rate)
	return self
end

function Node:play_particlefx(emitter_state_function)
	gui.set_flipbook_cursor(self.node, emitter_state_function)
	return self
end

function Node:stop_particlefx(options)
	gui.stop_particlefx(self.node, options)
	return self
end

function Node:get_particlefx()
	return gui.get_particlefx(self.node)
end

function Node:set_particlefx(particlefx)
	gui.set_particlefx(self.node, particlefx)
	return self
end

function Node:get_inherit_alpha()
	return gui.get_inherit_alpha(self.node)
end

function Node:set_inherit_alpha(inherit_alpha)
	gui.set_inherit_alpha(self.node, inherit_alpha)
	return self
end

function Node:get_alpha()
	return gui.get_alpha(self.node)
end

function Node:set_alpha(alpha)
	gui.set_alpha(self.node, alpha)
	return self
end


return Node
