/*
    Mask Jquery
=========================================*/
jQuery(function($){
   $(".mask-date").mask("99/99/9999");
});


/*
    Modal
=========================================*/
var getModalEdit = function(id){ 
    $('#myModal').foundation('reveal', 'open');
    if (id){
        var jqxhr = $.getJSON( "/tarefas/get_tarefa/"+id, function() {
            var obj = jqxhr.responseJSON
            
            // Troca o titulo do form
            $("#myModal h3").text("Atualizar Tarefa");
            
            // Acrescenta o input para o PUT
            if (!$("#myModal input#method").length){
                $('<input>').attr({'type': 'hidden', 'name': '_method', 'value': 'put', 'id': 'method'}).appendTo('#form-cadastro');
                $('<input>').attr({'type': 'hidden', 'name': 'id', 'value': id, 'id': 'id'}).appendTo('#form-cadastro');
            } else {
                $("#myModal input#method").attr("value", id);
            }
                        
            $("#myModal input#titulo").attr("value", obj.titulo);
            $("#myModal input#data_inicio").attr("value", obj.data_inicio);   
            $("#myModal input#data_termino").attr("value", obj.data_termino);
            $( "select#categoria option" ).each(function() {
                if ($(this).attr('value') == parseInt(obj.categoria)){
                    $(this).attr("selected", "selected");    
                }
            });
            $( "#myModal select#prioridade option" ).each(function() {
                if ($(this).attr('value') == parseInt(obj.prioridade)){
                    $(this).attr("selected", "selected");    
                }
            });
            $( "#myModal select#visibilidade option" ).each(function() {
                if ($(this).attr('value') == parseInt(obj.visibilidade)){
                    $(this).attr("selected", "selected");    
                }
            });
            $("#myModal textarea#descricao").text(obj.descricao);
            $("#myModal input#id").attr("value", obj.id);
        })
    } else {
        if ($("#myModal input#method").attr("value")){
            $( "#method" ).remove();    
            $( "#id" ).remove();  
        }
        
        $("#myModal input#titulo").attr("value", "");
        $("#myModal input#data_inicio").attr("value", "");   
        $("#myModal input#data_termino").attr("value", "");
        $( "select#categoria option" ).each(function() {
            if ($(this).attr('value') != parseInt(obj.categoria)){
                $(this).attr("selected", "selected");    
            }
        });
        $( "#myModal select#prioridade option" ).each(function() {
            if ($(this).attr('value') != parseInt(obj.prioridade)){
                $(this).attr("selected", "selected");    
            }
        });
        $( "#myModal select#visibilidade option" ).each(function() {
            if ($(this).attr('value') != parseInt(obj.visibilidade)){
                $(this).attr("selected", "selected");    
            }
        });
        $("#myModal textarea#descricao").text("");
        $("#myModal input#id").attr("value", "");
    }
}

/*
    Forms
=========================================*/
$("form").submit(function(e){
    
    // Retorna-se false para que o formulário não seja
    // enviado pelo methodo tradicional
    e.preventDefault();
    
    /**
     * Retorna o caminho para a ação do formulário
     * @return String
     */
    var action = $(this).attr("action");
    
    /**
     * Retorna o ID da tag que será o foco
     * das mensagens de retorno
     * 
     * @return String
     */
    var focusResponse = $(this).attr("data-response");
    
    /**
     * Retorna o Methodo utilizado para o envio do 
     * formulário
     * 
     * @return String
     */
    var method = $(this).attr("method");

    var request = $.ajax({
        type: 'POST',
        async: false,
        url: action,
        data: $('form').serialize(),
    });
    
    request.done(function(msg) {
        $(focusResponse).html('<div data-alert class="alert-box success" id="msg-01">Sucesso<a href="#" class="close">&times;</a></div>');
        // Limpa o formulário
        $(':input').not(':button, :submit, :reset, :hidden').val('').removeAttr('checked').removeAttr('selected');
        setTimeout("removeTagPorID('msg-01')", 2000);
    });
    request.fail(function(jqXHR, textStatus) {
        $(focusResponse).html('<div data-alert class="alert-box alert" id="msg-01">Erro<a href="#" class="close">&times;</a></div>');
        setTimeout("removeTagPorID('msg-01')", 2000);
    });
});

var removeTagPorID = function(id) {
	$("#"+id).fadeOut('slow');
}

/*
    Calendar
=========================================*/
$(document).ready(function() {
	
    if ($('#calendar').length){
        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();
        
        var jqxhr = $.getJSON( "/tarefas/get_array_json", function() {
            $('#calendar').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay'
                },
                        
                editable: false,
                events: jqxhr.responseJSON
            });    
        })
    }
});