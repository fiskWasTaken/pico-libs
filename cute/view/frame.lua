function cute:draw_frame()
 local frame=self.frame
 local oy=self:oy()

 -- skip render if nothing to draw
 if (oy>130) return
 rectfill(0,oy+4,128,128,0)
 line(0,oy+4,128,oy+4,7)

 -- top bar
 local top=self.vis*16
 rectfill(0,0,128,top,0)
 line(0,top,128,top,7)
end