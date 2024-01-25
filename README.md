# Defold Wrap Library

This tiny library is intended to help you change the way you code on Defold.

Instead of
```lua
local node = gui.get_node("my_node")
gui.set_alpha(node, 0.5)
gui.animate(node, "color.w", 1, gui.EASING_LINEAR, 2)
gui.set_enabled(node, true)
```
Write this
```lua
local wrap = require("wrap.wrap")

local node = wrap.node("my_node")
node:set_alpha(0.5):animate("color.w", 1, gui.EASING_LINEAR, 2):set_enabled(true)
```
You can also get a list of wrapped nodes
```lua
local w = wrap.node({ mynode = "my_node", title = "text_title", button = gui.get_node("button") })
w.mynode:set_alpha(0.5)
w.title:set_text("Admin")
w.button:set_size(vmath.vector3(100, 50, 0))
```

Currently, it has all methods working for GUI nodes, besides, it supports some convenient methods you may need it sometimes, like
```
add_position(...),
get_position_x()
get_position_y()
get_position_z()
set_position_x(...)
set_position_y(...)
set_position_z(...)
add_position_x(...)
add_position_y(...)
add_position_z(...)
...
```

To use this library, simply add `https://github.com/baochungit/defold-wrap/archive/master.zip` as a dependency in your `game.project` file

---
