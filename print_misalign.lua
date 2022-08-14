function print_misalign(text,x,y,c1,c2,int)
 c2=c2 or 7
 int=int or 2
 while text!="" do
  c=rnd(10)>1 and c1 or c2
  print(sub(text,1,1),x,y+rnd(int)-int/2,c)
  text=sub(text,2)
  x+=4
 end
end