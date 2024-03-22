local Node = require("wrap.node")
local Go = require("wrap.go")
local NodeList = require("wrap.node_list")
local GoList = require("wrap.go_list")
local GuiApplet = require("wrap.gui_applet")

local Wrap = {}

function Wrap.node(node, tree)
	if type(node) == "table" then
		return NodeList.new(node, tree)
	else
		if type(node) == "string" then
			return Node.new(tree and tree[node] or node)
		else
			return Node.new(node)
		end
	end
end

function Wrap.go(go)
	if type(go) == "table" then
		return GoList.new(go)
	else
		return Go.new(go)
	end
end

function Wrap.gui_applet(root_node, scene)
	return GuiApplet.new(root_node, scene)
end

return Wrap