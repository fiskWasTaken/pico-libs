-- collision.lua
-- this is an implementation of the separating axis theorem algorithm

-- get the normals for points
function normals(points)
 local out={}

 for i=1,#points do
  local curr=points[i]
  local nxt=points[(i%#points)+1]

  -- perpl
  out[i]={-(curr[2]-nxt[2]),curr[1]-nxt[1]}
 end

 return out
end

-- get dot product for two vectors
function dot(a,b)return a[1]*b[1]+a[2]*b[2]end

-- get projection for points
function proj(axis, points)
 local mn=dot(axis,points[1])
 local mx=mn

 for i=1,#points do
  local p=dot(axis,points[i])
  if p<mn then mn=p elseif p>mx then mx=p end
 end

 return {mn,mx}
end

-- does vector a overlap vector b?
function overlap(a,b)return a[2]>b[1] or a[1]>b[2]end

-- find the overlap of vector a and vector b, assuming there is one
function get_overlap(a,b) return a[2]>b[1] and a[2]-b[1] or b[2]-a[1] end

-- check collision between
-- obj a and b
function check(a,b)
 local a_offs,b_offs=offset_points(a),offset_points(b)
 local mtv,mtvlen={0,0},1
 local n=normals(a_offs)

 for n in all(normals(a_offs),normals(b_offs)) do
  for i=1,#n do
   local p1,p2=proj(n[i],a_offs),proj(n[i],b_offs)
 
   if not overlap(p1,p2)then
    return false,mtv
   else
    local o=get_overlap(p1,p2)
    if (mtvlen==-1 or o<mtvlen) mtvlen,mtv=o,n[i]
   end
  end
 end

 local len=sqrt(mtv[1]*mtv[1]+mtv[2]*mtv[2])
 local nor={mtv[1]/len,mtv[2]/len}

 return true,{nor[1]*mtvlen,nor[2]*mtvlen}
end

-- get the absolute points of an object
function offset_points(obj)
 local offsets={}

 for i=1,#obj.points do
  -- todo: handle obj rotation
  -- each point will need to be rotated by the rot
  offsets[i]={
  obj.pos[1]+obj.points[i][1],
  obj.pos[2]+obj.points[i][2]
  }
 end

 return offsets
end