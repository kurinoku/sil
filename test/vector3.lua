local vector = require 'vector'
local sil = require 'sil'

local class, super = sil.newClass(vector, 'Vector3')
function class:init(x, y, z)
  super.init(self, x, y)
  self.z = z

  return self
end

function class.__mt:__tostring()
  return '<' .. self.class.name .. ' x = ' .. tostring(self.x) .. ', y = ' .. tostring(self.y) .. ', z = ' .. tostring(self.z) .. '>'
end

return class