function index_of(array,value)
 for i,v in pairs(array) do
  if (v==value) return i
 end
end

function chain(options,current_value,skip)
 skip = skip or -1
 local idx = index_of(options,current_value) or 1
 return options[(idx + skip - 1) % #options + 1]
end
