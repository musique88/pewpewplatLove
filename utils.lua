vectorO = {}
vectorO.__index = vectorO

function vectorO:new(x,y)
  return {x=x, y=y}
end

function vectorO:length()
  return sqrt((self.x^2)+(self.y^2))
end

function vectorO:angle()
  return atan(self.y/self.x)
end
