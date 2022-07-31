-- sprite rotate
local rspr_clear_col=0

-- rspr copies sprite at sx,sy
-- to buffer on sheet at x,y
-- w is size in sprite (1=8px)
function rspr(sx,sy,x,y,a,w)
 local ca,sa=cos(a),sin(a)
 local srcx,srcy,addr,pixel_pair
 local ddx0,ddy0=ca,sa
 local mask=0xfff8<<(w-1)
 w*=4
 ca*=w-0.5
 sa*=w-0.5
 local dx0,dy0=sa-ca+w,-ca-sa+w
 w=2*w-1
 for ix=0,w do
  srcx,srcy=dx0,dy0
  for iy=0,w do
   if (srcx|srcy)&mask==0 then
    local c=sget(sx+srcx,sy+srcy)
    if c!=0 then
     pset(x+ix,y+iy,c)
    end
   end
   srcx-=ddy0
   srcy+=ddx0
  end
  dx0+=ddx0
  dy0+=ddy0
 end
end

