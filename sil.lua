-- Simple Inheritance for Lua

local M = {
	_VERSION     = 'sil v1.0',
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


function M.newClass(super, name)
	local class

	if super ~= nil then
		class = super:new()
	else
		class = {}
	end
	class.isClass = true
	class.__super = super
	class.__index = class
	class.name = name or 'UnnamedClass'


	function class:new()
		local o = {class = self, isClass = false, name = nil}
		setmetatable(o, self)
		return o
	end

	function class:init()
		return self
	end

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
