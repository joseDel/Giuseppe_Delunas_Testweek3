USE [master]
GO
/****** Object:  Database [Pizzeria]    Script Date: 12/17/2021 3:26:32 PM ******/
CREATE DATABASE [Pizzeria]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Pizzeria', FILENAME = N'C:\Users\giuseppe.delunas\Pizzeria.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Pizzeria_log', FILENAME = N'C:\Users\giuseppe.delunas\Pizzeria_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Pizzeria] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Pizzeria].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Pizzeria] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Pizzeria] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Pizzeria] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Pizzeria] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Pizzeria] SET ARITHABORT OFF 
GO
ALTER DATABASE [Pizzeria] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Pizzeria] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Pizzeria] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Pizzeria] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Pizzeria] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Pizzeria] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Pizzeria] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Pizzeria] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Pizzeria] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Pizzeria] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Pizzeria] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Pizzeria] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Pizzeria] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Pizzeria] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Pizzeria] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Pizzeria] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Pizzeria] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Pizzeria] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Pizzeria] SET  MULTI_USER 
GO
ALTER DATABASE [Pizzeria] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Pizzeria] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Pizzeria] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Pizzeria] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Pizzeria] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Pizzeria] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Pizzeria] SET QUERY_STORE = OFF
GO
USE [Pizzeria]
GO
/****** Object:  UserDefinedFunction [dbo].[NumIngredientiPizza]    Script Date: 12/17/2021 3:26:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[NumIngredientiPizza](@nomePizza varchar(50))
returns int
as
begin
declare @numIngredienti int
select @numIngredienti = count(*)
from Pizza p join Pizza_Ingrediente pizzI on p.IdPizza = pizzI.IdPizza
			 join Ingrediente i on pizzI.IdIngrediente = i.IdIngrediente
where p.Nome = @nomePizza
return @numIngredienti
end
GO
/****** Object:  UserDefinedFunction [dbo].[NumPizzeContenentiIngrediente]    Script Date: 12/17/2021 3:26:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[NumPizzeContenentiIngrediente](@nomeIngrediente varchar(50))
returns int
as
begin 
declare @numPizze int

select @numPizze = count(*)
from Pizza p join Pizza_Ingrediente pizzI on p.IdPizza = pizzI.IdPizza
			 join Ingrediente i on pizzI.IdIngrediente = i.IdIngrediente
where i.Nome = @nomeIngrediente
return @numPizze
end
GO
/****** Object:  UserDefinedFunction [dbo].[NumPizzeSenzaIngrediente]    Script Date: 12/17/2021 3:26:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[NumPizzeSenzaIngrediente](@codiceIngrediente int)
returns int
as
begin
declare @numPizze int
select @numPizze = count(*)
from Pizza p
where p.Nome not in (select p.Nome 
					 from Pizza p join Pizza_Ingrediente pizzI on p.IdPizza = pizzI.IdPizza
								  join Ingrediente i on pizzI.IdIngrediente = i.IdIngrediente
					 where i.IdIngrediente = @codiceIngrediente
)
return @numPizze
end
GO
/****** Object:  Table [dbo].[Pizza]    Script Date: 12/17/2021 3:26:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pizza](
	[IdPizza] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](50) NULL,
	[Prezzo] [decimal](4, 2) NULL,
 CONSTRAINT [PK_IdPizza] PRIMARY KEY CLUSTERED 
(
	[IdPizza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[ListinoPizze]    Script Date: 12/17/2021 3:26:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[ListinoPizze]()
returns table
as
return
select p.Nome, p.Prezzo from Pizza p
GO
/****** Object:  Table [dbo].[Ingrediente]    Script Date: 12/17/2021 3:26:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingrediente](
	[IdIngrediente] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](50) NULL,
	[Costo] [decimal](4, 2) NULL,
	[Scorte] [int] NULL,
 CONSTRAINT [PK_IdIngrediente] PRIMARY KEY CLUSTERED 
(
	[IdIngrediente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pizza_Ingrediente]    Script Date: 12/17/2021 3:26:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pizza_Ingrediente](
	[IdPizza] [int] NULL,
	[IdIngrediente] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[ListinoPizzeIngrediente]    Script Date: 12/17/2021 3:26:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[ListinoPizzeIngrediente](@nomeIngrediente varchar(50))
returns table
as
return
select p.Nome, p.Prezzo
from Pizza p join Pizza_Ingrediente pizzI on p.IdPizza = pizzI.IdPizza
			 join Ingrediente i on pizzI.IdIngrediente = i.IdIngrediente
where i.IdIngrediente = (select i.IdIngrediente
from Ingrediente i
where i.Nome = @nomeIngrediente)
GO
/****** Object:  UserDefinedFunction [dbo].[ListinoPizzeSenzaIngrediente]    Script Date: 12/17/2021 3:26:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[ListinoPizzeSenzaIngrediente](@nomeIngrediente varchar(50))
returns table
as
return
select p.Nome, p.Prezzo
from Pizza p
where p.Nome not in (select p.Nome 
					 from Pizza p join Pizza_Ingrediente pizzI on p.IdPizza = pizzI.IdPizza
								  join Ingrediente i on pizzI.IdIngrediente = i.IdIngrediente
					 where i.Nome = @nomeIngrediente
)
GO
/****** Object:  View [dbo].[Menu]    Script Date: 12/17/2021 3:26:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Menu] as
select p.Nome as Pizza, p.Prezzo, stuff((SELECT ', ' + i.Nome
										 from Pizza p join Pizza_Ingrediente pizzI on p.IdPizza = pizzI.IdPizza
													  join Ingrediente i on pizzI.IdIngrediente = i.IdIngrediente 
										 FOR XML PATH('')), 1, 2, '') as Ingredienti
from Pizza p join Pizza_Ingrediente pizzI on p.IdPizza = pizzI.IdPizza
			 join Ingrediente i on pizzI.IdIngrediente = i.IdIngrediente
group by p.Nome, p.Prezzo
GO
SET IDENTITY_INSERT [dbo].[Ingrediente] ON 

INSERT [dbo].[Ingrediente] ([IdIngrediente], [Nome], [Costo], [Scorte]) VALUES (1, N'Pomodoro', CAST(1.00 AS Decimal(4, 2)), 50)
INSERT [dbo].[Ingrediente] ([IdIngrediente], [Nome], [Costo], [Scorte]) VALUES (2, N'Mozzarella', CAST(2.00 AS Decimal(4, 2)), 75)
INSERT [dbo].[Ingrediente] ([IdIngrediente], [Nome], [Costo], [Scorte]) VALUES (3, N'Mozzarella di bufala', CAST(3.00 AS Decimal(4, 2)), 40)
INSERT [dbo].[Ingrediente] ([IdIngrediente], [Nome], [Costo], [Scorte]) VALUES (4, N'Spianata piccante', CAST(2.00 AS Decimal(4, 2)), 30)
INSERT [dbo].[Ingrediente] ([IdIngrediente], [Nome], [Costo], [Scorte]) VALUES (5, N'Funghi', CAST(4.00 AS Decimal(4, 2)), 60)
INSERT [dbo].[Ingrediente] ([IdIngrediente], [Nome], [Costo], [Scorte]) VALUES (6, N'Carciofi', CAST(1.00 AS Decimal(4, 2)), 75)
INSERT [dbo].[Ingrediente] ([IdIngrediente], [Nome], [Costo], [Scorte]) VALUES (7, N'Cotto', CAST(3.00 AS Decimal(4, 2)), 90)
INSERT [dbo].[Ingrediente] ([IdIngrediente], [Nome], [Costo], [Scorte]) VALUES (8, N'Olive', CAST(3.00 AS Decimal(4, 2)), 75)
INSERT [dbo].[Ingrediente] ([IdIngrediente], [Nome], [Costo], [Scorte]) VALUES (9, N'Funghi porcini', CAST(4.00 AS Decimal(4, 2)), 50)
INSERT [dbo].[Ingrediente] ([IdIngrediente], [Nome], [Costo], [Scorte]) VALUES (10, N'Stracchino', CAST(3.00 AS Decimal(4, 2)), 10)
INSERT [dbo].[Ingrediente] ([IdIngrediente], [Nome], [Costo], [Scorte]) VALUES (11, N'Speck', CAST(3.00 AS Decimal(4, 2)), 120)
INSERT [dbo].[Ingrediente] ([IdIngrediente], [Nome], [Costo], [Scorte]) VALUES (12, N'Rucola', CAST(1.00 AS Decimal(4, 2)), 18)
INSERT [dbo].[Ingrediente] ([IdIngrediente], [Nome], [Costo], [Scorte]) VALUES (13, N'Grana', CAST(1.00 AS Decimal(4, 2)), 100)
INSERT [dbo].[Ingrediente] ([IdIngrediente], [Nome], [Costo], [Scorte]) VALUES (14, N'Verdure di stagione', CAST(2.00 AS Decimal(4, 2)), 100)
INSERT [dbo].[Ingrediente] ([IdIngrediente], [Nome], [Costo], [Scorte]) VALUES (15, N'Patate', CAST(1.00 AS Decimal(4, 2)), 80)
INSERT [dbo].[Ingrediente] ([IdIngrediente], [Nome], [Costo], [Scorte]) VALUES (16, N'Salsiccia', CAST(3.00 AS Decimal(4, 2)), 40)
INSERT [dbo].[Ingrediente] ([IdIngrediente], [Nome], [Costo], [Scorte]) VALUES (17, N'Pomodorini', CAST(2.00 AS Decimal(4, 2)), 70)
INSERT [dbo].[Ingrediente] ([IdIngrediente], [Nome], [Costo], [Scorte]) VALUES (18, N'Ricotta', CAST(3.00 AS Decimal(4, 2)), 65)
INSERT [dbo].[Ingrediente] ([IdIngrediente], [Nome], [Costo], [Scorte]) VALUES (19, N'Provola', CAST(4.00 AS Decimal(4, 2)), 25)
INSERT [dbo].[Ingrediente] ([IdIngrediente], [Nome], [Costo], [Scorte]) VALUES (20, N'Gorgonzola', CAST(3.00 AS Decimal(4, 2)), 80)
INSERT [dbo].[Ingrediente] ([IdIngrediente], [Nome], [Costo], [Scorte]) VALUES (21, N'Pomodoro fresco', CAST(2.00 AS Decimal(4, 2)), 30)
INSERT [dbo].[Ingrediente] ([IdIngrediente], [Nome], [Costo], [Scorte]) VALUES (23, N'Bresaola', CAST(4.00 AS Decimal(4, 2)), 10)
SET IDENTITY_INSERT [dbo].[Ingrediente] OFF
GO
SET IDENTITY_INSERT [dbo].[Pizza] ON 

INSERT [dbo].[Pizza] ([IdPizza], [Nome], [Prezzo]) VALUES (1, N'Margherita', CAST(5.00 AS Decimal(4, 2)))
INSERT [dbo].[Pizza] ([IdPizza], [Nome], [Prezzo]) VALUES (2, N'Bufala', CAST(7.00 AS Decimal(4, 2)))
INSERT [dbo].[Pizza] ([IdPizza], [Nome], [Prezzo]) VALUES (3, N'Diavola', CAST(6.00 AS Decimal(4, 2)))
INSERT [dbo].[Pizza] ([IdPizza], [Nome], [Prezzo]) VALUES (4, N'Quattro stagioni', CAST(7.00 AS Decimal(4, 2)))
INSERT [dbo].[Pizza] ([IdPizza], [Nome], [Prezzo]) VALUES (5, N'Porcini', CAST(7.00 AS Decimal(4, 2)))
INSERT [dbo].[Pizza] ([IdPizza], [Nome], [Prezzo]) VALUES (6, N'Dioniso', CAST(8.80 AS Decimal(4, 2)))
INSERT [dbo].[Pizza] ([IdPizza], [Nome], [Prezzo]) VALUES (7, N'Ortolana', CAST(8.00 AS Decimal(4, 2)))
INSERT [dbo].[Pizza] ([IdPizza], [Nome], [Prezzo]) VALUES (8, N'Patate e salsiccia', CAST(7.00 AS Decimal(4, 2)))
INSERT [dbo].[Pizza] ([IdPizza], [Nome], [Prezzo]) VALUES (9, N'Pomodorini', CAST(6.00 AS Decimal(4, 2)))
INSERT [dbo].[Pizza] ([IdPizza], [Nome], [Prezzo]) VALUES (10, N'Quattro formaggi', CAST(8.00 AS Decimal(4, 2)))
INSERT [dbo].[Pizza] ([IdPizza], [Nome], [Prezzo]) VALUES (11, N'Caprese', CAST(8.00 AS Decimal(4, 2)))
INSERT [dbo].[Pizza] ([IdPizza], [Nome], [Prezzo]) VALUES (12, N'Zeus', CAST(8.80 AS Decimal(4, 2)))
SET IDENTITY_INSERT [dbo].[Pizza] OFF
GO
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (1, 1)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (1, 2)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (2, 1)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (2, 3)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (2, 2)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (3, 2)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (3, 1)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (3, 4)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (4, 2)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (4, 1)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (4, 5)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (4, 7)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (4, 8)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (5, 1)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (5, 2)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (5, 9)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (6, 1)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (6, 2)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (6, 10)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (6, 11)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (6, 12)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (6, 13)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (7, 1)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (7, 2)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (7, 14)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (8, 2)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (8, 16)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (8, 15)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (9, 17)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (9, 18)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (9, 2)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (10, 2)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (10, 19)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (10, 20)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (10, 13)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (11, 2)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (11, 21)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (11, NULL)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (12, 2)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (12, 23)
INSERT [dbo].[Pizza_Ingrediente] ([IdPizza], [IdIngrediente]) VALUES (12, 12)
GO
ALTER TABLE [dbo].[Pizza_Ingrediente]  WITH CHECK ADD  CONSTRAINT [FK_IdIngrediente] FOREIGN KEY([IdIngrediente])
REFERENCES [dbo].[Ingrediente] ([IdIngrediente])
GO
ALTER TABLE [dbo].[Pizza_Ingrediente] CHECK CONSTRAINT [FK_IdIngrediente]
GO
ALTER TABLE [dbo].[Pizza_Ingrediente]  WITH CHECK ADD  CONSTRAINT [FK_IdPizza] FOREIGN KEY([IdPizza])
REFERENCES [dbo].[Pizza] ([IdPizza])
GO
ALTER TABLE [dbo].[Pizza_Ingrediente] CHECK CONSTRAINT [FK_IdPizza]
GO
ALTER TABLE [dbo].[Ingrediente]  WITH CHECK ADD  CONSTRAINT [check_costo_pos] CHECK  (([Costo]>(0)))
GO
ALTER TABLE [dbo].[Ingrediente] CHECK CONSTRAINT [check_costo_pos]
GO
ALTER TABLE [dbo].[Ingrediente]  WITH CHECK ADD  CONSTRAINT [check_scorte_nonNeg] CHECK  (([Scorte]>(0)))
GO
ALTER TABLE [dbo].[Ingrediente] CHECK CONSTRAINT [check_scorte_nonNeg]
GO
ALTER TABLE [dbo].[Pizza]  WITH CHECK ADD  CONSTRAINT [check_prezzo_pos] CHECK  (([Prezzo]>(0)))
GO
ALTER TABLE [dbo].[Pizza] CHECK CONSTRAINT [check_prezzo_pos]
GO
/****** Object:  StoredProcedure [dbo].[AggiornaPrezzoPizza]    Script Date: 12/17/2021 3:26:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AggiornaPrezzoPizza]
@nomePizza varchar(50),
@nuovoPrezzo decimal
as
update Pizza
set Prezzo = @nuovoPrezzo
where Nome = @nomePizza
GO
/****** Object:  StoredProcedure [dbo].[AssociaPizzaIngrediente]    Script Date: 12/17/2021 3:26:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AssociaPizzaIngrediente]
@nomePizza varchar(50),
@nomeIngrediente varchar(50)
as

declare @IDPIZZA int
select @IDPIZZA = p.IdPizza from pizza p where p.Nome = @nomePizza

declare @IDINGR int
select @IDINGR = i.IdIngrediente from Ingrediente i where i.Nome = @nomeIngrediente

insert into Pizza_Ingrediente values (@IDPIZZA, @IDINGR)
GO
/****** Object:  StoredProcedure [dbo].[EliminaIngredienteDaPizza]    Script Date: 12/17/2021 3:26:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[EliminaIngredienteDaPizza]
@nomePizza varchar(50),
@nomeIngr varchar(50)
as
declare @IDPIZZA int
select @IDPIZZA = p.IdPizza from Pizza p where p.Nome = @nomePizza
declare @IDINGR int
select @IDINGR = i.IdIngrediente from Ingrediente i where i.Nome = @nomeIngr

delete 
from Pizza_Ingrediente
where IdPizza = @IDPIZZA and IdIngrediente = @IDINGR
GO
/****** Object:  StoredProcedure [dbo].[IncrementoPrezzoPercentuale]    Script Date: 12/17/2021 3:26:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[IncrementoPrezzoPercentuale]
@nomeIngrediente varchar(50)
as
update Pizza
set Prezzo = Prezzo + (Prezzo * 0.1)
where Nome in (select p.Nome
			   from Pizza p join Pizza_Ingrediente pizzI on p.IdPizza = pizzI.IdPizza
						   join Ingrediente i on pizzI.IdIngrediente = i.IdIngrediente
			   where i.Nome = @nomeIngrediente)
GO
/****** Object:  StoredProcedure [dbo].[InserisciIngrediente]    Script Date: 12/17/2021 3:26:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[InserisciIngrediente]
@nomeIngrediente varchar(50),
@costoIngrediente decimal,
@scorteIngrediente int
as
insert into Ingrediente values (@nomeIngrediente, @costoIngrediente, @scorteIngrediente)
GO
/****** Object:  StoredProcedure [dbo].[InserisciPizza]    Script Date: 12/17/2021 3:26:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[InserisciPizza]
@nomePizza varchar(50),
@prezzoPizza decimal
as
insert into Pizza values (@nomePizza, @prezzoPizza)
GO
USE [master]
GO
ALTER DATABASE [Pizzeria] SET  READ_WRITE 
GO
