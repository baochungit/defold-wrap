local function contains(table, val)
	for i = 1, #table do
		if table[i] == val then 
			return true
		end
	end
	return false
end

return {
	contains = contains
}