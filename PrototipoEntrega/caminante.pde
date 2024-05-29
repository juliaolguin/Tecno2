class Caminante {
  float x, y, dir, xInicial, yInicial;
  float t = 20;
  float vel;
  float variacion = 3;
  color relleno;
  boolean circuloCompleto = false;

  Caminante() {
    x = random(150, width - 150);
    y = random(150, height - 150);
    xInicial = x;
    yInicial = y;
    dir = radians(random(360));
    vel = 4;
    relleno = color(random(255));
  }

  void asignarColor(color nuevoColor) {
    relleno = nuevoColor;
  }

 void dibujar() {
  if (!circuloCompleto) {
    pushStyle();
    fill(relleno);
    noStroke();
    ellipse(x, y, t, t);
    popStyle();
  }
}


  void mover() {
    if (circuloCompleto) return;
    
    variacion = radians(2);
    dir = dir + variacion;
    float dx = vel * cos(dir);
    float dy = vel * sin(dir);
    y = y + dy;
    x = x + dx;

    // Espacio toroidal
    x = (x > width ? x - width : x);
    x = (x < 0 ? x + width : x);
    y = (y > height ? y - height : y);
    y = (y < 0 ? y + height : y);

    // Verificar si el caminante ha completado un círculo
    if (dist(x, y, xInicial, yInicial) < vel) {
      circuloCompleto = true;
    }
  }
}
