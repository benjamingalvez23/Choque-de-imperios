// Vida del muro
vida_max = 100;
vida = vida_max;

// Reparar el muro cada 3 segunds
tiempo_reparar = 180;  
contador_reparar = 0;

barra = instance_create_layer(x, y, layer, obj_barra); // Crea una barra de vida en la misma capa del muro y guarda su identificador en "barra"
barra.muro = id; // Le dice a la barra cuál es su muro (id es el identificador de este muro)