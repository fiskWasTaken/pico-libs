-- set the length of a vector
function vec_set_len(x,y,len)
 x,y=vec_nor(x,y)
 return vec_scl(x,y,len)
end