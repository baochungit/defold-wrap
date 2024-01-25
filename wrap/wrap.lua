local Node = require("wrap.node")
local NodeList = require("wrap.node_list")

local Wrap = {}

function Wrap.node(node)
	if type(node) == "table" then
		return NodeList.new(node)
	else
		return Node.new(node)
	end
end

return Wrap