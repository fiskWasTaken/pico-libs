cute.handlers.dialogue=function(frame)
 local d=frame.data
 local oy=cute:oy()

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

  if (frame.m) print(frame.m,2,oy+11,7)

  local button,c="❎",7
  if (frame.⬇️) button,c="⬇️",12

  local shake=(frame.⧗/30)%2
  print(button,120,oy+20+shake,c)
end