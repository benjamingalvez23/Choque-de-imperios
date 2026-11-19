if (x < 0 || x > room_width || y < 0 || y > room_height) // si sale de los límites de la room...
{
    instance_destroy();                           // ...se destruye para no gastar memoria
}