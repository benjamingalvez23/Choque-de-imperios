if (global.pausa) exit;

// Muerte (da furia al jugador)
if (vida <= 0)
{
	if (instance_exists(objeto_jugador))
	{
		var j = instance_nearest(x, y, objeto_jugador);
		j.ganar_furia(furia_al_morir);
	}
	show_debug_message("¡ENEMIGO ELIMINADO!");
	instance_destroy();
	exit;
}

// Cooldown del disparo (corre incluso mientras camina)
if (shoot_cooldown > 0) shoot_cooldown--;

// Movimiento en curso
if (moviendo)
{
	x += sign(dest_x - x) * min(spd, abs(dest_x - x));
	y += sign(dest_y - y) * min(spd, abs(dest_y - y));
	
	if (x == dest_x && y == dest_y) moviendo = false;
	exit;
}

// Buscar al jugador
if (!instance_exists(objeto_jugador)) exit;
var jugador = instance_nearest(x, y, objeto_jugador);

// Alinearse a la grilla del jugador (una vez)
if (!alineado)
{
	x = jugador.dest_x + round((x - jugador.dest_x) / 32) * 32;
	y = jugador.dest_y + round((y - jugador.dest_y) / 32) * 32;
	dest_x = x;
	dest_y = y;
	alineado = true;
}

// Distancia entre centros
var dist = point_distance(x + 16, y + 16, jugador.x + 16, jugador.y + 16);

if (dist > detect_range) exit;

// Acercarse hasta tener rango de tiro
if (dist > shoot_range)
{
	var dcx = round((jugador.x - x) / 32);
	var dcy = round((jugador.y - y) / 32);
	var mx = 0;
	var my = 0;
	
	if (abs(dcx) >= abs(dcy)) mx = sign(dcx);
	else my = sign(dcy);
	
	if (!puede_mover(mx, my))
	{
		if (mx != 0) { mx = 0; my = sign(dcy); }
		else { my = 0; mx = sign(dcx); }
	}
	
	if ((mx != 0 || my != 0) && puede_mover(mx, my))
	{
		dest_x = x + mx * 32;
		dest_y = y + my * 32;
		moviendo = true;
	}
}
// Disparar
else if (shoot_cooldown <= 0)
{
	var dir = point_direction(x + 16, y + 16, jugador.x + 16, jugador.y + 16);
	
	var bala = instance_create_layer(x + 16, y + 16, "Instances", Object3);
	bala.direction = dir;
	bala.vel_bala = 6;
	bala.danio = danio;
	
	shoot_cooldown = shoot_delay;
}