function newBlock(name, texTop, texFront)
    block = {}

    block.name = name or "placeholder" 

    block.textureTop = texTop or {x=0,y=0}
    block.textureFront = texFront or {x=0,y=0}

    table.insert(globals.blocks, block)
end