function love.load()
    --my shit
    require "/src/player"
    require "/src/block"
    require "/src/world"
    
    --libs
    camera = require "/src/libs/camera"
    cam = camera()

    love.graphics.setDefaultFilter("nearest","nearest",1)

    globals = {}
    globals.spritesheet = love.graphics.newImage("/assets/imgs/pngs/spritesheet.png")
    globals.scale = 5
    globals.blocks = {}

    function globals.getBlock(name)
        for i,v in pairs(globals.blocks) do
            if v.name == name then
                return v
            end
        end
    end
    
    table.insert(globals.blocks,newBlock("air",{x=0,y=0},{x=0,y=0}))
    table.insert(globals.blocks,newBlock("wood",{x=0,y=2},{x=1,y=2}))

    globals.currentWorld = newWorld()

    love.window.setMode(love.graphics.getWidth()*globals.scale,love.graphics.getHeight()*globals.scale,{})

    player:load()
end

function love.update(dt)
    player:update(dt)

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    local nw = w/globals.scale
    local nh = h/globals.scale
    cam:lookAt(player.position.x + (w - nw)/2, (player.position.y) + (h - nh)/2) -- same for the y-axis
end

function love.draw()
    love.graphics.scale(globals.scale,globals.scale)
    love.graphics.clear()

    globals.currentWorld.resetDrawStack()

    cam:attach()

    world:draw()
    player:draw()

    for l=0,#globals.currentWorld.drawStack,1 do
        table.sort(globals.currentWorld.drawStack[l], function(t1,t2)
            return t1.screenCordinates.y < t2.screenCordinates.y
        end)
        for c=1,#globals.currentWorld.drawStack[l],1 do
            drawSpr(globals.currentWorld.drawStack[l][c])
        end
    end

    cam:detach()

    uiDraw()
end

function uiDraw()
    love.graphics.rectangle("fill",love.graphics.getWidth()/globals.scale/2,love.graphics.getHeight()/globals.scale/2,1,1)
end

function spr(sprCords,scrCords,sprDim,f,s,t)
    table.insert(globals.currentWorld.drawStack[scrCords.z], {spriteCordinates=sprCords,screenCordinates=scrCords,spriteDimensions=sprDim,flip=f,shade=s,type=t,extra=extra})
end

function drawSpr(t)
    local sx = t.spriteCordinates.x
    local sy = t.spriteCordinates.y
    local x = t.screenCordinates.x
    local y = t.screenCordinates.y
    local sw = t.spriteDimensions.w
    local sh = t.spriteDimensions.h
    local flip = t.flip or false
    local shade = t.shade or false
    
    if shade == true then
        love.graphics.setColor(31/255,16/255,42/255,1)
    end

    love.graphics.draw(globals.spritesheet,love.graphics.newQuad(sx*16,sy*16,sw*16,sh*16,globals.spritesheet:getDimensions()),x,y)

    love.graphics.setColor(1,1,1,1)
end