# cute

**cut**scene **e**ngine is a library designed for providing interactive cutscenes.

cute is designed to plug into a pico-8 project using coroutines, making it easy to implement without breaking existing game logic.

## Getting started

cute is split over several files so you only need to include what you need. You can start with the basic themes and handlers:

```
#include cute/cute.lua
#include cute/dialogue.lua
#include cute/themes/basic.lua
#include cute/handlers/dialogue.lua
#include cute/cinematic.lua

function _update()
 if (cute.co) return
 -- existing _update() logic...
 if (btnp(2)) cute:cinematic(start_cutscene())
end

function cutscene()
 a={name="fisk",color=11}
 cute:d(a,"hey, you!!")
 cute:d(a,"this is a cutscene!")
end

function _draw()
 cute:draw()
 -- existing _draw logic
end
```

* `cute.lua` contains the core library.
* `dialogue.lua` provides the `cute:d` dialogue function.
* `view/frame.lua` draws the basic frame when a cutscene is occuring.
* `view/dialogue.lua` draws dialogue-specific cutscene content.
* `cinematic.lua` provides simple ease in/out animation.

The first argument to `cute:d` can be virtually anything -- it will be passed directly to `frame.data` where it will be handled by the cutscene drawing routine. You can use this to pass on any actor-specific data such as sprites. 

It is expected you will want to swap out the views to style them according to your game. You can safely remove `views/frame.lua` and `view/dialogue.lua` and implement your own.

## extra stuff

* `cute:on_step()` is a callback for each step forward in a cutscene.
* `cute:on_progress()` is a callback for dialogue animation. You could use this to provide sound during message playback.
* `choice.lua` provides `cute:c()`, a function to provide a multiple-choice prompt.  
* `text.lua` provides `cute:t()`, providing text input with cyclic control.  
* `text_kb.lua` provides an experimental `cute:t_kb()` event handler for text. 
* `cute.co` contains a reference to the currently running scene, iff there is one. You can use this to granularly control what is computed in the `_update()` function, rather than blocking the entire call.