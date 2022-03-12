-- normalise a vector
function vec_nor(x,y)
    l=vec_len(x,y)
    if l>0 then
    return x/l,y/l
    end
    return x,y
    end
    