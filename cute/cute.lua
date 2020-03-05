-- cute: coroutine cutscene lib

cute={
v=0,
f={},
w=25,
rows=2,
ty=92,
handlers={}
}

function cute:draw()
if self.co then
if costatus(self.co)=="dead" then
-- gc
self.co=nil
else
coresume(self.co)
self:draw_frame()

if self.handlers[self.f.t] then
self.handlers[self.f.t](self.f)
else
printh("no frame handler for"..self.f.t)
end
end
end
end

function cute:oy()return 100+(1-self.v)*(128-self.ty)end
function cute:play(func)cute.co=cocreate(func)end