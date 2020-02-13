function cute:t_kb(d,prompt,len)
 poke(24365,1)
 i=""
 len=len or 32

 local f={
  data=d,
  input=i,
  prompt=prompt,
  type='text',
  cursor=1
 }

 -- clear input buffer
 while stat(30) do stat(31) end

 repeat
  self.frame=f
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
  f.cursor=#i+1
 until btnp(⬇️)

 poke(24365,0)
 return i
end