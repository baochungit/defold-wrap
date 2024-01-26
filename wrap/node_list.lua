local Node = require("wrap.node")

local NodeList = {}
NodeList.__index = NodeList

function NodeList.new(nodes)
	local self = setmetatable({}, NodeList)
	self._nodes = nodes
	for key, node in pairs(self._nodes) do
		if type(key) == "number" and type(node) == "string" then
			key = node
		end 
		self[key] = Node.new(node)
	end
	return self
end

return NodeList