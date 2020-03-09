--
-- Create Tables
--
CREATE TABLE Association_DroneModelToPartCategory
(
	DroneModel INT NOT NULL,
	PartCategory INT NOT NULL,
	AmountRequired INT NOT NULL,
	CONSTRAINT pk_Association_DroneModelToPartCategory PRIMARY KEY(DroneModel, PartCategory)
);
CREATE TABLE Association_DroneModelToTerrain
(
	DroneModel INT NOT NULL,
	Terrain INT NOT NULL,
	CONSTRAINT pk_Association_DroneModelToTerrain PRIMARY KEY(DroneModel, Terrain)
);
CREATE TABLE Association_DrovingZoneToContract
(
	DrovingZone INT NOT NULL,
	Contract INT NOT NULL,
	CONSTRAINT pk_Association_DrovingZoneToContract PRIMARY KEY(DrovingZone, Contract)
);
CREATE TABLE Association_PartToPartCategory
(
	Part INT NOT NULL,
	PartCategory INT NOT NULL,
	CONSTRAINT pk_Association_PartToPartCategory PRIMARY KEY(Part, PartCategory)
);
CREATE TABLE Association_StaffMemberToStaffRole
(
	StaffMember INT NOT NULL,
	StaffRole INT NOT NULL,CONSTRAINT pk_Association_StaffMemberToStaffRole PRIMARY KEY(StaffMember, StaffRole)
);
CREATE TABLE Association_SupplierToPart
(
	Supplier INT NOT NULL,
	Part INT NOT NULL,
	PartInStock BIT NOT NULL,
	CONSTRAINT pk_Association_SupplierToPart PRIMARY KEY(Supplier, Part)
);
CREATE TABLE Contract
(
	ContractNumber INT IDENTITY NOT NULL,
	Contractee INT NOT NULL,
	SubscriptionLevel INT NOT NULL,
	CreatedBy INT NOT NULL,
	CreationDate DATETIME NOT NULL,
	StartDate DATETIME NOT NULL,
	EndDate DATETIME NOT NULL,
	Price MONEY NOT NULL,
	IsExclusive BIT NOT NULL,
	CONSTRAINT pk_Contract PRIMARY KEY(ContractNumber)
);
CREATE TABLE Contractee
(
	ContracteeID INT IDENTITY NOT NULL,
	Name VARCHAR(60) NOT NULL,
	Account INT NOT NULL,
	PhoneNumber INT,
	CONSTRAINT pk_Contractee PRIMARY KEY(ContracteeID)
);
CREATE TABLE DataEntry
(
	DroneDeployment INT NOT NULL,
	TimeTaken DATETIME NOT NULL,
	Latitude NUMERIC NOT NULL,
	Longitude NUMERIC NOT NULL,
	Altitude NUMERIC NOT NULL,
	Temperature NUMERIC NOT NULL,
	Humidity NUMERIC NOT NULL,
	AmbientLightStrength NUMERIC NOT NULL,
	CONSTRAINT pk_DataEntry PRIMARY KEY(DroneDeployment, TimeTaken)
);
CREATE TABLE Drone
(
	DroneNumber INT IDENTITY NOT NULL,
	DateOfEntryIntoService DATETIME,
	Model INT NOT NULL,
	Latitude NUMERIC,
	Longitude NUMERIC,
	Altitude NUMERIC,
	CONSTRAINT pk_Drone PRIMARY KEY(DroneNumber)
);
CREATE TABLE DroneDeployment
(
	DeploymentID INT IDENTITY NOT NULL,
	Drone INT NOT NULL,
	DrovingZone INT NOT NULL,
	DateStarted DATETIME NOT NULL,
	DateEnded DATETIME,
	CONSTRAINT pk_DroneDeployment  PRIMARY KEY(DeploymentID)
);
CREATE TABLE DroneModel
(
	ModelID INT IDENTITY NOT NULL,
	ModelName VARCHAR(60) NOT NULL,
	CONSTRAINT pk_DroneModel PRIMARY KEY(ModelID)
);
CREATE TABLE DroneSubscriptionInteraction
(
	Drone INT NOT NULL,
	Subscription INT NOT NULL,
	InteractionStartTime DATETIME NOT NULL,
	InteractionEndTime DATETIME,
	LastInputTime DATETIME NOT NULL,
	CONSTRAINT pk_DroneSubscriptionInteraction PRIMARY KEY(Drone, Subscription, InteractionStartTime)
);
CREATE TABLE DrovingZone
(
	ZoneID INT IDENTITY NOT NULL,
	TerrainType INT NOT NULL,
	CONSTRAINT pk_DrovingZone PRIMARY KEY(ZoneID)
);
CREATE TABLE DrovingZoneBoundary
(
	DrovingZone INT NOT NULL,
	BoundIndex INT NOT NULL,
	Latitude NUMERIC NOT NULL,
	Longitude NUMERIC NOT NULL,
	AltitudeMinimum NUMERIC NOT NULL,
	AltitudeMaximum NUMERIC NOT NULL,
	CONSTRAINT pk_DrovingZoneBoundry PRIMARY KEY(DrovingZone, BoundIndex)
);
CREATE TABLE MaintenanceComment
(
	MaintenanceRecord INT NOT NULL,
	EntryNumber INT NOT NULL,
	Content VARCHAR(255),
	CONSTRAINT pk_MaintenanceComment PRIMARY KEY(MaintenanceRecord, EntryNumber)
);
CREATE TABLE MaintenanceRecord
(
	RecordNumber INT IDENTITY NOT NULL,
	Installation INT NOT NULL,
	WorkDate DATETIME NOT NULL, 
	Outcome INT NOT NULL,
	CONSTRAINT pk_MaintenanceRecord PRIMARY KEY(RecordNumber)
);
CREATE TABLE MaintenanceResult
(
	OutcomeID INT NOT NULL,
	OutcomeName VARCHAR(60) NOT NULL,
	CONSTRAINT pk_MaintenanceResult PRIMARY KEY(OutcomeID)
);
CREATE TABLE Manufacturer
(
	ManufacturerID INT IDENTITY NOT NULL,
	Name VARCHAR(60) NOT NULL,
	CONSTRAINT pk_Manufacturer PRIMARY KEY(ManufacturerID)
);
CREATE TABLE Part
(
	PartID INT IDENTITY NOT NULL,
	Manufacturer INT NOT NULL,
	ProductCode VARCHAR(60) NOT NULL ,
	CONSTRAINT pk_Part PRIMARY KEY(PartID)
);
CREATE TABLE PartCategory
(
	CategoryID INT IDENTITY NOT NULL,
	CategoryName VARCHAR(60) NOT NULL,
	CONSTRAINT pk_PartCategory PRIMARY KEY(CategoryID)
);
CREATE TABLE PartCondition
(
	ConditionID INT IDENTITY NOT NULL,
	ConditionName VARCHAR(60) NOT NULL,
	CONSTRAINT pk_PartCondition PRIMARY KEY(ConditionID)
);
CREATE TABLE PartInstallation
(
	PartInstallationID INT IDENTITY NOT NULL,
	Drone INT NOT NULL,
	PartInstance INT NOT NULL,
	DateInstalled DATETIME NOT NULL,
	DateRemoved DATETIME,
	CONSTRAINT pk_PartInstallation PRIMARY KEY(PartInstallationID)
);
CREATE TABLE PartInstance
(
	InstanceNumber INT IDENTITY NOT NULL,
	PartType INT NOT NULL,
	Condition INT NOT NULL,
	DatePurchased DATETIME NOT NULL,
	DateRetired DATETIME,
	Supplier INT NOT NULL,
	CONSTRAINT pk_PartInstance PRIMARY KEY(InstanceNumber)
);
CREATE TABLE PhoneNumber
(
	PhoneNumberID INT IDENTITY NOT NULL,
	AreaCode VARCHAR(16),
	NumberString VARCHAR(16) NOT NULL,
	Extension VARCHAR(16),
	CONSTRAINT pk_PhoneNumber PRIMARY KEY(PhoneNumberID)
);
CREATE TABLE StaffMember
(
	EmployeeID INT IDENTITY NOT NULL,
	FirstName VARCHAR(60) NOT NULL,
	LastName VARCHAR(60) NOT NULL,
	PhoneNumber INT NOT NULL,
	CONSTRAINT pk_StaffMember PRIMARY KEY(EmployeeID)
);
CREATE TABLE StaffRole
(
	RoleID INT NOT NULL,
	RoleName VARCHAR(60) NOT NULL,
	CONSTRAINT pk_StaffRole PRIMARY KEY(RoleID)
);
CREATE TABLE SubscriberAccount
(
	SubscriberID INT IDENTITY NOT NULL,
	Username VARCHAR(24) NOT NULL,
	Password VARCHAR(255) NOT NULL,
	EmailAddress VARCHAR(255) NOT NULL,
	CONSTRAINT pk_SubscriberAccount PRIMARY KEY(SubscriberID)
);
CREATE TABLE Subscription
(
	SubscriptionID INT IDENTITY NOT NULL,
	Account INT NOT NULL,
	Drone INT NOT NULL,
	SubscriptionLevel INT NOT NULL,
	Contract INT,
	CreatedBy INT NOT NULL,
	StartDate DATETIME NOT NULL,
	EndDate DATETIME,
	DiscountApplied NUMERIC NOT NULL,
	CONSTRAINT pk_Subscription PRIMARY KEY(SubscriptionID)		
);
CREATE TABLE SubscriptionLevelEditHistory
(
	EditDateTime DATETIME NOT NULL,
	SubscriptionLevel INT NOT NULL,
	StaffMember INT NOT NULL,
	CONSTRAINT pk_SubscriptionLevelEditHistory PRIMARY KEY(EditDateTime, SubscriptionLevel)
);
CREATE TABLE SubscriptionLevel
(
	LevelValue INT NOT NULL,
	MarketedName VARCHAR(60) NOT NULL,
	MonthlyFee MONEY NOT NULL,
	CONSTRAINT pk_SubscriptionLevel PRIMARY KEY(LevelValue)
);
CREATE TABLE Supplier
(
	SupplierID INT IDENTITY NOT NULL,
	Name VARCHAR(60) NOT NULL,
	PhoneNumber INT NOT NULL,
	AddressNumber VARCHAR(60),
	AddressStreet VARCHAR(60),
	AddressCity VARCHAR(60),
	AddressPostCode VARCHAR(60),
	AddressCountry VARCHAR(60),
	CONSTRAINT pk_Supplier PRIMARY KEY(SupplierID)
);
CREATE TABLE Terrain
(
	TerrainID INT IDENTITY NOT NULL,
	TerrainName VARCHAR(60) NOT NULL,
	CONSTRAINT pk_Terrain PRIMARY KEY(TerrainID)
);
CREATE TABLE VideoStream
(
	StreamID INT IDENTITY NOT NULL,
	Drone INT NOT NULL,
	URI VARCHAR(255),
	CONSTRAINT pk_VideoStream PRIMARY KEY(StreamID)
);
CREATE TABLE VideoStreamSubscriptionInteraction
(
	VideoStream INT NOT NULL,
	Subscription INT NOT NULL,
	InteractionStartTime DATETIME NOT NULL,
	InteractionEndTime DATETIME,
	ControlOfVideoStream BIT NOT NULL,
	LastInputTime DATETIME NOT NULL,
	CONSTRAINT pk_VideoStreamSubscriptionInteraction PRIMARY KEY(VideoStream, Subscription, InteractionStartTime)
);

--
-- ADD CONSTRAINTS AND FOREIGN KEYS
--
GO

CREATE FUNCTION ufn_GetStaffMemberIsAdministrativeExecutive(@StaffMember INT)
RETURNS BIT
AS
-- Checks if the entered staff member has the administrative executive role.
BEGIN
	DECLARE @result BIT
	DECLARE @count INT
	SELECT @count = COUNT(*)
		FROM Association_StaffMemberToStaffRole sr
		WHERE sr.StaffMember = @StaffMember
			AND sr.StaffRole = 2;
	IF(@count > 0)
		SET @result = 1;
	ELSE
		SET @result = 0;
	RETURN @result;
END;
GO

CREATE FUNCTION ufn_GetNumberOfStreamsForDrone(@Drone INT)
RETURNS INT
AS
-- Checks if the entered staff member has the administrative executive role.
BEGIN
	DECLARE @result INT
	SELECT @RESULT = COUNT(*)
		FROM VideoStream vs
		WHERE vs.Drone = @Drone;
	IF(@result IS NULL)
		SET @result = 0;
	RETURN @result;
END;
GO

ALTER TABLE Association_DroneModelToPartCategory
	ADD
		CONSTRAINT fk_Association_DroneModelToPartCategory_DroneModel FOREIGN KEY (DroneModel) REFERENCES DroneModel(ModelID),
		CONSTRAINT fk_Association_DroneModelToPartCategory_PartCategory FOREIGN KEY (PartCategory) REFERENCES PartCategory(CategoryID)	
;
ALTER TABLE Association_DroneModelToTerrain
	ADD
		CONSTRAINT fk_Association_DroneModelToTerrain_DroneModel FOREIGN KEY (DroneModel) REFERENCES DroneModel(ModelID),
		CONSTRAINT fk_Association_DroneModelToTerrain_Terrain FOREIGN KEY (Terrain) REFERENCES Terrain(TerrainID)
;
ALTER TABLE Association_DrovingZoneToContract
	ADD
		CONSTRAINT fk_Association_DrovingZoneToContract_DrovingZone FOREIGN KEY (DrovingZone) REFERENCES DrovingZone(ZoneID),
		CONSTRAINT fk_Association_DrovingZoneToContract_Contract FOREIGN KEY (Contract) REFERENCES Contract(ContractNumber)
;
ALTER TABLE Association_PartToPartCategory
	ADD
		CONSTRAINT fk_Association_PartToPartCategory_Part FOREIGN KEY (Part) REFERENCES Part(PartID),
		CONSTRAINT fk_Association_PartToPartCategory_PartCategory FOREIGN KEY (PartCategory) REFERENCES PartCategory(CategoryID)
;
ALTER TABLE Association_StaffMemberToStaffRole
	ADD
		CONSTRAINT fk_Association_StaffMemberToStaffRole_StaffMember FOREIGN KEY (StaffMember) REFERENCES StaffMember(EmployeeID),
		CONSTRAINT fk_Association_StaffMemberToStaffRole_StaffRole FOREIGN KEY (StaffRole) REFERENCES StaffRole(RoleID)
;
ALTER TABLE Association_SupplierToPart
	ADD
		CONSTRAINT fk_Association_SupplierToPart_Supplier FOREIGN KEY (Supplier) REFERENCES Supplier(SupplierID),
		CONSTRAINT fk_Association_SupplierToPart_Part FOREIGN KEY (Part) REFERENCES Part(PartID)
;
ALTER TABLE Contract
	ADD
		CONSTRAINT c_Contract_EnforceLevelOfExlcusive CHECK((IsExclusive = 1 AND SubscriptionLevel > 3) OR (IsExclusive <> 1)),
		CONSTRAINT fk_Contract_Contractee FOREIGN KEY (Contractee) REFERENCES Contractee(ContracteeID),
		CONSTRAINT fk_Contract_Level FOREIGN KEY (SubscriptionLevel) REFERENCES SubscriptionLevel(LevelValue),
		CONSTRAINT fk_Contract_StaffMember FOREIGN KEY (CreatedBy) REFERENCES StaffMember(EmployeeID)
;
ALTER TABLE Contractee
	ADD
		CONSTRAINT fk_Contractee_SubscriberAccount FOREIGN KEY (Account) REFERENCES SubscriberAccount(SubscriberID),
		CONSTRAINT fk_Contractee_PhoneNumber FOREIGN KEY (PhoneNumber) REFERENCES PhoneNumber(PhoneNumberId)
;
ALTER TABLE DataEntry
	ADD
		CONSTRAINT c_DataEntry_LatitudeLimit CHECK(Latitude BETWEEN -90 AND 90),
		CONSTRAINT c_DataEntry_LongitudeLimit CHECK(Longitude BETWEEN -180 AND 180),
		CONSTRAINT fk_DataEntry_DroneDeployment FOREIGN KEY (DroneDeployment) REFERENCES DroneDeployment(DeploymentId)
;
ALTER TABLE Drone	
	ADD
		CONSTRAINT c_Drone_LatitudeLimit CHECK(Latitude BETWEEN -90 AND 90),
		CONSTRAINT c_Drone_LongitudeLimit CHECK(Longitude BETWEEN -180 AND 180),
		CONSTRAINT fk_Drone_DroneModel FOREIGN KEY (Model) REFERENCES DroneModel(ModelID)
;
ALTER TABLE DroneDeployment
	ADD
		CONSTRAINT c_DroneDeployment_EndDateAfterStartDate CHECK((DateEnded IS NULL) OR (DATEDIFF(ms, DateStarted, DateEnded) > 0)),
		CONSTRAINT fk_DroneDeployment_Drone FOREIGN KEY (Drone) REFERENCES Drone(DroneNumber),
		CONSTRAINT fk_DroneDeployment_DrovingZone FOREIGN KEY (DrovingZone) REFERENCES DrovingZone(ZoneId),
		CONSTRAINT uk_DroneDeployment_DroneDrovingZoneDateStarted UNIQUE(Drone, DrovingZone, DateStarted)
;
ALTER TABLE DroneSubscriptionInteraction
	ADD
		CONSTRAINT c_DroneSubscriptionInteraction_EndAfterStart CHECK((InteractionEndTime IS NULL) OR (DATEDIFF(ms, InteractionStartTime, InteractionEndTime) > 0)),
		CONSTRAINT c_DroneSubscriptionInteraction_EnforceSubscriptionLevel CHECK(Subscription > 2),
		CONSTRAINT fk_DroneSubscriptionInteraction_Drone FOREIGN KEY (Drone) REFERENCES Drone(DroneNumber),
		CONSTRAINT fk_DroneSubscriptionInteraction_Subscription FOREIGN KEY (Subscription) REFERENCES Subscription(SubscriptionID)
;
ALTER TABLE DrovingZoneBoundary
	ADD 
		CONSTRAINT c_DrovingZoneBoundary_LatitudeLimit CHECK(Latitude BETWEEN -90 AND 90),
		CONSTRAINT c_DrovingZoneBoundary_LongitudeLimit CHECK(Longitude BETWEEN -180 AND 180),
		CONSTRAINT fk_DrovingZoneBoundary_DrovingZone FOREIGN KEY (DrovingZone) REFERENCES DrovingZone(ZoneID)
;
ALTER TABLE MaintenanceComment
	ADD 
		CONSTRAINT fk_MaintenanceComment_MaintenanceRecord FOREIGN KEY (MaintenanceRecord) REFERENCES MaintenanceRecord(RecordNumber)
;
ALTER TABLE MaintenanceRecord
	ADD 
		CONSTRAINT fk_MaintenanceRecord_PartInstallation FOREIGN KEY (Installation) REFERENCES PartInstallation(PartInstallationID),
		CONSTRAINT fk_MaintenanceRecord_MaintenanceResult FOREIGN KEY (Outcome) REFERENCES MaintenanceResult(OutcomeID)
;
ALTER TABLE Part
	ADD 
		CONSTRAINT fk_Part_Manufacturer FOREIGN KEY (Manufacturer) REFERENCES Manufacturer(ManufacturerID)
;
ALTER TABLE PartInstallation
	ADD
		CONSTRAINT c_PartInstallation_RemoveDateAfterInstallDate CHECK((DateRemoved IS NULL) OR (DATEDIFF(ms, DateInstalled, DateRemoved) > 0)),
		CONSTRAINT fk_PartInstallation_Drone FOREIGN KEY (Drone) REFERENCES Drone(DroneNumber),
		CONSTRAINT fk_PartInstallation_PartInstance FOREIGN KEY (PartInstance) REFERENCES PartInstance(InstanceNumber),
		CONSTRAINT uk_PartInstallation_DronePartInstanceDateInstalled UNIQUE(Drone, PartInstance, DateInstalled)
;
ALTER TABLE PartInstance
	ADD 
		CONSTRAINT fk_PartInstance_PartType FOREIGN KEY (PartType) REFERENCES Part(PartID),
		CONSTRAINT fk_PartInstance_PartCondition FOREIGN KEY (Condition) REFERENCES PartCondition(ConditionID),
		CONSTRAINT fk_PartInstance_Supplier FOREIGN KEY (Supplier) REFERENCES Supplier(SupplierID)
;
ALTER TABLE StaffMember
	ADD 
		CONSTRAINT fk_StaffMember_PhoneNumber FOREIGN KEY (PhoneNumber) REFERENCES PhoneNumber(PhoneNumberId)
;
ALTER TABLE Subscription
	ADD
		CONSTRAINT c_Subscription_EndDateAfterStartDate CHECK((EndDate IS NULL) OR (DATEDIFF(ms, StartDate, EndDate) > 0)),
		CONSTRAINT c_DiscountLimit CHECK(DiscountApplied BETWEEN 0 AND 3),
		CONSTRAINT fk_Subscription_SubscriptionAccount FOREIGN KEY (Account) REFERENCES SubscriberAccount(SubscriberID),
		CONSTRAINT fk_Subscription_Drone FOREIGN KEY (Drone) REFERENCES Drone(DroneNumber),
		CONSTRAINT fk_Subscription_SubscriptionLevel FOREIGN KEY (SubscriptionLevel) REFERENCES SubscriptionLevel(LevelValue),
		CONSTRAINT fk_Subscription_Contract FOREIGN KEY (Contract) REFERENCES Contract(ContractNumber),
		CONSTRAINT fk_Subscription_StaffMember FOREIGN KEY (CreatedBy) REFERENCES StaffMember(EmployeeID),
		CONSTRAINT uk_Subscription_AccountDroneStartDate UNIQUE(Account, Drone, StartDate)
;
ALTER TABLE SubscriptionLevelEditHistory
	ADD 
		CONSTRAINT fk_SubscriptionLevelEditHistory_SubscriptionLevel FOREIGN KEY (SubscriptionLevel) REFERENCES SubscriptionLevel(LevelValue)
;
ALTER TABLE Supplier
	ADD 
		CONSTRAINT fk_Supplier_PhoneNumber FOREIGN KEY (PhoneNumber) REFERENCES PhoneNumber(PhoneNumberId)
;
ALTER TABLE VideoStream
	ADD 
		CONSTRAINT c_VideoStream_LimitNumberOfStreams CHECK(dbo.ufn_GetNumberOfStreamsForDrone(Drone) <= 100),
		CONSTRAINT fk_VideoStream_Drone FOREIGN KEY (Drone) REFERENCES Drone(DroneNumber)
;
ALTER TABLE VideoStreamSubscriptionInteraction
	ADD 
		CONSTRAINT c_VideoStreamSubscriptionInteraction_EndAfterStart CHECK((InteractionEndTime IS NULL) OR (DATEDIFF(ms, InteractionStartTime, InteractionEndTime) > 0)),
		CONSTRAINT fk_VideoStreamSubscriptionInteraction_VideoStream FOREIGN KEY (VideoStream) REFERENCES VideoStream(StreamID),
		CONSTRAINT fk_VideoStreamSubscriptionInteraction_Subscription FOREIGN KEY (Subscription) REFERENCES Subscription(SubscriptionID)
;

--
-- CREATE TRANSACTION PROCEDURES
--
CREATE PROCEDURE CreateSubscription
	@Drone INT, -- The drone the subscription is for
	@Account INT, -- The customer the subscription is for
	@SubscriptionLevel INT, -- The privelege level for the subscription
	@SalesPerson INT, -- The sales staff creating the the subscription
	@Discount NUMERIC
AS
	-- Creates a subscription to a drone
	INSERT INTO Subscription(Account, Drone, SubscriptionLevel, StartDate, DiscountApplied)
	VALUES
	(
		@Account,
		@Drone,
		@SubscriptionLevel,
		CURRENT_TIMESTAMP,
		@Discount
	);
GO

CREATE PROCEDURE GetSalesPersonSubscribers
	@SalesPersonFirst VARCHAR(60), -- The first name of the sales person
	@SalesPersonLast VARCHAR(60) -- The last name of the sales person
AS
	-- Get all subscribers that a sales person has created subscriptions for
	
	-- Find the ID of the sales person.
	DECLARE @salesPerson INT;
	SELECT @salesPerson = (sm.EmployeeID)
		FROM StaffMember sm
		WHERE sm.FirstName = @SalesPersonFirst
			AND sm.LastName = @SalesPersonLast;
	
	-- Get the subscribers
	SELECT sa.Username, sa.EmailAddress
		FROM SubscriberAccount sa
			INNER JOIN (SELECT DISTINCT s.Account AS Acc FROM Subscription s WHERE s.CreatedBy = @salesPerson) subs
				ON sa.SubscriberID = subs.Acc;
GO

CREATE PROCEDURE GetDronesCurrentlyContract
AS
	-- Gets a list of all drones that are currently operating for a contract and returns the contractee and drone information
	SELECT ct.Name, d.DroneNumber, d.Latitude, d.Longitude
		FROM Drone d
			INNER JOIN DroneDeployment dd
				INNER JOIN DrovingZone dz
					INNER JOIN Association_DrovingZoneToContract adzc
						INNER JOIN Contract c
							INNER JOIN Contractee ct
								ON c.Contractee = ct.ContracteeID
							ON adzc.Contract = c.ContractNumber
						ON dz.ZoneID = adzc.DrovingZone
					ON dd.DrovingZone = dz.ZoneID
				ON d.DroneNumber = dd.Drone
		WHERE dd.DateEnded IS NULL;
GO

CREATE PROCEDURE GetContractData
	@ContracteeName VARCHAR(60) -- The contracting company the information is for
AS
	-- Takes a contractee name and gets all the data collected for that contractee's contracts.
	SELECT ct.Name, c.ContractNumber, dd.Drone, dd.DrovingZone, de.Temperature, de.Humidity, de.AmbientLightStrength
		FROM DataEntry de
			INNER JOIN DroneDeployment dd
				INNER JOIN DrovingZone dz
						INNER JOIN Association_DrovingZoneToContract adzc
							INNER JOIN Contract c
								INNER JOIN Contractee ct
									ON c.Contractee = ct.ContracteeID
								ON adzc.Contract = c.ContractNumber
							ON dz.ZoneID = adzc.DrovingZone
						ON dd.DrovingZone = dz.ZoneID
				ON de.DroneDeployment = dd.DeploymentID
			WHERE ct.Name = @ContracteeName;
GO

CREATE PROCEDURE ViewCurrentStreamViewers
AS
	-- Gets a list of subscribers that are watching any of the available streams on any of the available drones.
	SELECT vs.Drone, sa.Username, vs.StreamID
		FROM VideoStream vs
			INNER JOIN VideoStreamSubscriptionInteraction vssi
				INNER JOIN Subscription s
					INNER JOIN SubscriberAccount sa
					ON s.Account = sa.SubscriberID
				ON vssi.Subscription = s.SubscriptionID
			ON vs.StreamID = vssi.VideoStream
		WHERE vssi.InteractionEndTime IS NULL
		ORDER BY vs.Drone;
GO

CREATE PROCEDURE GetDronePartSuplliers
	@droneID INT -- The drone to get suppliers for
AS
	 -- Takes a drone id an returns the suppliers that have provided the currently installed parts.
	SELECT DISTINCT s.Name, m.Name, p.ProductCode
		FROM Drone d
			INNER JOIN PartInstallation pinstall
				INNER JOIN PartInstance pinst
					INNER JOIN Part p
						INNER JOIN Manufacturer m
						ON p.Manufacturer = m.ManufacturerID
					ON pinst.PartType = p.PartID 
					INNER JOIN Supplier s
					ON pinst.Supplier = s.SupplierID
				ON pinstall.PartInstance = pinst.InstanceNumber
			ON d.DroneNumber = pinstall.Drone
		WHERE d.DroneNumber = @droneID;
GO

CREATE PROCEDURE SetDroneLocation
	@DroneID INT, -- The drone the data being set
	@NewLatitude NUMERIC, -- Latitiude for the new location
	@NewLongitude NUMERIC, -- Longitude for the new location
	@NewZone INT -- The new zone to put the drone in
AS
	-- Change the location values
	UPDATE Drone
		SET Latitude = @NewLatitude, Longitude = @NewLongitude;
		
	-- Add the drone to the droving zone. 
	INSERT INTO DroneDeployment(Drone, DrovingZone, DateStarted)
	VALUES
	(
		@DroneID,
		@NewZone,
		CURRENT_TIMESTAMP
	);
GO

CREATE PROCEDURE DeleteContractData
	@ContractNumber INT -- The contract to remove data for
AS
	-- Takes a contract identifier and expunges all data collected for that contract.
	DELETE FROM DataEntry
		WHERE DroneDeployment IN
		(
			SELECT dd.DeploymentID
				FROM DroneDeployment dd
					INNER JOIN DrovingZone dz
						INNER JOIN Association_DrovingZoneToContract adzc
							INNER JOIN Contract c
							ON adzc.Contract = c.ContractNumber
						ON dz.ZoneID = adzc.DrovingZone
					ON dd.DrovingZone = dz.ZoneID
				WHERE c.ContractNumber = @ContractNumber
		);
GO

CREATE PROCEDURE EnterDataCollected
	@droneDeployment INT, -- The drone and drovingzone the data was collected for
	@time DATETIME, -- When the drone recorded this data locally
	@latitude NUMERIC, -- Location information
	@longitude NUMERIC, -- Location information
	@alititude NUMERIC, -- Location information
	@temperature NUMERIC, -- Information
	@humidity NUMERIC, -- Information
	@ambientLightStrenght NUMERIC -- Information
AS
	-- Inserts one unit of information collected by a drone for a drovingzone and inserts it into the database
	INSERT INTO DataEntry(DroneDeployment, TimeTaken, Latitude, Longitude, Altitude, Temperature, Humidity, AmbientLightStrength)
	VALUES
	(
		@droneDeployment,
		@time,
		@latitude,
		@longitude,
		@alititude,
		@temperature,
		@humidity,
		@ambientLightStrenght
	);
GO

--
-- INSERT TEST DATA
--
INSERT INTO SubscriberAccount(Username, Password, EmailAddress)
VALUES
(
	'User1',
	'Password',
	'User1@Email.com'
),
(
	'User2',
	'Password',
	'User2@Email.com'
),
(
	'User3',
	'Password',
	'User3@Email.com'
),
(
	'User4',
	'Password',
	'User4@Email.com'
),
(
	'User5',
	'Password',
	'User5@Email.com'
),
(
	'User6',
	'Password',
	'User6@Email.com'
),
(
	'User7',
	'Password',
	'UserOne@Email.com'
),
(
	'User8',
	'Password',
	'UserOne@Email.com'
),
(
	'User9',
	'Password',
	'User9@Email.com'
),
(
	'User10',
	'Password',
	'User10@Email.com'
),
(
	'User11',
	'Password',
	'User11@Email.com'
),
(
	'User12',
	'Password',
	'User12@Email.com'
),
(
	'User13',
	'Password',
	'User13@Email.com'
);

INSERT INTO PhoneNumber(AreaCode, NumberString, Extension)
VALUES
(
	'+54',
	'123 1234',
	NULL
),
(
	'+54',
	'123 1235',
	NULL
),
(
	'+54',
	'123 1236',
	NULL
),
(
	'+54',
	'123 1237',
	NULL
),
(
	'+54',
	'123 1238',
	NULL
),
(
	'+54',
	'123 1239',
	NULL
),
(
	'+54',
	'123 1210',
	NULL
),
(
	'+54',
	'123 1211',
	NULL
),
(
	'+54',
	'123 1212',
	NULL
),
(
	'+54',
	'123 1213',
	NULL
),
(
	'+54',
	'123 1214',
	NULL
);

INSERT INTO Contractee(Name, Account, PhoneNumber)
VALUES
(
	'Contractee One',
	1,
	1
),
(
	'Contractee Two',
	2,
	2
),
(
	'Contractee Three',
	3,
	3
);

INSERT INTO StaffMember(FirstName, LastName, PhoneNumber)
VALUES
(
	'Staff',
	'One',
	4
),
(
	'Staff',
	'Two',
	5
);

INSERT INTO SubscriptionLevel(LevelValue, MarketedName, MonthlyFee)
VALUES
(
	1,
	'Standard',
	10
),
(
	2,
	'Gold',
	20
),
(
	3,
	'Platinum',
	40
),
(
	4,
	'Super Platinum',
	50
);

INSERT INTO Contract(Contractee, SubscriptionLevel, CreatedBy, CreationDate, StartDate, EndDate, Price, IsExclusive)
VALUES
(
	1,
	1,
	1,
	'2018/06/01',
	'2018/06/04',
	'2018/06/12',
	200,
	0
),
(
	2,
	1,
	1,
	'2018/06/01',
	'2018/06/04',
	'2018/06/12',
	200,
	0
),
(
	3,
	2,
	1,
	'2018/06/01',
	'2018/06/04',
	'2018/06/12',
	200,
	0
);

INSERT INTO DroneModel(ModelName)
VALUES
(
	'Standard Model'
);

INSERT INTO Drone(DateOfEntryIntoService, Model, Latitude, Longitude, Altitude)
VALUES
(
	'2018/06/01',
	1,
	-41.108698,
	173.023622,
	1
),
(
	'2018/06/01',
	1,
	-41.108698,
	173.023622,
	1
),
(
	'2018/06/01',
	1,
	-41.108698,
	173.023622,
	1
),
(
	'2018/06/01',
	1,
	-41.108698,
	173.023622,
	1
),
(
	'2018/06/01',
	1,
	-41.108698,
	173.023622,
	1
),
(
	'2018/06/01',
	1,
	-41.108698,
	173.023622,
	1
),
(
	'2018/06/01',
	1,
	-41.108698,
	173.023622,
	1
);

INSERT INTO Terrain(TerrainName)
VALUES
(
	'Field'
),
(
	'Forest'
),
(
	'Alpine'
),
(
	'Swamp'
),
(
	'Desert'
);

INSERT INTO DrovingZone(TerrainType) 
VALUES
(
	1
),
(
	1
),
(
	1
),
(
	1
);

INSERT INTO DrovingZoneBoundary(DrovingZone, BoundIndex, Latitude, Longitude, AltitudeMinimum, AltitudeMaximum)
VALUES
(
	1,
	0,
	-41.108698,
	173.023622,
	0.5,
	13
),
(
	1,
	1,
	-41.108698,
	173.028681,
	0.5,
	13
),
(
	1,
	2,
	-41.113333,
	173.023622,
	0.5,
	13
),
(
	1,
	3,
	-41.113333,
	173.028681,
	0.5,
	13
),
(
	2,
	0,
	-41.108698,
	173.023622,
	0.5,
	13
),
(
	2,
	1,
	-41.108698,
	173.028681,
	0.5,
	13
),
(
	2,
	2,
	-41.113333,
	173.023622,
	0.5,
	13
),
(
	2,
	3,
	-41.113333,
	173.028681,
	0.5,
	13
),
(
	3,
	0,
	-41.108698,
	173.023622,
	0.5,
	13
),
(
	3,
	1,
	-41.108698,
	173.028681,
	0.5,
	13
),
(
	3,
	2,
	-41.113333,
	173.023622,
	0.5,
	13
),
(
	3,
	3,
	-41.113333,
	173.028681,
	0.5,
	13
),
(
	4,
	0,
	-41.108698,
	173.023622,
	0.5,
	13
),
(
	4,
	1,
	-41.108698,
	173.028681,
	0.5,
	13
),
(
	4,
	2,
	-41.113333,
	173.023622,
	0.5,
	13
),
(
	4,
	3,
	-41.113333,
	173.028681,
	0.5,
	13
);

INSERT INTO DroneDeployment(Drone, DrovingZone, DateStarted, DateEnded)
VALUES
(
	1,
	1,
	'2018/06/04',
	NULL
),
(
	2,
	1,
	'2018/06/04',
	NULL
),
(
	3,
	2,
	'2018/06/04',
	NULL
),
(
	4,
	2,
	'2018/06/04',
	NULL
),
(
	5,
	3,
	'2018/06/04',
	NULL
),
(
	6,
	3,
	'2018/06/04',
	NULL
),
(
	7,
	1,
	'2018/06/04',
	NULL
);

INSERT INTO DataEntry(DroneDeployment, TimeTaken, Latitude, Longitude, Altitude, Temperature, Humidity, AmbientLightStrength)
VALUES
(
	1,
	'2018/06/04 00:00:01',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	1,
	'2018/06/04 00:00:02',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	1,
	'2018/06/04 00:00:03',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	1,
	'2018/06/04 00:00:04',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	1,
	'2018/06/04 00:00:05',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	1,
	'2018/06/04 00:00:06',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	1,
	'2018/06/04 00:00:07',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	1,
	'2018/06/04 00:00:08',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	1,
	'2018/06/04 00:00:09',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	1,
	'2018/06/04 00:00:10',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
-- 
(
	2,
	'2018/06/04 00:00:01',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	2,
	'2018/06/04 00:00:02',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	2,
	'2018/06/04 00:00:03',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	2,
	'2018/06/04 00:00:04',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	2,
	'2018/06/04 00:00:05',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	2,
	'2018/06/04 00:00:06',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	2,
	'2018/06/04 00:00:07',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	2,
	'2018/06/04 00:00:08',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	2,
	'2018/06/04 00:00:09',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	2,
	'2018/06/04 00:00:10',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
-- 
(
	3,
	'2018/06/04 00:00:01',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	3,
	'2018/06/04 00:00:02',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	3,
	'2018/06/04 00:00:03',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	3,
	'2018/06/04 00:00:04',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	3,
	'2018/06/04 00:00:05',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	3,
	'2018/06/04 00:00:06',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	3,
	'2018/06/04 00:00:07',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	3,
	'2018/06/04 00:00:08',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	3,
	'2018/06/04 00:00:09',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	3,
	'2018/06/04 00:00:10',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
-- 
(
	4,
	'2018/06/04 00:00:01',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	4,
	'2018/06/04 00:00:02',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	4,
	'2018/06/04 00:00:03',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	4,
	'2018/06/04 00:00:04',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	4,
	'2018/06/04 00:00:05',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	4,
	'2018/06/04 00:00:06',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	4,
	'2018/06/04 00:00:07',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	4,
	'2018/06/04 00:00:08',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	4,
	'2018/06/04 00:00:09',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	4,
	'2018/06/04 00:00:10',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
-- 
(
	5,
	'2018/06/04 00:00:01',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	5,
	'2018/06/04 00:00:02',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	5,
	'2018/06/04 00:00:03',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	5,
	'2018/06/04 00:00:04',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	5,
	'2018/06/04 00:00:05',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	5,
	'2018/06/04 00:00:06',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	5,
	'2018/06/04 00:00:07',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	5,
	'2018/06/04 00:00:08',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	5,
	'2018/06/04 00:00:09',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	5,
	'2018/06/04 00:00:10',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
-- 
(
	6,
	'2018/06/04 00:00:01',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	6,
	'2018/06/04 00:00:02',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	6,
	'2018/06/04 00:00:03',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	6,
	'2018/06/04 00:00:04',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	6,
	'2018/06/04 00:00:05',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	6,
	'2018/06/04 00:00:06',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	6,
	'2018/06/04 00:00:07',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	6,
	'2018/06/04 00:00:08',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	6,
	'2018/06/04 00:00:09',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	6,
	'2018/06/04 00:00:10',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
-- 
(
	7,
	'2018/06/04 00:00:01',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	7,
	'2018/06/04 00:00:02',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	7,
	'2018/06/04 00:00:03',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	7,
	'2018/06/04 00:00:04',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	7,
	'2018/06/04 00:00:05',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	7,
	'2018/06/04 00:00:06',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	7,
	'2018/06/04 00:00:07',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	7,
	'2018/06/04 00:00:08',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	7,
	'2018/06/04 00:00:09',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
),
(
	7,
	'2018/06/04 00:00:10',
	-41.108698,
	173.023622,
	1,
	8,
	62.8,
	100
);


INSERT INTO Subscription(Account, Drone, SubscriptionLevel, Contract, CreatedBy, StartDate, EndDate, DiscountApplied)
VALUES
(
	1,
	1,
	1,
	NULL,
	1,
	'2018/06/01',
	NULL,
	0
),
(
	1,
	2,
	1,
	NULL,
	1,
	'2018/06/01',
	NULL,
	0
),
(
	2,
	3,
	1,
	NULL,
	1,
	'2018/06/01',
	NULL,
	0
),
(
	3,
	4,
	3,
	NULL,
	1,
	'2018/06/01',
	NULL,
	0
);

INSERT INTO DroneSubscriptionInteraction(Drone, Subscription, InteractionStartTime, InteractionEndTime, LastInputTime)
VALUES
(
	3,
	4,
	'2018/06/01 00:00:01',
	'2018/06/01 00:00:04',
	'2018/06/01 00:00:04'
),
(
	3,
	4,
	'2018/06/01 00:00:06',
	'2018/06/01 00:00:10',
	'2018/06/01 00:00:10'
);


INSERT INTO Manufacturer(Name)
VALUES
(
	'Manufacturer 1'
),
(
	'Manufacturer 2'
),
(
	'Manufacturer 3'
),
(
	'Manufacturer 4'
);

INSERT INTO Part(Manufacturer, ProductCode)
VALUES
(
	1,
	'PP-001'
),
(
	2,
	'PP-002'
),
(
	3,
	'PP-004'
),
(
	1,
	'PP-009'
);

INSERT INTO PartCategory(CategoryName)
VALUES
(
	'Motor'
	
),
(
	'Body'
)
;

INSERT INTO PartCondition(ConditionName)
VALUES
(
	'Good'
),
(
	'Damaged'
),
(
	'Retired'
);

INSERT INTO Supplier(Name, PhoneNumber, AddressNumber, AddressStreet, AddressCity, AddressPostCode, AddressCountry)
VALUES
(
	'Supplier 1',
	5,
	'12',
	'Street',
	'City',
	'142',
	'New Zealand'
),
(
	'Supplier 2',
	6,
	'12',
	'Street',
	'City',
	'142',
	'New Zealand'
),
(
	'Supplier 3',
	7,
	'12',
	'Street',
	'City',
	'142',
	'New Zealand'
);

INSERT INTO PartInstance(PartType, Condition, DatePurchased, DateRetired, Supplier)
VALUES
(
	1,
	1, 
	'2018/06/01',
	NULL,
	1
),
(
	1,
	1, 
	'2018/06/01',
	NULL,
	1
),
(
	1,
	1, 
	'2018/06/01',
	NULL,
	1
),
(
	1,
	1, 
	'2018/06/01',
	NULL,
	1
),
(
	1,
	1, 
	'2018/06/01',
	NULL,
	1
),
(
	1,
	1, 
	'2018/06/01',
	NULL,
	1
),
(
	1,
	1, 
	'2018/06/01',
	NULL,
	1
);

INSERT INTO PartInstallation(Drone, PartInstance, DateInstalled, DateRemoved)
VALUES
(
	1,
	1,
	'2018/06/01',
	NULL
),
(
	2,
	2,
	'2018/06/01',
	NULL
),
(
	3,
	3,
	'2018/06/01',
	NULL
),
(
	4,
	4,
	'2018/06/01',
	NULL
),
(
	5,
	5,
	'2018/06/01',
	NULL
),
(
	6,
	6,
	'2018/06/01',
	NULL
),
(
	7,
	7,
	'2018/06/01',
	NULL
);

INSERT INTO MaintenanceResult(OutcomeID, OutcomeName)
VALUES
(
	1,
	'Fine'
),
(
	2,
	'Repaired'
),
(
	3,
	'Replacement Ordered'
),
(
	4,
	'Retired'
);

INSERT INTO MaintenanceRecord(Installation, WorkDate, Outcome)
VALUES
(
	1,
	'2018/06/01',
	1
),
(
	2,
	'2018/06/01',
	1
),
(
	3,
	'2018/06/01',
	1
),
(
	4,
	'2018/06/01',
	1
),
(
	5,
	'2018/06/01',
	1
),
(
	6,
	'2018/06/01',
	1
),
(
	7,
	'2018/06/01',
	1
);

INSERT INTO MaintenanceComment(MaintenanceRecord, EntryNumber, Content)
VALUES
(
	1,
	1,
	'Initial installation'
),
(
	2,
	1,
	'Initial installation'
),
(
	3,
	1,
	'Initial installation'
),
(
	4,
	1,
	'Initial installation'
),
(
	5,
	1,
	'Initial installation'
),
(
	6,
	1,
	'Initial installation'
),
(
	7,
	1,
	'Initial installation'
);

INSERT INTO StaffRole(RoleID, RoleName)
VALUES
(
	1,
	'Sales'
),
(
	2,
	'Administrative Executive'
);


INSERT INTO SubscriptionLevelEditHistory(EditDateTime, SubscriptionLevel, StaffMember)
VALUES
(
	'2018/06/01 00:00:06',
	3,
	2
);

INSERT INTO VideoStream(Drone, URI)
VALUES
(
	1,
	'URI'
),
(
	1,
	'URI'
),
(
	2,
	'URI'
),
(
	2,
	'URI'
),
(
	3,
	'URI'
),
(
	3,
	'URI'
),
(
	4,
	'URI'
),
(
	4,
	'URI'
),
(
	5,
	'URI'
),
(
	6,
	'URI'
),
(
	7,
	'URI'
),
(
	7,
	'URI'
);

INSERT INTO VideoStreamSubscriptionInteraction(VideoStream, Subscription, InteractionStartTime, InteractionEndTime, ControlOfVideoStream, LastInputTime)
VALUES
(
	1,
	1,
	'2018/06/01 00:00:01',
	NULL,
	0,
	'2018/06/01 00:00:10'
),
(
	5,
	2,
	'2018/06/01 00:00:01',
	NULL,
	0,
	'2018/06/01 00:00:10'
)
;

INSERT INTO Association_DroneModelToPartCategory(DroneModel, PartCategory, AmountRequired)
VALUES
(
	1,
	1,
	1
);

INSERT INTO Association_DroneModelToTerrain(DroneModel, Terrain)
VALUES
(
	1,
	1
);

INSERT INTO Association_DrovingZoneToContract(DrovingZone, Contract)
VALUES
(
	1,
	1
),
(
	2,
	2
),
(
	3,
	3
),
(
	4,
	3
);

INSERT INTO Association_PartToPartCategory(Part, PartCategory)
VALUES
(
	1,
	1
),
(
	2,
	1
),
(
	3,
	2
),
(
	4,
	2
);

INSERT INTO Association_StaffMemberToStaffRole(StaffMember, StaffRole)
VALUES
(
	1,
	1
),
(
	2,
	1
),
(
	2,
	2
);

INSERT INTO Association_SupplierToPart(Supplier, Part, PartInStock)
VALUES
(
	1,
	1,
	1
),
(
	1,
	2,
	1
),
(
	1,
	3,
	1
),
(
	1,
	4,
	1
);
