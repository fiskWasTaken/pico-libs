function ctor(self,o)
	self.__index=self
	return setmetatable(o or {},self)
end