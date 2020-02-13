-- slide in.
function slide_in(⧗)
 ⧗=⧗ or 30
 for t=1,⧗ do
  cute.vis=ease_outquint(t,0,1,⧗)
  yield()
 end
end

-- slide out.
function slide_out(⧗)
 ⧗=⧗ or 30
 for t=1,⧗ do
  cute.vis=ease_inquint(t,1,-1,⧗)
  yield()
 end
end

function ease_outquint(t,b,c,d)
 t/=d
 t-=1
 return c*(t*t*t*t*t+1)+b
end

function ease_inquint(t,b,c,d)
 t/=d/2
 if (t<1) return c/2*t*t*t*t*t+b
 t-=2
 return c/2*(t*t*t*t*t+2)+b
end

function cinematic(label)
 local func=cocreate(label)

 -- buffer first cutscene frame
 coresume(func)

 for co in all({
  cocreate(slide_in),
  func,
  cocreate(slide_out)
 }) do
  while costatus(co)!="dead" do
   yield(coresume(co))
  end
 end
end

-- convenience wrapper
function cute:cinematic(label)
 cute:play(function() cinematic(label) end)
end
