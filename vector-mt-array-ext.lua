function v2:mag()
 local ax,ay=abs(self[1]),abs(self[2])
 local d=max(ax,ay)
 local n=min(ax,ay)/d
 return sqrt(n*n+1)*d
end

function v2:mag2()
 return self[1]*self[1]+self[2]*self[2]
end

function v2:norm()
 local mag=self:mag()
 return vec2(self[1]/mag,self[2]/mag)
end

function v2:dot(v2)
 return self[1]*v2[1]+self[2]*v2[2]
end

function v2:perp()
 return vec2(-self[2],self[1])
end

v2.__index=v2