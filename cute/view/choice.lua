cute.handlers.choice=function(frame)
 local p=frame.prompt
 local oy=cute:oy()
 x,last_size=40,0
 print(p,64-(#p*4/2),oy+6,7)

 for i,c in pairs(frame.choices) do
 	col=(i==frame.choice) and 9 or 7
 	print(c,x,oy+15,col)
 	x+=#c*4+8
 end
end