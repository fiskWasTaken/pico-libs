-- cute: coroutine cutscene lib

cute={
 -- visibility for draw state
 -- 0=hidden,1=fully visible
 vis=0,
 -- current frame
 frame={},
 -- max text width
 width=25,
 rows=2,
 -- autoplay interval delay
 autoplay_interval=60,
 -- target y offset at full vis
 target_oy=92,
 handlers={}
}

-- draw/update the bound
-- coroutine, if there is one.
function cute:draw()
 if self.co then
  if costatus(self.co)=="dead" then
   -- gc
   self.co=nil
  else
   coresume(self.co)
   self:draw_frame()

   if self.handlers[self.frame.type] then
    self.handlers[self.frame.type](self.frame)
   else
    printh("no frame handler for"..self.frame.type)
   end
  end
 end
end

function cute:oy()
 return 100+(1-self.vis)*(128-self.target_oy)
end

function cute:play(func)
 cute.co=cocreate(func)
end