composite={}

function composite:new(o)
	self.__index=self
	o=o or {}
	o.x=o.x or 0
	o.y=o.y or 0
	o.w=o.w or 0
	o.h=o.h or 0
	o.children=o.children or {}
	o=setmetatable(o,self)
	o:init()
	return o
end

function composite:init()
end

function composite:add_child(child)
	add(self.children,child)
	child.parent=self
end

function composite:remove_child(child)
	del(self.children,child)
	child.parent=nil
end

function composite:click(x,y)
 debug_text="click (local "..x..","..y..")"
end

function composite:child_click(x,y)
 debug_text="child_click (local "..x..","..y..")"
end
 
function composite:draw()
end

function composite:paint()
 self:draw()
 foreach(self.children,function(c) c:paint() end)
end

function composite:abs_pos()
	local x,y=self.x,self.y
	local p=self.parent
	
	while p do
		x+=p.x
		y+=p.y
		p=p.parent
	end
	
	return x,y
end
	
function composite:root()
	local p=self
	
	while true do
		if (p.parent == nil) return p
		p=p.parent
	end
end

function composite:contains(x,y)
	local ax,ay=self:abs_pos()
	return (mid(ax,ax+self.w,x)==x)
	 and (mid(ay,ay+self.h,y)==y)
end

function composite:bubble_click(x,y)
 -- iterate backwards
 -- elements at the end of the 
 -- array
 -- have higher z priority
 for i=#self.children,1,-1 do
  child=self.children[i]
  if child:contains(x,y) then
   self:child_click(x,y)
   child:bubble_click(x,y)
   return
  end
 end
	
 -- if no children catch the event, this does
 self:child_click(x,y)
 self:click(x,y)
end
