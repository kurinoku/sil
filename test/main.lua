package.path = package.path .. ';../?.lua' -- just to import 'sil' in parent directory

local vector = require 'vector'
local vector3 = require 'vector3'
local sil = require 'sil'

-- constructors calling directly the class
local v1 = vector(10, 3)

print(v1)
v1() 

-- implement vector class' __add metamethod
function vector.__mt:__add(b)
    return vector(self.x+b.x, self.y+b.y)
end

print('sum:', v1 + v1)

local v3 = vector3(8, 3, 20)
print(v3)
v3()


-- as you can see since it wasn't implemented it uses vector's __add
-- it also shows updating once the classes have already been created
print('sum:', v3 + v3) 

print('is v3 a vector instance?: ', sil.isInstance(v3, vector))
print('is v3 a vector3 instance?: ',sil.isInstance(v3, vector3))
print('is v1 a vector instance?: ', sil.isInstance(v1, vector))
print('is v1 a vector3 instance?: ',sil.isInstance(v1, vector3))

-- You can check if a class is subclassing another with isInstance too
print('is vector a vector3 subclass?: ',sil.isInstance(vector, vector3))
print('is vector3 a vector subclass?: ',sil.isInstance(vector3, vector))