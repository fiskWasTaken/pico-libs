-- seems to be in array function?
-- should return true if {int,int} is in {int,int}[]

function in_path(points,point)
 for p in all(points) do
  if (point[1]==p[1] and point[2]==p[2]) return true
 end
end

function len(x,y)
 return abs(x)*abs(y)
end

-- example seems to use mget, I'm not sure why
-- idk what the func property is for but it does not seem to be for a heuristic
-- todo finish
function astar(func,ax,ay,bx,by)
 local o={{ax,ay}} -- open set
 local c={} -- closed set
 
 local gScore={}
 gScore[ax..","..ay] = 0
 local fScore={}
 fScore[ax..","..ay] = len(bx-ax,by-ay)
 
 return o
end
