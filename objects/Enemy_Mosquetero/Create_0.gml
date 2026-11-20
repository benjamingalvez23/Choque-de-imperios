objeto_jugador = Player_Lautaro;

// Movimiento casilla a casilla
spd = 2;
moviendo = false;
dest_x = x;
dest_y = y;
alineado = false;

// Estadísticas
vida_maxima = 20;
vida = vida_maxima;
danio = 5;
furia_al_morir = 5;

// IA
detect_range = 250;
shoot_range = 150;
shoot_cooldown = 0;
shoot_delay = 45;

puede_mover = function(_mx, _my)
{
	var nx = x + _mx * 32;
	var ny = y + _my * 32;
	
	// if (place_meeting(nx, ny, obj_pared)) return false;   // paredes
	
	var libre = true;
	var ocupantes = [Player_Lautaro, Enemy_Espadachin, Enemy_Mosquetero];
	
	for (var i = 0; i < 3; i++)
	{
		with (ocupantes[i])
		{
			if (id != other.id)
			{
				var cerca = (abs(x - nx) < 32 && abs(y - ny) < 32);
				var va_ahi = (dest_x == nx && dest_y == ny);
				if (cerca || va_ahi) libre = false;
			}
		}
	}
	return libre;
}
