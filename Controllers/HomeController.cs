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
            BD.user = usuario;
            return RedirectToAction("PerfilNoLee");
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
    public IActionResult InsertarInformacionPersonal2(Informacion_Personal_Empleado usuario, IFormFile foto_perfil)
    {
        if (foto_perfil != null)
        {
            if(foto_perfil.Length > 0 )
            {
                string ubicacion = this.Environment.ContentRootPath + @"\wwwroot\img\" + foto_perfil.FileName;
                using (var stream = System.IO.File.Create(ubicacion))
                {
                    foto_perfil.CopyToAsync(stream);
                }
                usuario.foto_perfil=foto_perfil.FileName;
            }

        }
            Models.BD.InsertarInformacionPersonalEmpleado2(usuario);
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
    public IActionResult InsertarCUD(Cud cud, int Id_Info_Empleado, int id, IFormFile myfile)
    {
        if (id != 0 || id == 0) 
        {
            if(myfile.Length > 0 )
            {
                string ubicacion = this.Environment.ContentRootPath + @"\wwwroot\uploads\" + myfile.FileName;
                using (var stream = System.IO.File.Create(ubicacion))
                {
                    myfile.CopyToAsync(stream);
                }
            }
            Models.BD.InsertarCUD(cud, Id_Info_Empleado, myfile.FileName);
        }
        Cud cud_ = Models.BD.SelectCUD(Id_Info_Empleado);
        ViewBag.cud = cud_;
        Informacion_Personal_Empleado perfilActualizado = Models.BD.CargarPerfilLogin(Id_Info_Empleado);
        ViewBag.UrlMultimedia=Models.BD.SelectMultimedia(Id_Info_Empleado);
        ViewBag.Lista_educacion = Models.BD.SelectEducacion(Id_Info_Empleado);
        ViewBag.Adaptacion = Models.BD.SelectAdaptacion(Id_Info_Empleado);
        ViewBag.Lista_Certificacion = Models.BD.SelectCertificacion(Id_Info_Empleado);
        ViewBag.idioma = Models.BD.SelectIdioma(Id_Info_Empleado);
        return View("PerfilLee", perfilActualizado);
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