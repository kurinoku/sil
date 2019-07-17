local vector = require 'vector'
local sil = require 'sil'

local class, super = sil.newClass(vector)
function class:init(x, y, z)
  super.init(self, x, y)
  self.z = z

  return self
end

function class:__tostring()
  return '<vector x = ' .. tostring(self.x) .. ', y = ' .. tostring(self.y) .. ', z = ' .. tostring(self.z) .. '>'
end

return class