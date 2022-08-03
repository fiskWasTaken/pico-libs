function cute:da(d,a)for m in all(a) do cute:d(d,m)end end

function cute:d(d,m)
local f={d=d,t='dialogue',⬇️=false,⧗=0}

local row,prog,spd,lines=1,0,0.4,wrap(m,self.w)
local trow=max(#lines-self.rows+2,2)

repeat
local text=join(slice(lines,row,row+self.rows-1),"\n")

f.⬇️=row+1<trow
f.⧗+=1
f.m=sub(text,0,prog)
self.f=f
yield()

if btnp(🅾️) then
if prog>=#text then
row+=1
prog=0
for i=row,row+self.rows-2 do
 if (lines[i]) prog+=#lines[i]
end
else
prog=#text
end
end

if prog<#text then
mult=btn(🅾️) and 2 or 1
prog+=spd*mult
if (self.progress) self:progress()
end
until row>=trow

if (self.step) self:step()
end

function slice(a,s,f)
local o={}
for i=s,f do
add(o,a[i])
end
return o
end

function join(s,d)
local o=""
for l in all(s) do
o=o=="" and l or o..d..l
end
return o
end

-- soft wrap a string, split
-- by space
function wrap(str,w)
local o,from,len={},1,#str

repeat
local to=min(from+w,len)

if to<len then
for c=min(to,len),from,-1 do
if sub(str,c,c)==" " then
 to=c
 break
end
end
end

add(o,sub(str,from,to))
from=to+1
until to>=len

return o
end
