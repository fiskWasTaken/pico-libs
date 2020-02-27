function cute:t_kb(d,prompt,len)
 poke(24365,1)
 i,len="",len or 32

 local f={
  d=d,
  input=i,
  prompt=prompt,
  t='text',
  c=1
 }

 -- clear input buffer
 while stat(30) do stat(31) end

 repeat
  self.f=f
  yield()

  if stat(30) then
   c=stat(31)

   if c>=" " and c<="z" and #i<len then
    i=i..c
   elseif c=="\8" then
    i=sub(i,1,#i-1)
   end
  end

  f.input=i
  f.c=#i+1
 until btnp(⬇️)

 poke(24365,0)
 return i
end