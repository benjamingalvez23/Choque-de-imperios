
if (global.pausa) exit;


if (vida <= 0 && !muerto)
{
	muerto = true;
	show_message("¡Has muerto!");
	room_restart();
	exit;
}

if (keyboard_check_pressed(ord("R")) && !furia_activa && furia >= furia_maxima)
{
	furia_activa = true;
	tiempo_furia = duracion_furia;
	spd = spd_base * mult_vel_furia;
	danio = danio_base * mult_danio_furia;
}


if (furia_activa)
{
	tiempo_furia--;
	furia = furia_maxima * (tiempo_furia / duracion_furia);
	
	if (tiempo_furia <= 0)
	{
		furia_activa = false;
		furia = 0;
		spd = spd_base;
		danio = danio_base;
	}
}


if (moviendo)
{
	x += sign(dest_x - x) * min(spd, abs(dest_x - x));
	y += sign(dest_y - y) * min(spd, abs(dest_y - y));
	
	if (x == dest_x && y == dest_y) moviendo = false;
}



if (!moviendo)
{
	var mx = 0;
	var my = 0;
	
	if (keyboard_check(ord("D")))      { mx = 1;  direccion = 3; }
	else if (keyboard_check(ord("A"))) { mx = -1; direccion = 2; }
	else if (keyboard_check(ord("W"))) { my = -1; direccion = 1; }
	else if (keyboard_check(ord("S"))) { my = 1;  direccion = 0; }
	
	if (mx != 0 || my != 0)
	{
		var nx = x + mx * 32;
		var ny = y + my * 32;
		
		if (casilla_libre(nx, ny))
		{
			dest_x = nx;
			dest_y = ny;
			moviendo = true;
		}
	}
}


if (keyboard_check_pressed(vk_space) && puede_atacar)
{
	puede_atacar = false;
	tiempo_ataque = cooldown_ataque;
	
	var ddx = [0, 0, -1, 1];
	var ddy = [1, -1, 0, 0];
	var ax = x + ddx[direccion] * 32;
	var ay = y + ddy[direccion] * 32;

	for (var i = 0; i < array_length(objetivos_ataque); i++)
	{
		var e = collision_rectangle(ax + 4, ay + 4, ax + 27, ay + 27, objetivos_ataque[i], false, true);
		
		if (e != noone)
		{
			e.vida -= danio;
			show_debug_message("¡ENEMIGO GOLPEADO!");
		}
	}
}

if (!puede_atacar)
{
	tiempo_ataque--;
	if (tiempo_ataque <= 0) puede_atacar = true;
}