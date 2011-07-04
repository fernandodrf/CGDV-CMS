module SocioecosHelper
  def remanente(socioeco)
    @remanente = socioeco.ingresos - socioeco.gastos
  end
  
end
