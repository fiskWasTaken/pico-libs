-- get the length of a vector
-- safely supports vectors up to about 1023x1023 which is great enough for most cases
-- at a cost of precision loss for smaller numbers
function vec_len(x,y)
 x>>=3
 y>>=3
 return sqrt(x*x+y*y)<<3
end
