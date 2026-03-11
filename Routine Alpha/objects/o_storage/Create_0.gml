//
sprite_index = sprite
is_open = false

switch (sprite) {
	case (s_storage_rags):
		inventory = new inventory_create(0,4)
		break
	
	default:
		inventory = new inventory_create(0,2)
}