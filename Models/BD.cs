using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Dapper;
namespace Hiring.Models;

public  class BD
{
     private static string ConnectionString { get; set; } = @"Server=.;DataBase=Hiring;Trusted_Connection=True;";   
     public static Usuario user;//agarra el usuario loggeado


    /*LOGIN + VERIFICACIONES*/
    
    public static Usuario Login(string pMail, string pContraseña)
    {
        Usuario user = null;
        using(SqlConnection db = new SqlConnection(ConnectionString))
        {
            string sp = "LoginUsuario";
            user= db.QueryFirstOrDefault<Usuario>(sp, new {pMail = pMail, pContraseña = pContraseña }, commandType: CommandType.StoredProcedure);
        }
        return user;
    }
    

    public static Usuario Login_VerificarContraseña(string pContraseña)
    {
       Usuario user = null;
        using(SqlConnection db = new SqlConnection(ConnectionString)){
            string sp = "Login_VerificarContraseña";
            user= db.QueryFirstOrDefault<Usuario>(sp, new {Contraseña=pContraseña}, commandType: CommandType.StoredProcedure);
        }
        return user;
    }
    
     public static Usuario Registro_VerificarExistencia(string Mail)
    {
       Usuario user = null;
        using(SqlConnection db = new SqlConnection(ConnectionString)){
            string sp = "Registro_VerificarExistencia";
            user= db.QueryFirstOrDefault<Usuario>(sp, new {Mail = Mail }, commandType: CommandType.StoredProcedure);
        }
        return user;
    }
    
      public static void Registro(string Mail, string Contraseña, int id_discapacidad)
    {
        using(SqlConnection db = new SqlConnection(ConnectionString)){
             
            string sp = "Registro";
            var parameters = new { Mail = Mail, Contraseña = Contraseña , id_discapacidad=id_discapacidad};
             db.Execute(sp, parameters, commandType: CommandType.StoredProcedure);
        }
    }

    public static string OlvideMiContraseña(string pMail)
    {
        string Contraseña_recuperada = " ";
        using(SqlConnection db = new SqlConnection(ConnectionString))
        {
            string sp = "OlvideMiContraseña";
            Contraseña_recuperada= db.QueryFirstOrDefault<string>(sp, new { Mail=pMail }, commandType: CommandType.StoredProcedure);
        }
        return Contraseña_recuperada;
    }

    /*----------------------------------------------------------------*/
    public static void CargaPerfilDefault(Usuario userr, string estilo, string foto_perfil, string encabezado, string nombre_apellido, string telefono, string mail)
    {
        using(SqlConnection db = new SqlConnection(ConnectionString)){
            string sp = "CargaPerfilDefault";
            var parameters = new { id = userr.id, estilo=estilo, foto_perfil=foto_perfil, encabezado=encabezado, nombre_apellido = nombre_apellido, telefono = telefono, mail = mail};
            db.Execute(sp, parameters, commandType: CommandType.StoredProcedure);
        }
    }
     public static Informacion_Personal_Empleado CargarPerfilLogin(int id)
    {
     // Inicializamos perfil como null
    Informacion_Personal_Empleado perfil = null;
    using (SqlConnection db = new SqlConnection(ConnectionString))
    {
        string sp = "CargarPerfilLogin";
        var parameters = new { id = id };
         perfil = db.QueryFirstOrDefault<Informacion_Personal_Empleado>(sp, parameters, commandType: CommandType.StoredProcedure);
    }

    return perfil;}
    
    //INFO PERSONAL
    public static void InsertarInformacionPersonalEmpleado1( Informacion_Personal_Empleado usuario)
    {
        using(SqlConnection db = new SqlConnection(ConnectionString)){
            string sp = "InsertarInformacionPersonalEmpleado1";
            var parameters = new { id = usuario.id, estilo=usuario.estilo, nombre_apellido = usuario.nombre_apellido, telefono = usuario.telefono, mail = usuario.mail};
            db.Execute(sp, parameters, commandType: CommandType.StoredProcedure);
        }
    }
    public static void InsertarInformacionPersonalEmpleado2(Informacion_Personal_Empleado usuario)
    {
        using(SqlConnection db = new SqlConnection(ConnectionString)){
            string sp = "InsertarInformacionPersonalEmpleado2";
            var parameters = new { id=usuario.id, foto_perfil=usuario.foto_perfil, acerca_de_mi=usuario.acerca_de_mi, profesion_actual=usuario.profesion_actual, ubicacion=usuario.ubicacion};
            db.Execute(sp, parameters, commandType: CommandType.StoredProcedure);
        }
    }

    //EDUCACION
    public static void InsertarEducacion(Educacion educacion, int id_info_empleado)
{
    try
    {
        using (SqlConnection db = new SqlConnection(ConnectionString))
        {
            string sp = "InsertarEducacion";
            var parameters = new 
            { 
                id = educacion.id == 0 ? 0 : educacion.id, 
                titulo = educacion.titulo, 
                nombre_institucion = educacion.nombre_institucion, 
                disciplina_academica = educacion.disciplina_academica, 
                actividades_grupo = educacion.actividades_grupo, 
                descripcion = educacion.descripcion, 
                fecha_expedicion = educacion.fecha_expedicion, 
                fecha_caducidad = educacion.fecha_caducidad, 
                id_info_empleado = id_info_empleado, 
                mes_expedicion = educacion.mes_expedicion, 
                mes_caducidad = educacion.mes_caducidad  
            };
            db.Execute(sp, parameters, commandType: CommandType.StoredProcedure);
        }
    }
    catch (Exception ex)
    {
        throw new Exception("Error al insertar la educación en la base de datos.", ex);
    }
}

    public static List<Educacion> SelectEducacion(int Id_Info_Empleado)
    {
        List<Educacion> Lista_educacion = new List<Educacion>(); 

        using (SqlConnection db = new SqlConnection(ConnectionString))
        {
            string sp = "SelectEducacion";
            Lista_educacion = db.Query<Educacion>(sp, new { id_info_empleado = Id_Info_Empleado}, commandType: CommandType.StoredProcedure).ToList();
        }

        return Lista_educacion;
    }
    public static Educacion SelectEducacionIdCard(int id)
    {
        Educacion educacion = null;
        using (SqlConnection db = new SqlConnection(ConnectionString))
        {
            string sp = "SelectEducacionIdCard";
            educacion = db.QueryFirstOrDefault<Educacion>(sp, new { id = id}, commandType: CommandType.StoredProcedure);
        }

        return educacion;
    }
    public static void EliminarEducacion(int id)
    {
        using (SqlConnection db = new SqlConnection(ConnectionString))
        {
            string sp = "EliminarEducacion";
             var parameters = new { id = id};
            db.Execute(sp, parameters, commandType: CommandType.StoredProcedure);
        }
    }

    //MULTIMEDIA
    public static List<string> SelectMultimedia(int Id_Info_Empleado)
    {
        List<string> UrlMultimedia = new List<string>(); 

        using (SqlConnection db = new SqlConnection(ConnectionString))
        {
            string sp = "SelectMultimedia";
            UrlMultimedia = db.Query<string>(sp, new { id_info_empleado = Id_Info_Empleado }, commandType: CommandType.StoredProcedure).ToList();
        }

        return UrlMultimedia;
    }

    public static void InsertarMultimedia(string URL, int Id_Empleado)
    {
        using (SqlConnection db = new SqlConnection(ConnectionString))
        {
            string sp = "InsertarMultimedia";
            var parameters = new { url = URL, id_info_empleado= Id_Empleado};
            db.Execute(sp, parameters, commandType: CommandType.StoredProcedure);
        }
    }

//ADAPTACION
    public static void InsertarAdaptacion(Necesidad Necesidad, int id_info_empleado)
    {
        try
        {
            using (SqlConnection db = new SqlConnection(ConnectionString))
            {
                string sp = "InsertarAdaptacion";
                var parameters = new 
                { 
                    id = Necesidad.id == 0 ? 0 : Necesidad.id, 
                    nombre = Necesidad.nombre, 
                    id_info_empleado= Necesidad.id_info_empleado
                };
                db.Execute(sp, parameters, commandType: CommandType.StoredProcedure);
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Error al insertar la necesidad de adaptacion en la base de datos.", ex);
        }
    }

    public static Necesidad SelectAdaptacion(int Id_Info_Empleado)
    {
        Necesidad Adaptacion = null; 

        using (SqlConnection db = new SqlConnection(ConnectionString))
        {
            string sp = "SelectNecesidad";
            Adaptacion = db.QueryFirstOrDefault<Necesidad>(sp, new { id_info_empleado = Id_Info_Empleado }, commandType: CommandType.StoredProcedure);
        }

        return Adaptacion;
    }
    public static Necesidad SelectAdaptacionIdCard(int id)
        {
            Necesidad Adaptacion = null;
            using (SqlConnection db = new SqlConnection(ConnectionString))
            {
                string sp = "SelectAdaptacionIdCard";
                Adaptacion = db.QueryFirstOrDefault<Necesidad>(sp, new { id = id}, commandType: CommandType.StoredProcedure);
            }

            return Adaptacion;
        }
    public static void EliminarAdaptacion(int id)
        {
            using (SqlConnection db = new SqlConnection(ConnectionString))
            {
                string sp = "EliminarAdaptacion";
                var parameters = new { id = id};
                db.Execute(sp, parameters, commandType: CommandType.StoredProcedure);
            }
        }

//CUD
    public static void InsertarCUD(Cud cud, int id_info_empleado, string myfile)
    {
        try
        {
            using (SqlConnection db = new SqlConnection(ConnectionString))
            {
                string sp = "InsertarCUD";
                var parameters = new 
                { 
                    id = cud.id == 0 ? 0 : cud.id, 
                    fecha_expedicion = cud.fecha_expedicion, 
                    url_= myfile,
                    id_info_empleado= cud.id_info_empleado,
                    empresa_emisora= cud.empresa_emisora,
                    fecha_vencimiento= cud.fecha_vencimiento
                };
                db.Execute(sp, parameters, commandType: CommandType.StoredProcedure);
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Error al insertar el cud en la base de datos.", ex);
        }
    }

    public static Cud SelectCUD(int Id_Info_Empleado)
    {
        Cud cud = null; 

        using (SqlConnection db = new SqlConnection(ConnectionString))
        {
            string sp = "SelectCUD";
            cud = db.QueryFirstOrDefault<Cud>(sp, new { id_info_empleado = Id_Info_Empleado }, commandType: CommandType.StoredProcedure);
        }

        return cud;
    }
    public static Cud SelectCUDIdCard(int id)
        {
            Cud cud = null;
            using (SqlConnection db = new SqlConnection(ConnectionString))
            {
                string sp = "SelectCUDIdCard";
                cud = db.QueryFirstOrDefault<Cud>(sp, new { id = id}, commandType: CommandType.StoredProcedure);
            }

            return cud;
        }
    public static void EliminarCUD(int id)
        {
            using (SqlConnection db = new SqlConnection(ConnectionString))
            {
                string sp = "EliminarCUD";
                var parameters = new { id = id};
                db.Execute(sp, parameters, commandType: CommandType.StoredProcedure);
            }
        }
    public static void EliminarMultimedia(string url, int id)
            {
                using (SqlConnection db = new SqlConnection(ConnectionString))
                {
                    string sp = "EliminarMultimedia";
                    var parameters = new { id = id, url=url};
                    db.Execute(sp, parameters, commandType: CommandType.StoredProcedure);
                }
            }

    //CERTIFICACIONES
    public static void InsertarCertificaciones(Certificacion Certificaciones, int id_info_empleado, int id)
        {
            try
            {
                using (SqlConnection db = new SqlConnection(ConnectionString))
                {
                    string sp = "InsertarCertificaciones";
                    var parameters = new 
                    { 
                        id = Certificaciones.id == 0 ? 0 : Certificaciones.id, 
                        titulo = Certificaciones.titulo,
                        empresa_emisora= Certificaciones.empresa_emisora,
                        id_credencial= Certificaciones.id_credencial,
                        url_credencial= Certificaciones.url_credencial,
                        id_info_empleado= Certificaciones.id_info_empleado,
                        fecha_caducidad= Certificaciones.fecha_caducidad,
                        fecha_expedicion= Certificaciones.fecha_expedicion
                    };
                    db.Execute(sp, parameters, commandType: CommandType.StoredProcedure);
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al insertar el cud en la base de datos.", ex);
            }
        }

    public static List<Certificacion> SelectCertificacion(int Id_Info_Empleado)
        {
            List<Certificacion> Lista_Certificacion = new List<Certificacion>(); 

            using (SqlConnection db = new SqlConnection(ConnectionString))
            {
                string sp = "SelectCertificacion";
                Lista_Certificacion = db.Query<Certificacion>(sp, new { id_info_empleado = Id_Info_Empleado}, commandType: CommandType.StoredProcedure).ToList();
            }

            return Lista_Certificacion;
        }
    
    public static Certificacion SelectCertificacionIdCard(int id)
    {
        Certificacion certificacion = null;
        using (SqlConnection db = new SqlConnection(ConnectionString))
        {
            string sp = "SelectCertificacionIdCard";
            certificacion = db.QueryFirstOrDefault<Certificacion>(sp, new { id = id}, commandType: CommandType.StoredProcedure);
        }

        return certificacion;
    }
        
    public static void EliminarCertificacion(int id)
    {
        using (SqlConnection db = new SqlConnection(ConnectionString))
        {
            string sp = "EliminarCertificacion";
            var parameters = new { id = id};
            db.Execute(sp, parameters, commandType: CommandType.StoredProcedure);
        }
    }

    //IDIOMAS
    public static int InsertarIdioma(Idioma Idioma, int id_info_empleado)
    {
        int id=-1;
        try
        {
            using (SqlConnection db = new SqlConnection(ConnectionString))
            {
                string sp = "InsertarIdioma";
                var parameters = new 
                { 
                    nombre = Idioma.nombre, 
                    id_info_empleado= id_info_empleado
                };
                id=db.QueryFirstOrDefault<int>(sp, parameters, commandType: CommandType.StoredProcedure);
            }
            return id;
        }
        catch (Exception ex)
        {
            throw new Exception("Error al insertar la necesidad de adaptacion en la base de datos.", ex);
        }
    }

    public static Idioma SelectIdioma(int Id_Info_Empleado)
    {
        Idioma idioma = null; 
        using (SqlConnection db = new SqlConnection(ConnectionString))
        {
            string sp = "SelectIdioma";
            idioma = db.QueryFirstOrDefault<Idioma>(sp, new { id_info_empleado = Id_Info_Empleado }, commandType: CommandType.StoredProcedure);
        }
        return idioma;
    }
    public static Idioma SelectIdiomaIdCard(int id)
        {
            Idioma idioma = null;
            using (SqlConnection db = new SqlConnection(ConnectionString))
            {
                string sp = "SelectIdiomaIdCard";
                idioma = db.QueryFirstOrDefault<Idioma>(sp, new { id = id}, commandType: CommandType.StoredProcedure);
            }
            return idioma;
        }
    public static void EliminarIdioma(int id)
        {
            using (SqlConnection db = new SqlConnection(ConnectionString))
            {
                string sp = "EliminarIdioma";
                var parameters = new { id = id};
                db.Execute(sp, parameters, commandType: CommandType.StoredProcedure);
            }
        }
    
}
    
