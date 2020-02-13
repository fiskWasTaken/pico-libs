-- cute dialogue
function cute:d(data,m)
 local frame={
  data=data,
  type='dialogue',
  ⬇️=false,
  ⧗=0
 }

 local row=1
 local lines=wrap(m,self.width)
 local progress=0
 local speed=0.4
 local trow=max(#lines-self.rows+2,2)

 repeat
  local text=join(slice(lines,row,row+self.rows-1),"\n")

  frame.⬇️=row+1<trow
  frame.⧗+=1
  frame.m=sub(text,0,progress)
  self.frame=frame
  yield()

  if btnp(❎) then
   if progress>=#text then
    row+=1
    progress=0
    for i=row,row+self.rows-2 do
     if (lines[i]) progress+=#lines[i]
    end
   else
    progress=#text
   end
  end

  if progress<#text then
   mult=(btn(❎)) and 2 or 1
   progress+=speed*mult
   if (self.on_progress) self:on_progress()
  end
 until row>=trow

 if (self.on_step) self:on_step()
end

function slice(arr,start,fin)
 local out={}
 for i=start,fin do
 add(out,arr[i])
 end
 return out
end

-- join an array of strings per the delimiter
function join(strings,delim)
 local ret=""

 for l in all(strings) do
  ret=ret=="" and l or ret..delim..l
 end

 return ret
end

-- soft wrap a string, split
-- by space
function wrap(str,w)
 local out,from,len={},1,#str

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

  add(out,sub(str,from,to))
  from=to+1
 until to>=len

 return out
end