-- seems to be in array function?
-- should return true if {int,int} is in {int,int}[]

function in_path(points,point)
 for p in all(points) do
  if (point[1]==p[1] and point[2]==p[2]) return p
 end
end

function len(x,y)
 return abs(x)*abs(y)
end

function adjacent(x,y)
 return {
  {x+1,y},
  {x-1,y},
  {x,y-1},
  {x,y+1}
 }
end

function reconstruct_path(map,current)
 local out={}
 
 add(out,current)
 return out
end

-- example seems to use mget, I'm not sure why
-- idk what the func property is for but it does not seem to be for a heuristic
-- todo finish
-- oh. mget is probably to track what's walkable
function astar(func,ax,ay,bx,by)
 local akey,o,c,gScore,fScore=ax..","..ay,{{ax,ay}},{},{},{} -- open,closed set
 gScore[akey],fScore[akey] = 0,len(bx-ax,by-ay)
  
 while #o>0 do
  printh(#o.." open, "..#c.." closed")
  local lowest,current,nx,ny=0x7fff

  for on in all(o) do
   local score=fScore[on[1]..","..on[2]]
   if score<lowest then
    nx,ny=unpack(on)
    lowest,current=score,on
   end
  end

  printh("try node "..nx..","..ny)

  if nx==bx and ny==by then
   return reconstruct_path(c,current)
  end

  del(o,current)
  
  for child in all(adjacent(nx,ny)) do
   local cx,cy=unpack(child)
   local ckey=cx..","..cy
   
   printh("try child "..ckey)

   local g=gScore[nx..","..ny] + len(nx-cx,ny-cy)

   if not gScore[ckey] or g < gScore[ckey] then
    gScore[ckey],fScore[ckey]=g,g+len(bx-cx,by-cy)
    c[ckey]=current

    if not in_path(o,child) then
     add(o,child)
    end
   end
  end
  
  add(c,{nx,ny})
 end
 
 return {}
end
