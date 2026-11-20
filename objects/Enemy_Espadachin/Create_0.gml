objeto_jugador = Player_Lautaro;

// Movimiento casilla a casilla
spd = 32/60 * 3;
moviendo = false;
dest_x = x;
dest_y = y;
alineado = false;

// Estadísticas
vida_maxima = 30;
vida = vida_maxima;
danio = 10;
furia_al_morir = 100;

// IA
rango_vision = 32 * 8;
estado = "perseguir";   // "perseguir" | "preparando" | "cooldown"
timer = 0;
tiempo_preparacion = 20;
tiempo_cooldown = 60;

// Casilla libre: nadie encima ni yendo hacia ella
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