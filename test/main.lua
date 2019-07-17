package.path = package.path .. ';../?.lua' -- just to import 'sil' in parent directory

local vector = require 'vector'
local vector3 = require 'vector3'
local sil = require 'sil'

local v1 = vector(10, 3)

v1() -- see 'vector.lua'

local v3 = vector3(8, 3, 20)
print(v3:tostring())

print('vector: ', sil.isInstance(v3, vector))
print('vector3: ',sil.isInstance(v3, vector3))