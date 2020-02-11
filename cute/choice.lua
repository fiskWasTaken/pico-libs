
function cute:c(d,prompt,choices)
 local f={
  data=d,
  choices=choices,
  prompt=prompt,
  type='choice',
  choice=1
 }

 repeat
  self.frame=f
  yield()
  if (btnp(⬅️)) f.choice=(f.choice-2)%#choices+1
  if (btnp(➡️)) f.choice=f.choice%#choices+1
  if (btnp(❎)) return f.choice
 until false
end