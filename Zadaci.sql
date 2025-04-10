-- 1. Napravite tablicu Polaznik i u nju umetnite nekoliko redaka. Napravite tablicu Zapisnik.

CREATE TABLE Polaznik(
IDPolaznik int PRIMARY KEY IDENTITY,
Ime nvarchar(15),
Prezime nvarchar(30)
)
INSERT INTO Polaznik
SELECT TOP 3 Ime,Prezime FROM Kupac

CREATE TABLE Zapis(
IDZapisa int PRIMARY KEY IDENTITY,
Akcija nvarchar(10),
Detalji nvarchar(50),
Vrijeme DATETIME DEFAULT GETDATE()

)
Select N'Maroččč?'
--2. Napravite okidač kojim ćete svako umetanje retka u tablicu Polaznik zapisati u tablicu Zapisnik.
GO
CREATE TRIGGER trg_AfterIsert_Polaznik
ON Polaznik
AFTER INSERT 
AS 
BEGIN
	INSERT INTO Zapis (Akcija,Detalji)
	VALUES ('Insert','Umetnut novi polaznik u tablicu Polaznik')
	END
--3. Promijenite okidač tako da zapiše ime, prezime umetnutog polaznika u Zapisnik.
GO
DROP TRIGGER trg_AfterIsert_Polaznik
GO
CREATE TRIGGER trg_AfterIsert_Polaznik
ON Polaznik 
AFTER INSERT 
AS 
BEGIN
SET NOCOUNT ON
INSERT INTO Zapis (Akcija,Detalji)
	SELECT 'Insert','Umetnut '+Ime +' '+Prezime FROM inserted
	END

--4. Promijenite okidač tako da se veže uz sve događaje i u Zapisnik zapisuje broj redaka u inserted 
		--i deleted tablicama. Umetnite novog polaznika, promijenite svim polaznicima prezime i na kraju 
--obrišite sve polaznike.
GO
DROP TRIGGER trg_AfterIsert_Polaznik
GO
CREATE TRIGGER trg_AfterIsert_Polaznik
ON Polaznik 
AFTER INSERT , UPDATE ,DELETE
AS 
BEGIN
SET NOCOUNT ON
DECLARE @UmetnutiRedak INT =(SELECT COUNT(*) FROM inserted)
DECLARE @ObrisaniRedak INT =(SELECT COUNT(*) FROM deleted)
INSERT INTO Zapis (Akcija,Detalji)
	VALUES( 'Insert','Umetnutih redaka '+CAST(@UmetnutiRedak AS NVARCHAR) +' Obrisanih Redaka ' +CAST(@ObrisaniRedak AS NVARCHAR));
	END

	INSERT INTO Polaznik
SELECT TOP 5 Ime,Prezime FROM Kupac
DELETE FROM Polaznik
SELECT * FROM Zapis

--5. Promijenite okidač tako da upisuje staru i novu vrijednost promijenjenog prezimena u Zapisnik.

GO
DROP TRIGGER trg_AfterIsert_Polaznik
GO
CREATE TRIGGER trg_AfterIsert_Polaznik
ON Polaznik 
AFTER INSERT , UPDATE ,DELETE
AS 
BEGIN
SET NOCOUNT ON
DECLARE @UmetnutiRedak nvarchar =CAST((SELECT 'Novo Ime :'+ i.Ime + ' '+i.Prezime +' Staro ime '+d.Ime + ' '+d.Prezime FROM inserted as i
INNER JOIN deleted as d 
ON d.Ime = i.Ime) as NVARCHAR)

INSERT INTO Zapis (Akcija,Detalji)
	VALUES( 'Insert',@UmetnutiRedak  );
	END

	INSERT INTO Polaznik
SELECT TOP 55 Ime,Prezime FROM Kupac
	INSERT INTO Polaznik (Prezime)
	Values('Janko?')
SELECT * FROM Zapis


--Napišite proceduru koja dohvaća prvih 10 redaka iz tablice Proizvod, prvih 5 
--redaka iz tablice KreditnaKartica i zadnja 3 retka iz tablice Racun. Pozovite 
--proceduru. Uklonite proceduru.
GO
DROP PROCEDURE Tablice
GO
CREATE PROCEDURE Tablice
AS
BEGIN
	SELECT TOP 10 * FROM Kupac
	SELECT TOP 5 * FROM KreditnaKartica
	SELECT TOP 3 * FROM Racun
	ORDER BY IDRacun desc;
END;
EXEC Tablice ;


--4. Napišite proceduru koja prima dvije cijene i vraća nazive i cijene svih proizvoda čija cijena je u zadanom rasponu. 
--Pozovite proceduru na oba načina. Uklonite proceduru. 
GO
CREATE PROCEDURE Cijene @c1 INT, @c2 INT
AS
BEGIN
	SELECT Naziv , CijenaBezPDV FROM Proizvod
	WHERE CijenaBezPDV BETWEEN @c1 AND @c2
END;
EXEC Cijene 22, 122;


GO
DROP PROC DohvatiBoju
GO
CREATE PROC DohvatiBoju @IDProizvoda INT ,@Boja nvarchar(20)  OUTPUT
as
BEGIN
SELECT @Boja = Boja FROM Proizvod  WHERE IDProizvod  = @IDProizvoda
END;

DECLARE @Boja2 nvarchar(20)
EXEC DohvatiBoju 318 , @Boja2 OUTPUT;
PRINT @Boja2