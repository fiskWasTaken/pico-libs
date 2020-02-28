-- split str by delimiter, optionally map values with func
function str_split(s,delim,func)
 local out,seg={},""
 for i=1,#s do
  local tok=sub(s,i,i)
  if (tok!=delim or i==#s) seg=seg..tok
  if tok==delim or i==#s then
   if (func) then add(out,func(seg)) else add(out,seg) end
   seg=""
  end
 end
 return out
end