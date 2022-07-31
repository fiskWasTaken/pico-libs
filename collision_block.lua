-- simple helper that will check pico-8 map-based collision
-- designed for an entity system where origins are centered. r is a radius
-- around the position x,y coordinates for which to check

-- if the first flag (0x1) is set on a block, it will have collision.

function collision_block(x,y,r)
 w=w or 8
 return collision(x-r,y-r) or collision(x-r,y+r) or collision(x+r,y-r) or collision(x+r,y+r)
end

function collision(x,y)
 return fget(mget(x\8,y\8))&1==1
end
