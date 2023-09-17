player = {}

function player:load()
    self.sprite = {x=0,y=1}
    self.position = {x=0,y=64,z=1}
end

function player:update(dt)
    --self.position.x = self.position.x + 50 *dt
end

function player:draw()
    spr(self.sprite,{x=self.position.x-8,y=self.position.y-8,z=self.position.z},{w=1,h=1},false,false,"entity",0,{})
end