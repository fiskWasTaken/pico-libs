function ctor(s,o)
s.__index=s
return setmetatable(o or {},s)
end