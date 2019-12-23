-- vector.lua
-- argument notation

vector={}

function vector.dot(x1,y1,x2,y2)
    return x1*x2+y1*y2
end

function vector.scl(x,y,m)
    return x*m,y*m
end

function vector.nor(x,y)
    local len=vector.len(x,y)
    if len>0 then
        return x/len,y/len
    end
    return x,y
end

function vector.len(x,y)
    return sqrt(abs(x)*2+abs(y)*2)
end

function vector.sub(x1,y1,x2,y2)
    return x1-x2,y1-y2
end