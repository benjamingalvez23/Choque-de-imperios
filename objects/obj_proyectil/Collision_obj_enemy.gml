with (obj_enemy)                                  // recorre TODOS los enemigos de la room
{
    if (point_distance(x, y, other.x, other.y) <= other.radio_explosion) // ¿el enemigo está dentro del radio de la explosión?
    {
        vida -= other.damage;                       // le resta 10 de vida (other = el proyectil)
    }
}
instance_destroy();                               // destruye el proyectil tras explotar