function ease_outquint(t,b,c,d)
 t/=d
 t-=1
 return c*(t*t*t*t*t+1)+b
end