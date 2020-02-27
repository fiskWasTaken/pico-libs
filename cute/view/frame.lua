function cute:draw_frame()
 local f,oy=self.f,self:oy()

 -- skip render if nothing to draw
 if (oy>130) return
 rectfill(0,oy+4,128,128,0)
 line(0,oy+4,128,oy+4,7)

 -- top bar
 local t=self.v*16
 rectfill(0,0,128,t,0)
 line(0,t,128,t,7)
end