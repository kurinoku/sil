# sil
### Simple Inheritance for Lua

This two function library, _if it can be called that_, let's you have classes in lua.

* newClass(super)  
Accepts a _**'super'**_ that can be nil, and returns the class and its superclass.  
It is initialized with a _**'new'**_ method and a blank _**'init'**_ method, it also has a _**'isClass'**_ property which the _**'new'**_ method switches to false in the instance when creating it.  
Check the [example](/test/vector3.lua).

* isInstance(obj, cls)  
Accepts a **sil**-created table (_**'obj'**_) and checks if inherits from the **sil**-created class (_**'cls'**_)