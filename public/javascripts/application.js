// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

//Para clases es con .
//Para ids es con #

$(document).ready(function() {

  var subtotal = new Array(0,0,0,0,0,0);
  var cuota = new Array(0,0,0,0,0,0);
  var cantidad = new Array(0,0,0,0,0,0);
  var adeudo = restan = total = 0;
  var r = buffer = 0;
  var str_pre1 = "#note_elements_attributes_";
  var addclicks = parseInt($("#note_count").val());
  var rowCount = $('.note_container tr').length;
  
  //Esconder Defuncion en carga depagina
  var sts;
  sts = parseFloat($("#patient_sts").val());
  if(sts != 4){
    $('.defunciones').hide();	
  }
  
  //Hide Añadir Elementos al inicio de la pagina
  rowCount -= 2;
  if ((addclicks >= 6)||(rowCount >= 6)){
  	  $('.add_nested_fields').hide();
  }
  
  if (rowCount > 0){
  	addclicks = rowCount;
  }
  
  //Hide Añadir Elementos
  $(".add_nested_fields").click(function(){
  	addclicks += 1;
  	if ((addclicks >= 6)||(rowCount >= 6)){
  	  $('.add_nested_fields').hide();
  	}
  });
  
  //Metodo que calcula subtotales y totales	
  $(".note_container").bind('change click', function(){
  var ST = 0;
  
	for( i=0; i < 6; i++){
	  //Lee valores de cuotas y cantidades y revisa que sea numero.
	  cuota[i] = parseFloat($(str_pre1 + i + "_cuota").val());
	  cantidad[i] = parseFloat($(str_pre1 + i + "_cantidad").val());
	  //Calcula subtotales
	  subtotal[i] = cantidad[i]*cuota[i];
 	  if (isNaN(subtotal[i])){
	    subtotal[i] = 0;
	  }
	  //Despliega subtotales
	  r = 2+i;
	  $("#subtotal_"+i).html(subtotal[i]);
	  ST += subtotal[i];
	}
    //Escribe subtotal
    $('#note_subtotal').val(ST); 
    //Le adeudo
    adeudo = parseFloat($("#note_adeudo").val());
    if(isNaN(adeudo)){ adeudo = 0; }
    //Escribe total    
    total = parseFloat(ST) + parseFloat(adeudo);
    $('#note_total').val(total);
    //Le acuenta
    acuenta = parseFloat($("#note_acuenta").val());
    if(isNaN(acuenta)){ acuenta = 0; }
    //Escribe restan
    restan = parseFloat(total) - parseFloat(acuenta);
    $('#note_restan').val(restan);       
  });

  //Metodo que calcula totales
  $(".note_container2").bind('change click', function(){
  var ST2 = 0;
    //Lee subtotal
    ST2 = parseFloat($("#note_subtotal").val());
    if(isNaN(ST2)){ 
      //HACER ALGO!!!
    } 
    //Lee adeudo
    adeudo = parseFloat($("#note_adeudo").val());
    if(isNaN(adeudo)){ adeudo = 0; }
    //Escribe total   
    total = parseFloat(ST2) + parseFloat(adeudo);
    $('#note_total').val(total);
    //Le acuenta
    acuenta = parseFloat($("#note_acuenta").val());
    if(isNaN(acuenta)){ acuenta = 0; }
    //Escribe restan
    restan = parseFloat(total) - parseFloat(acuenta);
    $('#note_restan').val(restan);       
  });

  //Metodo que actualiza el nombre de paciente y fija el adeudo  
  $("#note_patient_id").change( function(){
    var patid;
    //Lee patient_id
    patid = parseFloat($("#note_patient_id").val());
    //Manda patient_id y Fija el adeudo
    $.getJSON('/notes/new.json', { id: patid }, function(data) {
      $('#note_adeudo').val(data[0]); 
      $('#patient_name').html(data[1]); 
    });   
  });
  

  //Metodo para mostrar/ocultar campos de Servicio Social en Voluntarios
  $("#volunteer_status").change(function() {
  	var status;
  	status = parseFloat($("#volunteer_status").val());

    if(status == 1){
      $('.serviciosocial').show();	
    } else {
	  $('.serviciosocial').hide();	
    }
  });

  //Metodo para mostrar/ocultar campos de Servicio Social en Voluntarios
  $("#patient_status").bind('change click', function() {
  	var status;
  	status = parseFloat($("#patient_status").val());

    if(status == 4){
      $('.defunciones').show();	
    } else {
	  $('.defunciones').hide();	
    }
  });


 });


