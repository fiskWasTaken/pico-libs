-- vector.lua
-- array notation

vector={}

function vector.dot(a,b)
    return a[1]*b[1]+a[2]*b[2]
end

function vector.scl(a,m)
    return a[1]*m,a[2]*m
end

function vector.nor(a)
    local len=vector.len(a[1],a[2])
    if len>0 then
        return {a[1]/len, a[2]/len}
    end
    return a
end

function vector.len(a)
    return sqrt(abs(a[1])*2+abs(a[2])*2)
end

function vector.sub(a,b)
    return a[1]-b[1],a[2]-b[2]
end