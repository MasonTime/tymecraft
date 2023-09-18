player = {}

function player:load()
    self.sprite = {x=0,y=1}
    self.position = {x=32,y=32,z=1}
    self.mapPosition = {x=0,y=0}

    self.cursor = {}
    self.cursor.position = {x=0,y=0,z=0}
    self.cursor.sprite = {x=1,y=0}
    self.cursor.mapPosition = {x=0,y=0}
end

function player:update(dt)

    if globals.btn.right then
        self.position.x = self.position.x + 50 *dt
    end

    if globals.btn.left then
        self.position.x = self.position.x - 50 *dt
    end

    if globals.btn.up then
        self.position.y = self.position.y - 50 *dt
    end

    if globals.btn.down then
        self.position.y = self.position.y + 50 *dt
    end

    self.mapPosition.x = math.floor(self.position.x/16)
    self.mapPosition.y = math.floor(self.position.y/16)

    self.cursor.position.x = math.floor(math.floor(love.mouse.getX()/globals.scale) - love.graphics.getWidth()/globals.scale/2 + self.position.x)
    self.cursor.position.y = math.floor(math.floor(love.mouse.getY()/globals.scale) - love.graphics.getHeight()/globals.scale/2 + self.position.y)
    self.cursor.mapPosition.x = math.floor(self.cursor.position.x/16)
    self.cursor.mapPosition.y = math.floor(self.cursor.position.y/16)

    if self.cursor.mapPosition.x >= 0 and self.cursor.mapPosition.y >= 0 then
        if globals.btn.m1 then
            globals.currentWorld:changeBlock(self.cursor.mapPosition.x,self.cursor.mapPosition.y,self.position.z,"air")
        end
    end

    print(self.cursor.position.x .. "," .. self.cursor.position.y)
    print(self.cursor.mapPosition.x .. "," .. self.cursor.mapPosition.y)
end

function player:draw()
    spr(self.cursor.sprite,{x=self.cursor.position.x-8,y=self.cursor.position.y-8,z=self.position.z},{w=1,h=1},false,false,"entity",0,{})
    spr(self.sprite,{x=self.position.x-8,y=self.position.y-8,z=self.position.z},{w=1,h=1},false,false,"entity",0,{})
end