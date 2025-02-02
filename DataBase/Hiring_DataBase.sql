USE [master]
GO
/****** Object:  Database [Hiring]    Script Date: 29/11/2024 10:15:59 ******/
CREATE DATABASE [Hiring]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Hiring', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Hiring.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Hiring_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Hiring_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Hiring] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Hiring].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Hiring] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Hiring] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Hiring] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Hiring] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Hiring] SET ARITHABORT OFF 
GO
ALTER DATABASE [Hiring] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Hiring] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Hiring] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Hiring] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Hiring] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Hiring] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Hiring] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Hiring] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Hiring] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Hiring] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Hiring] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Hiring] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Hiring] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Hiring] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Hiring] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Hiring] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Hiring] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Hiring] SET RECOVERY FULL 
GO
ALTER DATABASE [Hiring] SET  MULTI_USER 
GO
ALTER DATABASE [Hiring] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Hiring] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Hiring] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Hiring] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Hiring] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Hiring', N'ON'
GO
ALTER DATABASE [Hiring] SET QUERY_STORE = OFF
GO
USE [Hiring]
GO
/****** Object:  User [alumno]    Script Date: 29/11/2024 10:15:59 ******/
CREATE USER [alumno] FOR LOGIN [alumno] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Certificacion]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Certificacion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[titulo] [varchar](max) NOT NULL,
	[empresa_emisora] [varchar](max) NOT NULL,
	[id_credencial] [int] NOT NULL,
	[id_info_empleado] [int] NOT NULL,
	[url_credencial] [varchar](max) NULL,
	[fecha_expedicion] [datetime] NULL,
	[fecha_caducidad] [datetime] NULL,
 CONSTRAINT [PK_Certificacion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cud]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cud](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[titulo] [varchar](max) NULL,
	[fecha_expedicion] [datetime] NULL,
	[url_] [varchar](max) NULL,
	[id_info_empleado] [int] NOT NULL,
	[empresa_emisora] [varchar](max) NULL,
	[fecha_vencimiento] [datetime] NULL,
 CONSTRAINT [PK_CUD] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discapacidad]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discapacidad](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](max) NULL,
 CONSTRAINT [PK_Discapacidad] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Educacion]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Educacion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[titulo] [varchar](max) NULL,
	[nombre_institucion] [varchar](max) NULL,
	[disciplina_academica] [varchar](max) NULL,
	[actividades_grupo] [varchar](max) NULL,
	[descripcion] [varchar](max) NULL,
	[fecha_expedicion] [varchar](100) NULL,
	[fecha_caducidad] [varchar](100) NULL,
	[id_info_empleado] [int] NOT NULL,
	[mes_expedicion] [varchar](100) NULL,
	[mes_caducidad] [varchar](100) NULL,
 CONSTRAINT [PK_Educacion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Habilidad]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Habilidad](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tag] [varchar](max) NULL,
 CONSTRAINT [PK_Habilidad] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Idioma]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Idioma](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](max) NOT NULL,
	[id_info_empleado] [int] NOT NULL,
 CONSTRAINT [PK_Idioma] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Informacion_Empleado_Certificacion]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Informacion_Empleado_Certificacion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fecha_expedicion] [date] NOT NULL,
	[fecha_caducidad] [date] NULL,
	[id_info_empleado] [int] NOT NULL,
	[id_certificacion] [int] NOT NULL,
 CONSTRAINT [PK_Informacion_Empleado_Certificacion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Informacion_Empleado_Habilidad]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Informacion_Empleado_Habilidad](
	[id] [int] NOT NULL,
	[id_info_empleado] [int] NOT NULL,
	[id_habilidad] [int] NOT NULL,
 CONSTRAINT [PK_Informacion_Empleado_Habilidad] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Informacion_Empleado_Idioma]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Informacion_Empleado_Idioma](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_info_empleado] [int] NOT NULL,
	[id_idioma] [int] NOT NULL,
 CONSTRAINT [PK_Informacion_Empleado_Idioma] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Informacion_Personal_Empleado]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Informacion_Personal_Empleado](
	[id] [int] NOT NULL,
	[nombre_apellido] [varchar](max) NULL,
	[mail] [varchar](max) NULL,
	[telefono] [varchar](50) NULL,
	[acerca_de_mi] [varchar](max) NULL,
	[profesion_actual] [varchar](max) NULL,
	[estilo] [varchar](max) NULL,
	[ubicacion] [varchar](max) NULL,
	[id_multimedia] [int] NULL,
	[sitio_web] [varchar](max) NULL,
	[foto_perfil] [varchar](max) NULL,
	[id_educacion] [int] NULL,
	[encabezado] [varchar](max) NULL,
 CONSTRAINT [PK_Informacion_Personal_Empleado] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Multimedia]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Multimedia](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_info_empleado] [int] NOT NULL,
	[url] [nvarchar](max) NULL,
 CONSTRAINT [PK_Usuario_Multimedia] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Necesidad]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Necesidad](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_info_empleado] [int] NOT NULL,
	[nombre] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Necesidad] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Mail] [varchar](320) NOT NULL,
	[Contraseña] [varchar](15) NOT NULL,
	[id_discapacidad] [int] NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Certificacion] ON 

INSERT [dbo].[Certificacion] ([id], [titulo], [empresa_emisora], [id_credencial], [id_info_empleado], [url_credencial], [fecha_expedicion], [fecha_caducidad]) VALUES (1, N'hhfdhfh', N'hdhdhdh', 14, 1, N'ssjskjhkjs', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Certificacion] OFF
GO
SET IDENTITY_INSERT [dbo].[Cud] ON 

INSERT [dbo].[Cud] ([id], [titulo], [fecha_expedicion], [url_], [id_info_empleado], [empresa_emisora], [fecha_vencimiento]) VALUES (32, NULL, CAST(N'2024-10-30T00:00:00.000' AS DateTime), N'images.jfif', 0, N'CUD', CAST(N'2024-12-06T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Cud] OFF
GO
SET IDENTITY_INSERT [dbo].[Discapacidad] ON 

INSERT [dbo].[Discapacidad] ([id], [nombre]) VALUES (1, N'no_lee')
INSERT [dbo].[Discapacidad] ([id], [nombre]) VALUES (2, N'lee')
SET IDENTITY_INSERT [dbo].[Discapacidad] OFF
GO
SET IDENTITY_INSERT [dbo].[Educacion] ON 

INSERT [dbo].[Educacion] ([id], [titulo], [nombre_institucion], [disciplina_academica], [actividades_grupo], [descripcion], [fecha_expedicion], [fecha_caducidad], [id_info_empleado], [mes_expedicion], [mes_caducidad]) VALUES (137, N'BACHILLER DE MECATRÓNICA ', N'Ort', N'Mecatrónica', N'Futbol y equipo de ajedrez', N'Bachiller en Mecatrónica con especialidad en desarrollo de robots, cables y muchas herramientas. Programación en C , C++ y Arduino', N'1923', N'1930', 2, N'marzo', N'noviembre')
INSERT [dbo].[Educacion] ([id], [titulo], [nombre_institucion], [disciplina_academica], [actividades_grupo], [descripcion], [fecha_expedicion], [fecha_caducidad], [id_info_empleado], [mes_expedicion], [mes_caducidad]) VALUES (138, N'Análisis de Sistemas', N'cqDQEDQWD', N'DDFDSFqsd', N'Futbol y equipo de ajedrez', N'muy lindo todo JAJAJAJ', N'1930', N'1968', 0, N'noviembre', N'diciembre')
INSERT [dbo].[Educacion] ([id], [titulo], [nombre_institucion], [disciplina_academica], [actividades_grupo], [descripcion], [fecha_expedicion], [fecha_caducidad], [id_info_empleado], [mes_expedicion], [mes_caducidad]) VALUES (139, N'Análisis de Sistemas', N'hhh', N'Sistemas de la Información 3', N'Futbol', N'muy lindo todo JAJAJAJ', N'1930', N'1968', 0, N'agosto', N'diciembre')
INSERT [dbo].[Educacion] ([id], [titulo], [nombre_institucion], [disciplina_academica], [actividades_grupo], [descripcion], [fecha_expedicion], [fecha_caducidad], [id_info_empleado], [mes_expedicion], [mes_caducidad]) VALUES (140, N'Análisis de Sistemas', N'Ort', N'Sistemas de la Información 3', N'Futbol', N'muy lindo todo JAJAJAJ', N'1923', N'1959', 0, N'marzo', N'noviembre')
INSERT [dbo].[Educacion] ([id], [titulo], [nombre_institucion], [disciplina_academica], [actividades_grupo], [descripcion], [fecha_expedicion], [fecha_caducidad], [id_info_empleado], [mes_expedicion], [mes_caducidad]) VALUES (145, N'BACHILLER DE MECATRÓNICA', N'Ort', N'Sistemas de la Información ', N'Futbol 2', N'hhfjfyjf', N'1930', N'1960', 0, N'noviembre', N'noviembre')
INSERT [dbo].[Educacion] ([id], [titulo], [nombre_institucion], [disciplina_academica], [actividades_grupo], [descripcion], [fecha_expedicion], [fecha_caducidad], [id_info_empleado], [mes_expedicion], [mes_caducidad]) VALUES (146, N'ggg', N'ggg', N'ggg', N'ggg', N'gggg', NULL, NULL, 44, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Educacion] OFF
GO
SET IDENTITY_INSERT [dbo].[Idioma] ON 

INSERT [dbo].[Idioma] ([id], [nombre], [id_info_empleado]) VALUES (47, N'Español, Inglés', 2)
SET IDENTITY_INSERT [dbo].[Idioma] OFF
GO
INSERT [dbo].[Informacion_Personal_Empleado] ([id], [nombre_apellido], [mail], [telefono], [acerca_de_mi], [profesion_actual], [estilo], [ubicacion], [id_multimedia], [sitio_web], [foto_perfil], [id_educacion], [encabezado]) VALUES (1, N'Yael Saroka', N'yaelsaroka@gmail.com', N'1556037929', NULL, NULL, N'#fffffffffff', NULL, NULL, NULL, N'../img/default/foto_Default.png', NULL, N'encabezado.png')
INSERT [dbo].[Informacion_Personal_Empleado] ([id], [nombre_apellido], [mail], [telefono], [acerca_de_mi], [profesion_actual], [estilo], [ubicacion], [id_multimedia], [sitio_web], [foto_perfil], [id_educacion], [encabezado]) VALUES (2, N'sarah signikaa ', N'sarah_maqui@gmail.com', N'+54 911 5567 3341', N'Soy una apasionada maquilladora con una sólida experiencia en la industria. Mi objetivo es resaltar la belleza natural de mis clientes y potenciar su confianza a través del arte del maquillaje. ', N'Maquilladora', N'#dcbbe2', N'Rosario, Santa fé', 1, N'sarH.com', N'perro.jfif', NULL, N'banner_sarah.png')
INSERT [dbo].[Informacion_Personal_Empleado] ([id], [nombre_apellido], [mail], [telefono], [acerca_de_mi], [profesion_actual], [estilo], [ubicacion], [id_multimedia], [sitio_web], [foto_perfil], [id_educacion], [encabezado]) VALUES (3, N'Pedro Pascal', N'Pedroperodr@gmail.com', N'+54 911 5567 3341', N'Soy un apasionado peluquero con una sólida experiencia en la industria. Mi objetivo es resaltar la belleza natural de mis clientes y potenciar su confianza a través del arte del pelo. ', N'Peluquero', N'#B7A68D', N'Casilda, Santa fé', 2, N'pep.com', N'https://is1-ssl.mzstatic.com/image/thumb/i93eX_NdIyNX-elbWwWKyg/1200x675mf.jpg', NULL, N'banner_pedro.png')
INSERT [dbo].[Informacion_Personal_Empleado] ([id], [nombre_apellido], [mail], [telefono], [acerca_de_mi], [profesion_actual], [estilo], [ubicacion], [id_multimedia], [sitio_web], [foto_perfil], [id_educacion], [encabezado]) VALUES (6, N'Gabriel Smart', N'smartgabi@gmail.com', N'+54 911 5698 2140', N'Soy un apasionado psicólogo con una sólida experiencia en la industria. Mi objetivo es resaltar el intelecto natural de mis clientes y potenciar su confianza en si mismo. ', N'Psicólogo', N'#28036A', N'La Falda, Córdoba', 3, N'psicosmart.com', N'data:image/jpeg;base64,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', NULL, N'https://static.vecteezy.com/system/resources/previews/003/302/993/non_2x/adult-psychology-issue-word-concepts-banner-vector.jpg')
INSERT [dbo].[Informacion_Personal_Empleado] ([id], [nombre_apellido], [mail], [telefono], [acerca_de_mi], [profesion_actual], [estilo], [ubicacion], [id_multimedia], [sitio_web], [foto_perfil], [id_educacion], [encabezado]) VALUES (20, N'Tu nombre', N'', N'', NULL, NULL, N'#ABE7DD', NULL, NULL, NULL, N'../img/default/foto_Default.png', NULL, N'encabezado.png')
INSERT [dbo].[Informacion_Personal_Empleado] ([id], [nombre_apellido], [mail], [telefono], [acerca_de_mi], [profesion_actual], [estilo], [ubicacion], [id_multimedia], [sitio_web], [foto_perfil], [id_educacion], [encabezado]) VALUES (21, N'Tu nombre', N'', N'', NULL, NULL, N'#ABE7DD', NULL, NULL, NULL, N'../img/default/foto_Default.png', NULL, N'encabezado.png')
INSERT [dbo].[Informacion_Personal_Empleado] ([id], [nombre_apellido], [mail], [telefono], [acerca_de_mi], [profesion_actual], [estilo], [ubicacion], [id_multimedia], [sitio_web], [foto_perfil], [id_educacion], [encabezado]) VALUES (22, N'Tu nombre', N'', N'', NULL, NULL, N'#ABE7DD', NULL, NULL, NULL, N'../img/default/foto_Default.png', NULL, N'encabezado.png')
INSERT [dbo].[Informacion_Personal_Empleado] ([id], [nombre_apellido], [mail], [telefono], [acerca_de_mi], [profesion_actual], [estilo], [ubicacion], [id_multimedia], [sitio_web], [foto_perfil], [id_educacion], [encabezado]) VALUES (29, N'Tu nombre', N'', N'', NULL, NULL, N'#ABE7DD', NULL, NULL, NULL, N'../img/default/foto_Default.png', NULL, N'encabezado.png')
INSERT [dbo].[Informacion_Personal_Empleado] ([id], [nombre_apellido], [mail], [telefono], [acerca_de_mi], [profesion_actual], [estilo], [ubicacion], [id_multimedia], [sitio_web], [foto_perfil], [id_educacion], [encabezado]) VALUES (30, N'Tu nombre', N'', N'', NULL, NULL, N'#ABE7DD', NULL, NULL, NULL, N'../img/default/foto_Default.png', NULL, N'encabezado.png')
INSERT [dbo].[Informacion_Personal_Empleado] ([id], [nombre_apellido], [mail], [telefono], [acerca_de_mi], [profesion_actual], [estilo], [ubicacion], [id_multimedia], [sitio_web], [foto_perfil], [id_educacion], [encabezado]) VALUES (31, N'Nuevo', N'mail@gmail.com', N'1556037929', N'Soy una apasionada maquilladora con una sólida experiencia en la industria. Mi objetivo es resaltar la belleza natural de mis clientes y potenciar su confianza a través del arte del maquillaje. ', N'Maquilladora', N'#00000', N'Rosario, Santa fé', NULL, NULL, NULL, NULL, N'encabezado.png')
INSERT [dbo].[Informacion_Personal_Empleado] ([id], [nombre_apellido], [mail], [telefono], [acerca_de_mi], [profesion_actual], [estilo], [ubicacion], [id_multimedia], [sitio_web], [foto_perfil], [id_educacion], [encabezado]) VALUES (32, N'Nuevo', N'mail@gmail.com', N'1556037929', NULL, NULL, N'#00000', NULL, NULL, NULL, N'../img/default/foto_Default.png', NULL, N'encabezado.png')
INSERT [dbo].[Informacion_Personal_Empleado] ([id], [nombre_apellido], [mail], [telefono], [acerca_de_mi], [profesion_actual], [estilo], [ubicacion], [id_multimedia], [sitio_web], [foto_perfil], [id_educacion], [encabezado]) VALUES (33, N'yael', N'mail@gmail.com', N'01556037929', NULL, NULL, N'#000000', NULL, NULL, NULL, N'../img/default/foto_Default.png', NULL, N'encabezado.png')
INSERT [dbo].[Informacion_Personal_Empleado] ([id], [nombre_apellido], [mail], [telefono], [acerca_de_mi], [profesion_actual], [estilo], [ubicacion], [id_multimedia], [sitio_web], [foto_perfil], [id_educacion], [encabezado]) VALUES (40, N'Tu nombre', N'', N'', NULL, NULL, N'#ABE7DD', NULL, NULL, NULL, N'../img/default/foto_Default.png', NULL, N'encabezado.png')
INSERT [dbo].[Informacion_Personal_Empleado] ([id], [nombre_apellido], [mail], [telefono], [acerca_de_mi], [profesion_actual], [estilo], [ubicacion], [id_multimedia], [sitio_web], [foto_perfil], [id_educacion], [encabezado]) VALUES (41, N'Veronica Josefina Anguilar', N'veronica@hotmail.com', N'1560072894', N'Como bioquímica apasionada y dedicada, mi carrera se ha enfocado en la intersección de la ciencia y la innovación tecnológica. Con una sólida formación en bioquímica y una experiencia significativa en investigación y desarrollo, me especializo en el análisis y la optimización de procesos biológicos complejos para mejorar la salud y el bienestar humano.', N'bioquimica', N'#6f8d58', N'CABA', NULL, NULL, N'https://hips.hearstapps.com/hmg-prod/images/veronica-2017-sandra-escacena-1570897155.jpg', NULL, N'encabezado.png')
INSERT [dbo].[Informacion_Personal_Empleado] ([id], [nombre_apellido], [mail], [telefono], [acerca_de_mi], [profesion_actual], [estilo], [ubicacion], [id_multimedia], [sitio_web], [foto_perfil], [id_educacion], [encabezado]) VALUES (44, N'Yael Saroka', N'yaesarokaaaaa@hotmail.com', N'156037958', N'Holaa', N'Programadora', N'#1d6119', NULL, NULL, NULL, NULL, NULL, N'encabezado.png')
INSERT [dbo].[Informacion_Personal_Empleado] ([id], [nombre_apellido], [mail], [telefono], [acerca_de_mi], [profesion_actual], [estilo], [ubicacion], [id_multimedia], [sitio_web], [foto_perfil], [id_educacion], [encabezado]) VALUES (45, N'sarita', N'sarita@gmail.comn', N'8333333', N'dddd', N'Ingeniera civil', N'#cfe7ab', NULL, NULL, NULL, N'images.jfif', NULL, N'encabezado.png')
GO
SET IDENTITY_INSERT [dbo].[Multimedia] ON 

INSERT [dbo].[Multimedia] ([id], [id_info_empleado], [url]) VALUES (36, 2, N'/uploads/1724212060.jpg')
INSERT [dbo].[Multimedia] ([id], [id_info_empleado], [url]) VALUES (37, 2, N'/uploads/1724212071.jpg')
INSERT [dbo].[Multimedia] ([id], [id_info_empleado], [url]) VALUES (38, 2, N'/uploads/1724368762.jpg')
INSERT [dbo].[Multimedia] ([id], [id_info_empleado], [url]) VALUES (42, 2, N'/uploads/1724551311.pdf')
INSERT [dbo].[Multimedia] ([id], [id_info_empleado], [url]) VALUES (43, 2, N'/uploads/1724551588.mp4')
INSERT [dbo].[Multimedia] ([id], [id_info_empleado], [url]) VALUES (44, 2, N'/uploads/1724808463.png')
SET IDENTITY_INSERT [dbo].[Multimedia] OFF
GO
SET IDENTITY_INSERT [dbo].[Necesidad] ON 

INSERT [dbo].[Necesidad] ([id], [id_info_empleado], [nombre]) VALUES (62, 2, N'Acceso a rampas, Material en braille')
INSERT [dbo].[Necesidad] ([id], [id_info_empleado], [nombre]) VALUES (63, 45, N'Acceso a rampas')
SET IDENTITY_INSERT [dbo].[Necesidad] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (1, N'yaesaroka@gmail.com', N'123645', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (2, N'sarah_maqui@gmail.com', N'123645', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (3, N'gdsgdsg@gmail.com', N'123645', NULL)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (5, N'prueba@gmail.com', N'1', NULL)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (6, N'pruebaO@gmail.com', N'1', 2)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (7, N'hol@gmail.com', N'1', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (8, N'botones@gmail.com', N'1', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (9, N'111@GMAIL.COM', N'1', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (10, N'default_prueba@gmail.com', N'1', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (11, N'hola@gmail.com', N'123', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (12, N'hola@gmail.com', N'123', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (13, N'hola@gmail.com', N'123', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (14, N'hola@gmail.com', N'123', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (15, N'hola2@gmail.com', N'123', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (16, N'hola2@gmail.com', N'123', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (17, N'carla@gmail.com', N'1234', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (18, N'calita55@gmail.com', N'1245', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (19, N'mica@hotmail.com', N'4575', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (20, N'mica2@hotmail.com', N'123', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (21, N'janita@gmail.com', N'789', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (22, N'camilita@gmail.com', N'12345', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (23, N'mariaa@gmail.com', N'12345', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (24, N'hola@gmail.com', N'123', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (25, N'holaaaa@gmail.com', N'12345', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (26, N'leo@gmail.com', N'123', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (27, N'cami@gmail.com', N'123', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (28, N'yaesaroka2@gmail.com', N'111', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (29, N'yaesaroka3@gmail.com', N'123', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (30, N'nuevo@gmail.com', N'123', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (31, N'holis@gmail.com', N'123', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (32, N'yaesaroka7@gmail.com', N'111', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (33, N'yaesaroka19@gmail.com', N'111', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (34, N'yaesaroka7@gmail.com', N'123', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (35, N'marina@hotmail.com', N'123', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (36, N'martin@gmail.com', N'123', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (37, N'luli@hotmail.com', N'123', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (38, N'yaesaroka7@gmail.com', N'123', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (39, N'marcela@hotmail.com', N'111', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (40, N'juanita@gmail.com', N'123', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (41, N'veronica@hotmail.com', N'123', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (42, N'holis@g', N'1', 2)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (43, N'saa@gmail', N'123645', 2)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (44, N'yaesarokaaaaa@hotmail.com', N'Yaeeeeee123$_', 1)
INSERT [dbo].[Usuario] ([id], [Mail], [Contraseña], [id_discapacidad]) VALUES (45, N'sarita@hotmail.com', N'Holaaaa#123', 1)
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
ALTER TABLE [dbo].[Certificacion]  WITH CHECK ADD  CONSTRAINT [FK_Certificacion_Informacion_Personal_Empleado] FOREIGN KEY([id_info_empleado])
REFERENCES [dbo].[Informacion_Personal_Empleado] ([id])
GO
ALTER TABLE [dbo].[Certificacion] CHECK CONSTRAINT [FK_Certificacion_Informacion_Personal_Empleado]
GO
ALTER TABLE [dbo].[Informacion_Empleado_Certificacion]  WITH CHECK ADD  CONSTRAINT [FK_Informacion_Empleado_Certificacion_Certificacion] FOREIGN KEY([id_certificacion])
REFERENCES [dbo].[Certificacion] ([id])
GO
ALTER TABLE [dbo].[Informacion_Empleado_Certificacion] CHECK CONSTRAINT [FK_Informacion_Empleado_Certificacion_Certificacion]
GO
ALTER TABLE [dbo].[Informacion_Empleado_Habilidad]  WITH CHECK ADD  CONSTRAINT [FK_Informacion_Empleado_Habilidad_Habilidad] FOREIGN KEY([id_habilidad])
REFERENCES [dbo].[Habilidad] ([id])
GO
ALTER TABLE [dbo].[Informacion_Empleado_Habilidad] CHECK CONSTRAINT [FK_Informacion_Empleado_Habilidad_Habilidad]
GO
ALTER TABLE [dbo].[Informacion_Empleado_Habilidad]  WITH CHECK ADD  CONSTRAINT [FK_Informacion_Empleado_Habilidad_Informacion_Personal_Empleado] FOREIGN KEY([id_info_empleado])
REFERENCES [dbo].[Informacion_Personal_Empleado] ([id])
GO
ALTER TABLE [dbo].[Informacion_Empleado_Habilidad] CHECK CONSTRAINT [FK_Informacion_Empleado_Habilidad_Informacion_Personal_Empleado]
GO
ALTER TABLE [dbo].[Informacion_Empleado_Idioma]  WITH CHECK ADD  CONSTRAINT [FK_Informacion_Empleado_Idioma_Idioma] FOREIGN KEY([id_idioma])
REFERENCES [dbo].[Idioma] ([id])
GO
ALTER TABLE [dbo].[Informacion_Empleado_Idioma] CHECK CONSTRAINT [FK_Informacion_Empleado_Idioma_Idioma]
GO
ALTER TABLE [dbo].[Informacion_Empleado_Idioma]  WITH CHECK ADD  CONSTRAINT [FK_Informacion_Empleado_Idioma_Informacion_Personal_Empleado] FOREIGN KEY([id_info_empleado])
REFERENCES [dbo].[Informacion_Personal_Empleado] ([id])
GO
ALTER TABLE [dbo].[Informacion_Empleado_Idioma] CHECK CONSTRAINT [FK_Informacion_Empleado_Idioma_Informacion_Personal_Empleado]
GO
ALTER TABLE [dbo].[Informacion_Personal_Empleado]  WITH CHECK ADD  CONSTRAINT [FK_Informacion_Personal_Empleado_Educacion] FOREIGN KEY([id_educacion])
REFERENCES [dbo].[Educacion] ([id])
GO
ALTER TABLE [dbo].[Informacion_Personal_Empleado] CHECK CONSTRAINT [FK_Informacion_Personal_Empleado_Educacion]
GO
ALTER TABLE [dbo].[Informacion_Personal_Empleado]  WITH CHECK ADD  CONSTRAINT [FK_Informacion_Personal_Empleado_Usuario] FOREIGN KEY([id])
REFERENCES [dbo].[Usuario] ([id])
GO
ALTER TABLE [dbo].[Informacion_Personal_Empleado] CHECK CONSTRAINT [FK_Informacion_Personal_Empleado_Usuario]
GO
ALTER TABLE [dbo].[Multimedia]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Multimedia_Informacion_Personal_Empleado] FOREIGN KEY([id_info_empleado])
REFERENCES [dbo].[Informacion_Personal_Empleado] ([id])
GO
ALTER TABLE [dbo].[Multimedia] CHECK CONSTRAINT [FK_Usuario_Multimedia_Informacion_Personal_Empleado]
GO
ALTER TABLE [dbo].[Necesidad]  WITH CHECK ADD  CONSTRAINT [FK_Necesidad_Informacion_Personal_Empleado] FOREIGN KEY([id_info_empleado])
REFERENCES [dbo].[Informacion_Personal_Empleado] ([id])
GO
ALTER TABLE [dbo].[Necesidad] CHECK CONSTRAINT [FK_Necesidad_Informacion_Personal_Empleado]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Discapacidad] FOREIGN KEY([id_discapacidad])
REFERENCES [dbo].[Discapacidad] ([id])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario_Discapacidad]
GO
/****** Object:  StoredProcedure [dbo].[ActualizarEducacion]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarEducacion]
    @id INT,
    @titulo NVARCHAR(100),
    @nombre_institucion NVARCHAR(100),
    @disciplina_academica NVARCHAR(100),
    @actividades_grupo NVARCHAR(100),
    @descripcion NVARCHAR(MAX),
    @fecha_expedicion DATE,
    @fecha_caducidad DATE,
    @mes_expedicion NVARCHAR(10),
    @mes_caducidad NVARCHAR(10)
AS
BEGIN
    UPDATE Educacion
    SET 
        titulo = @titulo,
        nombre_institucion = @nombre_institucion,
        disciplina_academica = @disciplina_academica,
        actividades_grupo = @actividades_grupo,
        descripcion = @descripcion,
        fecha_expedicion = @fecha_expedicion,
        fecha_caducidad = @fecha_caducidad,
        mes_expedicion = @mes_expedicion,
        mes_caducidad = @mes_caducidad
    WHERE id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[CargaPerfilDefault]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CargaPerfilDefault]
	-- Add the parameters for the stored procedure here
	@id int, @estilo varchar(10), @foto_perfil varchar(max), @encabezado varchar(max), @nombre_apellido varchar(max), @telefono varchar(max), @mail varchar(320)
AS
BEGIN
	INSERT INTO Informacion_Personal_Empleado(id,estilo,foto_perfil,encabezado, nombre_apellido, telefono, mail)
	VALUES (@id,   @estilo,   @foto_perfil,   @encabezado,    @nombre_apellido,    @telefono,    @mail)
	 
END
GO
/****** Object:  StoredProcedure [dbo].[CargarPerfilLogin]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CargarPerfilLogin]
	-- Add the parameters for the stored procedure here
	@id int
AS
BEGIN
	SELECT * FROM Informacion_Personal_Empleado
	WHERE id=@id
END
GO
/****** Object:  StoredProcedure [dbo].[EliminarAdaptacion]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarAdaptacion]
	-- Add the parameters for the stored procedure here
	@id INT
AS
BEGIN
	delete Necesidad from Necesidad
		where id = @id
END

GO
/****** Object:  StoredProcedure [dbo].[EliminarCertificacion]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[EliminarCertificacion]
	-- Add the parameters for the stored procedure here
	@id INT
AS
BEGIN
	delete Certificacion from Certificacion
		where id = @id
END

GO
/****** Object:  StoredProcedure [dbo].[EliminarCUD]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarCUD]
	-- Add the parameters for the stored procedure here
	@id INT
AS
BEGIN
	delete Cud from Cud
		where id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[EliminarEducacion]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarEducacion]
	-- Add the parameters for the stored procedure here
	@id INT
AS
BEGIN
	delete Educacion from Educacion
		where id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[EliminarIdioma]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[EliminarIdioma]
	-- Add the parameters for the stored procedure here
	@id INT
AS
BEGIN
	delete Idioma from Idioma
		where id = @id
END

GO
/****** Object:  StoredProcedure [dbo].[EliminarMultimedia]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarMultimedia]
	-- Add the parameters for the stored procedure here
	@id INT, @url nvarchar(MAX)
AS
BEGIN
	delete Multimedia from Multimedia
		where id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[InsertarAdaptacion]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarAdaptacion]
    @nombre VARCHAR(max),
	@id_info_empleado INT
AS
BEGIN
	DECLARE @idExistente INT

	SELECT @idExistente = id
	FROM Necesidad
	WHERE id_info_empleado=@id_info_empleado

    IF @idExistente IS NULL
    BEGIN
        -- Lógica para insertar un nuevo registro
        INSERT INTO Necesidad(nombre, id_info_empleado)
        VALUES ( @nombre, @id_info_empleado);
		SET @idExistente=SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        -- Lógica para actualizar un registro existente
        UPDATE Necesidad 
        SET 
            nombre=@nombre
        WHERE id = @idExistente;
    END
	SELECT @idExistente;
END


GO
/****** Object:  StoredProcedure [dbo].[InsertarCertificaciones]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarCertificaciones]
    @id INT, 
	@titulo VARCHAR(MAX),
	@empresa_emisora VARCHAR(MAX),
	@id_credencial INT,
	@url_credencial VARCHAR(MAX),
	@id_info_empleado INT,
	@fecha_caducidad Datetime,
	@fecha_expedicion DATETIME
AS
BEGIN
    IF @id = 0
    BEGIN
        INSERT INTO Certificacion(titulo, empresa_emisora, id_credencial,url_credencial, id_info_empleado, fecha_caducidad, fecha_expedicion)
        VALUES ( @titulo, @empresa_emisora, @id_credencial, @url_credencial, @id_info_empleado, @fecha_caducidad, @fecha_expedicion);
    END
    ELSE
    BEGIN
        -- Lógica para actualizar un registro existente
        UPDATE Certificacion 
        SET 
            titulo=@titulo,
			empresa_emisora=@empresa_emisora,
			id_credencial=@id_credencial,
			url_credencial=@url_credencial,
			fecha_caducidad= @fecha_caducidad,
			fecha_expedicion= @fecha_expedicion
        WHERE id = @id;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[InsertarCUD]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarCUD]
    @fecha_expedicion DATETIME,
	@url_ VARCHAR(MAX),
	@id_info_empleado INT,
	@empresa_emisora varchar(MAX),
	@fecha_vencimiento DATETIME
AS
BEGIN
	DECLARE @idExistente INT;


	SELECT @idExistente=id
	FROM Cud
	WHERE id_info_empleado=@id_info_empleado

        IF @idExistente IS NULL
		BEGIN
        INSERT INTO Cud(fecha_expedicion, url_, id_info_empleado, empresa_emisora, fecha_vencimiento )
        VALUES ( @fecha_expedicion, @url_, @id_info_empleado, @empresa_emisora, @fecha_vencimiento);
		SET @idExistente = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        -- Lógica para actualizar un registro existente
        UPDATE Cud 
        SET 
            fecha_expedicion=@fecha_expedicion,
			url_=@url_,
			empresa_emisora=@empresa_emisora,
			fecha_vencimiento=@fecha_vencimiento
        WHERE id = @idExistente;
    END
	SELECT @idExistente
END
GO
/****** Object:  StoredProcedure [dbo].[InsertarEducacion]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarEducacion]
    @id INT, -- ID para la actualización
    @titulo NVARCHAR(100),
    @nombre_institucion NVARCHAR(100),
    @mes_expedicion NVARCHAR(20),
    @fecha_expedicion INT,
    @mes_caducidad NVARCHAR(20),
    @fecha_caducidad INT,
    @disciplina_academica NVARCHAR(100),
    @actividades_grupo NVARCHAR(100),
    @descripcion NVARCHAR(MAX),
    @id_info_empleado INT
AS
BEGIN
    IF @id = 0
    BEGIN
        -- Lógica para insertar un nuevo registro
        INSERT INTO Educacion (titulo, nombre_institucion, mes_expedicion, fecha_expedicion, mes_caducidad, fecha_caducidad, disciplina_academica, actividades_grupo, descripcion, id_info_empleado)
        VALUES (@titulo, @nombre_institucion, @mes_expedicion, @fecha_expedicion, @mes_caducidad, @fecha_caducidad, @disciplina_academica, @actividades_grupo, @descripcion, @id_info_empleado);
    END
    ELSE
    BEGIN
        -- Lógica para actualizar un registro existente
        UPDATE Educacion 
        SET 
            titulo = @titulo,
            nombre_institucion = @nombre_institucion,
            mes_expedicion = @mes_expedicion,
            fecha_expedicion = @fecha_expedicion,
            mes_caducidad = @mes_caducidad,
            fecha_caducidad = @fecha_caducidad,
            disciplina_academica = @disciplina_academica,
            actividades_grupo = @actividades_grupo,
            descripcion = @descripcion
        WHERE id = @id;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[InsertarIdioma]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarIdioma]
@nombre VARCHAR(MAX),
@id_info_empleado INT
AS
BEGIN
DECLARE @idExistente INT;

    -- Verifica si el registro ya existe y obtén su ID
    SELECT @idExistente = id
    FROM Idioma
    WHERE  id_info_empleado=@id_info_empleado;

    IF @idExistente IS NULL
    BEGIN
        INSERT INTO Idioma(nombre, id_info_empleado)
        VALUES ( @nombre, @id_info_empleado);
SET @idExistente = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        -- Lógica para actualizar un registro existente
        UPDATE Idioma
        SET
            nombre=@nombre
        WHERE id = @idExistente;
    END
select @idExistente;
END
GO
/****** Object:  StoredProcedure [dbo].[InsertarInformacionPersonalEmpleado1]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarInformacionPersonalEmpleado1]
	@id int, @Nombre_Apellido varchar(max), @Mail varchar(254),@telefono varchar(max),  @estilo varchar(max)
	AS
BEGIN
	UPDATE Informacion_Personal_Empleado
	SET nombre_apellido = @Nombre_Apellido , mail= @Mail ,telefono= @telefono, estilo= @estilo 
	WHERE id = @id

END
GO
/****** Object:  StoredProcedure [dbo].[InsertarInformacionPersonalEmpleado2]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarInformacionPersonalEmpleado2]
	 @id int, @acerca_de_mi varchar(max), @profesion_actual varchar(max), @ubicacion varchar(max), @foto_perfil varchar(max)
AS
BEGIN
	UPDATE Informacion_Personal_Empleado
	SET acerca_de_mi = @acerca_de_mi , profesion_actual= @profesion_actual ,ubicacion= @ubicacion, foto_perfil= @foto_perfil 
	WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[InsertarMultimedia]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarMultimedia]
	@URL varchar(MAX), @Id_Info_Empleado int
AS 
BEGIN
	INSERT INTO Multimedia(url, id_info_empleado)
	VALUES (@URL, @Id_Info_Empleado)
END 
GO
/****** Object:  StoredProcedure [dbo].[InsertarNecesidad]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InsertarNecesidad]
	@Nombre varchar(max), @id_info_empleado int
AS
BEGIN
	INSERT INTO Necesidad
	VALUES (@Nombre, @id_info_empleado)
END
GO
/****** Object:  StoredProcedure [dbo].[Login_VerificarContraseña]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Login_VerificarContraseña]
	-- Add the parameters for the stored procedure here
	@Contraseña varchar(150)
AS
BEGIN
	SELECT Contraseña FROM Usuario WHERE  @Contraseña=Contraseña 
END
GO
/****** Object:  StoredProcedure [dbo].[LoginUsuario]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LoginUsuario]
	-- Add the parameters for the stored procedure here
	@pMail varchar(150), @pContraseña varchar(150)
AS
BEGIN
	SELECT * FROM Usuario WHERE @pMail=Mail AND @pContraseña=Contraseña
END
GO
/****** Object:  StoredProcedure [dbo].[OlvideMiContraseña]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[OlvideMiContraseña]
	-- Add the parameters for the stored procedure here
	@Mail varchar(150)
AS
BEGIN
	SELECT Contraseña FROM Usuario WHERE @Mail=Mail
END
GO
/****** Object:  StoredProcedure [dbo].[Registro]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Registro]
	-- Add the parameters for the stored procedure here
	@Mail varchar(150), @Contraseña varchar(150), @id_discapacidad int
AS
BEGIN
	INSERT INTO Usuario(Mail, Contraseña, id_discapacidad) VALUES (@Mail, @Contraseña,@id_discapacidad )
END
GO
/****** Object:  StoredProcedure [dbo].[Registro_VerificarExistencia]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Registro_VerificarExistencia]
	-- Add the parameters for the stored procedure here
	@Mail varchar(255)
AS
BEGIN
	SELECT * FROM Usuario WHERE  Mail=@Mail
END
GO
/****** Object:  StoredProcedure [dbo].[SelectAdaptacionIdCard]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectAdaptacionIdCard]
@id int
AS
BEGIN
SELECT *
    FROM Necesidad
    WHERE id = @id;
	end
GO
/****** Object:  StoredProcedure [dbo].[SelectCertificacion]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[SelectCertificacion]
@Id_Info_Empleado int
AS
BEGIN
SELECT * FROM Certificacion
WHERE id_info_empleado=@Id_Info_Empleado

END 
GO
/****** Object:  StoredProcedure [dbo].[SelectCertificacionIdCard]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[SelectCertificacionIdCard]
@id int
AS
BEGIN
SELECT *
    FROM Certificacion
    WHERE id = @id;
	end
GO
/****** Object:  StoredProcedure [dbo].[SelectCUD]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectCUD]
@Id_Info_Empleado int
AS
BEGIN
SELECT * FROM Cud
WHERE id_info_empleado=@Id_Info_Empleado

END 
GO
/****** Object:  StoredProcedure [dbo].[SelectCUDIdCard]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectCUDIdCard]
@id int
AS
BEGIN
SELECT *
    FROM Cud
    WHERE id = @id;
	end
GO
/****** Object:  StoredProcedure [dbo].[SelectEducacion]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectEducacion]
@Id_Info_Empleado int
AS
BEGIN
SELECT * FROM Educacion
WHERE id_info_empleado=@Id_Info_Empleado

END 
GO
/****** Object:  StoredProcedure [dbo].[SelectEducacionIdCard]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectEducacionIdCard]
@id int
AS
BEGIN
SELECT *
    FROM Educacion
    WHERE id = @id;
	end
GO
/****** Object:  StoredProcedure [dbo].[SelectIdioma]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[SelectIdioma]
@Id_Info_Empleado int
AS
BEGIN
SELECT * FROM Idioma
WHERE id_info_empleado=@Id_Info_Empleado

END 
GO
/****** Object:  StoredProcedure [dbo].[SelectIdiomaIdCard]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[SelectIdiomaIdCard]
@id int
AS
BEGIN
SELECT *
    FROM Idioma
    WHERE id = @id;
	end
GO
/****** Object:  StoredProcedure [dbo].[SelectMultimedia]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectMultimedia]
@Id_Info_Empleado int
AS
BEGIN
SELECT * FROM Multimedia
WHERE id_info_empleado=@Id_Info_Empleado

END 
GO
/****** Object:  StoredProcedure [dbo].[SelectNecesidad]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectNecesidad]
	@id_info_empleado int
AS
BEGIN
	SELECT *
	FROM Necesidad
	WHERE id_info_empleado=@id_info_empleado
END
GO
/****** Object:  StoredProcedure [dbo].[SelectURL]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectURL] 
	@id INT
AS
BEGIN
	SELECT url from Multimedia
		where id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[SelectUser]    Script Date: 29/11/2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectUser]
	@id int
AS
BEGIN
	SELECT * FROM Usuario
	WHERE id = @id

END
GO
USE [master]
GO
ALTER DATABASE [Hiring] SET  READ_WRITE 
GO
