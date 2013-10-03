/*
    Modal
=========================================*/
var getModal = function(id) {
    $('#myModal').foundation('reveal', 'open', 'http://www.uol.com.br');
}

var getModalEdit = function(id){
    $('.ui.modal.teste').modal('show').onShow(function(){
        var request = $.ajax({
            type: 'POST',
            async: false,
            url: '/tarefas/get_tarefas/'+id,
            data: $('form').serialize(),
        });
    }()); 
}

/*
    POPUP
=========================================*/


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
        $(focusResponse).html('<div class="ui green message" id="msg-01">Gravado com Sucesso</div>');
        setTimeout("removeTagPorID('msg-01')", 2000);
    });
    request.fail(function(jqXHR, textStatus) {
        $(focusResponse).html('<div class="ui red message" id="msg-01">Erro ao cadastrar dados</div>');
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
                        
                editable: true,
                events: jqxhr.responseJSON
            });    
        })
    }
});