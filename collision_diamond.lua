-- simple helper for ap-based collision
-- if the first flag (0x1) is set on a block, it will have collision.
function collision_block(x,y,r)
 return collision(x,y-r) or collision(x-r,y) or collision(x+r,y) or collision(x,y+r)
end

function collision(x,y)
 return tonum(fget(mget(x\8,y\8)))&1==1
end