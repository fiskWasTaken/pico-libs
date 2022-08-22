-- normalise a vector
function vec_nor(vec)
 l=vec_len(vec)
 if (l>0) return {vec[1]/l,vec[2]/l}
 return vec
end