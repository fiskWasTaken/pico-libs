-- get the length of a vector
-- if number is too high, prevents overflow
-- length may never be higher than about 181.0166, avoid using numbers larger than 100 for inputs
function vec_len(vec)
 local r=vec[1]*vec[1]+vec[2]*vec[2]
 return sqrt(r<0 and 0x7fff or r)
end
