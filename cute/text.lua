function cute:t(d,prompt,len)
 len=len or 32
 local chars="abcdefghijklmnopqrstuvwxyz1234567890 "

 local f={
  d=d,
  input="",
  prompt=prompt,
  t='text',
  c=1,
  char=1
 }

 repeat
  self.f=f
  yield()

  if (btnp(⬅️)) f.c=max(1,f.c-1)
  if (btnp(➡️)) f.c=min(len,f.c+1)
  if (btnp(⬇️)) f.char=(f.char-2)%#chars+1
  if (btnp(⬆️)) f.char=f.char%#chars+1

  f.input=sub(f.input,1,f.c-1)..sub(chars,f.char,f.char)..sub(f.input,f.c+1,-1)
 until btnp(❎)

 return i
end