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

Any changes to a _**'class.__mt'**_ will affect the subclasses _**'.__mt'**_ as well, only if the subclasses value in that key are the same as the class value. For example:  
if class.__mt.__add is changed subclass1.\_\_mt.__add will be changed only if it was the same as class.__mt.__add before changing it, the same goes for subclass2, subclass3, subclassN...
This behaviour can be toggled by changing ___mt_'s **propagate**, by default is __true__.