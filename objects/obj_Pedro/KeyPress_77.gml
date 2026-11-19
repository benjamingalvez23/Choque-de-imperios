// Guardamos en "muro" el obj_muro más cercano a Pedro (si no existe ninguno en la sala, vale noone)
var muro = instance_nearest(x, y, obj_muro);

// Comprobamos que haya un muro, que esté a 8 píxeles o menos, Y que el cooldown ya haya terminado
if (muro != noone && distance_to_object(muro) <= 8 && contador_reparar >= tiempo_reparar){
    // Reparacion
    muro.vida += 50;
    // Evita que la vida quede sobre 100
    if (muro.vida > muro.vida_max){
        muro.vida = muro.vida_max;
    }
    contador_reparar = 0;
}