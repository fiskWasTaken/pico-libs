-- is 3d mode enabled?
is3d=false

function go3d()
    camera,sspr,spr,map=icamera,isspr,ispr,imap
    camera2d()
    is3d=true
end

function go2d()
    map,spr,sspr,pset,camera=map2d,spr2d,sspr2d,pset2d,camera2d
    is3d=false
end