local Node = require("wrap.node")

local NodeList = {}
NodeList.__index = NodeList

function NodeList.new(data)
	local self = setmetatable({}, NodeList)
	self._data = data
	for key, node in pairs(self._data) do
		if type(key) == "number" and type(node) == "string" then
			key = node
		end 
		self[key] = Node.new(node)
	end
	return self
end

return NodeList