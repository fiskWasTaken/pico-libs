#ease

These are some token-optimised easing functions. Combined with coroutines, ease functions are great for providing fluid transition animations.


All easing functions in this library use the same four arguments:

* `t`: current time.
* `b`: original value.
* `c`: relative change in value.
* `t`: duration.

The *current time* and the *duration* can be any kind of time unit (i.e. frames).

## An example

A complete pico-8 program using a coroutine to display a scrolling message that accounts for text width:

```
#include ease/linear.lua

fun=cocreate(function() 
 msg="this is a very very very very very very long message"
 -- pico-8 chars are 4 pixels wide
 -- (except for glyphs!)
 -- so this is how we get the 
 -- pixel width of a string
 local len=#msg*4
 -- final x position of animation is pixel
 -- width of string, minus the screen width
 local to=max(len-128)
 -- position of message + duration
 local y,d=120,300
  
 for i=1,d do
  -- draw white rectangle
  rectfill(0,y,127,127,7)
  -- we negate the sign to
  -- actually scroll the text
  -- if you're confused, you
  -- can remove the sign to
  -- see what happens, and
  -- work out why that might
  -- be
  x=-ease_linear(i,0,to,d)
  -- draw the text 
  print(msg,x,y+1,0)
  yield()
 end
end)

function _draw()
 cls()
 coresume(fun)
end
```