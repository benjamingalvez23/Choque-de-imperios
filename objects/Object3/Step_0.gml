speed = global.pausa ? 0 : vel_bala;
if (x < -64 || y < -64 || x > room_width + 64 || y > room_height + 64) instance_destroy();