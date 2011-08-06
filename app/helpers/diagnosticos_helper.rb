module DiagnosticosHelper

  def text_diag(id)
  	return diag = CatalogoDiagnostico.find(id).diagnostico
  end

end
