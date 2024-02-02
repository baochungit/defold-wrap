local Node = require("wrap.node")
local Go = require("wrap.go")
local NodeList = require("wrap.node_list")
local NodeTree = require("wrap.node_tree")
local GoList = require("wrap.go_list")

local Wrap = {}

function Wrap.node(node, tree)
	if tree then
		return NodeTree.new(node, tree)
	elseif type(node) == "table" then
		return NodeList.new(node)
	else
		return Node.new(node)
	end
end

function Wrap.go(go)
	if type(go) == "table" then
		return GoList.new(go)
	else
		return Go.new(go)
	end
end

return Wrap