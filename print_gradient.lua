function print_gradient(txt,x,y,c1,c2)
	?txt,x,y,c1
	clip(x,y+3,127,127)
	?txt,x,y,c2
	clip()
end