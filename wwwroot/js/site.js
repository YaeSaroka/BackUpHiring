// Please see documentation at https://learn.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.

//VIEW 1 FUNCTIONS

//VALIDACIONES DE REGISTRO

//npm install express fs

function mostrarSiguienteSeccion(numeroSeccion) {
    if (numeroSeccion === 1) {
        $('#seccion1').show();
        $('#seccion1-body').show();
        $('#seccion1-footer').show();

        $('#seccion2').hide();
        $('#seccion2-body').hide();
        $('#seccion2-footer').hide();
    } else if (numeroSeccion === 2) {
        $('#seccion2').show();
        $('#seccion2-body').show();
        $('#seccion2-footer').show();

        $('#seccion1').hide();
        $('#seccion1-body').hide();
        $('#seccion1-footer').hide();
    }
}
//FUNCION MULTIMEDIA 
function updateSlides() {
    const slides = document.getElementsByClassName('carousel-item');
    const carousel = document.getElementById('CarouseLArchivos');
    if (slides.length > 0) {
        carousel.style.display = 'block'; // Muestra el carrusel
        const bootstrapCarousel = new bootstrap.Carousel(carousel);
        document.querySelector('.carousel-control-prev').style.display = 'block';
        document.querySelector('.carousel-control-next').style.display = 'block';
    } else {
        carousel.style.display = 'none'; // Oculta el carrusel
        document.querySelector('.carousel-control-prev').style.display = 'none';
        document.querySelector('.carousel-control-next').style.display = 'none';
    }
}

//FUNCION COLOR SEGUN EL FONDO
function adjustTextColorBasedOnBackground() {
    var card = document.querySelector('.card-container');
    var bgColor = window.getComputedStyle(card.querySelector('.rectangulo-encabezado')).backgroundColor;

    var rgb = bgColor.match(/\d+/g);
    var hex = rgb.map(x => {
        var hexPart = parseInt(x).toString(16);
        return hexPart.length === 1 ? '0' + hexPart : hexPart;
    }).join('');

    var brightness = getBrightness(hex);

    var textColor = brightness > 128 ? 'black' : 'white';
    card.style.color = textColor;
    card.querySelectorAll('.telefono, .mail, .ubicacion, .acerca_de_mi_container, #profesion').forEach(el => {
        el.style.color = textColor;
    });
}

document.addEventListener('DOMContentLoaded', adjustTextColorBasedOnBackground);

function getBrightness(hex) {
    // Asegúrate de que el valor hexadecimal tenga el formato correcto
    hex = hex.replace('#', '');
    if (hex.length !== 6) {
        throw new Error('Formato hexadecimal inválido');
    }

    // Convierte los componentes hexadecimales a valores RGB
    var r = parseInt(hex.substring(0, 2), 16);
    var g = parseInt(hex.substring(2, 4), 16);
    var b = parseInt(hex.substring(4, 6), 16);

    // Calcula el brillo utilizando la fórmula de luminancia relativa
    return (r * 299 + g * 587 + b * 114) / 1000;
}

//FUNCION PARA FECHAS DEL MODAL EDUCACION
document.addEventListener('DOMContentLoaded', function () {
    const currentYear = new Date().getFullYear();
    const startYear = currentYear - 110;
    const endYear = currentYear ;
    const anoInicioSelect = document.getElementById('ano-inicio');
    const anoFinSelect = document.getElementById('ano-fin');
    const mesInicioSelect = document.getElementById('mes-inicio'); 
    const mesFinSelect = document.getElementById('mes-fin'); 

    function populateYearSelect(selectElement, start, end) {
      for (let year = start; year <= end; year++) {
        const option = document.createElement('option');
        option.value = year;
        option.textContent = year;
        selectElement.appendChild(option);
      }
    }
    function populateMonthSelect(selectElement) {
        const months = [ 
            { value: 'enero', text: 'Enero' },
            { value: 'febrero', text: 'Febrero' },
            { value: 'marzo', text: 'Marzo' },
            { value: 'abril', text: 'Abril' },
            { value: 'mayo', text: 'Mayo' },
            { value: 'junio', text: 'Junio' },
            { value: 'julio', text: 'Julio' },
            { value: 'agosto', text: 'Agosto' },
            { value: 'septiembre', text: 'Septiembre' },
            { value: 'octubre', text: 'Octubre' },
            { value: 'noviembre', text: 'Noviembre' },
            { value: 'diciembre', text: 'Diciembre' }
        ];

        months.forEach(month => {
            const option = document.createElement('option');
            option.value = month.value;
            option.textContent = month.text;
            selectElement.appendChild(option);
        });
    }
  
    populateYearSelect(anoInicioSelect, startYear, endYear);
    populateYearSelect(anoFinSelect, startYear, endYear);
    populateMonthSelect(mesInicioSelect); 
    populateMonthSelect(mesFinSelect);
  });

 
//FUNCIÓN PARA PRECARGAR INFORMACIÓN DEL MODAL EDUCACION
$(document).on('click', '.editar-icono', function () {
    var id = $(this).data('id');

    $.ajax({
        url: '/Home/ObtenerDatosEducacion/' + id,
        type: 'GET',
        success: function (response) {
            if (response.success === false) {
                alert(response.message);
            } else {
                console.log("ID obtenido: ", response.id); 
                $('input[name="id"]').val(response.id); 
                $('input[name="titulo"]').val(response.titulo);
                $('input[name="nombre_institucion"]').val(response.nombre_institucion);
                $('select[name="mes_expedicion"]').val(response.mes_expedicion);
                $('select[name="fecha_expedicion"]').val(response.fecha_expedicion);
                $('select[name="mes_caducidad"]').val(response.mes_caducidad);
                $('select[name="fecha_caducidad"]').val(response.fecha_caducidad);
                $('input[name="disciplina_academica"]').val(response.disciplina_academica);
                $('input[name="actividades_grupo"]').val(response.actividades_grupo);
                $('input[name="Descripcion"]').val(response.descripcion);
                $('#ModalEducacion').modal('show');
            }
        },
        error: function (xhr, status, error) {
            console.error("Error al obtener los datos: ", error);
        }
    });
});

$(document).on('click', '.eliminar-icono', function () {
    var id = $(this).data('id');
    var idInfoEmpleado = $('.card-container').data('info-empleado');

    $.ajax({
        url: '/Home/EliminarEducacion',
        type: 'POST',
        data: { Id_Info_Empleado: idInfoEmpleado, id: id },
        success: function (response) {
            if (!response.success) {
                alert(response.message);
            } else {
                $('.educacion1_container[data-id="' + id + '"]').remove();
                
                if ($('.educacion1_container').length === 0) {
                    $('#listaEducacionContainer').html(`
                        <div class="educacion-container">
                            <div class="icon-container">
                                <i class="fa-solid fa-graduation-cap icon-educacion"></i>
                            </div>
                            <a data-bs-toggle="modal" data-bs-target="#ModalEducacion">
                                <img class="img_educacion" src="../img/componente/educacion.png" alt="Educación">
                            </a>
                        </div>
                    `);
                }
            }
        },
        error: function (xhr, status, error) {
            console.error("Error al eliminar la educación: ", error);
        }
    });
});


$(document).on('click', '.mas-icono', function () {
    $('#ModalEducacionForm').find('input[type="text"], input[type="hidden"], select').val('');
    $('#ModalEducacionForm').find('textarea').val('');
    $('#ModalEducacion').modal('show');
});



//ADAPTACION
$(document).on('click', '.editar-icono-adaptacion', function () {
    var id = $(this).data('id');

    $.ajax({
        url: '/Home/ObtenerDatosAdaptacion/' + id,
        type: 'GET',
        success: function (response) {
            if (response.success === false) {
                alert(response.message);
            } else {
                console.log("ID obtenido: ", response.id); 
                $('input[name="id"]').val(response.id); 
                $('input[name="nombre"]').val(response.nombre);
                $('#ModalAdaptacion').modal('show');
            }
        },
        error: function (xhr, status, error) {
            console.error("Error al obtener los datos: ", error);
        }
    });
});

    $(document).on('click', '.eliminar-icono-adaptacion', function () {
        var id = $(this).data('id');
    
        $.ajax({
            url: '/Home/EliminarAdaptacion/' + id,
            type: 'POST',  
            success: function (response) {
                if (!response.success) {
                    alert(response.message);
                } else {
                    // Elimina el contenedor de la educación del DOM
                    $('.adaptacion1_container[data-id="' + id + '"]').remove();
    
                    // Verifica si quedan elementos de educación
                    if ($('.adaptacion1_container').length === 0) {
                        var noEducacionHtml = `
                            <div class="adaptacion-container">
                        <div class="icon-container">
                            <i class="fa-solid fa-person-walking-with-cane icon-educacion"></i>
                            <i class="fa-solid fa-wheelchair icon-educacion" style="margin-left: 10px;"></i>
                        </div>
                        <a data-bs-toggle="modal" data-bs-target="#ModalAdaptacion">
                                <img class="img_adaptacion" src="../img/componente/adaptacion.jpg" alt="Adaptación">
                            </a>
                    </div>
`;
                        $('#AdaptacionContainer').html(noEducacionHtml);
                    }
                }
            },
            error: function (xhr, status, error) {
                console.error("Error al eliminar la adaptación: ", error);
            }
        });
    });


//CUD
$(document).on('click', '.editar-icono-cud', function () {
    var id = $(this).data('id');

    $.ajax({
        url: '/Home/ObtenerDatosCUD/' + id,
        type: 'GET',
        success: function (response) {
            if (response.success === false) {
                alert(response.message);
            } else {
                console.log("ID obtenido: ", response.id); 
                $('input[name="id"]').val(response.id); 
                $('input[name="empresa_emisora"]').val(response.empresa_emisora); 
                $('input[name="fecha_expedicion"]').val(response.fecha_expedicion);
                $('input[name="fecha_vencimiento"]').val(response.fecha_vencimiento);
                $('input[name="url_"]').val(response.url_)
                $('#ModalCUD').modal('show');
            }
        },
        error: function (xhr, status, error) {
            console.error("Error al obtener los datos: ", error);
        }
    });
});



   
    $(document).on('click', '.eliminar-icono-cud', function () {
        var id = $(this).data('id');
        $.ajax({
            url: '/Home/EliminarCUD/' + id,
            type: 'POST',  
            success: function (response) {
                if (!response.success) {
                    alert(response.message);
                } else {
                    // Elimina el contenedor de la educación del DOM
                    console.log("Idelimiando",id);
                    $('.cud1_container[data-id="' + id + '"]').remove();
    
                    // Verifica si quedan elementos de educación
                    if ($('.cud1_container').length === 0) {
                        var noEducacionHtml = `
                            <div class="cud-container">
                                    <div class="icon-container">
                                        <i class="fa-solid fa-stamp icon-educacion"></i>
                                    </div>
                                    <a data-bs-toggle="modal" data-bs-target="#ModalCUD">
                                        <img class="img_adaptacion" src="../img/componente/adaptacion.jpg" alt="Adaptación">
                                    </a>
                                </div> 
`;
                        $('#CUDContainer').html(noEducacionHtml);
                    }
                }
            },
            error: function (xhr, status, error) {
                console.error("Error al eliminar el CUD: ", error);
            }
        });
    });
    $(document).on('click', '.eliminar-icono', function () {
    var id = $(this).data('id');
    var idInfoEmpleado = $('.card-container').data('info-empleado');

    $.ajax({
        url: '/Home/EliminarEducacion',
        type: 'POST',
        data: { Id_Info_Empleado: idInfoEmpleado, id: id },
        success: function (response) {
            if (!response.success) {
                alert(response.message);
            } else {
                $('.educacion1_container[data-id="' + id + '"]').remove();
                
                if ($('.educacion1_container').length === 0) {
                    $('#listaEducacionContainer').html(`
                        <div class="educacion-container">
                            <div class="icon-container">
                                <i class="fa-solid fa-graduation-cap icon-educacion"></i>
                            </div>
                            <a data-bs-toggle="modal" data-bs-target="#ModalEducacion">
                                <img class="img_educacion" src="../img/componente/educacion.png" alt="Educación">
                            </a>
                        </div>
                    `);
                }
            }
        },
        error: function (xhr, status, error) {
            console.error("Error al eliminar la educación: ", error);
        }
    });
});

//CERTIFICACION
$(document).on('click', '.editar-icono-certificacion', function () {
    var id = $(this).data('id');

    $.ajax({
        url: '/Home/ObtenerDatosCertificacion/' + id,
        type: 'GET',
        success: function (response) {
            if (response.success === false) {
                alert(response.message);
            } else {
                console.log("ID obtenido: ", response.id); 
                $('input[name="id"]').val(response.id); 
                $('input[name="titulo"]').val(response.titulo);
                $('input[name="empresa_emisora"]').val(response.empresa_emisora);
                $('input[name="id_credencial"]').val(response.id_credencial);
                $('input[name="url_credencial"]').val(response.url_credencial);
                $('input[name="fecha_caducidad"]').val(response.fecha_caducidad);
                $('input[name="fecha_expedicion"]').val(response.fecha_expedicion);
                $('#modal_certificaciones').modal('show');
            }
        },
        error: function (xhr, status, error) {
            console.error("Error al obtener los datos: ", error);
        }
    });
});



$(document).on('click', '.eliminar-icono-certificacion', function () {
    var id = $(this).data('id'); // Obtener el ID del elemento que se clicó
    var idInfoEmpleado = $('.card-container').data('info-empleado');
    console.log("ID Eliminar Certificación: ", id); // Para depuración
        $.ajax({
            url: '/Home/EliminarCertificacion/',
            type: 'POST',  
            data: { Id_Info_Empleado: idInfoEmpleado, id: id },
            success: function (response) {
                if (!response.success) {
                    alert(response.message);
                } else {
                    // Remover el contenedor de la certificación
                    $('.certificacion1_container[data-id="' + id + '"]').remove();
                    
                    // Verificar si no hay más certificaciones
                    if ($('.certificacion1_container').length === 0) {
                        $('#listaCertificacionContainer').html(noEducacionHtml);
                    }
                }
            },
            error: function (xhr, status, error) {
                console.error("Error al eliminar la certificación: ", error);
            }
        });
    
});



$(document).on('click', '.mas-icono-certificacion', function () {
    $('#ModalCertificadoForm').find('input[type="text"], input[type="hidden"], select').val('');
    $('#ModalCertificadoForm').find('textarea').val('');
    $('#modal_certificaciones').modal('show');
});

//IDIOMA
$(document).on('click', '.editar-icono-idioma', function () {
    var id = $(this).data('id');

    $.ajax({
        url: '/Home/ObtenerDatosIdioma/' + id,
        type: 'GET',
        success: function (response) {
            if (response.success === false) {
                alert(response.message);
            } else {
                console.log("ID obtenido: ", response.id); 
                $('input[name="id"]').val(response.id); 
                $('input[name="nombre"]').val(response.nombre);
                $('#ModalIdioma').modal('show');
            }
        },
        error: function (xhr, status, error) {
            console.error("Error al obtener los datos: ", error);
        }
    });
});



$(document).on('click', '.eliminar-icono-idioma', function () {
    var id = $(this).data('id');

    $.ajax({
        url: '/Home/EliminarIdioma/' + id,
        type: 'POST',
        success: function (response) {
            if (!response.success) {
                alert(response.message);
            } else {
                // Elimina el contenedor de la educación del DOM
                $('.idioma1_container[data-id="' + id + '"]').remove();

                // Verifica si quedan elementos de educación
                if ($('.idioma1_container').length === 0) {
                    $('#IdiomaContainer').html(noEducacionHtml);
                }
            }
        },
        error: function (xhr, status, error) {
            console.error("Error al eliminar el idioma: ", error);
        }
    });
});


function AgregarIdioma()
{
    
    
    var idInfoEmpleado = $("#id_info_empleado").val(); // Asigna el valor manualmente
    var nombreIdioma = $("#nombreIdioma").val(); // Asigna el valor manualmente
    
    console.log("ID Info Empleado: ", idInfoEmpleado);
  
    $.ajax({
        url: '/Home/InsertarIdioma/', 
        type: 'POST',
        data: {idEmpleado: idInfoEmpleado, nombre: nombreIdioma },
        success: function(response) {
           let textohtml = '<div class="idioma1_container" data-id="' + response.ididioma + '">';
           textohtml += '<div class="header_adaptacion"><i class="fa-solid fa-comments"></i><div class="titulo_adaptacion">IDIOMA';
           textohtml += '<div class="descripcion_adaptacion">' + nombreIdioma + '</div>';
           textohtml += '</div>';
           textohtml += '<i class="fa-solid fa-edit editar-icono-idioma" data-id="' + response.ididioma + '"></i>';
           textohtml += '<i class="fa-solid fa-trash eliminar-icono-idioma" data-id="' + response.ididioma +'"></i></div></div>';
           $("#IdiomaContainer").html(textohtml);
           $('#ModalIdioma').modal('hide');
        },
        error: function(error) {
            console.log("Error: ", error);
        }
    });
};

//SUGERENCIAS IDIOMAS
const sugerenciasIdioma = [
    "Inglés",
    "Español",
    "Francés",
    "Alemán",
    "Italiano",
    "Portugués",
    "Chino",
    "Japonés",
    "Ruso"
];

function mostrarSugerenciasIdioma() {
    const input = document.getElementById('nombreIdioma');
    const sugerenciasContainer = document.getElementById('sugerencias-container-idioma');
    sugerenciasContainer.innerHTML = '';

    const valor = input.value.split(/[,|-]/).pop().trim().toLowerCase();
    if (valor) {
        const sugerenciasFiltradas = sugerenciasIdioma.filter(sugerencia => 
            sugerencia.toLowerCase().includes(valor)
        );

        sugerenciasFiltradas.forEach(sugerencia => {
            const div = document.createElement('div');
            div.classList.add('sugerencia');
            div.textContent = sugerencia;
            div.onclick = () => {
                agregarSugerenciaIdioma(sugerencia);
                sugerenciasContainer.innerHTML = '';
            };
            sugerenciasContainer.appendChild(div);
        });
    }
}

function agregarSugerenciaIdioma(sugerencia) {
    const input = document.getElementById('nombreIdioma');
    const valoresActuales = input.value.split(/[,|-]/);
    valoresActuales.pop(); 
    valoresActuales.push(sugerencia); 
    input.value = valoresActuales.join(', ') + ', ';
    if (input.value.endsWith(', ')) { input.value = input.value.slice(0, -2);
}}

//SUGERENCIAS ADAPTACIONES
const sugerenciasAdaptacion = [
    "Acceso a rampas",
    "Material en braille",
    "Intérprete de lenguaje de señas",
    "Software de lectura de pantalla",
    "Asistencia personal",
    "Rampa",
    "Baño adaptado a sillas de ruedas"
];

function mostrarSugerenciasAdaptacion() {
    const input = document.getElementById('nombreAdaptacion');
    const sugerenciasContainer = document.getElementById('sugerencias-container-adaptacion');
    sugerenciasContainer.innerHTML = '';

    const valor = input.value.split(/[,|-]/).pop().trim().toLowerCase();
    if (valor) {
        const sugerenciasFiltradas = sugerenciasAdaptacion.filter(sugerencia => 
            sugerencia.toLowerCase().includes(valor)
        );

        sugerenciasFiltradas.forEach(sugerencia => {
            const div = document.createElement('div');
            div.classList.add('sugerencia');
            div.textContent = sugerencia;
            div.onclick = () => {
                agregarSugerenciaAdaptacion(sugerencia);
                sugerenciasContainer.innerHTML = '';
            };
            sugerenciasContainer.appendChild(div);
        });
    }
}

function agregarSugerenciaAdaptacion(sugerencia) {
    const input = document.getElementById('nombreAdaptacion');
    const valoresActuales = input.value.split(/[,|-]/);
    valoresActuales.pop(); 
    valoresActuales.push(sugerencia); 
    input.value = valoresActuales.join(', ') + ', ';
    if (input.value.endsWith(', ')) { input.value = input.value.slice(0, -2);
}}

function AgregarAdaptacion()
{
    var idInfoEmpleado = $("#id_info_empleado").val(); 
    var nombreAdaptacion = $("#nombreAdaptacion").val(); 
    console.log("NOMBRE ADAPTACION", nombreAdaptacion);
    console.log("ID Info Empleado: ", idInfoEmpleado);

    $.ajax({
        url: '/Home/InsertarAdaptacion/', 
        type: 'POST',
        data: {nombre:nombreAdaptacion, idEmpleado:idInfoEmpleado },
        success: function(response) {
            var textohtml = '<div class="adaptacion1_container" data-id="' + response.idadaptacion + '">';
            textohtml += '<div class="header_adaptacion">';
            textohtml += '<img src="../img/componente/icono.png" alt="icono" class="icono-adaptacion-img">';
            textohtml += '<div class="titulo_adaptacion">NECESIDADES DE ADAPTACIÓN';
            textohtml += '<div class="descripcion_adaptacion">' + nombreAdaptacion + '</div>';
            textohtml += '</div>';
            textohtml += '<i class="fa-solid fa-edit editar-icono-adaptacion" data-id="' + response.idadaptacion + '"></i>';
            textohtml += '<i class="fa-solid fa-trash eliminar-icono-adaptacion" data-id="' + response.idadaptacion + '"></i>';
            textohtml += '</div>';
            textohtml += '</div>';
            $("#AdaptacionContainer").html(textohtml);
            $('#ModalAdaptacion').modal('hide');
        },
        error: function(error) {
            console.log("Error: ", error);
        }
    });
};


function openCamera() {
    if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
        navigator.mediaDevices.getUserMedia({ video: true })
            .then(function(stream) {
                const video = document.getElementById('cameraPreview');
                video.style.display = 'block';
                video.srcObject = stream;

                // Botón para tomar la foto
                const button = document.createElement('button');
                button.textContent = 'Capturar Foto';
                button.onclick = function() {
                    captureImage(stream);
                };
                document.getElementById("CambiarFoto").appendChild(button);
            })
            .catch(function(err) {
                console.log("Error al acceder a la cámara: " + err);
            });
    } else {
        alert('Tu navegador no soporta el acceso a la cámara.');
    }
}


function captureImage(stream) {
    const video = document.getElementById('cameraPreview');
    const canvas = document.getElementById('canvas');
    const context = canvas.getContext('2d');
    canvas.width = video.videoWidth;
    canvas.height = video.videoHeight;
    context.drawImage(video, 0, 0, canvas.width, canvas.height);
    const image = canvas.toDataURL('image/png');
    const preview = document.getElementById('fotoVistaPrevia');
    preview.src = image;
    preview.style.display = 'block';

    // Detener el flujo de la cámara
    const tracks = stream.getTracks();
    tracks.forEach(track => track.stop());

    // Ocultar el video después de tomar la foto
    video.style.display = 'none';

    // Convertir la imagen base64 a un Blob
    const byteCharacters = atob(image.split(',')[1]);
    const byteArray = new Uint8Array(byteCharacters.length);
    for (let i = 0; i < byteCharacters.length; i++) {
        byteArray[i] = byteCharacters.charCodeAt(i);
    }
    const blob = new Blob([byteArray], { type: 'image/png' });

    // Crear un archivo (File) con el Blob, necesario para enviarlo con el formulario
    const file = new File([blob], 'foto_perfil.png', { type: 'image/png' });

    // Asignar el archivo al input de tipo file
    const inputFile = document.getElementById('fotoPerfil');
    const dataTransfer = new DataTransfer();
    dataTransfer.items.add(file);
    inputFile.files = dataTransfer.files;
}


// Función para mostrar la vista previa de la imagen seleccionada desde la galería
function previewImage(event) {
    const file = event.target.files[0];
    const reader = new FileReader();
    
    reader.onload = function() {
        const preview = document.getElementById('fotoVistaPrevia');
        preview.src = reader.result;
        preview.style.display = 'block'; 
    };
    
    if (file) {
        reader.readAsDataURL(file);
    }
}



document.addEventListener('DOMContentLoaded', function() {
    console.log("DOM fully loaded and parsed");
    const form = document.getElementById("form_register");
    
    if (form) {
        console.log("Form found");
        form.addEventListener("submit", function (event) {
            event.preventDefault(); 
            const email = document.getElementById("email").value;
            const password = document.getElementById("password").value;
            const confirmPassword = document.getElementById("confirm-password").value;

            let valid = true;

            // Validar el correo electrónico
            if (!validateEmail(email)) {
                document.getElementById("emailError").textContent = "Por favor, introduce un correo electrónico válido.";
                valid = false;
            } else {
                document.getElementById("emailError").textContent = "";
            }

            // Validar la contraseña
            if (!validatePassword(password)) {
                document.getElementById("passwordError").textContent = "La contraseña debe tener al menos 8 caracteres, incluyendo una letra mayúscula y un carácter especial.";
                valid = false;
            } else {
                document.getElementById("passwordError").textContent = "";
            }

            // Validar que las contraseñas coincidan
            if (password !== confirmPassword) {
                document.getElementById("confirmPasswordError").textContent = "Las contraseñas no coinciden. Por favor, verifica.";
                valid = false;
            } else {
                document.getElementById("confirmPasswordError").textContent = "";
            }

            if (valid) {
                this.submit(); 
            }
        });

        document.querySelectorAll(".password-toggle").forEach(toggle => {
            toggle.addEventListener("click", function() {
                const target = document.getElementById(this.getAttribute("data-toggle-target"));
                const type = target.getAttribute("type") === "password" ? "text" : "password";
                target.setAttribute("type", type);
                this.querySelector("p").textContent = type === "password" ? "Mostrar" : "Ocultar";
            });
        });

        // Validar MAIL
        function validateEmail(email) {
            const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;  
            return re.test(String(email).toLowerCase());
        }

        // Validar contraseña 
        function validatePassword(password) {
            const re = /^(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}$/;  
            return re.test(password);
        }
    } else {
        console.log("Form not found");
    }
});
//VISUALIZAR CONTRASEÑAS 
document.getElementById('toggle-password').addEventListener('click', function () {
    const passwordField = document.getElementById('password');
    const passwordToggle = document.getElementById('toggle-password').querySelector('i');

    if (passwordField.type === 'password') {
        passwordField.type = 'text';
        passwordToggle.classList.remove('fa-eye');
        passwordToggle.classList.add('fa-eye-slash');
    } else {
        passwordField.type = 'password';
        passwordToggle.classList.remove('fa-eye-slash');
        passwordToggle.classList.add('fa-eye');
    }
});

function togglePasswordVisibility(toggleId, inputId) {
    const passwordField = document.getElementById(inputId);
    const passwordToggle = document.getElementById(toggleId).querySelector('p');

    console.log(passwordField, passwordToggle); // Verifica los elementos

    if (passwordField.type === 'password') {
        passwordField.type = 'text';
        passwordToggle.textContent = "Ocultar";
    } else {
        passwordField.type = 'password';
        passwordToggle.textContent = "Mostrar";
    }
}

/************************/
function AgregarCud() {
    var idInfoEmpleado = $("#id_info_empleado").val(); 
    console.log(idInfoEmpleado);
    var EmpresaEmisora = $("#empresa_emisora").val();
    console.log("empresa", EmpresaEmisora);
    var fechaexpedicion = $("#fecha_expedicion").val();  
    console.log("FECHA", fechaexpedicion);
    var fechavencimiento = $("#fecha_vencimiento").val();  
    var myfile = $("#myfile")[0].files[0];  

    if (!myfile) {
        console.log("No file selected.");
        return;
    }

    var formData = new FormData(document.getElementById("ModalCudForm"));
    console.log(formData);
    $.ajax({
        url: '/Home/InsertarCUD/',
        type: 'POST',
        data: formData,
        processData: false,  // No procesar los datos
        contentType: false,
        success: function(response) {
            $("#CUDContainer").empty();
            var textohtml = '<div class="cud1_container" data-id="' + response.idcud + '">';
            textohtml += '<div class="header_adaptacion">';
            textohtml += '<img src="../img/componente/CUD.png" alt="icono" class="icono-adaptacion-img">';
            textohtml += '<div class="titulo_adaptacion">CERTIFICADO ÚNICO DE DISCAPACIDAD (CUD)';
            textohtml += '<div class="fecha_educacion">Expedición: ' + fechaexpedicion + '</div>';
            textohtml += '</div>';
            textohtml += '<i class="fa-solid fa-edit editar-icono-cud" data-id="' + response.idcud + '"></i>';
            textohtml += '<i class="fa-solid fa-trash eliminar-icono-cud" data-id="' + response.idcud + '" onclick="BorrarVoz(\'cud\')"></i>';
            textohtml += '</div>';
            textohtml += '<div class="descargar-archivo" data-id="' + response.idcud + '">';
            textohtml += '<a href="' + response.myfileUrl + '" download class="btn btn-success descargar" style="background-color: #21554d; border-color: #21554d; margin-top:10px">';
            textohtml += '<i class="fa-solid fa-download"></i> Descargar CUD';
            textohtml += '</a>';
            textohtml += '</div>';
            textohtml += '</div>';
                
                $("#CUDContainer").append(textohtml);
                $('#ModalCUD').modal('hide'); 
            },
        error: function(error) {
            console.log("Error: ", error);
        }
    });
}
