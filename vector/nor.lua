-- normalise a vector
function vec_nor(x,y)
 l=vec_len(x,y)
 if (l>0) return x/l,y/l
 return x,y
end