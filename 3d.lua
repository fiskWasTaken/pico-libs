-- instant 3d+!
-- todo: breakup and modify again or find a copy of this somewhere.

do
-- parameters
p3d={
    vanish={x=64,y=0}, -- vanishing pt
    d=128,             -- screen dist in pixels
    near=1,            -- near plane z
    camyoff=32,        -- added to cam y pos
    camheight=32       -- camera height
}

-- save 2d versions
map2d,spr2d,sspr2d,pset2d,camera2d=map,spr,sspr,pset,camera

-- 3d camera position
local cam={x=0,y=0,z=0}

-- is 3d mode enabled?
is3d=false

-- helper functions

-- screen to camera space
local function s2c(x,y,z)
    return x-cam.x,y-cam.y,z-cam.z
end

-- perspective projection
local function proj(x,y,z)
    if -y>=p3d.near then
    local scale=p3d.d/-y
    return x*scale+p3d.vanish.x,-z*scale+p3d.vanish.y,scale
    end
end

-- screen to projected
function s2p(x,y,z)
    local x,y,z=s2c(x,y,z)
    return proj(x,y,z)
end

-- 3d drawing fns
function sspr3d(sx,sy,sw,sh,x,y,z,w,h,fx,fy)
    w=w or sw
    h=h or sh
    local px,py,scale=s2p(x,y,z)

    if(not scale)return
    local pw,ph=w*scale,h*scale

    -- sub pixel stuff
    local x0,y0=flr(px),flr(py)
    sspr2d(sx,sy,sw,sh,x0,y0,flr(px+pw)-x0,flr(py+ph)-y0,fx,fy)
end

spr3d=function(n,x,y,z,w,h,fx,fy)
    if(not z)return
    -- convert to equivalent sspr() call
    w=(w or 1)*8
    h=(h or 1)*8
    sspr3d(flr(n%16)*8,n\16*8,w,h,x,y,z,w,h,fx,fy)
end 

function map3d(cx,cy,x,y,z,w,h,lyr)
    if(not h)return

    -- near/far corners
    local fx,fy,fz=s2c(x,y,z)
    local nx,ny,nz=s2c(x,y+h*8,z)

    -- clip
    ny=min(ny,-p3d.near)
    if(fy>=ny)return

    -- project
    local npx,npy,nscale=proj(nx,ny,nz)
    local fpx,fpy,fscale=proj(fx,fy,fz)

    if npy<fpy then
    local tx,ty,ts=npx,npy,nscale
    npx,npy,nscale=fpx,fpy,fscale
    fpx,fpy,fscale=tx,ty,ts
    end

    -- clamp
    npy,fpy=min(npy,128),max(fpy)

    -- rasterise
    local py=flr(npy)
    while py>=fpy do

    -- floor plane intercept
    local g=(py-p3d.vanish.y)/p3d.d
    local d=-nz/g  

    -- map coords
    local mx,my=cx,(-fy-d)/8+cy

    -- project to get left/right
    local lpx,lpy,lscale=proj(nx,-d,nz)
    local rpx,rpy,rscale=proj(nx+w*8,-d,nz)

    -- delta x
    local dx=w/(rpx-lpx)

    -- sub-pixel correction
    local l,r=flr(lpx+0.5)+1,flr(rpx+0.5)
    mx+=(l-lpx)*dx

    -- render
    tline(l,py,r,py,mx,my,dx,0,lyr)

    py-=1
    end 
end 

function map3dupright(cx,cy,x,y,z,w,h,lyr)
    if(not h)return
    local px,py,scale=s2p(x,y,z)
    if(not scale)return

    local pw,ph=w*8*scale,h*8*scale

    -- texture step
    local dx,dy=w/pw,h/ph
    local mx,my=cx+0.0625,cy+0.0625

    -- sub pixel stuff
    local x0,x1=flr(px),flr(px+pw)
    local y0,y1=flr(py),flr(py+ph)
    mx+=(x0-px)*dx
    my+=(y0-py)*dy  

    if(x0>=x1 or y0>=y1)return

    for y=y0,y1-1 do
    tline(x0,y,x1,y,mx,my,dx,0,lyr)
    my+=dy
    end
end

function camera3d(x,y,z)
    cam.x,cam.y,cam.z=x,y,z
end

-- "instant 3d" wrapper functions
local function icamera(x,y)
    cam.x=(x or 0)+64
    cam.y=(y or 0)+128+p3d.camyoff
    cam.z=p3d.camheight
end

local function isspr(sx,sy,sw,sh,x,y,w,h,fx,fy)
    z=h or sh
    y+=z
    sspr3d(sx,sy,sw,sh,x,y,z,w,h,fx,fy)
end

local function ispr(n,x,y,w,h,fx,fy)
    z=(h or 1)*8
    y+=z
    spr3d(n,x,y,z,w,h,fx,fy)
end

local function imap(cx,cy,x,y,w,h,lyr)
    cx=cx or 0
    cy=cy or 0
    x=x or 0
    y=y or 0
    w=w or 128
    h=h or 64
    map3d(cx,cy,x,y,0,w,h,lyr)
end

function go3d()
    camera,sspr,spr,map=icamera,isspr,ispr,imap
    camera2d()
    is3d=true
end

function go2d()
    map,spr,sspr,pset,camera=map2d,spr2d,sspr2d,pset2d,camera2d
    is3d=false
end

-- defaults
icamera()
end
