-- vector.lua
-- argument notation

vec={}

-- get the dot product of two vectors
function vec.dot(x1,y1,x2,y2)
    return x1*x2+y1*y2
end

-- scale a vector
function vec.scl(x,y,m)
    return x*m,y*m
end

-- normalise a vector
function vec.nor(x,y)
    local len=vec.len(x,y)
    if len>0 then
        return x/len,y/len
    end
    return x,y
end

-- get the length of a vector
function vec.len(x,y)
    return sqrt(abs(x)*2+abs(y)*2)
end

-- set the length of a vector
function vec.set_len(x,y,len)
    x,y=vec.nor(x,y)
    return vec.scl(x,y,len)
end

-- sub vector 2 from vector 1
function vec.sub(x1,y1,x2,y2)
    return x1-x2,y1-y2
end

-- add vector 2 to vector 1
function vec.add(x1,y1,x2,y2)
    return x1+x2,y1+y2
end

-- get the vector for an angle
function vec.from_angle(a)
    return sin(a),cos(a)
end