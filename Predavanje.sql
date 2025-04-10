
--Okidači
DECLARE @Ime nvarchar(20)
SET @Ime= 'Marko'
PRINT @Ime
SELECT @Ime  AS Ime

DECLARE @prodano int
SET @prodano = (SELECT SUM(Kolicina) FROM Stavka)
PRINT @prodano

DECLARE @NazivProizvoda nvarchar(50)
DECLARE @BojaProizvoda nvarchar(50)
SELECT 
@NazivProizvoda = p.Naziv,
@BojaProizvoda = p.Boja
FROM Proizvod AS p WHERE p.IDProizvod = 741
PRINT @NazivProizvoda 
PRINT @BojaProizvoda

DECLARE @ProsjecnaCijena money
SELECT @ProsjecnaCijena = AVG(CijenaBezPDV) 
FROM Proizvod AS p
PRINT @ProsjecnaCijena
SELECT * FROM Proizvod
WHERE CijenaBezPDV >= @ProsjecnaCijena
GO


GO
CREATE PROCEDURE DohvatiKupce
AS
BEGIN
	SELECT * FROM Kupac;
END;
EXEC DohvatiKupce ;



GO
ALTER PROCEDURE DohvatiKupce
AS
BEGIN
	SELECT * FROM Kupac
	ORDER BY Ime ,Prezime;
END;
EXEC DohvatiKupce ;

DROP PROC DohvatiKupce