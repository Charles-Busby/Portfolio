CREATE TABLE Customer (CustomerId Integer Not Null, FirstName Char(10) Not Null, LastName Char(10) Not Null, StreetNumber Integer Not Null, StreetName Char(30) Not Null, Apt Char(5), City Char(30) Not Null, State Char(2) Not Null, ZipCode Integer Not Null, Telephone Integer Not Null, PRIMARY KEY (CustomerId));
CREATE TABLE Genre (GenreId Integer Not Null, GenreTitle Char(15) Not Null, PRIMARY KEY (GenreId));
CREATE TABLE Charges (ChargeId Integer Not Null, ChargeName Char(10) Not Null, ChargeAmount Decimal(5,2) Not Null, PRIMARY KEY (ChargeId));
CREATE TABLE Director (DirectorId Integer Not Null, FirstName Char(10) Not Null, LastName Char(10) Not Null, MovieId Integer Not Null, PRIMARY KEY (MovieId));
CREATE TABLE VendorCatalog (	DistributorSerialNumber Char(20) Not Null, VendorId Integer Not Null, MovieTitle Char(10) Not Null, Genre Integer Not Null, 	Format Char(3) Not Null, YearReleased Integer Not Null, RunTime Time Not Null, Rating Char(4) Not Null, AcademyAward Boolean Not Null, Price decimal(5,2) Not Null, PRIMARY KEY (DistributorSerialNumber, VendorId));
CREATE TABLE Taxes (TaxId Integer Not Null, Taxcode Char(10) Not Null, Taxpercentage Decimal(3,2) Not Null, PRIMARY KEY (TaxId));
CREATE TABLE History (	CustomerId Integer Not Null, InvoiceNumber Integer Not Null, MovieId Integer Not Null, MovieTitle Char(20) Not Null, RentalDate Date Not Null, Apt Char(5) Not Null, City Char(30) Not Null, State Char(2) Not Null, ZipCode Integer Not Null, Telephone Integer Not Null, PRIMARY KEY (CustomerId, InvoiceNumber, MovieId));
CREATE TABLE Movie (MovieId Integer Not Null, VendorId Integer Not Null, DistributorSerialNumber Char(20) Not Null, MovieTitle Char(20) Not Null, Genre Integer Not Null, Format Char(3) Not Null, PurchasePrice Decimal(5,2) Not Null, RentalBasePrice Decimal(5,2) Not Null, ZipCode Integer Not Null, Telephone Integer Not Null, PRIMARY KEY (MovieId));
CREATE TABLE Actress (	ActressId Integer Not Null,FirstName Char(10) Not Null,LastName Char(10) Not Null,MovieId Integer Not Null,PRIMARY KEY (ActressId));
CREATE TABLE Vendor (VendorID Integer Not Null, TaxIdNumber Integer Not Null, Name Char(20) Not Null, StreetNumber Integer Not Null, StreetName Char(30) Not Null, Suite Char(8), City Char(30) Not Null, State Char(2) Not Null, ZipCode Integer Not Null, Country Char(3) Not Null, Telephone Integer Not Null, PRIMARY KEY (VendorID));
CREATE TABLE Invoice (InvoiceNumber Integer Not Null, MovieId Integer Not Null, CustomerId Integer Not Null, DayofRental Date Not Null, BasePrice Decimal(5,2) Not Null, ReturnDate Date Not Null, Damaged Boolean Not Null, Rewound Boolean Not Null, Taxes Decimal(5,2) Not Null, Discounts integer Not Null, PRIMARY KEY (InvoiceNumber));
CREATE TABLE Actor (ActorId Integer Not Null, FirstName Char(10) Not Null, LastName Char(10) Not Null, MovieId Integer Not Null, PRIMARY KEY (ActorId));
CREATE TABLE CreditCard (CardNumber Integer Not Null, CardVendor Char(4) Not Null, CustomerId Integer Not Null, PRIMARY KEY (CardNumber, CardVendor));
Alter Table Actress Add Constraint Movie
	Foreign key (MovieId)
	References Movie (MovieId)
	On Delete No Action
	On update no action;
Alter Table Director Add Constraint Movie
	Foreign key (MovieId)
	References Movie (MovieId)
	On Delete No Action
	On update no action;
Alter Table Actor Add Constraint Movie
	Foreign key (MovieId)
	References Movie (MovieId)
	On Delete No Action
	On update no action;
Alter Table Movie Add Constraint Genre
	Foreign key (Genre)
	References Genre (GenreId)
	On Delete No Action
	On update no action;
Alter Table Movie Add Constraint Vendor
	Foreign key (VendorId)
	References Vendor (VendorId)
	On Delete No Action
	On update no action;
Alter Table VendorCatalog Add Constraint Vendor
	Foreign key (VendorId)
	References Vendor (VendorId)
	On Delete No Action
	On update no action;
Alter Table VendorCatalog Add Constraint Genre
	Foreign key (Genre)
	References Genre (GenreId)
	On Delete No Action
	On update no action;
Alter Table Invoice Add Constraint Movie
	Foreign key (MovieId)
	References Movie (MovieId)
	On Delete No Action
	On update no action;
Alter Table Invoice Add Constraint Customer
	Foreign key (CustomerId)
	References Customer (CustomerId)
	On Delete No Action
	On update no action;
Alter Table History Add Constraint Customer
	Foreign key (CustomerId)
	References Customer (CustomerId)
	On Delete No Action
	On update no action;
Alter Table History Add Constraint Invoice
	Foreign key (InvoiceNumber)
	References Invoice (InvoiceNumber)
	On Delete No Action
	On update no action;
Alter Table History Add Constraint Movie
	Foreign key (MovieId)
	References Movie (MovieId)
	On Delete No Action
	On update no action;
Alter Table Invoice Add Constraint Charges
	Foreign key (Discounts)
	References Charges (ChargeId)
	On Delete No Action
	On update no action;
