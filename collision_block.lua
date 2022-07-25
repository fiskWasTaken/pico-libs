-- simple helper that will check pico-8 map-based collision
function collision_block(x,y)
 return collision(x,y) or collision(x,y+8) or collision(x+8,y) or collision(x+8,y+8)
end

function collision(x,y)
 return mget(x\8,y\8)!=0
end
