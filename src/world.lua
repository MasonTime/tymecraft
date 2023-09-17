function newWorld()
    world = {}

    world.width = 7
    world.height = 7
    world.length = 1
    world.blocks = {}
    world.entities = {}
    world.drawStack = {}

    for z=0, world.length, 1 do
        world.blocks[z] = {};
        for y=0, world.height, 1 do
            world.blocks[z][y] = {};
            for x=0, world.width, 1 do

                if false then
                    if y%2 > 0 then
                        world.blocks[z][y][x] = globals.getBlock("wood")
                    else
                        world.blocks[z][y][x] = globals.getBlock("air")
                    end
                else
                    world.blocks[z][y][x] = globals.getBlock("wood")
                end

            end
        end
    end

    local n = 0

    function world:update (dt)

    end

    function world:draw ()
        for Z=0, world.length, 1 do
            for Y=0, world.height, 1 do
                for X=0, world.width, 1 do
                    local currentBlock = world.blocks[Z][Y][X]

                    spr( currentBlock.textureFront, {x=(X)*16,y=Y*16,z=Z}, {w=1,h=1}, false, false, "block") --front
                end
            end
        end
    end

    function world:resetDrawStack()
        for l=0, world.length, 1 do
            world.drawStack[l] = {}
        end
    end

    return world
end

