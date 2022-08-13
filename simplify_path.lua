function simplify_path(path)
 local p_node,px,py,out=path[1],0,0,{}

 for node in all(path) do
  local dx,dy=node[1]-p_node[1],node[2]-p_node[2]
  if (px!=dx or py!=dy) add(out,p_node)
  p_node,px,py=node,dx,dy
 end

 add(out,path[#path])
	
 return out
end