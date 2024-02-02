local Node = require("wrap.node")

local NodeTree = {}
NodeTree.__index = NodeTree

function NodeTree.new(data, tree)
	local self = setmetatable({}, NodeTree)
	self._data = data
	self.tree = tree
	for key, name in pairs(self._data) do
		if type(name) == "string" then
			if type(key) == "number" then
				key = name
			end 
			self[key] = Node.new(tree[name])
		end
	end
	return self
end

return NodeTree