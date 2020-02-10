-- split a string by a delimiter and return an array of values
function str_split(str,delim)
 local out={}
 local seg=""

 for i=1,#str do
  local tok=sub(str,i,i)
  if tok==delim then
   add(out,seg)
   seg=""
  else
   seg=seg..tok
  end
 end
 if (#seg>0) add(out,seg)
 return out
end