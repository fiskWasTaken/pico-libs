-- slide in
function slin()
for t=1,30 do
cute.v=eo(t,0,1,30)
yield()
end
end

-- slide out
function slout()
for t=1,30 do
cute.v=ei(t,1,-1,30)
yield()
end
end

-- these easing functions should be rewritten to take normalised params
function eo(t,b,c,d)
t/=d
t-=1
return c*(t*t*t*t*t+1)+b
end

function ei(t,b,c,d)
t/=d/2
if (t<1) return c/2*t*t*t*t*t+b
t-=2
return c/2*(t*t*t*t*t+2)+b
end

function cm(l)
local f=cocreate(l)
coresume(f) -- buffer

for co in all{cocreate(slin),f,cocreate(slout)} do
while costatus(co)!="dead" do
yield(coresume(co))
end
end
end

-- convenience wrapper
function cute:cm(label)
cute:play(function() cm(label) end)
end
