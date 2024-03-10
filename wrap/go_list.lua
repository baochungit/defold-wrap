local Go = require("wrap.go")

local GoList = {}
GoList.__index = GoList

function GoList.new(data)
	local self = setmetatable({}, GoList)
	self._data = data
	for key, url in pairs(self._data) do
		if type(key) == "number" and type(url) == "string" then
			key = url
		end 
		self[key] = Go.new(url)
	end
	return self
end

return GoList