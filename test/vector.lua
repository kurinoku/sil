
local sil = require 'sil'

local class, super = sil.newClass(nil, 'Vector')

function class:init(x, y)
  self.x = x
  self.y = y

  return self
end


function class.__mt:__call() -- superfluous example, this metamethod will affect instances
  print('called the instance:', self)
end

function class.__mt:__tostring()
  return '<' .. self.class.name .. ' x = ' .. tostring(self.x) .. ', y = ' .. tostring(self.y) .. '>'
end

return class