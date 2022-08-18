-- STORING & RETRIEVING DATA - GROUP 20 (imCINEMA BOOKING SYSTEM)
-- -----------------------------------------------------

CREATE DATABASE IF NOT EXISTS `S&RD__PROJECT`;
USE  `S&RD__PROJECT`;

-- -----------------------------------------------------
-- Table `S&RD__PROJECT`.`City`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S&RD__PROJECT`.`City` (
  `City_ID` INT NOT NULL,
  `City_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`City_ID`))
;


-- -----------------------------------------------------
-- Table `S&RD__PROJECT`.`Cinema`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S&RD__PROJECT`.`Cinema` (
  `Cinema_ID` INT NOT NULL,
  `Cinema_Name` VARCHAR(45) NOT NULL,
  `Cinema_Adress` VARCHAR(45) NOT NULL,
  `Cinema_Contact` VARCHAR(45) NOT NULL,
  `Cinema_NrCinemaRooms` INT NOT NULL,
  `City_ID` INT NOT NULL,
  `Cinema_Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Cinema_ID`),
  INDEX `fk_Cinemas_Cidades1_idx` (`City_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Cinemas_Cidades1`
    FOREIGN KEY (`City_ID`)
    REFERENCES `S&RD__PROJECT`.`City` (`City_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `S&RD__PROJECT`.`CinemaRoom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S&RD__PROJECT`.`CinemaRoom` (
  `CRoom_ID` INT NOT NULL,
  `Cinema_ID` INT NOT NULL,
  `CRoom_NrSeats` INT NOT NULL,
  PRIMARY KEY (`CRoom_ID`, `Cinema_ID`),
  INDEX `fk_Salas_Cinemas_idx` (`Cinema_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Salas_Cinemas`
    FOREIGN KEY (`Cinema_ID`)
    REFERENCES `S&RD__PROJECT`.`Cinema` (`Cinema_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `S&RD__PROJECT`.`Movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S&RD__PROJECT`.`Movie` (
  `Movie_ID` INT NOT NULL,
  `Movie_Title` VARCHAR(45) NOT NULL,
  `Movie_Duration` INT NULL,
  `Movie_PGRating` VARCHAR(45) NULL,
  `Movie_PremiereDate` DATETIME NOT NULL,
  `Movie_LastDate` VARCHAR(45) NOT NULL,
  `Movie_OnDisplay` TINYINT NOT NULL,
  `Movie_Rating` FLOAT NOT NULL,
  `Movie_ReleaseYear` INT NOT NULL,
  PRIMARY KEY (`Movie_ID`))
;


-- -----------------------------------------------------
-- Table `S&RD__PROJECT`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S&RD__PROJECT`.`Category` (
  `Cat_ID` INT NOT NULL,
  `Cat_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Cat_ID`))
;


-- -----------------------------------------------------
-- Table `S&RD__PROJECT`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S&RD__PROJECT`.`Customer` (
  `Cust_ID` INT NOT NULL,
  `Cust_FirstName` VARCHAR(45) NOT NULL,
  `Cust_LastName` VARCHAR(45) NOT NULL,
  `Cust_Password` VARCHAR(45) NULL,
  `Cust_Contact` VARCHAR(45) NOT NULL,
  `Cust_Username` VARCHAR(45) NULL,
  `Cust_NIF` INT NULL,
  `Cust_Email` VARCHAR(45) NULL,
  PRIMARY KEY (`Cust_ID`))
;


-- -----------------------------------------------------
-- Table `S&RD__PROJECT`.`Payment_Methods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S&RD__PROJECT`.`Payment_Methods` (
  `PM_ID` INT NOT NULL,
  `PM_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PM_ID`))
;


-- -----------------------------------------------------
-- Table `S&RD__PROJECT`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S&RD__PROJECT`.`Payment` (
  `Payment_ID` INT NOT NULL,
  `PM_ID` INT NOT NULL,
  `Payment_Value` VARCHAR(45) NOT NULL,
  `Payment_Date` DATETIME NOT NULL,
  PRIMARY KEY (`Payment_ID`),
  INDEX `fk_Pagamentos_Meios_Pagamento1_idx` (`PM_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamentos_Meios_Pagamento1`
    FOREIGN KEY (`PM_ID`)
    REFERENCES `S&RD__PROJECT`.`Payment_Methods` (`PM_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `S&RD__PROJECT`.`Ticket_Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S&RD__PROJECT`.`Ticket_Type` (
  `TT_ID` INT NOT NULL,
  `TT_Name` VARCHAR(45) NOT NULL,
  `TT_Price` FLOAT NOT NULL,
  `TT_Tax` FLOAT NOT NULL,
  PRIMARY KEY (`TT_ID`))
;


-- -----------------------------------------------------
-- Table `S&RD__PROJECT`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S&RD__PROJECT`.`Staff` (
  `Staff_ID` INT NOT NULL,
  `Staff_Username` VARCHAR(45) NOT NULL,
  `Staff_Password` VARCHAR(45) NOT NULL,
  `Staff_Active` TINYINT NOT NULL,
  `Staff_StartDate` DATETIME NOT NULL,
  `Staff_EndDate` DATETIME NULL,
  PRIMARY KEY (`Staff_ID`))
;


-- -----------------------------------------------------
-- Table `S&RD__PROJECT`.`Booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S&RD__PROJECT`.`Booking` (
  `Booking_ID` INT NOT NULL,
  `Cust_ID` INT NOT NULL,
  `Payment_ID` INT NOT NULL,
  `TT_ID` INT NOT NULL,
  `Booking_NrTickets` INT NOT NULL,
  `Staff_ID` INT NOT NULL,
  `Booking_Rating` INT NULL,
  PRIMARY KEY (`Booking_ID`),
  INDEX `fk_Reservas_Utilizadores1_idx` (`Cust_ID` ASC) VISIBLE,
  INDEX `fk_Reservas_Pagamentos1_idx` (`Payment_ID` ASC) VISIBLE,
  INDEX `fk_Reservas_Tipos_Bilhetes1_idx` (`TT_ID` ASC) VISIBLE,
  INDEX `fk_Reservas_Staff1_idx` (`Staff_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Reservas_Utilizadores1`
    FOREIGN KEY (`Cust_ID`)
    REFERENCES `S&RD__PROJECT`.`Customer` (`Cust_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservas_Pagamentos1`
    FOREIGN KEY (`Payment_ID`)
    REFERENCES `S&RD__PROJECT`.`Payment` (`Payment_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservas_Tipos_Bilhetes1`
    FOREIGN KEY (`TT_ID`)
    REFERENCES `S&RD__PROJECT`.`Ticket_Type` (`TT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservas_Staff1`
    FOREIGN KEY (`Staff_ID`)
    REFERENCES `S&RD__PROJECT`.`Staff` (`Staff_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `S&RD__PROJECT`.`Seat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S&RD__PROJECT`.`Seat` (
  `Seat_ID` INT NOT NULL,
  `Cinema_ID` INT NOT NULL,
  `CRoom_ID` INT NOT NULL,
  `Seat_Row` VARCHAR(45) NOT NULL,
  `Seat_Number` INT NOT NULL,
  PRIMARY KEY (`Seat_ID`),
  INDEX `fk_Lugares_Salas1_idx` (`CRoom_ID` ASC, `Cinema_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Lugares_Salas1`
    FOREIGN KEY (`CRoom_ID` , `Cinema_ID`)
    REFERENCES `S&RD__PROJECT`.`CinemaRoom` (`CRoom_ID` , `Cinema_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `S&RD__PROJECT`.`Exhibition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S&RD__PROJECT`.`Exhibition` (
  `Exhibition_ID` INT NOT NULL,
  `Movie_ID` INT NOT NULL,
  `Cinema_ID` INT NOT NULL,
  `CRoom_ID` INT NOT NULL,
  `Exhibition_BeginDateTime` DATETIME NOT NULL,
  `Exhibition_EndDateTime` DATETIME NOT NULL,
  `Lotation` FLOAT NOT NULL,
  PRIMARY KEY (`Exhibition_ID`),
  INDEX `fk_Exibicoes_Filmes2_idx` (`Movie_ID` ASC) VISIBLE,
  INDEX `fk_Exibicoes_Salas1_idx` (`CRoom_ID` ASC, `Cinema_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Exibicoes_Filmes2`
    FOREIGN KEY (`Movie_ID`)
    REFERENCES `S&RD__PROJECT`.`Movie` (`Movie_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Exibicoes_Salas1`
    FOREIGN KEY (`CRoom_ID` , `Cinema_ID`)
    REFERENCES `S&RD__PROJECT`.`CinemaRoom` (`CRoom_ID` , `Cinema_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `S&RD__PROJECT`.`Log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S&RD__PROJECT`.`Log` (
  `Log_ID` INT NOT NULL AUTO_INCREMENT,
  `Log_Datetime` DATETIME NOT NULL,
  `Log_OldDatetimeExhibition` DATETIME NOT NULL,
  `Log_NewDatetimeExhibition` VARCHAR(45) NOT NULL,
  `Log_Exhibition_ID` INT NOT NULL,
  PRIMARY KEY (`Log_ID`))
;


-- -----------------------------------------------------
-- Table `S&RD__PROJECT`.`Category_Movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S&RD__PROJECT`.`Category_Movie` (
  `Cat_ID` INT NOT NULL,
  `Movie_ID` INT NOT NULL,
  PRIMARY KEY (`Cat_ID`, `Movie_ID`),
  INDEX `fk_Categorias_has_Filmes_Filmes1_idx` (`Movie_ID` ASC) VISIBLE,
  INDEX `fk_Categorias_has_Filmes_Categorias1_idx` (`Cat_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Categorias_has_Filmes_Categorias1`
    FOREIGN KEY (`Cat_ID`)
    REFERENCES `S&RD__PROJECT`.`Category` (`Cat_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Categorias_has_Filmes_Filmes1`
    FOREIGN KEY (`Movie_ID`)
    REFERENCES `S&RD__PROJECT`.`Movie` (`Movie_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `S&RD__PROJECT`.`Snack`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S&RD__PROJECT`.`Snack` (
  `Snack_ID` INT NOT NULL,
  `Snack_Name` VARCHAR(45) NOT NULL,
  `Snack_Price` FLOAT NOT NULL,
  `Snack_Tax` FLOAT NOT NULL,
  PRIMARY KEY (`Snack_ID`))
;


-- -----------------------------------------------------
-- Table `S&RD__PROJECT`.`Snack_Booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S&RD__PROJECT`.`Snack_Booking` (
  `Snack_ID` INT NOT NULL,
  `Booking_ID` INT NOT NULL,
  `SnackBooking_Quantity` INT NULL,
  PRIMARY KEY (`Snack_ID`, `Booking_ID`),
  INDEX `fk_Produtos_has_Reservas_Reservas1_idx` (`Booking_ID` ASC) VISIBLE,
  INDEX `fk_Produtos_has_Reservas_Produtos1_idx` (`Snack_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Produtos_has_Reservas_Produtos1`
    FOREIGN KEY (`Snack_ID`)
    REFERENCES `S&RD__PROJECT`.`Snack` (`Snack_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produtos_has_Reservas_Reservas1`
    FOREIGN KEY (`Booking_ID`)
    REFERENCES `S&RD__PROJECT`.`Booking` (`Booking_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `S&RD__PROJECT`.`Role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S&RD__PROJECT`.`Role` (
  `Role_ID` INT NOT NULL,
  `Role_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Role_ID`))
;


-- -----------------------------------------------------
-- Table `S&RD__PROJECT`.`Staff_Role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S&RD__PROJECT`.`Staff_Role` (
  `Staff_ID` INT NOT NULL,
  `Role_ID` INT NOT NULL,
  PRIMARY KEY (`Staff_ID`, `Role_ID`),
  INDEX `fk_Staff_has_Posicoes_Posicoes1_idx` (`Role_ID` ASC) VISIBLE,
  INDEX `fk_Staff_has_Posicoes_Staff1_idx` (`Staff_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Staff_has_Posicoes_Staff1`
    FOREIGN KEY (`Staff_ID`)
    REFERENCES `S&RD__PROJECT`.`Staff` (`Staff_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Staff_has_Posicoes_Posicoes1`
    FOREIGN KEY (`Role_ID`)
    REFERENCES `S&RD__PROJECT`.`Role` (`Role_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `S&RD__PROJECT`.`Booking_Seat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S&RD__PROJECT`.`Booking_Seat` (
  `Booking_ID` INT NOT NULL,
  `Seat_ID` INT NOT NULL,
  `Exhibition_ID` INT NOT NULL,
  PRIMARY KEY (`Booking_ID`, `Seat_ID`, `Exhibition_ID`),
  INDEX `fk_Booking_Seat_Seat1_idx` (`Seat_ID` ASC) VISIBLE,
  INDEX `fk_Booking_Seat_Booking1_idx` (`Booking_ID` ASC) VISIBLE,
  INDEX `fk_Booking_Seat_Exhibition1_idx` (`Exhibition_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Booking_Seat_Booking1`
    FOREIGN KEY (`Booking_ID`)
    REFERENCES `S&RD__PROJECT`.`Booking` (`Booking_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Booking_Seat_Seat1`
    FOREIGN KEY (`Seat_ID`)
    REFERENCES `S&RD__PROJECT`.`Seat` (`Seat_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Booking_Seat_Exhibition1`
    FOREIGN KEY (`Exhibition_ID`)
    REFERENCES `S&RD__PROJECT`.`Exhibition` (`Exhibition_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

-- DATA INSERTION:
-- -----------------------------------------------------
INSERT INTO `CITY` (`CITY_ID`, `CITY_NAME`) VALUES 
(1, 'Lisboa'),
(2, 'Porto'),
(3, 'Coimbra'),
(4, 'Faro'),
(5, 'Aveiro')
;

INSERT INTO `CINEMA` (`CINEMA_ID`,`CINEMA_NAME`,`CINEMA_ADRESS`, `CINEMA_CONTACT`, `CINEMA_NRCINEMAROOMS`, `CITY_ID`, `CINEMA_EMAIL`) VALUES
(1, 'IMCineLisboa', 'Rua Visconde de Oeiras, 3','216758876', 5, 1, 'imcinelisboa@gmail.com'),
(2, 'IMCineLisboaChiado', 'Praça Publica 3, R/C','216777894', 3, 1, 'imcinelisboachiado@gmail.com'),
(3, 'IMCinePorto', 'Travessa dos Travesseiros, 17 3ºD','2167811323', 4, 2, 'imcineporto@gmail.com'),
(4, 'IMCineCoimbra', 'Rua do Entronco, 4 R/C','2144456212', 3, 3, 'imcinecoimbra@gmail.com'),
(5, 'IMCineFaro', 'Rua Cheia de Graça, 291 2ºE','214678900', 4, 4, 'imcinefaro@gmail.com'),
(6, 'IMCineAveiro', 'Rua Vasco da Columbo, 18','211236780', 4, 5, 'imcineaveiro@gmail.com')
;

INSERT INTO `CINEMAROOM` (`CROOM_ID`,`CINEMA_ID`,`CROOM_NRSEATS`) VALUES
(1, 1, 8),
(2, 1, 8),
(3, 1, 8),
(4, 1, 8),
(1, 2, 9),
(2, 2, 9),
(1, 3, 7),
(2, 3, 7),
(1, 4, 8),
(2, 4, 8),
(1, 5, 6),
(1, 6, 6)
;

INSERT INTO `MOVIE` (`MOVIE_ID`, `MOVIE_TITLE`, `MOVIE_Duration`, `MOVIE_PGRating`, `MOVIE_PremiereDate`, `MOVIE_LastDate`, `MOVIE_OnDisplay`, `MOVIE_Rating`, `MOVIE_ReleaseYear`) VALUES 
(1, 'SpiderMan 3', 202,'PG-13' , '2021-11-25', '2022-02-29', 1, 3.8, 2020),
(2, 'Borat', 232,'R' , '2021-05-25', '2021-10-29', 0, 4.8, 2020),
(3, 'Inception', 192,'R' , '2017-03-13', '2017-08-30', 0, 5, 2016),
(4, 'Cars', 162, 'G' , '2012-08-23', '2013-10-05', 0, 3.9, 2012),
(5, 'Kingsman', 198, 'R' , '2021-12-2', '2022-04-20', 1, 4.2, 2021),
(6, 'No Time To Die', 221, 'R' , '2021-09-20', '2022-04-15', 1, 3.6, 2021),
(7, 'Once Upon A Time In Hollywood', 265, 'R' , '2021-12-10', '2022-06-01', 1, 4.2, 2021),
(8, 'Inglorious Bastards', 212, 'R' , '2021-05-29', '2022-01-26', 1, 4.5, 2013),
(9, '12 Angry Men', 200, 'PG-13' , '1999-01-01', '2230-01-01', 1, 4.5, 1957)
;

INSERT INTO `CATEGORY` (`CAT_ID`, `CAT_NAME`) VALUES 
(1, 'Romance'),
(2, 'Drama'),
(3, 'Thriller'),
(4, 'Documentary'),
(5, 'Comedy'),
(6, 'Horror')
;

INSERT INTO `CUSTOMER` (`CUST_ID`, `CUST_FirstName`, `CUST_LastName`, `CUST_Password`, `CUST_Contact`, `CUST_Username`, `CUST_NIF`, `CUST_Email`) VALUES 
(1, 'André', 'Leonor', '13d12Ws12', '914123456', 'AndreLR', 234345456, 'andreleonor@sapo.pt'),
(2, 'Rita', 'Ronaldo', 'ff12Wsapo12', '934123992', 'Ritinha79', 291125291, 'ritaronalds@gmail.com'),
(3, 'Rodrigo', 'Bernardo', 'jasfiwj24', '912121229', 'Maddog', 212864545, 'rodrigober@gmail.com'),
(4, 'Mariana', 'Joana', 'animalestimacao', '932019283', 'nomedoanimal', 232823511, 'nomedoanimal@gmail.com'),
(5, 'Beatriz', 'Serradeiro', 'Bea.1906.SCP', '936258137', 'scpfan', 212556123, 'beascp1906@gmail.com'),
(6, 'Paula', 'Matreira', 'paulixmatrix', '918898767', 'PaulaMira', 264647645, 'paulmatrix@gmail.com'),
(7, 'Miro', 'Atiro', 'mironoteu23', '966030281', 'MiroAtiro', 292888945, 'atiromiro@gmail.com'),
(8, 'Mara', 'Cuja', 'funkeira213', '963243212', 'MaraNaoCja', 214315416, 'brasilbrkkkk@gmail.com'),
(9, 'João', 'Silva', 'desviopadrap', '913112345', 'silvadelas', 213860091, 'joaogenerico@gmail.com'),
(10, 'José', 'Mário','animallindo88', '964778811', 'joseMario1', 245786667, 'jose.mario2203@gmail.com'),
(11, 'Joana', 'Chaves','bebessaofeios', '962475871', 'joChaves4', 277898101, 'chaves_joana2@gmail.com'),
(12, 'Flávia', 'Nunes','nunes1235boi', '932458790', 'nunes_grande', 345666783, 'nunes_cyborgue69@gmail.com'),
(13, 'Paulo', 'Rebelo','peaceandlove_weed', '918765432', 'rebelo_hippie', 244129876, 'paulinho_rebels@gmail.com'),
(14, 'Teresa', 'Marta','martinha_martona', '938769871', 'martaTeresa61', 345687121, 'brincas_malxD_mutante@gmail.com')
;

INSERT INTO `PAYMENT_METHODS` (`PM_ID`,`PM_NAME`) VALUES
(1, 'MBWay'),
(2, 'PayPal'),
(3, 'Money'),
(4, 'Debit/Credit Card')
;

INSERT INTO `PAYMENT` (`Payment_ID`, `PM_ID`, `Payment_Value`, `Payment_Date`) VALUES 
(1, 1, 7, '2021-12-15'),
(2, 1, 7, '2021-10-14'),
(3, 1, 14, '2021-09-16'),
(4, 1, 14, '2021-09-17'),
(5, 1, 10.5, '2021-09-11'),
(6, 2, '7', '2021-08-11'),
(7, 3, '7', '2021-11-10'),
(8, 4, '4', '2021-01-12'),
(9, 4, '4', '2021-02-22'),
(10, 3, '4','2021-08-21'),
(11, 2, '8', '2021-07-28'),
(12, 2, '8','2021-06-26'),
(13, 2, '12','2021-02-01'),
(14, 1, '12','2020-03-02'),
(15, 1, '14', '2020-04-06'),
(16, 2, '21', '2020-12-09'),
(17, 3, '28', '2020-11-08'),
(18, 4, '4.5', '2020-10-30'),
(19, 2, '3.5', '2020-10-12'),
(20, 3, '14', '2020-10-07'),
(21, 4, '7', '2020-05-05'),
(22, 4, '7', '2020-05-01'),
(23, 4, '7', '2020-01-01'),
(24, 2, '7','2020-03-09'),
(25, 2, '3.5','2020-02-24')
;

INSERT INTO `TICKET_TYPE` (`TT_ID`,`TT_NAME`,`TT_PRICE`, `TT_TAX`) VALUES
(1, 'Adult', 7, 1.23),
(2, 'Child', 4.5, 1.23),
(3, 'Family', 4, 1.23),
(4, 'Student', 4.50, 1.23),
(5, 'Partnership Discount', 3.5, 1.23)
;

INSERT INTO `STAFF` (`STAFF_ID`,`STAFF_USERNAME`,`STAFF_PASSWORD`, `STAFF_ACTIVE`, `STAFF_STARTDATE`, `STAFF_ENDDATE`) VALUES
(1, 'Antonio_maria', 'zeze1234', 1, '2020-05-01', NULL),
(2, 'Jose_paiva', 'paivinha_golo', 1, '2016-06-22', NULL),
(3, 'Ana_paulinha', 'love_gatosbebes', 1, '2018-04-18', NULL),
(4, 'Pedro_Venancio', 'pintodacosta22', 1, '2021-09-12', NULL),
(5, 'Beatriz_Marega', 'bibiunhasgel123', 1, '2015-12-10', NULL),
(6, 'Mario_Botelho', 'ovelhachone13', 1, '2020-01-06', NULL),
(7, 'Filomena_Maia', 'cautelacomela12', 1, '2013-08-21', NULL)
;

INSERT INTO `BOOKING` (`BOOKING_ID`, `CUST_ID`, `PAYMENT_ID`, `TT_ID`, `BOOKING_NRTICKETS`, `STAFF_ID`, `BOOKING_RATING`) VALUES 
(1, 1, 1, 1, 1, 2, 4),
(2, 7, 2, 2, 2, 1, 5),
(3, 8, 3, 1, 2, 3, 2),
(4, 2, 4, 3, 2, 4, 4),
(5, 14, 5, 3, 3, 5, 4),
(6, 1, 6, 4, 1, 6, 4),
(7, 2, 7, 5, 1, 7, 4),
(8, 3, 8, 1, 1, 1, 5),
(9, 5, 9, 1, 4, 1, 5),
(10, 1, 10, 5, 2, 2, 4),
(11, 10, 11, 5, 3, 4, 4),
(12, 11, 12, 4, 1, 5, 3),
(13, 9, 13, 4, 1, 2, 4),
(14, 7, 14, 1, 1, 2, 4),
(15, 4, 15, 2, 1, 1, 5),
(16, 5, 16, 3, 5, 1, 4),
(17, 1, 17, 1, 6, 6, 1),
(18, 4, 18, 1, 9, 6, 4),
(19, 8, 19, 3, 1, 7, 2),
(20, 13, 20, 5, 2, 2, 5),
(21, 10, 21, 5, 2, 2, 5),
(22, 11, 22, 3, 2, 1, 4),
(23, 6, 23, 2, 4, 1, 3),
(24, 2, 24, 1, 1, 3, 4),
(25, 9, 25, 1, 1, 4, 5)
;

INSERT INTO `SEAT` (`SEAT_ID`,`CINEMA_ID`,`CROOM_ID`, `Seat_Row`, `Seat_Number`) VALUES
(1, 1, 1 , 'A', 1),
(2, 1, 1 , 'A', 2),
(3, 1, 1 , 'A', 3),
(4, 1, 1 , 'A', 4),
(5, 1, 1 , 'B', 1),
(6, 1, 1 , 'B', 2),
(7, 1, 1 , 'B', 3),
(8, 1, 1 , 'B', 4),
(9, 1, 2 , 'A', 1),
(10, 1, 2 , 'A', 2),
(11, 1, 2 , 'A', 3),
(12, 1, 2 , 'A', 4),
(13, 1, 2 , 'B', 1),
(14, 1, 2 , 'B', 2),
(15, 1, 2 , 'B', 3),
(16, 1, 2 , 'B', 4),
(17, 1, 3 , 'A', 1),
(18, 1, 3 , 'A', 2),
(19, 1, 3 , 'A', 3),
(20, 1, 3 , 'A', 4),
(21, 1, 3 , 'B', 1),
(22, 1, 3 , 'B', 2),
(23, 1, 3 , 'B', 3),
(24, 1, 3 , 'B', 4),
(25, 1, 4 , 'A', 1),
(26, 1, 4 , 'A', 2),
(27, 1, 4 , 'A', 3),
(28, 1, 4 , 'A', 4),
(29, 1, 4 , 'B', 1),
(30, 1, 4 , 'B', 2),
(31, 1, 4 , 'B', 3),
(32, 1, 4 , 'B', 4),
(33, 2, 1 , 'A', 1),
(34, 2, 1 , 'A', 2),
(35, 2, 1 , 'A', 3),
(36, 2, 1 , 'A', 4),
(37, 2, 1 , 'A', 5),
(38, 2, 1 , 'B', 1),
(39, 2, 1 , 'B', 2),
(40, 2, 1 , 'B', 3),
(41, 2, 1 , 'B', 4),
(42, 2, 2 , 'A', 1),
(43, 2, 2 , 'A', 2),
(44, 2, 2 , 'A', 3),
(45, 2, 2 , 'A', 4),
(46, 2, 2 , 'A', 5),
(47, 2, 2 , 'B', 1),
(48, 2, 2 , 'B', 2),
(49, 2, 2 , 'B', 3),
(50, 2, 2 , 'B', 4),
(51, 3, 1 , 'A', 1),
(52, 3, 1 , 'A', 2),
(53, 3, 1 , 'A', 3),
(54, 3, 1 , 'A', 4),
(55, 3, 1 , 'B', 1),
(56, 3, 1 , 'B', 2),
(57, 3, 1 , 'B', 3),
(58, 3, 2 , 'A', 1),
(59, 3, 2 , 'A', 2),
(60, 3, 2 , 'A', 3),
(61, 3, 2 , 'A', 4),
(62, 3, 2 , 'B', 1),
(63, 3, 2 , 'B', 2),
(64, 3, 2 , 'B', 3),
(65, 4, 1 , 'A', 1),
(66, 4, 1 , 'A', 2),
(67, 4, 1 , 'A', 3),
(68, 4, 1 , 'A', 4),
(69, 4, 1 , 'B', 1),
(70, 4, 1 , 'B', 2),
(71, 4, 1 , 'B', 3),
(72, 4, 1 , 'B', 4),
(73, 4, 2 , 'A', 1),
(74, 4, 2 , 'A', 2),
(75, 4, 2 , 'A', 3),
(76, 4, 2 , 'A', 4),
(77, 4, 2 , 'B', 1),
(78, 4, 2 , 'B', 2),
(79, 4, 2 , 'B', 3),
(80, 4, 2 , 'B', 4),
(81, 5, 1 , 'A', 1),
(82, 5, 1 , 'A', 2),
(83, 5, 1 , 'A', 3),
(84, 5, 1 , 'B', 1),
(85, 5, 1 , 'B', 2),
(86, 5, 1 , 'B', 3),
(87, 6, 1 , 'A', 1),
(88, 6, 1 , 'A', 2),
(89, 6, 1 , 'A', 3),
(90, 6, 1 , 'B', 1),
(91, 6, 1 , 'B', 2),
(92, 6, 1 , 'B', 3)
;

INSERT INTO `EXHIBITION` (`EXHIBITION_ID`, `MOVIE_ID`, `CINEMA_ID`, `CROOM_ID`, `Exhibition_BeginDateTime`, `Exhibition_EndDateTime`, `LOTATION`) VALUES
(1, 1, 1, 1, '2021-12-22 12:35:00', '2021-12-22 14:35:00', 0),
(2, 5, 1, 2, '2021-12-22 14:35:00', '2021-12-22 16:35:00', 0),
(3, 8, 1, 4, '2021-12-25 19:20:00', '2021-12-25 21:20:00', 0),
(4, 9, 2, 1, '2021-12-24 16:20:00', '2021-12-24 18:20:00', 0),
(5, 1, 2, 2, '2021-12-22 13:00:00', '2021-12-22 15:00:00', 0),
(6, 7, 3, 2, '2021-12-20 12:35:00', '2021-12-20 14:35:00', 0),
(7, 5, 5, 1, '2021-12-22 18:35:00', '2021-12-22 20:35:00', 0),
(8, 8, 5, 1, '2021-12-23 12:20:00', '2021-12-23 14:20:00', 0),
(9, 8, 6, 1, '2021-12-27 16:20:00', '2021-12-24 18:20:00', 0),
(10, 1, 4, 2, '2021-12-23 15:00:00', '2021-12-23 18:00:00', 0)
;

INSERT INTO `CATEGORY_MOVIE` (`Cat_ID`,`Movie_ID`) VALUES
(3, 1),
(5, 2),
(3, 3),
(5, 4),
(5, 5),
(3, 5),
(2, 6),
(3, 6),
(2, 7),
(5, 7),
(3, 8),
(4, 9)
;

INSERT INTO `SNACK` (`SNACK_ID`, `SNACK_NAME`, `SNACK_PRICE`, `SNACK_TAX`) VALUES 
(1, 'Popcorn S', 4.00, 1.23),
(2, 'Popcorn M', 4.35, 1.23),
(3, 'Popcorn L', 4.50, 1.23),
(4, 'Soda S', 2.10, 1.23),
(5, 'Soda M', 2.55, 1.23),
(6, 'Soda L', 2.85, 1.23)
;

INSERT INTO `SNACK_BOOKING` (`SNACK_ID`, `BOOKING_ID`, `SNACKBOOKING_QUANTITY`) VALUES 
(6, 1,2),
(1, 2,3),
(3, 20,1),
(4, 12,1),
(2, 10,1),
(2, 11,1),
(4, 19,4),
(5, 8,4),
(6, 3,3),
(1, 6,2),
(1, 7,2),
(4, 14,1),
(2, 1, 5)
;

INSERT INTO `ROLE` (`ROLE_ID`, `ROLE_NAME`) VALUES 
(1, 'Manager'),
(2, 'Sub-manager'),
(3, 'Cleaning Staff'),
(4, 'Cashier'),
(5, 'Technician')
;

INSERT INTO `STAFF_ROLE` (`STAFF_ID`,`ROLE_ID`) VALUES
(1, 2),
(1, 5),
(2, 4),
(3, 3),
(4, 1),
(5, 4),
(5, 2),
(6, 3),
(7, 5),
(7, 1),
(7, 4)
;

INSERT INTO `BOOKING_SEAT` (`Exhibition_ID`,`Seat_ID`,`Booking_ID`) VALUES 
(1, 1, 1),
(1, 2, 2),
(1, 3, 2),
(1, 4, 14),
(1, 5, 23),
(1, 6, 23),
(1, 7, 23),
(1, 8, 23),
(2, 9, 9),
(2, 10, 9),
(2, 11, 9),
(2, 12, 9),
(2, 13, 6),
(2, 14, 11),
(2, 15, 11),
(2, 16, 11),
(3, 25, 16),
(3, 26, 16),
(3, 27, 16),
(3, 32, 16),
(3, 31, 16), 
(4, 33, 17),
(4, 34, 17),
(4, 35, 17),
(4, 36, 17),
(4, 37, 17),
(4, 38, 17),
(5, 42, 18),
(5, 43, 18),
(5, 44, 18),
(5, 45, 18),
(5, 46, 18),
(5, 47, 18),
(5, 48, 18),
(5, 49, 18),
(5, 50, 18),
(6, 58, 24),
(6, 59, 25),
(6, 60, 21),
(6, 61, 21),
(6, 62, 22),
(6, 63, 22),
(6, 64, 12),
(7, 81, 13),
(7, 82, 10),
(7, 83, 10),
(7, 84, 15),
(7, 85, 19),
(7, 86, 20),
(8, 81, 4),
(8, 82, 4),
(8, 85, 8),
(9, 89, 3),
(9, 90, 3),
(9, 91, 7),
(10, 78, 5),
(10, 79, 5),
(10, 80, 5)
;


-- ---------------------- VIEWS -------------------------------
--  VIEW 1 - HEADER & TOTALS
CREATE VIEW HEAD_AND_TOTALS AS (
SELECT DISTINCT p.PAYMENT_ID AS Invoice_Number, p.PAYMENT_DATE AS Invoice_Date, CONCAT(cust.CUST_FIRSTNAME, " ", cust.CUST_LASTNAME) AS Customer_Name,
cust.CUST_NIF AS NIF , cust.CUST_EMAIL AS Email, cust.CUST_CONTACT AS Customer_Contact, cn.Cinema_Name, cn.Cinema_Adress, cn.Cinema_Contact, cn.Cinema_Email, p.PAYMENT_VALUE AS Invoice_Total
FROM CUSTOMER AS cust, PAYMENT AS p, BOOKING AS b, CINEMA AS cn, BOOKING_SEAT AS bs, EXHIBITION AS e
WHERE b.PAYMENT_ID = p.PAYMENT_ID  AND cust.CUST_ID = b.CUST_ID AND b.BOOKING_ID = bs.BOOKING_ID AND bs.EXHIBITION_ID = e.EXHIBITION_ID AND e.CINEMA_ID = cn.CINEMA_ID
ORDER BY Invoice_Number);

-- TO SEE THE 'HEADER & TOTALS' VIEW RESULTS: 

-- SELECT *
-- FROM HEAD_AND_TOTALS;

--  VIEW 2 - DETAILS
CREATE VIEW DETAILS AS (
(SELECT A.Payment_ID, A.Tickets_Type AS Tickets_Description, A.Price AS Tickets_UnitCost_€, A.Tickets_QTY, 
GROUP_CONCAT(B.Snack_Name) AS Snacks_Description, GROUP_CONCAT(B.Price) AS Snacks_UnitCost_€, GROUP_CONCAT(B.Snacks_QTY) AS Snacks_QTY, 
ROUND(A.Price * A.Tickets_QTY, 2) AS Ticket_Amount_€, GROUP_CONCAT(ROUND(B.Price * B.Snacks_QTY, 2)) AS Snack_Amount_€
FROM (SELECT p.Payment_ID, b.Booking_NrTickets AS Tickets_QTY, tt.TT_Name AS Tickets_Type, b.Booking_ID AS Booking_ID, tt.TT_Price AS Price
	  FROM Payment AS p, Booking AS b, Ticket_Type AS tt
	  WHERE p.Payment_ID = b.Payment_ID AND b.TT_ID = tt.TT_ID) AS A
LEFT JOIN (SELECT sb.SnackBooking_Quantity AS Snacks_QTY, s.Snack_Name, b.Booking_ID AS Booking_ID, s.Snack_Price AS Price
		   FROM Snack AS s, Snack_Booking AS sb, Booking AS b
		   WHERE b.Booking_ID = sb.Booking_ID AND sb.Snack_ID = s.Snack_ID) AS B
ON A.Booking_ID = B.Booking_ID
GROUP BY A.Payment_ID
ORDER BY A.Payment_ID ASC
));

-- TO SEE THE 'DETAILS' VIEW RESULTS: 

-- SELECT *
-- FROM DETAILS;


-- ---------------------- TRIGGERS ---------------------------
--  TRIGGER 1 (AFTER INSERT) - UPDATE LOTATION WITH EACH SEAT BY EXHIBITION
delimiter $$
CREATE TRIGGER TR1_AFIN_ExhibitionLotation
AFTER INSERT
ON Booking_Seat
FOR EACH ROW
BEGIN
	UPDATE Exhibition AS E
    INNER JOIN (
		SELECT bs.Exhibition_ID, COUNT(bs.Seat_ID) AS Occupied_Seats, cr.CRoom_NrSeats AS Number_Of_Seats
		FROM Booking_Seat AS bs , cinemaroom AS cr, Exhibition AS e
		WHERE bs.Exhibition_ID = e.Exhibition_ID AND e.Cinema_ID = cr.Cinema_ID AND e.CRoom_ID = cr.CRoom_ID
        GROUP BY Exhibition_ID) AS occupation ON E.Exhibition_ID = occupation.Exhibition_ID
	SET E.Lotation = (occupation.Occupied_Seats/occupation.Number_Of_Seats)
    WHERE NEW.Exhibition_ID = E.Exhibition_ID;
END $$
delimiter ;

-- TO TEST THE 'TR1_AFIN_ExhibitionLotation' TRIGGER: 

/*
INSERT INTO BOOKING_SEAT VALUES
(2,73,10),
(3,74,10),
(3,75,10),
(2,76,10);
*/

-- SELECT * FROM EXHIBITION;


--  TRIGGER 2 - INSERTION OF ROWS ON THE LOG TABLE
delimiter $$
CREATE TRIGGER TR2_AFUP_InsertLOG
AFTER UPDATE ON EXHIBITION
FOR EACH ROW 
	BEGIN
		IF NEW.Exhibition_BeginDatetime != OLD.Exhibition_BeginDatetime THEN
		INSERT INTO LOG (Log_Datetime, Log_OldDatetimeExhibition , Log_NewDatetimeExhibition , Log_Exhibition_ID)
		VALUES 
		(CURRENT_TIMESTAMP(), old.Exhibition_BeginDatetime, new.Exhibition_BeginDatetime, new.Exhibition_ID);
        END IF;
	END $$
 delimiter ;

-- TO TEST THE 'TR2_AFUP_InsertLOG' TRIGGER: 

-- UPDATE Exhibition 
-- SET EXHIBITION_BEGINDATETIME = '2022-01-03 12:00:00', EXHIBITION_ENDDATETIME = '2022-01-03 14:00:00'
-- WHERE EXHIBITION_ID = 1;

-- SELECT * FROM LOG;