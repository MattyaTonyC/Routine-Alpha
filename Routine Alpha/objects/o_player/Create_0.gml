//
hp_max = 100
hp = 70

//
acc = 0.15
spd_max = 0.75
spd = { x:0, y:0 }

//
inventory = new inventory_create(4,6)
inventory.active[0] = { id:"bread",count:1 }
inventory.active[1] = { id:"salad",count:3 }
inventory.active[2] = { id:"meat",count:7 }
inventory.active[3] = { id:"mobilk",count:123 }