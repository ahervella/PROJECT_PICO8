
--Frame Deltas--

n_prevTime = 0
n_deltaTimeUpdate = 0

-------------------------

b_mainInitialized = false

---ZObjects---

zoT_objs = {}

--Object manager owns objects and collisions
--has collision layer defs which are used like dicts
--each dict has all the objs on that layer and all the pairs
--each time we add an obj, we go to the collision layer,
--make all the pairs based off the obj list
--each update we check if each pair is overlapping
-- shouldn't be too bad if its all the monsters with player,
-- and all the bullets witch each enemy


function _init()
    b_mainInitialized = true

    cls(0)
    --Don't repeat button press for flipping character
    --poke(0X5F5C, 255)
    
    ObjManager:__init()

    ZWall:__newWall(
        Vector2:__new(20, 60),
        Vector2:__new( 100, 10)
    )


    ZWall:__newWall(
        Vector2:__new(20, 80),
        Vector2:__new( 100, 10)
    )

    ZPlayer:__newObj( 
        Vector2:__new(40, 40),
        true
    )
--[[
    ZEnemy:__newObj(
        Vector2:__new(60, 20),
        true
    )
    --]]

    ZCamera:__newCam()
end

function _update()
        printh("")
    printh("-----start of update-----")
    printh("")

    n_deltaTimeUpdate = t() - n_prevTime;
    n_prevTime = t()

    ObjManager:__update()

        printh("")
    printh("-----end of update-----")
    printh("")
end

function _draw()
    printh("")
    printh("-----start of draw-----")
    printh("")

    cls(0)

    ObjManager:__draw()
    printh("")
    printh("-----end of draw-----")
    printh("")
end

