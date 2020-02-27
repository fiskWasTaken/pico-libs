cute.handlers.text=function(f)
 local p=f.prompt
 local oy=cute:oy()
 i=f.input
 x,last_size=40,0
 print(p,64-(#p*4/2),oy+6,7)
 print(f.input,64-(#f.input*4/2),oy+13,7)
end