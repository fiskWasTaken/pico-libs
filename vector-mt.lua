-- vector metatable, adapted from https://www.lexaloffle.com/bbs/?pid=110085#p
vec2mt={
 __eq=function(self,v2)
  return self.x==v2.x and self.y==v2.y
 end,
 __add=function(self,v2)
  return vec2(self.x+v2.x,self.y+v2.y)
 end,
 __sub=function(self,v2)
  return vec2(self.x-v2.x,self.y-v2.y)
 end,
 __mul=function(self,v2)
  if type(v2)=="number" then
   return vec2(self.x*v2,self.y*v2)
  else
   return vec2(self.x*v2.x,self.y*v2.y)
  end
 end,
 __div=function(self,v2)
  if type(v2)=="number" then
   return vec2(self.x/v2,self.y/v2)
  else
   return vec2(self.x/v2.x,self.y/v2.y)
  end
 end,
 __idiv=function(self,v2)
  return vec2(self.x\v2,self.y\v2)
 end,
 mag=function(self)
  local ax,ay=abs(self.x),abs(self.y)
  local d=max(ax,ay)
  local n=min(ax,ay)/d
  return sqrt(n*n+1)*d
 end,
 mag2=function(self)
  return self.x*self.x+self.y*self.y
 end,
 norm=function(self)
  local mag=self:mag()
  return vec2(self.x/mag,self.y/mag)
 end,
 dot=function(self,v2)
  return self.x*v2.x+self.y*v2.y
 end,
 perp=function(self)
  return vec2(-self.y,self.x)
 end
}
vec2mt.__index=vec2mt

-- constructor
function vec2(x,y)
    return setmetatable({x=x or 0,y=y or 0},vec2mt)
end