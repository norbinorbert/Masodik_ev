USE DeliveryCompanies
GO

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION
-- beszurunk egy sort, majd ujbol olvasunk A-ban
INSERT INTO Foods VALUES ('Fantom', 'Description', 10.99, 1)

ROLLBACK

-- megoldas: SERIALIZABLE ISOLATION LEVEL

