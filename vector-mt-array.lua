-- another vector metatable, adapted from https://www.lexaloffle.com/bbs/?pid=110085#p, but made for array structures suitable for unpack
v2={}

function v2:__eq(v2)
 return self[1]==v2[1] and self[2]==v2[2]
end
function v2:__add(v2)
 return vec2(self[1]+v2[1],self[2]+v2[2])
end
function v2:__sub(v2)
 return vec2(self[1]-v2[1],self[2]-v2[2])
end
function v2:__mul(v2)
 if type(v2)=="number" then
  return vec2(self[1]*v2,self[2]*v2)
 else
  return vec2(self[1]*v2[1],self[2]*v2[2])
 end
end
function v2:__div(v2)
 if type(v2)=="number" then
  return vec2(self[1]/v2,self[2]/v2)
 else
  return vec2(self[1]/v2[1],self[2]/v2[2])
 end
end
function v2:__idiv(v2)
 return vec2(self[1]\v2,self[2]\v2)
end

-- constructor
function vec2(x,y)
 return setmetatable({x or 0,y or 0},v2)
end