# sil
### Simple Inheritance for Lua

This two function library, _if it even can be called library_, let's you have classes with simple inheritance in lua.

* newClass(super, name)  
Accepts an optional superclass (_**'super'**_) and an optional _**'name'**_ for the class, and returns the class and its superclass.  
Modify the _**'init'**_ method for custom initialization.  
It also has a _**'isClass'**_ property which when a instance is initialized it's set to false.  
Check the [examples](/test/).

* isInstance(obj, cls)  
Accepts a **sil**-created table (_**'obj'**_) and checks if inherits from the **sil**-created class (_**'cls'**_).

To have metamethods affect instances define them for _**'class.__mt'**_. Any other defined for _**'class'**_ will only define them for the class itself.