-- slide in
function slin()
for t=1,30 do
cute.v=ease_outquad(t/30)
yield()
end
end

-- slide out
function slout()
for t=1,30 do
cute.v=ease_outquad(1-(t/30))
yield()
end
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
function cute:cm(label) cute:play(function() cm(label) end) end
