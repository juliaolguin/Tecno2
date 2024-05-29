ArrayList<Caminante> todosLosCaminantes; // Lista para todos los caminantes dibujados
ArrayList<Caminante> caminantesActivos; // Lista para caminantes que se activan con la tecla '1'
ArrayList<Caminante> caminantesAzules; // Lista para caminantes azules
ArrayList<Caminante> caminantesRojos; // Lista para caminantes rojos
int cantidad = 4;
int cantidadTotal = 0;
int maxCantidad =40 ;
boolean moverCaminantes = false;
boolean moverCaminantesAzules = false;
boolean moverCaminantesRojos = false;

void setup() {
  size(1200, 1200);
  background(255);
  todosLosCaminantes = new ArrayList<Caminante>();
  caminantesActivos = new ArrayList<Caminante>();
  caminantesAzules = new ArrayList<Caminante>();
  caminantesRojos = new ArrayList<Caminante>();
}

void draw() {
  if (!moverCaminantes && !moverCaminantesAzules && !moverCaminantesRojos) {
    // Si no hay interacción de mouse o teclado, limpiar el lienzo con fondo blanco
    background(255);
  } else {
    // Dibujar todos los caminantes
    for (Caminante c : todosLosCaminantes) {
      c.dibujar();
    }

    // Verificar si algún tipo de movimiento está activo y mover los caminantes correspondientes
    if (moverCaminantes) {
      moverYActualizarCaminantes(caminantesActivos, color(200)); // Caminantes activados con la tecla '1'
    } else if (moverCaminantesAzules) {
      moverYActualizarCaminantes(caminantesAzules, color(0, 0, 255)); // Caminantes azules
    } else if (moverCaminantesRojos) {
      moverYActualizarCaminantes(caminantesRojos, color(255, 0, 0)); // Caminantes rojos
    }
  }
}

void limpiarLienzo() {
  background(255);
}


void moverYActualizarCaminantes(ArrayList<Caminante> lista, color nuevoColor) {
  boolean allCompleted = true;
  for (Caminante c : lista) {
    if (!c.circuloCompleto) {
      c.mover();
      allCompleted = false;
    }
    c.dibujar();
  }
  
  if (allCompleted && cantidadTotal < maxCantidad) {
    crearNuevosCaminantes(cantidad, nuevoColor, lista);
  }
}

void keyPressed() {
  if (key == '1') {
    moverCaminantes = true;
    if (cantidadTotal == 0 || caminantesActivos.size() == 0) {
      crearNuevosCaminantes(cantidad, color(255), caminantesActivos); // Crear los primeros caminantes o nuevos caminantes sin color específico
    }
  }
}

void keyReleased() {
  if (key == '1') {
    moverCaminantes = false;
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    moverCaminantesAzules = true;
    if (caminantesAzules.size() == 0) {
      crearNuevosCaminantes(cantidad, color(0, 0, 255), caminantesAzules); // Crear caminantes azules
    }
  } else if (mouseButton == RIGHT) {
    moverCaminantesRojos = true;
    if (caminantesRojos.size() == 0) {
      crearNuevosCaminantes(cantidad, color(255, 0, 0), caminantesRojos); // Crear caminantes rojos
    }
  }
}

void mouseReleased() {
  if (mouseButton == LEFT) {
    moverCaminantesAzules = false;
  } else if (mouseButton == RIGHT) {
    moverCaminantesRojos = false;
  }
}

void crearNuevosCaminantes(int num, color nuevoColor, ArrayList<Caminante> lista) {
  lista.clear();
  for (int i = 0; i < num; i++) {
    if (cantidadTotal < maxCantidad) {
      Caminante c = new Caminante();
      if (nuevoColor != color(255)) { // Si se especificó un color diferente al blanco, asignarlo
        c.asignarColor(nuevoColor);
      }
      lista.add(c);
      todosLosCaminantes.add(c);
      cantidadTotal++;
    }
  }
}
