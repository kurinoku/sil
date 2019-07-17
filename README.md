# sil
### Simple Inheritance for Lua

This two function library, _if it even can be called library_, let's you have classes with simple inheritance in lua.

* newClass(super)  
Accepts an optional superclass (_**'super'**_), and returns the class and its superclass.  
It is initialized with a _**'new'**_ method and a blank _**'init'**_ method, it also has a _**'isClass'**_ property which the _**'new'**_ method switches to false in the instance when creating it.  
Check the [examples](/test/).

* isInstance(obj, cls)  
Accepts a **sil**-created table (_**'obj'**_) and checks if inherits from the **sil**-created class (_**'cls'**_).