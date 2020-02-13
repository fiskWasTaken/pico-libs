function cute:t(d,prompt,len)
 i=""
 len=len or 32

 local cursor=1

 local f={
  data=d,
  input=i,
  prompt=prompt,
  type='text',
  cursor=cursor
 }

 repeat
  self.frame=f
  yield()

  if btnp(⬇️) then
   break
  end

  f.input=i
 until false

 return i
end