function simplify_path(path)
 local p_node,px,py=path[1],0,0
 local out={p_node}

 for node in all(path) do
  local dx,dy=node[1]-p_node[1],node[2]-p_node[2]
	
  if px!=dx or py!=dy then
   p_node,px,py=node,dx,dy
   add(out,node)
  end
 end
	
 return out
end
