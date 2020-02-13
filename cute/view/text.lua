cute.handlers.text=function(frame)
 local p=frame.prompt
 local oy=cute:oy()
 i=frame.input
 x,last_size=40,0
 print(p,64-(#p*4/2),oy+6,7)
 print(frame.input,64-(#frame.input*4/2),oy+13,7)
end