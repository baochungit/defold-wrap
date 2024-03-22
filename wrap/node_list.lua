local Node = require("wrap.node")

local NodeList = {}
NodeList.__index = NodeList

function NodeList.new(data, tree)
	local self = setmetatable({}, NodeList)
	self.tree = tree
	for key, node in pairs(data) do
		if type(key) == "number" and type(node) == "string" then
			key = node
		end 
		if type(node) == "string" then
			self[key] = Node.new(tree and tree[node] or node)
		else
			self[key] = Node.new(node)
		end
	end
	return self
end

return NodeList