$(".datatablesPacientesMont").DataTable({
    deferRender: true,
    retrieve: true,
    processing: true,
    paging: true,
    lengthChange: false,
    searching: true,
    ordering: false,
    info: true,
    autoWidth: false,
    language: {
        url: "public/views/resources/js/dataTables.spanish.lang",
    },
});
$("#deshacer-filtro-PAC").on("click", function () {
    window.location = "pacientes";
});
$("#pacBusqueda").select2(
    {
        maximumInputLength: "12",
        minimumInputLength: "2",
        language: {

            noResults: function () {

                return "No hay resultado";
            },
            searching: function () {

                return "Buscando..";
            },
            inputTooShort: function () {
                return "Ingrese 2 o más caracteres";
            },
            inputTooLong: function () {
                return "Ingrese máximo 12 caracteres";
            }
        },
        scrollAfterSelect: true,
        placeholder: 'Ingrese N° de DNI,CE,PASS o Nombres del Paciente',
        ajax: {
            url: "public/views/src/ajaxFamiliares.php",
            type: "post",
            dataType: "json",
            delay: 150,
            data: function (params) {
                return {
                    searchTerm: params.term,
                };
            },
            processResults: function (response) {
                return {
                    results: response,
                };
            },
            cache: true,
        },
    }
);
$("#pacBusqueda").on("change", function () {
    let paciente = $(this).val();
    window.location =
        "index.php?ruta=pacientes&idPaciente=" +
        paciente;
})