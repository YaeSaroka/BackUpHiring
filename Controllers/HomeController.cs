using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Hiring.Models;
using System.IO;
using Microsoft.AspNetCore.Hosting;
using System.Web;

namespace Hiring.Controllers;

public class HomeController : Controller
{
    private IWebHostEnvironment Environment;


    public HomeController(IWebHostEnvironment environment)
    {
        Environment= environment;
    }


    public IActionResult Index()
    {
        return View();
    }
      
    public IActionResult Privacy()
    {
        return View();
    }
   
   public IActionResult Registro()
    {
        return View();
    }
   public IActionResult Login()
    {
        return View();
    }
    public IActionResult PerfilLee(int id)
    {
       return View();
    }

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }

    /*REGISTROS Y VERIFICACIONES DE LOGIN*/

    [HttpPost]
    public IActionResult Login(string Mail , string Contraseña)
    {
        List<string> UrlMultimedia = new List<string>(); 
        Usuario usuario = Models.BD.Login(Mail,Contraseña); 
        if (usuario == null )
        {
            ViewBag.MensajeError = "Usuario o Contraseña Incorrecto";
            return View("Index");
        }
        else if (usuario.id_discapacidad == 1)
        {
            Informacion_Personal_Empleado perfil= Models.BD.CargarPerfilLogin(usuario.id);
            ViewBag.UrlMultimedia=Models.BD.SelectMultimedia(usuario.id);
            ViewBag.Lista_educacion = Models.BD.SelectEducacion(usuario.id);
            ViewBag.Adaptacion = Models.BD.SelectAdaptacion(usuario.id);
            ViewBag.cud = Models.BD.SelectCUD(usuario.id);
            ViewBag.Lista_Certificacion = Models.BD.SelectCertificacion(usuario.id);
            ViewBag.idioma = Models.BD.SelectIdioma(usuario.id);
            return View("PerfilLee", perfil);
        }
        else  {
            Informacion_Personal_Empleado perfil= Models.BD.CargarPerfilLogin(usuario.id);
            return View("PerfilNoLee", perfil);
        }
    }
    [HttpPost]
    public IActionResult RegistrarUsuario(Usuario user){
        const string estilo= "#ABE7DD", foto_perfil="../img/default/foto_Default.png", encabezado="encabezado.png", nombre_apellido = "Tu nombre", telefono = "", mail="";
        Usuario userr = BD.Registro_VerificarExistencia(user.mail);
        if(userr == null)
        {
            Models.BD.Registro(user.mail, user.contraseña, user.id_discapacidad);
            userr = Models.BD.Registro_VerificarExistencia(user.mail);
            if(user.id_discapacidad==1) 
            {
                Models.BD.CargaPerfilDefault(userr,estilo, foto_perfil, encabezado, nombre_apellido, telefono, mail);
                Informacion_Personal_Empleado perfil= Models.BD.CargarPerfilLogin(userr.id);
                return View("PerfilLee", perfil);
            }
            else return View("PerfilNoLee");
        }
        else
        {
            ViewBag.MSJError= "El usuario ya existe!";
            return View("Registro");
        }
    }

    public IActionResult OlvideContrasena(string Mail)
    {
        string contraseña = BD.OlvideMiContraseña(Mail);
        if(contraseña == null || contraseña == "") {
            ViewBag.MensajeInexistente = "No existe el mail ingresado anteriormente";
            return View("OlvideContrasena");
        }
        else
        {
            ViewBag.ContraseñaRecordada = contraseña;
            return View("OlvideContrasena");
        }
    }
 
 //PERFIL NO LEE
   [HttpPost]
   public bool InsertarUsuario(int id, string nombre, string mail, string telefono, string acerca, string profesion, string estilo, string ubicacion)
    {
        Informacion_Personal_Empleado usuario = new Informacion_Personal_Empleado
        {
            id = id,
            nombre_apellido = nombre,
            mail = mail,
            telefono = telefono,
            acerca_de_mi = acerca,
            profesion_actual = profesion,
            estilo = estilo,
            ubicacion = ubicacion
        };
            Models.BD.InsertarInformacionPersonalEmpleado1(usuario);
            Models.BD.InsertarInformacionPersonalEmpleado2(usuario);
        // Insertar en la BD los datos
        return true;
    }
    public bool GuardarEduNoLee(string Titulo, string Institucion, string Disciplina, string Actividades, string Descripcion, string AnoInicio, string MesInicio, string AnoFinal, string MesFinal, int id, Educacion edu){
        Educacion educacion_ = new Educacion
            {
                titulo = Titulo,
                nombre_institucion = Institucion,
                disciplina_academica = Disciplina,
                actividades_grupo = Actividades,
                descripcion = Descripcion,
                mes_expedicion = MesInicio,
                mes_caducidad = MesFinal,
                fecha_expedicion = AnoInicio,
                fecha_caducidad = AnoFinal
            };
        if(edu == null){
            Models.BD.InsertarEducacion(educacion_, id);
        } else if(edu != null) Models.BD.ActualizarEducacion(educacion_, id);
    
        return true;
    }
    public bool GuardarCerti(
    string titulo_, string empresaEmisora, DateTime fechaExp, DateTime fechaCaducidad,
    int id_user, int idCredencial, int id_cert_)
{
    var certificacion = new Certificacion
    {
        titulo = titulo_,
        empresa_emisora = empresaEmisora,
        fecha_expedicion = fechaExp,
        fecha_caducidad = fechaCaducidad,
        id_info_empleado = id_user,
        id_credencial = idCredencial,
        id = id_cert_
    };

    Models.BD.InsertarCertificaciones(certificacion, id_user, id_cert_);
    return true;
}
public bool GuardarNece(int id_, string necesidad, int id_nece){
    Necesidad necesidad_ = new Necesidad 
    {
        id = id_nece,
        nombre = necesidad,
        id_info_empleado = id_
    };
    var Nece = Models.BD.SelectAdaptacion(id_);
    if(Nece == null) Models.BD.InsertarAdaptacion(necesidad_, id_);
    else Models.BD.ActualizarAdaptacion(id_nece, necesidad);
    
return true; 
}
public bool GuardarCUD(int id_, string institucion_emisora, DateTime expe, DateTime caducidad, int id_cud_){
    Cud certificado = new Cud {
        empresa_emisora = institucion_emisora,
        fecha_expedicion = expe,
        fecha_vencimiento = caducidad,
        id_info_empleado = id_,
        id = id_cud_
    };
    var Cud_ = Models.BD.SelectCUD(id_);
    if(Cud_ == null) Models.BD.InsertarCUD(certificado);
    else {
        Models.BD.ActualizarCUD(id_cud_, institucion_emisora, expe, caducidad);
    }
    return true;
}


public JsonResult VerificarVacio(int sector, int id)
{
    Informacion_Personal_Empleado datos_ = null;
    List<Educacion> datos_2 = null;
    List<Certificacion> datos_3 = null;
    Necesidad datos_4 = null;
    Cud datos_5 = null;
    string mensaje = "No se encontraron datos de "; // Predeterminado

    // Cargar los datos según el sector
    if (sector == 1)
        datos_ = Models.BD.CargarPerfilLogin(id);  // Información personal
    else if (sector == 2)
        datos_2 = Models.BD.SelectEducacion(id); // Educación
    else if (sector == 3)
        datos_3 = Models.BD.SelectCertificacion(id);
    else if (sector == 4)
        datos_4 = Models.BD.SelectAdaptacion(id);
    else if (sector == 5)
        datos_5 = Models.BD.SelectCUD(id);
    if (sector == 1 && datos_ == null)
        mensaje += " Información Personal ingresados!";
    else if (sector == 2 && (datos_2 == null || !datos_2.Any()))
        mensaje += " Educación ingresados!";
    else if (sector == 3 && (datos_3 == null || !datos_3.Any()))
        mensaje += " Certificacion!";
    else if(sector == 4 && (datos_4 == null))
        mensaje += " Necesidades";
    else if(sector == 5 && (datos_5 == null))
        mensaje += " CUD";
        

    // Verificar los campos faltantes de Información Personal (sector 1)
    else if (sector == 1 && datos_ != null)
    {
        List<string> camposFaltantes = new List<string>();
        var propiedades = datos_.GetType().GetProperties();
        foreach (var propiedad in propiedades)
        {
            var valor = propiedad.GetValue(datos_);
            if (valor == null || string.IsNullOrEmpty(valor.ToString()))
            {
                camposFaltantes.Add(propiedad.Name); 
            }
        }

        if (camposFaltantes.Count > 0)
            mensaje = "Faltan datos por ingresar en Información Personal (" + string.Join(", ", camposFaltantes) + ")";
        else
            mensaje = "Todos los datos de Información Personal están completos.";
    }
    else if (sector == 2 && datos_2 != null && datos_2.Any())
    {
        HashSet<string> camposFaltantesSet = new HashSet<string>(); // Usamos HashSet para evitar duplicados

        foreach (var educacion in datos_2)
        {
            var propiedades = educacion.GetType().GetProperties();
            foreach (var propiedad in propiedades)
            {
                var valor = propiedad.GetValue(educacion);
                if (valor == null || string.IsNullOrEmpty(valor.ToString()))
                {
                    camposFaltantesSet.Add(propiedad.Name); 
                }
            }
        }

        if (camposFaltantesSet.Count > 0)
            mensaje = "Faltan datos por ingresar en Educación (" + string.Join(", ", camposFaltantesSet) + ")";
        else
            mensaje = "Todos los datos de Educación están completos.";
    }
    else if(sector == 3 && datos_3 != null && datos_3.Any()){
        HashSet<string> camposFaltantesSet = new HashSet<string>();

        foreach (var certificacion in datos_3)
        {
            var propiedades = certificacion.GetType().GetProperties();
            foreach (var propiedad in propiedades)
            {
                var valor = propiedad.GetValue(certificacion);
                if (valor == null || string.IsNullOrEmpty(valor.ToString()))
                {
                    camposFaltantesSet.Add(propiedad.Name); 
                }
            }
        }
        if (camposFaltantesSet.Count > 0)
            mensaje = "Faltan datos por ingresar en Certificacion (" + string.Join(", ", camposFaltantesSet) + ")";
        else
            mensaje = "Todos los datos de Certificaion están completos.";
    }
    else if(sector == 4 && datos_4 != null){
        List<string> camposFaltantes = new List<string>();
        if(datos_4.nombre == null){
             camposFaltantes.Add(datos_4.nombre); 
        }
        if (camposFaltantes.Count > 0)
            mensaje = "Faltan datos por ingresar en Necesidad (" + string.Join(", ", camposFaltantes) + ")";
        else
            mensaje = "Todos los datos de Necesidad están completos.";
    }
     else if (sector == 5 && datos_5 != null)
{
    List<string> camposFaltantes = new List<string>();
    var propiedades = datos_5.GetType().GetProperties();
    foreach (var propiedad in propiedades)
    {
        var valor = propiedad.GetValue(datos_5);
        if ((valor == null || string.IsNullOrEmpty(valor.ToString())) && 
            !propiedad.Name.Equals("titulo", StringComparison.OrdinalIgnoreCase) && 
            !propiedad.Name.Equals("url_", StringComparison.OrdinalIgnoreCase))
        {
            camposFaltantes.Add(propiedad.Name); 
        }
    }

    if (camposFaltantes.Count > 0)
        mensaje = "Faltan datos por ingresar en CUD (" + string.Join(", ", camposFaltantes) + ")";
    else
        mensaje = "Todos los datos de CUD están completos.";
}


    if (sector == 1) return Json(new { mensaje = mensaje, datos = datos_ });
    else if (sector == 2 && datos_2 != null && datos_2.Any())
    {
        var educacionData = datos_2.First();  
        return Json(new
        {
            mensaje = mensaje,
            datos = new
            {
                titulo = educacionData.titulo,
                institucion = educacionData.nombre_institucion,
                disciplina = educacionData.disciplina_academica,
                actividad_grupo = educacionData.actividades_grupo,
                descripcion = educacionData.descripcion,
                ano_inicio = educacionData.fecha_expedicion,
                mes_inicio = educacionData.mes_expedicion,
                ano_fin = educacionData.fecha_caducidad,
                mes_fin = educacionData.mes_caducidad
            }
        });
    }
    else if (sector == 3 && datos_3 != null && datos_3.Any())
{
    var certificacionData = datos_3.First();
    Console.WriteLine("Certificación obtenida: " + certificacionData.titulo); // Log
    return Json(new
    {
        mensaje = mensaje,
        datos = new
        {
            titulo = certificacionData.titulo,
            empresa = certificacionData.empresa_emisora,
            credencial = certificacionData.id_credencial,
            caducidad = certificacionData.fecha_caducidad,
            expedicion = certificacionData.fecha_expedicion,
            id = certificacionData.id_info_empleado,
            id_certi = certificacionData.id
        }
    });
}

    else if (sector == 4 && datos_4 != null) return Json(new {mensaje = mensaje, datos = datos_4});
    if (sector == 5) return Json(new { mensaje = mensaje, datos = datos_5 });
    
    return Json(new { mensaje, datos = (object)null });
}



 //INFO PERSONAL
    [HttpPost]
    public IActionResult InsertarInformacionPersonal1(Informacion_Personal_Empleado usuario)
    {
        Models.BD.InsertarInformacionPersonalEmpleado1(usuario);
        Informacion_Personal_Empleado perfil= Models.BD.CargarPerfilLogin(usuario.id);
        List<string> UrlMultimedia = new List<string>(); 
        ViewBag.UrlMultimedia=Models.BD.SelectMultimedia(usuario.id);
        ViewBag.Lista_educacion = Models.BD.SelectEducacion(usuario.id);
        ViewBag.Adaptacion = Models.BD.SelectAdaptacion(usuario.id);
        ViewBag.cud = Models.BD.SelectCUD(usuario.id);
        ViewBag.Lista_Certificacion = Models.BD.SelectCertificacion(usuario.id);
        ViewBag.idioma = Models.BD.SelectIdioma(usuario.id);
        return View("PerfilLee", perfil);
    }


    [HttpPost]
    public async Task<IActionResult> InsertarInformacionPersonal2(Informacion_Personal_Empleado usuario, IFormFile foto_perfil)
{
    if (foto_perfil != null && foto_perfil.Length > 0)
    {
        string fileName = Guid.NewGuid().ToString() + Path.GetExtension(foto_perfil.FileName);
        string ubicacion = Path.Combine(this.Environment.WebRootPath, "img", fileName);
        using (var stream = new FileStream(ubicacion, FileMode.Create))
        {
            await foto_perfil.CopyToAsync(stream);
        }
        usuario.foto_perfil = fileName;
    }
    Models.BD.InsertarInformacionPersonalEmpleado2(usuario);
    Informacion_Personal_Empleado perfil = Models.BD.CargarPerfilLogin(usuario.id);
    ViewBag.UrlMultimedia = Models.BD.SelectMultimedia(usuario.id);
    ViewBag.Lista_educacion = Models.BD.SelectEducacion(usuario.id);
    ViewBag.Adaptacion = Models.BD.SelectAdaptacion(usuario.id);
    ViewBag.cud = Models.BD.SelectCUD(usuario.id);
    ViewBag.Lista_Certificacion = Models.BD.SelectCertificacion(usuario.id);
    ViewBag.idioma = Models.BD.SelectIdioma(usuario.id);
    return View("PerfilLee", perfil);
}
//EDUCACION
    [HttpPost]
    public IActionResult InsertarEducacion(Educacion educacion, int Id_Info_Empleado, int id = 0)
{
    Console.WriteLine("ID Info Empleado recibido: " + Id_Info_Empleado); // Verifica que el valor sea el correcto
    if (Id_Info_Empleado == 0) {
        ViewBag.MensajeError = "ID del empleado no válido.";
        return RedirectToAction("PerfilLee");
    }
    var educacionExistente = Models.BD.SelectEducacion(Id_Info_Empleado);
    if (educacionExistente.Any(e => e.titulo == educacion.titulo && e.disciplina_academica == educacion.disciplina_academica && e.descripcion == educacion.descripcion)) 
    {
        ViewBag.MensajeError = "Esta educación ya fue añadida.";
        Informacion_Personal_Empleado perfil = Models.BD.CargarPerfilLogin(Id_Info_Empleado);
        ViewBag.Lista_educacion = educacionExistente;
        return View("PerfilLee", perfil);
    }
    Models.BD.InsertarEducacion(educacion, Id_Info_Empleado);
    List<Educacion> Lista_educacion = Models.BD.SelectEducacion(Id_Info_Empleado);
    ViewBag.Lista_educacion = Lista_educacion;
    ViewBag.UrlMultimedia = Models.BD.SelectMultimedia(Id_Info_Empleado);
    ViewBag.Adaptacion = Models.BD.SelectAdaptacion(Id_Info_Empleado);
    ViewBag.cud = Models.BD.SelectCUD(Id_Info_Empleado);
    ViewBag.Lista_Certificacion = Models.BD.SelectCertificacion(Id_Info_Empleado);
    ViewBag.idioma = Models.BD.SelectIdioma(Id_Info_Empleado);
    Informacion_Personal_Empleado perfilActualizado = Models.BD.CargarPerfilLogin(Id_Info_Empleado);

    return View("PerfilLee", perfilActualizado);
}

 public IActionResult EliminarEducacion(int Id_Info_Empleado, int id)
{
    if (Id_Info_Empleado == 0)
    {
        return Json(new { success = false, message = "Id_Info_Empleado no es válido." });
    }

    try
    {
        Models.BD.EliminarEducacion(id);
        List<Educacion> Lista_educacion = Models.BD.SelectEducacion(Id_Info_Empleado);
        ViewBag.Lista_educacion = Lista_educacion;
        Informacion_Personal_Empleado perfilActualizado = Models.BD.CargarPerfilLogin(Id_Info_Empleado);
        ViewBag.Lista_educacion = Models.BD.SelectEducacion(Id_Info_Empleado);
        ViewBag.Adaptacion = Models.BD.SelectAdaptacion(Id_Info_Empleado);
        ViewBag.cud = Models.BD.SelectCUD(Id_Info_Empleado);
        ViewBag.Lista_Certificacion = Models.BD.SelectCertificacion(Id_Info_Empleado);
        ViewBag.idioma = Models.BD.SelectIdioma(Id_Info_Empleado);
        return Json(new { success = true });
    }
    catch (Exception ex)
    {
        return Json(new { success = false, message = "No se pudo eliminar la educación." });
    }
}



    public JsonResult ObtenerDatosEducacion(int id)
    {
        var educacion = Models.BD.SelectEducacionIdCard(id);
        if (educacion == null)
        {
            return Json(new { success = false, message = "Educación no encontrada." });
        }
        return Json(new
        {
            success = true,
            id = educacion.id,
            titulo = educacion.titulo,
            nombre_institucion = educacion.nombre_institucion,
            disciplina_academica = educacion.disciplina_academica,
            actividades_grupo = educacion.actividades_grupo,
            descripcion = educacion.descripcion,
            fecha_expedicion = educacion.fecha_expedicion,
            fecha_caducidad = educacion.fecha_caducidad,
            mes_expedicion = educacion.mes_expedicion,
            mes_caducidad = educacion.mes_caducidad
        });
    }

    //MULTIMEDIA
    [HttpPost]
    public async Task<IActionResult> UploadFile(IFormFile file, int Id_Empleado)
    {
        if (file == null || file.Length == 0)
        {
            return Json(new { success = false, message = "No file uploaded." });
        }
        try
        {
            var uploads = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/uploads");
            string extension = Path.GetExtension(file.FileName).ToLower();
            string timeStamp = DateTimeOffset.UtcNow.ToUnixTimeSeconds().ToString() + extension;
            var filePath = Path.Combine(uploads, timeStamp);
            using (var stream = new FileStream(filePath, FileMode.Create))
            {
                await file.CopyToAsync(stream);
            }
            var fileUrl = Url.Content($"/uploads/{timeStamp}"); 
            BD.InsertarMultimedia(fileUrl, Id_Empleado);
            var UrlMultimedia = BD.SelectMultimedia(Id_Empleado);
            return Json(new { success = true, data = UrlMultimedia });
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
            return Json(new { success = false, message = ex.Message });
        }
    }
    [HttpPost]
    public JsonResult InsertarAdaptacion(string nombre, int idEmpleado)
    {
        int AdaptacionElegida =0;
        Necesidad adaptacionaBuscar = new Necesidad();
        adaptacionaBuscar.nombre= nombre;
        AdaptacionElegida = Models.BD.InsertarAdaptacion(adaptacionaBuscar, idEmpleado);
        return Json(new {success=true, idadaptacion=AdaptacionElegida});
    }
    public IActionResult EliminarAdaptacion(int Id_Info_Empleado, int id)
    {
        try
        {
            Models.BD.EliminarAdaptacion(id);
            Necesidad Adaptacion = Models.BD.SelectAdaptacion(Id_Info_Empleado);
            ViewBag.Adaptacion = Adaptacion;
            Informacion_Personal_Empleado perfilActualizado = Models.BD.CargarPerfilLogin(Id_Info_Empleado);
            ViewBag.UrlMultimedia=Models.BD.SelectMultimedia(id);
            ViewBag.Lista_educacion = Models.BD.SelectEducacion(id);
            ViewBag.Adaptacion = Models.BD.SelectAdaptacion(id);
            ViewBag.cud = Models.BD.SelectCUD(id);
            ViewBag.Lista_Certificacion = Models.BD.SelectCertificacion(id);
            ViewBag.idioma = Models.BD.SelectIdioma(Id_Info_Empleado);
            return Json(new { success = true });
        }
        catch (Exception ex)
        {
            return Json(new { success = false, message = "No se pudo eliminar la Adaptacion." });
        }
    }
    public JsonResult ObtenerDatosAdaptacion(int id)
    {
        var necesidad = Models.BD.SelectAdaptacionIdCard(id);
        if (necesidad == null)
        {
            return Json(new { success = false, message = "Adaptacion no encontrada." });
        }
        
        return Json(new
        {
            success = true,
            id = necesidad.id,
            nombre = necesidad.nombre
        });
    }
    //CUD
   [HttpPost]
public JsonResult InsertarCUD(int id_info_empleado, string empresa_emisora, DateTime fecha_expedicion, DateTime fecha_vencimiento, IFormFile myfile)
{
    int CudElegido = 0;
    Cud cudabuscar = new Cud
    {
        empresa_emisora = empresa_emisora,
        fecha_expedicion = fecha_expedicion,
        fecha_vencimiento = fecha_vencimiento,
        id_info_empleado = id_info_empleado
    };

    string myfileUrl = string.Empty;

    if (myfile != null && myfile.Length > 0)
    {
        string uploadsFolder = Path.Combine(this.Environment.ContentRootPath, "wwwroot/uploads");
        Directory.CreateDirectory(uploadsFolder);
        string filePath = Path.Combine(uploadsFolder, myfile.FileName);
        
        using (var stream = new FileStream(filePath, FileMode.Create))
        {
            myfile.CopyTo(stream);
        }
        
        cudabuscar.url_ = myfile.FileName;
        myfileUrl = "/uploads/" + myfile.FileName;
    }

    CudElegido = Models.BD.InsertarCUD(cudabuscar);

    return Json(new { success = true, idcud = CudElegido, myfileUrl = myfileUrl });
}


    public IActionResult EliminarCUD(int Id_Info_Empleado, int id)
    {
        try
        {
            Models.BD.EliminarCUD(id);
            Cud cud_ = Models.BD.SelectCUD(Id_Info_Empleado);
            ViewBag.cud = cud_;
            Informacion_Personal_Empleado perfilActualizado = Models.BD.CargarPerfilLogin(Id_Info_Empleado);
            ViewBag.UrlMultimedia=Models.BD.SelectMultimedia(id);
            ViewBag.Lista_educacion = Models.BD.SelectEducacion(id);
            ViewBag.Adaptacion = Models.BD.SelectAdaptacion(id);
            ViewBag.cud = Models.BD.SelectCUD(id);
            ViewBag.Lista_Certificacion = Models.BD.SelectCertificacion(id);
            ViewBag.idioma = Models.BD.SelectIdioma(Id_Info_Empleado);
            return Json(new { success = true });
        }
        catch (Exception ex)
        {
            return Json(new { success = false, message = "No se pudo eliminar el CUD." });
        }
    }
    public JsonResult ObtenerDatosCUD(int id)
    {
        var Cud = Models.BD.SelectCUDIdCard(id);
        if (Cud == null)
        {
            return Json(new { success = false, message = "CUD no encontrado." });
        }
        return Json(new
        {
            success = true,
            id = Cud.id,
            empresa_emisora= Cud.empresa_emisora,
            fecha_expedicion = Cud.fecha_expedicion,
            fecha_vencimiento = Cud.fecha_vencimiento,
            url_= Cud.url_
        });
    }
   
   
[HttpPost]
public JsonResult EliminarArchivo(int id)
{
    try
    {
        var fileUrl = BD.SelectURL(id); 
        if (string.IsNullOrEmpty(fileUrl) || !fileUrl.StartsWith("/wwwroot"))
        {
            return Json(new { success = false, message = "URL de archivo no válida." });
        }
        var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", fileUrl.TrimStart('/'));
        if (System.IO.File.Exists(filePath))
        {
            System.IO.File.Delete(filePath);
        }
        else
        {
            return Json(new { success = false, message = "El archivo no existe en el sistema." });
        }
        BD.EliminarMultimedia(id);
        var UrlMultimedia = BD.SelectMultimedia(id);
        return Json(new { success = true, data = UrlMultimedia });
    }
    catch (Exception ex)
    {
        Console.WriteLine($"Error: {ex.Message}");
        return Json(new { success = false, message = "Ocurrió un error al eliminar el archivo." });
    }
}


    //CERTIFICACIONES
    [HttpPost]
   public IActionResult InsertarCertificaciones(Certificacion certificacion, int Id_Info_Empleado, int id)
{
    var certificacionExistente = Models.BD.SelectCertificacion(Id_Info_Empleado);
    if (certificacionExistente.Any(c => c.titulo == certificacion.titulo && c.empresa_emisora == certificacion.empresa_emisora && c.id_credencial == certificacion.id_credencial && c.url_credencial == certificacion.url_credencial))
    {
        ViewBag.MensajeError = "Esta certificación ya fue añadida.";
        Informacion_Personal_Empleado perfil = Models.BD.CargarPerfilLogin(Id_Info_Empleado);
        ViewBag.Lista_Certificacion = certificacionExistente;
        return View("PerfilLee", perfil);
    }
    
    Models.BD.InsertarCertificaciones(certificacion, Id_Info_Empleado, id);
    List<Certificacion> Lista_Certificacion = Models.BD.SelectCertificacion(Id_Info_Empleado);
    ViewBag.Lista_Certificacion = Lista_Certificacion;
    Informacion_Personal_Empleado perfilActualizado = Models.BD.CargarPerfilLogin(Id_Info_Empleado);
    ViewBag.UrlMultimedia = Models.BD.SelectMultimedia(Id_Info_Empleado);
    ViewBag.Lista_educacion = Models.BD.SelectEducacion(Id_Info_Empleado);
    ViewBag.Adaptacion = Models.BD.SelectAdaptacion(Id_Info_Empleado);
    ViewBag.cud = Models.BD.SelectCUD(Id_Info_Empleado);
    ViewBag.idioma = Models.BD.SelectIdioma(Id_Info_Empleado);
    
    return View("PerfilLee", perfilActualizado);
}
   public IActionResult EliminarCertificacion(int Id_Info_Empleado, int id)
{
    if (Id_Info_Empleado == 0)
    {
        return Json(new { success = false, message = "Id_Info_Empleado no es válido." });
    }
    try
    {
        Models.BD.EliminarCertificacion(id);
        List<Certificacion> Lista_Certificacion = Models.BD.SelectCertificacion(Id_Info_Empleado);
        ViewBag.Lista_Certificacion = Lista_Certificacion;
        Informacion_Personal_Empleado perfilActualizado = Models.BD.CargarPerfilLogin(Id_Info_Empleado);
        ViewBag.Lista_educacion = Models.BD.SelectEducacion(Id_Info_Empleado);
        ViewBag.Adaptacion = Models.BD.SelectAdaptacion(Id_Info_Empleado);
        ViewBag.cud = Models.BD.SelectCUD(Id_Info_Empleado);
        ViewBag.idioma = Models.BD.SelectIdioma(Id_Info_Empleado);
        return Json(new { success = true });
    }
    catch (Exception ex)
    {
        return Json(new { success = false, message = "No se pudo eliminar la certificación." });
    }
}

        
    public JsonResult ObtenerDatosCertificacion(int id)
    {
        var certificacion = Models.BD.SelectCertificacionIdCard(id);
        if (certificacion == null)
        {
            return Json(new { success = false, message = "Certificacion no encontrada." });
        }
        return Json(new
        {
            success = true,
            id = certificacion.id,
            titulo = certificacion.titulo,
            empresa_emisora= certificacion.empresa_emisora,
            id_credencial= certificacion.id_credencial,
            url_credencial=certificacion.url_credencial,
            fecha_caducidad = certificacion.fecha_caducidad,
            fecha_expedicion = certificacion.fecha_expedicion
        });
    }

    //Idioma
    [HttpPost]
    public JsonResult InsertarIdioma(string nombre, int idEmpleado)
    {
        int IdiomaElegido =0;
        Idioma idiomaaBuscar = new Idioma{nombre=nombre};
        IdiomaElegido = Models.BD.InsertarIdioma(idiomaaBuscar, idEmpleado);

        return Json(new { success = true,  ididioma = IdiomaElegido});
    }
    public IActionResult EliminarIdioma(int Id_Info_Empleado, int id)
    {
        try
        {
            Models.BD.EliminarIdioma(id);
            Idioma idioma = Models.BD.SelectIdioma(Id_Info_Empleado);
            ViewBag.idioma = idioma;
            Informacion_Personal_Empleado perfilActualizado = Models.BD.CargarPerfilLogin(Id_Info_Empleado);
            ViewBag.UrlMultimedia=Models.BD.SelectMultimedia(id);
            ViewBag.Lista_educacion = Models.BD.SelectEducacion(id);
            ViewBag.Adaptacion = Models.BD.SelectAdaptacion(id);
            ViewBag.cud = Models.BD.SelectCUD(id);
            ViewBag.Lista_Certificacion = Models.BD.SelectCertificacion(id);
            return Json(new { success = true });
        }
        catch (Exception ex)
        {
            return Json(new { success = false, message = " ERROR. No se pudo eliminar el Idioma." });
        }
    }
    public JsonResult ObtenerDatosIdioma(int id)
    {
        var idioma = Models.BD.SelectIdiomaIdCard(id);
        if (idioma == null)
        {return Json(new { success = false, message = "Idioma no encontrado." });}
        return Json(new
        {
            success = true,
            id = idioma.id,
            nombre = idioma.nombre
        });
    }

}