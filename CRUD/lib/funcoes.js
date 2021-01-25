function Calendario(textBox) {
    var data = $("#" + textBox).val();

    $("#" + textBox).datepicker();
    $("#" + textBox).datepicker("option", "showOn", "button");
    $("#" + textBox).datepicker("option", "changeYear", true);
    $("#" + textBox).datepicker("option", "showAnim", "slideDown");
    $("#" + textBox).datepicker("option", "dateFormat", "dd/mm/yy");
    $("#" + textBox).datepicker("option", "dayNames", ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado', 'Domingo']);
    $("#" + textBox).datepicker("option", "dayNamesMin", ['D', 'S', 'T', 'Q', 'Q', 'S', 'S', 'D']);
    $("#" + textBox).datepicker("option", "dayNamesShort", ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom']);
    $("#" + textBox).datepicker("option", "monthNames", ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro']);
    $("#" + textBox).datepicker("option", "monthNamesShort", ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez']);

    $("#" + textBox).val(data);

    $("#" + textBox).datepicker("show");
    return false;
}
function MascaraData(input, event) {
    if ((event.keyCode >= 96 && event.keyCode <= 105) || (event.keyCode >= 48 && event.keyCode <= 57)) {
        if (input.value.length == 2 || input.value.length == 5) {
            input.value = input.value + '/';
        }
    }
}
function MascData(campo) {

    valor = $(campo).val();

    valor = valor.replace(/\D/g, "");                   
    valor = valor.replace(/(\d{2})(\d)/, "$1/$2");
    valor = valor.replace(/(\d{2})(\d)/, "$1/$2");

    valor = valor.replace(/(\d{2})(\d{2})$/, "$1$2");

    $(campo).val(valor);
}