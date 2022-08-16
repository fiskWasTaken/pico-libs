-- return nil if not found in sequence
function index_of(a,v)
 for i,o in ipairs(a) do
  if (v==o) return i
 end
end