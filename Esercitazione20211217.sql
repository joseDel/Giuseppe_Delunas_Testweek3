-- Esercitazione pizzeria

create database Pizzeria

create table Pizza (
IdPizza int identity(1,1) not null constraint PK_IdPizza primary key,
Nome varchar(50),
Prezzo decimal(4, 2) constraint check_prezzo_pos check (Prezzo>0)
)

create table Ingrediente (
IdIngrediente int identity(1,1) not null constraint PK_IdIngrediente primary key,
Nome varchar(50),
Costo decimal(4, 2) constraint check_costo_pos check (Costo>0),
Scorte int constraint check_scorte_nonNeg check (Scorte>0)
)

create table Pizza_Ingrediente (
IdPizza int Constraint FK_IdPizza foreign key references Pizza(IdPizza),
IdIngrediente int Constraint FK_IdIngrediente foreign key references Ingrediente(IdIngrediente)
)

-- procedure inserimento
create procedure InserisciPizza
@nomePizza varchar(50),
@prezzoPizza decimal
as
insert into Pizza values (@nomePizza, @prezzoPizza)
go

create procedure InserisciIngrediente
@nomeIngrediente varchar(50),
@costoIngrediente decimal,
@scorteIngrediente int
as
insert into Ingrediente values (@nomeIngrediente, @costoIngrediente, @scorteIngrediente)
go

create procedure AssociaPizzaIngrediente
@nomePizza varchar(50),
@nomeIngrediente varchar(50)
as

declare @IDPIZZA int
select @IDPIZZA = p.IdPizza from pizza p where p.Nome = @nomePizza

declare @IDINGR int
select @IDINGR = i.IdIngrediente from Ingrediente i where i.Nome = @nomeIngrediente

insert into Pizza_Ingrediente values (@IDPIZZA, @IDINGR)
go

-- inserimento pizze
execute InserisciPizza 'Margherita', 5
execute InserisciPizza 'Bufala', 7
execute InserisciPizza 'Diavola', 6
execute InserisciPizza 'Quattro stagioni', 6.5
execute InserisciPizza 'Porcini', 7
execute InserisciPizza 'Dioniso', 8
execute InserisciPizza 'Ortolana', 8
execute InserisciPizza 'Patate e salsiccia', 6
execute InserisciPizza 'Pomodorini', 6
execute InserisciPizza 'Quattro formaggi', 7.5
execute InserisciPizza 'Caprese', 7.5
execute InserisciPizza 'Zeus', 7.5

-- inserimento ingredienti
execute InserisciIngrediente 'Pomodoro', 1, 50
execute InserisciIngrediente 'Mozzarella', 2, 75
execute InserisciIngrediente 'Mozzarella di bufala', 3, 40
execute InserisciIngrediente 'Spianata piccante', 1.5, 30
execute InserisciIngrediente 'Funghi', 3.5, 60
execute InserisciIngrediente 'Carciofi', 1, 75
execute InserisciIngrediente 'Cotto', 2.5, 90
execute InserisciIngrediente 'Olive', 3, 75
execute InserisciIngrediente 'Funghi porcini', 4, 50
execute InserisciIngrediente 'Stracchino', 3, 10
execute InserisciIngrediente 'Speck', 2.5, 120
execute InserisciIngrediente 'Rucola', 1, 18
execute InserisciIngrediente 'Grana', 0.5, 100
execute InserisciIngrediente 'Verdure di stagione', 2, 100
execute InserisciIngrediente 'Patate', 1, 80
execute InserisciIngrediente 'Salsiccia', 2.5, 40
execute InserisciIngrediente 'Pomodorini', 2, 70
execute InserisciIngrediente 'Ricotta', 2.5, 65
execute InserisciIngrediente 'Provola', 4, 25
execute InserisciIngrediente 'Gorgonzola', 3, 80
execute InserisciIngrediente 'Pomodoro fresco', 1.5, 30
execute InserisciIngrediente 'Basilico', 0.4, 20
execute InserisciIngrediente 'Bresaola', 4, 10

-- inserimento Pizza_ingrediente
execute AssociaPizzaIngrediente 'Margherita', 'Pomodoro'
execute AssociaPizzaIngrediente 'Margherita', 'Mozzarella'
execute AssociaPizzaIngrediente 'Bufala', 'Pomodoro'
execute AssociaPizzaIngrediente 'Bufala', 'Mozzarella di bufala'
execute AssociaPizzaIngrediente 'Bufala', 'Mozzarella'
execute AssociaPizzaIngrediente 'Diavola', 'Mozzarella'
execute AssociaPizzaIngrediente 'Diavola', 'Pomodoro'
execute AssociaPizzaIngrediente 'Diavola', 'Spianata piccante'
execute AssociaPizzaIngrediente 'Quattro stagioni', 'Mozzarella'
execute AssociaPizzaIngrediente 'Quattro stagioni', 'Pomodoro'
execute AssociaPizzaIngrediente 'Quattro stagioni', 'Funghi'
execute AssociaPizzaIngrediente 'Quattro stagioni', 'Carciofi'
execute AssociaPizzaIngrediente 'Quattro stagioni', 'Cotto'
execute AssociaPizzaIngrediente 'Quattro stagioni', 'Olive'
execute AssociaPizzaIngrediente 'Porcini', 'Pomodoro'
execute AssociaPizzaIngrediente 'Porcini', 'Mozzarella'
execute AssociaPizzaIngrediente 'Porcini', 'Funghi porcini'
execute AssociaPizzaIngrediente 'Dioniso', 'Pomodoro'
execute AssociaPizzaIngrediente 'Dioniso', 'Mozzarella'
execute AssociaPizzaIngrediente 'Dioniso', 'Stracchino'
execute AssociaPizzaIngrediente 'Dioniso', 'Speck'
execute AssociaPizzaIngrediente 'Dioniso', 'Rucola'
execute AssociaPizzaIngrediente 'Dioniso', 'Grana'
execute AssociaPizzaIngrediente 'Ortolana', 'Pomodoro'
execute AssociaPizzaIngrediente 'Ortolana', 'Mozzarella'
execute AssociaPizzaIngrediente 'Ortolana', 'Verdure di stagione'
execute AssociaPizzaIngrediente 'Patate e salsiccia', 'Mozzarella'
execute AssociaPizzaIngrediente 'Patate e salsiccia', 'Salsiccia'
execute AssociaPizzaIngrediente 'Patate e salsiccia', 'Patate'
execute AssociaPizzaIngrediente 'Pomodorini', 'Pomodorini'
execute AssociaPizzaIngrediente 'Pomodorini', 'Ricotta'
execute AssociaPizzaIngrediente 'Pomodorini', 'Mozzarella'
execute AssociaPizzaIngrediente 'Quattro formaggi', 'Mozzarella'
execute AssociaPizzaIngrediente 'Quattro formaggi', 'Provola'
execute AssociaPizzaIngrediente 'Quattro formaggi', 'Gorgonzola'
execute AssociaPizzaIngrediente 'Quattro formaggi', 'Grana'
execute AssociaPizzaIngrediente 'Caprese', 'Mozzarella'
execute AssociaPizzaIngrediente 'Caprese', 'Pomodoro fresco'
execute AssociaPizzaIngrediente 'Caprese', 'Basilico'
execute AssociaPizzaIngrediente 'Zeus', 'Mozzarella'
execute AssociaPizzaIngrediente 'Zeus', 'Bresaola'
execute AssociaPizzaIngrediente 'Zeus', 'Rucola'

-- Queries
-- 1)
select *
from Pizza p
where p.Prezzo > 6

-- 2)
select p.Nome, p.Prezzo
from Pizza p
where p.Prezzo = (select max(p.Prezzo)
				  from Pizza p)

-- 3)
select *
from Pizza p
where p.Nome not in (select p.Nome 
					 from Pizza p join Pizza_Ingrediente pizzI on p.IdPizza = pizzI.IdPizza
								  join Ingrediente i on pizzI.IdIngrediente = i.IdIngrediente
					 where i.Nome = 'Pomodoro'
)

-- 4)
select p.Nome, p.Prezzo
from Pizza p join Pizza_Ingrediente pizzI on p.IdPizza = pizzI.IdPizza
			 join Ingrediente i on pizzI.IdIngrediente = i.IdIngrediente
where i.Nome like '%Funghi%'

-- Procedure
-- 1) Inserimento nuova pizza ---> già svolto sopra (InserisciIngrediente)

-- 2) Assegnazione ingrediente a pizza ---> svolto sopra (AssociaPizzaIngrediente)

-- 3) 
create procedure AggiornaPrezzoPizza
@nomePizza varchar(50),
@nuovoPrezzo decimal
as
update Pizza
set Prezzo = @nuovoPrezzo
where Nome = @nomePizza

execute AggiornaPrezzoPizza 'Patate e salsiccia', 7

-- 4)
create procedure EliminaIngredienteDaPizza
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
go

execute EliminaIngredienteDaPizza 'Quattro stagioni', 'Carciofi'

-- 5)
create procedure IncrementoPrezzoPercentuale
@nomeIngrediente varchar(50)
as
update Pizza
set Prezzo = Prezzo + (Prezzo * 0.1)
where Nome in (select p.Nome
			   from Pizza p join Pizza_Ingrediente pizzI on p.IdPizza = pizzI.IdPizza
						   join Ingrediente i on pizzI.IdIngrediente = i.IdIngrediente
			   where i.Nome = @nomeIngrediente)
go

execute IncrementoPrezzoPercentuale 'Rucola'



-- Funzioni
-- 1)
create function ListinoPizze()
returns table
as
return
select p.Nome, p.Prezzo from Pizza p

select * from ListinoPizze()

-- 2)
create function ListinoPizzeIngrediente(@nomeIngrediente varchar(50))
returns table
as
return
select p.Nome, p.Prezzo
from Pizza p join Pizza_Ingrediente pizzI on p.IdPizza = pizzI.IdPizza
			 join Ingrediente i on pizzI.IdIngrediente = i.IdIngrediente
where i.IdIngrediente = (select i.IdIngrediente
from Ingrediente i
where i.Nome = @nomeIngrediente)

select * from ListinoPizzeIngrediente('Rucola')

-- 3)
create function ListinoPizzeSenzaIngrediente(@nomeIngrediente varchar(50))
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

select * from ListinoPizzeSenzaIngrediente('Mozzarella')

-- 4)
create function NumPizzeContenentiIngrediente(@nomeIngrediente varchar(50))
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

select dbo.NumPizzeContenentiIngrediente('Rucola') as [Numero pizze contenenti ingrediente selezionato]

-- 5)
create function NumPizzeSenzaIngrediente(@codiceIngrediente int)
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

select dbo.NumPizzeSenzaIngrediente(12) as [Numero pizze che non contengono ingrediente selezionato]

-- 6)
create function NumIngredientiPizza(@nomePizza varchar(50))
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

select dbo.NumIngredientiPizza('Dioniso') as [Numero ingredienti contenuti nella pizza selezionata]


-- Vista
create view Menu as
select p.Nome as Pizza, p.Prezzo, stuff((SELECT ', ' + i.Nome
										 from Pizza p join Pizza_Ingrediente pizzI on p.IdPizza = pizzI.IdPizza
													  join Ingrediente i on pizzI.IdIngrediente = i.IdIngrediente 
										 FOR XML PATH('')), 1, 2, '') as Ingredienti
from Pizza p join Pizza_Ingrediente pizzI on p.IdPizza = pizzI.IdPizza
			 join Ingrediente i on pizzI.IdIngrediente = i.IdIngrediente
group by p.Nome, p.Prezzo
