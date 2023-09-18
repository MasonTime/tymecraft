function newWorld()
    world = {}

    world.width = 128
    world.height = 128
    world.length = 1
    world.blocks = {}
    world.entities = {}
    world.drawStack = {}

    for z=0, world.length, 1 do
        world.blocks[z] = {};
        for y=0, world.height, 1 do
            world.blocks[z][y] = {};
            for x=0, world.width, 1 do

                if z == 0 then
                    world.blocks[z][y][x] = globals.getBlock("grass")
                end

                if z == 1 then
                    world.blocks[z][y][x] = globals.getBlock("air")
                end

            end
        end
    end

    function world:update (dt)

    end

    function world:draw ()
        for Z=0, world.length, 1 do
            for Y=0, world.height, 1 do
                for X=0, world.width, 1 do
                    local currentBlock = world:getBlock(X,Y,Z)
                    
                    if math.sqrt((X - player.mapPosition.x)^2) < 20 and math.sqrt((Y - player.mapPosition.y)^2) < 20 then
                        if currentBlock.name ~= "air" then
                            if Z == world.length or world:getBlock(X,Y,Z+1).name == "air"  then
                                local texture = currentBlock.textureTop

                                if Y ~= world.height then
                                    if world:getBlock(X,Y+1,Z).name == "air" then
                                        texture = currentBlock.textureFront
                                    end
                                else
                                    texture = currentBlock.textureFront
                                end
                                
                                spr(texture, {x=(X)*16,y=Y*16,z=Z}, {w=1,h=1}, false, false, "block") --front
                            end
                        end
                    end
                end
            end
        end
    end

    function world:resetDrawStack()
        for l=0, world.length, 1 do
            world.drawStack[l] = {}
        end
    end

    function world:getBlock(x,y,z)
        return world.blocks[z][y][x]
    end

    function world:changeBlock(x,y,z, blockName)
        local block = blockName

        world.blocks[z][y][x] = globals.getBlock(block)
    end

    return world
end

