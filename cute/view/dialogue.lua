cute.handlers.dialogue=function(f)
 local d,oy=f.d,cute:oy()

 if d then
  -- actor name
  local nw=#d.name*4
  rectfill(2,oy,nw+4,oy+8,0)
  rect(2,oy,nw+4,oy+8,7)
  print(d.name,4,oy+2,d.color)

  if d.spr then
   local x,y=108,oy-4
   rectfill(x,y,x+18,y+18,0)
   rect(x,y,x+18,y+18,7)
   d.spr(x+1,y+1)
  end
 end

 local b,c="❎",7
 if (f.⬇️) b,c="⬇️",12

 print(f.m,2,oy+11,7)
 print(b,120,oy+20+(f.⧗/30)%2,c)
end