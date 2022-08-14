function print_outline(txt,x,y,c1,c2)
	?txt,x,y-1,c2
	?txt,x,y+1
	?txt,x+1,y
	?txt,x-1,y
	?txt,x,y,c1
end