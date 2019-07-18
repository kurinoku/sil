-- Simple Inheritance for Lua

local M = {
	_VERSION     = 'sil v1.4',
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

local get_super_mt = function(name) 
	return function(self, ...)
		return self.class.__mt.super[name](self, ...)
	end
end

local not_implemented_mt = function(name)
	return function(self, ...)
		error("Metamethod '" .. name .. "' not implemented.")
	end
end

local no_super_mt = {
	__add = not_implemented_mt('__add'),
	__sub = not_implemented_mt('__sub'),
	__mul = not_implemented_mt('__mul'),
	__div = not_implemented_mt('__div'),
	__mod = not_implemented_mt('__mod'),
	__pow = not_implemented_mt('__pow'),
	__unm = not_implemented_mt('__unm'),
	__idiv = not_implemented_mt('__idiv'),
	__band = not_implemented_mt('__band'),
	__bor = not_implemented_mt('__bor'),
	__bxor = not_implemented_mt('__bxor'),
	__bnot = not_implemented_mt('__bnot'),
	__shl = not_implemented_mt('__shl'),
	__shr = not_implemented_mt('__shr'),
	__concat = not_implemented_mt('__concat'),
	__len = not_implemented_mt('__len'),
	__eq = not_implemented_mt('__eq'),
	__lt = not_implemented_mt('__lt'),
	__le = not_implemented_mt('__le'),
	__call = not_implemented_mt('__call'),
	__tostring = not_implemented_mt('__tostring')
}

local default_mt = {
	__add = get_super_mt('__add'),
	__sub = get_super_mt('__sub'),
	__mul = get_super_mt('__mul'),
	__div = get_super_mt('__div'),
	__mod = get_super_mt('__mod'),
	__pow = get_super_mt('__pow'),
	__unm = get_super_mt('__unm'),
	__idiv = get_super_mt('__idiv'),
	__band = get_super_mt('__band'),
	__bor = get_super_mt('__bor'),
	__bxor = get_super_mt('__bxor'),
	__bnot = get_super_mt('__bnot'),
	__shl = get_super_mt('__shl'),
	__shr = get_super_mt('__shr'),
	__concat = get_super_mt('__concat'),
	__len = get_super_mt('__len'),
	__eq = get_super_mt('__eq'),
	__lt = get_super_mt('__lt'),
	__le = get_super_mt('__le'),
	__call = get_super_mt('__call'),
	__tostring = get_super_mt('__tostring')
}


local mt_for_mt = {__newindex = propagate_newindex, __metatable = nil}

function M.addSupportMetamethod(...)
	local args = {...}
	for k, x in pairs(args) do
		default_mt[x] = get_super_mt(x)
		no_super_mt[x] = not_implemented_mt(x)
	end
end

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

	class.__mt = {__index = class, __children_mt = {}}
	if super ~= nil then
		mirror_table(default_mt, class.__mt)
		class.__mt.super = super.__mt
		--insert(super.__mt.__children_mt, class.__mt)
	else
		mirror_table(no_super_mt, class.__mt)
	end
	-- setmetatable(class.__mt, mt_for_mt)

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
