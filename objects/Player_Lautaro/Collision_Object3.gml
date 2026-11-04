vida -= 5;

vida = max(vida, 0);

if (vida <= 0) {
    show_message("¡Has muerto!");
}

with (other) {
    instance_destroy();
}