local Go = require("wrap.go")

local GoList = {}
GoList.__index = GoList

function GoList.new(ids)
	local self = setmetatable({}, GoList)
	self._ids = ids
	for key, id in pairs(self._ids) do
		if type(key) == "number" and type(id) == "string" then
			key = id
		end 
		self[key] = Go.new(id)
	end
	return self
end

return GoList