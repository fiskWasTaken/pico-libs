-- cute default cutscene frame function
-- games should probably implement their own...

-- draw frame
function cute:draw_frame()
 local frame=self.frame

 -- y position
 -- we start low enough that the frame
 -- transitions without any elements
 -- popping into view too soon
 local oy=self:oy()
 local top=self.vis*16

 -- draw nothing if we are too far
 -- off screen
 if (oy>130) return

 rectfill(0,0,128,top,0)
 line(0,top,128,top,7)
 rectfill(0,oy+4,128,128,0)
 line(0,oy+4,128,oy+4,7)
end