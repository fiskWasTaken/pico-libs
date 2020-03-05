function cute:c(d,prompt,choices)
local f={d=d,choices=choices,prompt=prompt,t='choice',choice=1}

repeat
self.f=f
yield()
if (btnp(⬅️)) f.choice=(f.choice-2)%#choices+1
if (btnp(➡️)) f.choice=f.choice%#choices+1
if (btnp(❎)) then
if (self.step) self:step()
return f.choice
end
until false
end