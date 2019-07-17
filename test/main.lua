package.path = package.path .. ';../?.lua' -- just to import 'sil' in parent directory

local vector = require 'vector'
local vector3 = require 'vector3'
local sil = require '../sil'

local v1 = vector:new():init(10, 3)
print(v1)
local v3 = vector3:new():init(8, 3, 20)
print(v3)

print('vector: ', sil.isInstance(v3, vector))
print('vector3: ',sil.isInstance(v3, vector3))