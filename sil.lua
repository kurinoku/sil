-- Simple Inheritance for Lua

local M = {
	_VERSION     = 'sil v1.3.1',
	_URL         = 'https://github.com/kurinoku/sil',
	_DESCRIPTION = 'Simple Inheritance for Lua', 
	_LICENSE     = [[
	MIT License

	Copyright (c) 2019 kurinoku

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
]]
}

local insert = table.insert

-- default constructor using lua's real multiple arguments
local function constructor(self, ...)
	return self:new():init(...)
end

local function default_new(self)
	local o = {class = self, isClass = false, name = nil}
	setmetatable(o, self.__mt)
	return o
end

local function default_init(self)
	return self
end

local function mirror_table(origin, dest)
	for k, v in pairs(origin) do 
		if rawget(dest, k) == nil then
			rawset(dest, k, rawget(origin, k))
		end
	end
end

local function propagate_newindex(self, key, value)
	local current_value = rawget(self, key)
	if self.propagate == true then
		for i = 1, #self.__children_mt do
			if self.__children_mt[i][key] == current_value then
				self.__children_mt[i][key] = value
			end
		end
	end
	rawset(self, key, value)
end

local mt_for_mt = {__newindex = propagate_newindex, __metatable = nil}

function M.newClass(super, name)
	local class

	if super ~= nil then
		class = super:new()
	else
		class = {}
	end
	class.isClass = true
	class.__super = super
	class.__index = super
	setmetatable(class, class)

	class.__mt = {__index = class, __children_mt = {}, propagate = true}
	if super ~= nil then
		mirror_table(super.__mt, class.__mt)
		class.__mt.propagate = super.__mt.propagate
		insert(super.__mt.__children_mt, class.__mt)
	end
	setmetatable(class.__mt, mt_for_mt)

	class.name = name or 'UnnamedClass'
	class.new = default_new
	class.init = default_init
	class.__call = constructor

	return class, super
end

local function istable(t) return (t~=nil and type(t) == 'table') end


function M.isInstance(obj, cls)

	if not istable(obj) or not istable(cls) or obj.isClass == nil or cls.isClass ~= true then
		return false 
	end

	if not obj.isClass then
		obj = obj.class
	end

	while istable(obj) do
		if obj == cls then return true end
		obj = obj.__super
	end
  
  	return false
end


return M
