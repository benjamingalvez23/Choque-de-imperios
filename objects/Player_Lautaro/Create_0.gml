spd_base = 32/60 * 5;
spd = spd_base;
moviendo = false;
dest_x = x;
dest_y = y;
direccion = 0;

vida_maxima = 100;
vida = vida_maxima;

furia_maxima = 100;
furia = 0;

danio_base = 5;
danio = danio_base;

muerto = false;

puede_atacar = true;
tiempo_ataque = 0;
cooldown_ataque = 20;
objetivos_ataque = [Enemy_Espadachin, Enemy_Mosquetero];

furia_activa = false;
tiempo_furia = 0;
duracion_furia = game_get_speed(gamespeed_fps) * 60;   // 1 minuto
mult_vel_furia = 1.5;
mult_danio_furia = 2;

recibir_danio = function(_cant)
{
	if (muerto) return;
	vida = max(0, vida - _cant);
}

ganar_furia = function(_cant)
{
	if (furia_activa) return;
	furia = min(furia + _cant, furia_maxima);
}


casilla_libre = function(_nx, _ny)
{
	
	var libre = true;
	var tipos = [Enemy_Espadachin, Enemy_Mosquetero];
	
	for (var i = 0; i < 2; i++)
	{
		with (tipos[i])
		{
			var cerca = (abs(x - _nx) < 32 && abs(y - _ny) < 32);
			var va_ahi = (dest_x == _nx && dest_y == _ny);
			if (cerca || va_ahi) libre = false;
		}
	}
	return libre;
}