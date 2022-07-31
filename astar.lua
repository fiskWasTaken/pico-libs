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

-- example seems to use mget, I'm not sure why
-- idk what the func property is for but it does not seem to be for a heuristic
-- todo finish
-- oh. mget is probably to track what's walkable
function astar(func,ax,ay,bx,by)
 local o={{ax,ay}} -- open set
 local c={} -- closed set
 
 local fScore={}
 fScore[ax..","..ay] = 0
 local gScore={}
 fScore[ax..","..ay] = len(bx-ax,by-ay)
  
 while #o>0 do
  printh(#o.." nodes in open set")
  printh(#c.." nodes in closed set")
  printh(#fScore.." nodes scored")
  local lowest,q,nx,ny=0x7fff

  for node,score in pairs(fScore) do
   if score<lowest then
    nx,ny=unpack(split(node,","))
    q=in_path(o,{nx,ny})
    del(o,q)
   end
  end

  printh("try node "..nx..","..ny)

  for child in all(adjacent(ax,ay)) do
   local cx,cy=unpack(child)
   local ckey=cx..","..cy

   if not func(cx,cy) then   
 
    if cx==bx and cy==by then
     add(o,{cx,cy})
     return o
    end

    if not c[ckey] then
     local g=len(nx-cx,ny-cy)
     local f=g+len(bx-cx,by-cy)
    
     if not fScore[ckey] or fScore[ckey]>f then
      gScore[ckey]=g
      fScore[ckey]=f
     end
    end
   end
  end
  
  add(c,{nx,ny})
 end

 return o
end
