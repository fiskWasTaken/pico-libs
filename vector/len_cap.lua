-- get the length of a vector
-- if number is too high, prevents overflow
-- length may never be higher than about 181.0166, avoid using numbers larger than 100 for inputs
function vec_len(x,y)
 local r=x*x+y*y
 return sqrt(r<0 and 0x7fff or r)
end
