object dominic {
  const autos = []

  method comprar(unAuto) {autos.add(unAuto)}
  method encontrarNoEnCondiciones() =  autos.filter({a => not a.estaEnCondiciones()})
  method autosEnCondiciones() = autos.filter({a => a.estaEnCondiciones()})
  method enviarAutosATaller() {
    taller.recibirAutos(self.encontrarNoEnCondiciones())
  }
  method hacerPrueba() {
    autos.forEach({a => a.hacerPrueba()})
  }
  method venderAutos() {
    autos.clear()
  }
  method promedioVelocidad() = autos.sum({a => a.velocidadMaxima()}) / autos.size()
  method masRapido() = self.autosEnCondiciones().max({a => a.velocidadMaxima()})
  method hayAutoMasRapido() = self.masRapido().velocidadMaxima() > 2 * self.promedioVelocidad()
}

object taller {
  const autosAReparar = []

  method recibirAutos(listaAutos) {
    autosAReparar.addAll(listaAutos)
  }
  method arreglarAutos() {
    autosAReparar.forEach({a => a.reparar()})
    autosAReparar.clear()
  }
}

object ferrari {
  var estadoMotor = 87

  method estadoMotor() = estadoMotor
  method estaEnCondiciones() = estadoMotor >= 65
  method reparar() {estadoMotor = 100}
  method velocidadMaxima() = 110 + if(estadoMotor > 75) 15 else 0
  method hacerPrueba() {estadoMotor = (estadoMotor - 30).max(0)}
}

object flechaRubi {
  var nivelCombustible = 100
  var property tipoCombustible = gasolina
  var color = azul 

  method estaEnCondiciones() = 
    nivelCombustible > nivelCombustible.nivelMinimo() &&
    color == rojo

  method hacerPrueba() {nivelCombustible = (nivelCombustible - 5).max(0)}
  method reparar() {
    nivelCombustible = nivelCombustible * 2 and
    color.cambiarDeColor()
  }
  method velocidadMaxima() {
    return nivelCombustible * 2 + tipoCombustible.cantidadAdicional(nivelCombustible)
  }
}

object gasolina {
  method nivelMinimo() = 85
  method cantidadAdicional(unaCantidad) = 10
}

object nafta {
  method nivelMinimo() = 50
  method cantidadAdicional(unaCantidad) = -1 * (unaCantidad * 2) * 0.1
}

object nitroLiquido {
  method nivelMinimo() = 0
  method cantidadAdicional(unaCantidad) = unaCantidad * 2 * 10 
}

object azul {
  method cambiarDeColor() = verde
}

object rojo {
  method cambiarDeColor() = azul
}

object verde {
  method cambiarDeColor() = rojo
}

object intocable {
  var property enCondiciones = true
  
  method hacerPrueba() {enCondiciones = false}
  method reparar() {enCondiciones = true} 
  method velocidadMaxima() = 45
}