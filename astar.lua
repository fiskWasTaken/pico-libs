function in_path(points,point)
 for p in all(points) do if (point[1]==p[1] and point[2]==p[2]) return p end
end

function len(x,y) return x*x+y*y end

function astar(is_wall,ax,ay,bx,by)
 local akey,o,c,gScore,fScore=ax..","..ay,{{ax,ay}},{},{},{} -- open,closed set
 gScore[akey],fScore[akey] = 0,len(bx-ax,by-ay)
 
 -- short circuit, impossible
 if (is_wall(bx,by)) return {} 
 
 while #o>0 and #c<255 do
  local lowest,current,nx,ny=0x7fff

  for on in all(o) do
   local score=fScore[on[1]..","..on[2]]
   if score<lowest then
    nx,ny=unpack(on)
    lowest,current=score,on
   end
  end

  if nx==bx and ny==by then
   local o={}
 
   repeat
    add(o,current,1)  
    current=c[current[1]..","..current[2]]
   until not current

   return o
  end

  del(o,current)
  
  for child in all({
    {nx+1,ny},
    {nx-1,ny},
    {nx,ny-1},
    {nx,ny+1}
   }) do
   local cx,cy=unpack(child)

   if not is_wall(cx,cy) then
    local ckey,g=cx..","..cy,gScore[nx..","..ny] + len(nx-cx,ny-cy)

    if g<(gScore[ckey] or 0x7fff) then
     gScore[ckey],fScore[ckey]=g,g+len(bx-cx,by-cy)
     c[ckey]=current
  
     if (not in_path(o,child)) add(o,child)
    end
   end
  end
  
  add(c,{nx,ny})
 end
 
 return {}
end
