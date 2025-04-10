
--DZ 
--5. Promijenite okidač tako da upisuje staru i novu vrijednost promijenjenog prezimena u Zapisnik.
--2. Napišite proceduru koja dohvaća prvih 10 redaka iz tablice Proizvod, 
--prvih 5 redaka iz tablice KreditnaKartica i zadnja 3 retka iz tablice Racun. 
--Pozovite proceduru. Uklonite proceduru.
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
DROP PROC Tablice;


--3. Napišite proceduru koja prima @ID proizvoda i  vraća samo taj proizvod iz tablice Proizvod. 
--Pozovite proceduru na oba načina. Uklonite proceduru.

GO
CREATE PROC DohvatiProizvodPoID @ID INT
AS
BEGIN
 SELECT * FROM Proizvod WHERE IDProizvod = @ID
END;

Exec DohvatiProizvodPoID 4 ;

DROP PROC DohvatiProizvodPoID

--5. Napišite proceduru koja prima četiri parametra potrebna za unos nove kreditne kartice. 
--Neka procedura napravi novi zapis u KreditnaKartica. Neka procedura prije i nakon 
--umetanja dohvati broj zapisa u tablici. Pozovite proceduru na oba načina. Uklonite proceduru.

GO
CREATE PROC K_Kartica 
@Tip nvarchar(50),
@Broj nvarchar(25),
@IstekMjesec tinyint,
@IstekGodina smallint
AS
BEGIN
INSERT INTO KreditnaKartica 
VALUES(@Tip,@Broj,@IstekMjesec,@IstekGodina)
END;

/* 
DZ 
--5. Promijenite okidač tako da upisuje staru i novu vrijednost promijenjenog prezimena u Zapisnik.
*/
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
--2. Napišite proceduru koja dohvaća prvih 10 redaka iz tablice Proizvod, 
--prvih 5 redaka iz tablice KreditnaKartica i zadnja 3 retka iz tablice Racun. 
--Pozovite proceduru. Uklonite proceduru.

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

--6. Napišite proceduru koja prima tri boje i za svaku boju vraća proizvode u njoj. Pozovite proceduru i nakon toga je uklonite.




--8. Napišite proceduru koja prima kriterij po kojemu ćete filtrirati prezimena iz tablice Kupac. Neka procedura pomoću izlaznog parametra vrati broj zapisa koji zadovoljavaju zadani kriterij. Neka procedura vrati i sve zapise koji zadovoljavaju kriterij. Pozovite proceduru i ispišite vraćenu vrijednost. Uklonite proceduru.
--9. Napišite proceduru koja za zadanog komercijalistu pomoću izlaznih parametara vraća njegovo ime i prezime te ukupnu količinu izdanih računa.

