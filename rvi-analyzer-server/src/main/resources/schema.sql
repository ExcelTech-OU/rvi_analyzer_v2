CREATE TABLE IF NOT EXISTS `User` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `username` VARCHAR(255),
  `password` VARCHAR(255),
  `supervisor` VARCHAR(255),
  `userGroup` VARCHAR(255),
  `passwordType` VARCHAR(255),
  `status` VARCHAR(255),
  `createdBy` VARCHAR(255),
  `createdDateTime` DATETIME NOT NULL  DEFAULT CURRENT_TIMESTAMP,
  `lastUpdatedDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);

CREATE TABLE IF NOT EXISTS `TestResult` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `testGate` VARCHAR(255),
  `productionOrder` VARCHAR(255),
  `productId` VARCHAR(255),
  `mode01` VARCHAR(255),
  `mode02` VARCHAR(255),
  `mode03` VARCHAR(255),
  `mode04` VARCHAR(255),
  `createdBy` VARCHAR(255),
  `createdDateTime` DATETIME NOT NULL  DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE IF NOT EXISTS `Test` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `testGate` VARCHAR(255),
  `material` VARCHAR(255),
  `createdBy` VARCHAR(255),
  `createdDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastUpdatedDateTime` DATETIME NOT NULL  DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);

CREATE TABLE IF NOT EXISTS `ParameterMode` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `testId` INT NOT NULL,
  FOREIGN KEY (`testId`) REFERENCES `Test`(`_id`),
  `name` VARCHAR(255),
  `parameter` VARCHAR(255));

CREATE TABLE IF NOT EXISTS `Parameter` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255),
  `createdBy` VARCHAR(255),
  `createdDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE IF NOT EXISTS `Style` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255),
  `plant` VARCHAR(255),
  `customer` VARCHAR(255),
  `createdBy` VARCHAR(255),
  `createdDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE IF NOT EXISTS `StyleAdmin` (
  `styleId` INT NOT NULL,
   FOREIGN KEY (`styleId`) REFERENCES `Style`(`_id`),
  `adminId` INT NOT NULL,
   FOREIGN KEY (`adminId`) REFERENCES `User`(`_id`),
  PRIMARY KEY (`styleId`, `adminId`));

CREATE TABLE IF NOT EXISTS `SONumber` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `soNumber` VARCHAR(255),
  `customerPO` VARCHAR(255),
  `createdBy` VARCHAR(255),
  `createdDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE IF NOT EXISTS `RMTracking` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `userId` VARCHAR(255),
  `productionOrder` VARCHAR(255),
  `createdBy` VARCHAR(255),
  `createdDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE IF NOT EXISTS `ProductionOrder` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `soNumber` VARCHAR(255),
  `orderId` VARCHAR(255),
  `createdBy` VARCHAR(255),
  `createdDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE IF NOT EXISTS `Plant` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255),
  `createdBy` VARCHAR(255),
  `createdDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastUpdatedDateTime` DATETIME NOT NULL  DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);

CREATE TABLE IF NOT EXISTS `Customer` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255),
  `status` VARCHAR(255),
  `createdBy` VARCHAR(255),
  `createdDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastUpdatedDateTime` DATETIME NOT NULL  DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);

CREATE TABLE IF NOT EXISTS `CustomerPO` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255),
  `rawMaterial` VARCHAR(255),
  `createdBy` VARCHAR(255),
  `createdDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE IF NOT EXISTS `Material` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255),
  `plant` VARCHAR(255),
  `customer` VARCHAR(255),
  `style` VARCHAR(255),
  `createdBy` VARCHAR(255),
  `createdDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE IF NOT EXISTS `Role` (
  `roleId` VARCHAR(255) PRIMARY KEY,
  `roleName` VARCHAR(255));

CREATE TABLE IF NOT EXISTS `Group` (
  `groupId` VARCHAR(255) PRIMARY KEY,
  `groupName` VARCHAR(255));

CREATE TABLE IF NOT EXISTS `GroupRole` (
--  `groupId` VARCHAR(255) NOT NULL,
--  FOREIGN KEY (`groupId`) REFERENCES `Group`(`groupId`),
--  `roleId` VARCHAR(255) NOT NULL,
--  FOREIGN KEY (`roleId`) REFERENCES `Role`(`roleId`),
--  PRIMARY KEY (`groupId`, `roleId`)
 `groupId` VARCHAR(255),
 `roleId` VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `DefaultConfiguration` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `customerName` VARCHAR(255),
  `operatorId` VARCHAR(255),
  `serialNo` VARCHAR(255),
  `batchNo` VARCHAR(255),
  `sessionId` VARCHAR(255) NOT NULL UNIQUE);

CREATE TABLE IF NOT EXISTS `Device` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255),
  `assignTo` VARCHAR(255),
  `macAddress` VARCHAR(255),
  `status` VARCHAR(255),
  `createdBy` VARCHAR(255),
  `createdDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE IF NOT EXISTS `SessionResult` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `testId` VARCHAR(255) NOT NULL UNIQUE);

CREATE TABLE IF NOT EXISTS `Reading` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `temperature` VARCHAR(255),
  `readingCurrent` VARCHAR(255),
  `voltage` VARCHAR(255),
  `readAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `result` VARCHAR(255),
  `sessionResultId` INT NOT NULL,
  FOREIGN KEY (`sessionResultId`) REFERENCES `SessionResult`(`_id`));

CREATE TABLE IF NOT EXISTS `Report` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `createdBy` VARCHAR(255),
  `password` VARCHAR(255),
  `sessionId` VARCHAR(255),
  `modeType` INT NOT NULL,
  `testId` VARCHAR(255),
  `urlHash` VARCHAR(255),
  `status` VARCHAR(255),
  `accessAttempts` INT,
  `createdDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE IF NOT EXISTS `SessionConfigurationModeOne` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `voltage` VARCHAR(255),
  `maxCurrent` VARCHAR(255),
  `passMinCurrent` VARCHAR(255),
  `passMaxCurrent` VARCHAR(255));

CREATE TABLE IF NOT EXISTS `SessionConfigurationModeTwo` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `readingCurrent` VARCHAR(255),
  `maxVoltage` VARCHAR(255),
  `passMinVoltage` VARCHAR(255),
  `passMaxVoltage` VARCHAR(255));

CREATE TABLE IF NOT EXISTS `SessionConfigurationModeThree` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `startingVoltage` VARCHAR(255),
  `desiredVoltage` VARCHAR(255),
  `maxCurrent` VARCHAR(255),
  `voltageResolution` VARCHAR(255),
  `chargeInTime` VARCHAR(255));

CREATE TABLE IF NOT EXISTS `SessionConfigurationModeFour` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `startingCurrent` VARCHAR(255),
  `desiredCurrent` VARCHAR(255),
  `maxVoltage` VARCHAR(255),
  `currentResolution` VARCHAR(255),
  `chargeInTime` VARCHAR(255));

CREATE TABLE IF NOT EXISTS `SessionConfigurationModeFive` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `fixedVoltage` VARCHAR(255),
  `maxCurrent` VARCHAR(255),
  `timeDuration` VARCHAR(255));

CREATE TABLE IF NOT EXISTS `SessionConfigurationModeSix` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `fixedCurrent` VARCHAR(255),
  `maxVoltage` VARCHAR(255),
  `timeDuration` VARCHAR(255));

CREATE TABLE IF NOT EXISTS `ModeOne` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `defaultConfigurationId` INT NOT NULL,
  FOREIGN KEY (`defaultConfigurationId`) REFERENCES `DefaultConfiguration`(`_id`),
  `sessionConfigurationsId` INT NOT NULL,
  FOREIGN KEY (`sessionConfigurationsId`) REFERENCES `SessionConfigurationModeOne`(`_id`),
  `status` VARCHAR(255),
  `createdBy` VARCHAR(255) NOT NULL,
  `createdDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastUpdatedDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);

CREATE TABLE IF NOT EXISTS `ModeTwo` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `defaultConfigurationId` INT NOT NULL,
  FOREIGN KEY (`defaultConfigurationId`) REFERENCES `DefaultConfiguration`(`_id`),
  `sessionConfigurationsId` INT NOT NULL,
  FOREIGN KEY (`sessionConfigurationsId`) REFERENCES `SessionConfigurationModeTwo`(`_id`),
  `status` VARCHAR(255),
  `createdBy` VARCHAR(255) NOT NULL,
  `createdDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastUpdatedDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);

CREATE TABLE IF NOT EXISTS `ModeThree` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `defaultConfigurationId` INT NOT NULL,
  FOREIGN KEY (`defaultConfigurationId`) REFERENCES `DefaultConfiguration`(`_id`),
  `sessionConfigurationId` INT NOT NULL,
  FOREIGN KEY (`sessionConfigurationId`) REFERENCES `SessionConfigurationModeThree`(`_id`),
  `resultId` INT NOT NULL,
  FOREIGN KEY (`resultId`) REFERENCES `SessionResult`(`_id`),
  `status` VARCHAR(255),
  `createdBy` VARCHAR(255) NOT NULL,
  `createdDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastUpdatedDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);

CREATE TABLE IF NOT EXISTS `ModeFour` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `defaultConfigurationId` INT NOT NULL,
  FOREIGN KEY (`defaultConfigurationId`) REFERENCES `DefaultConfiguration`(`_id`),
  `sessionConfigurationsId` INT NOT NULL,
  FOREIGN KEY (`sessionConfigurationsId`) REFERENCES `SessionConfigurationModeFour`(`_id`),
  `resultsId` INT NOT NULL,
  FOREIGN KEY (`resultsId`) REFERENCES `SessionResult`(`_id`),
  `status` VARCHAR(255),
  `createdBy` VARCHAR(255) NOT NULL,
  `createdDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastUpdatedDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);

CREATE TABLE IF NOT EXISTS `ModeFive` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `defaultConfigurationId` INT NOT NULL,
  FOREIGN KEY (`defaultConfigurationId`) REFERENCES `DefaultConfiguration`(`_id`),
  `sessionConfigurationId` INT NOT NULL,
  FOREIGN KEY (`sessionConfigurationId`) REFERENCES `SessionConfigurationModeFive`(`_id`),
  `resultsId` INT NOT NULL,
  FOREIGN KEY (`resultsId`) REFERENCES `SessionResult`(`_id`),
  `status` VARCHAR(255),
  `createdBy` VARCHAR(255) NOT NULL,
  `createdDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastUpdatedDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE IF NOT EXISTS `ModeSix` (
  `_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `defaultConfigurationId` INT NOT NULL,
  FOREIGN KEY (`defaultConfigurationId`) REFERENCES `DefaultConfiguration`(`_id`),
  `sessionConfigurationId` INT NOT NULL,
  FOREIGN KEY (`sessionConfigurationId`) REFERENCES `SessionConfigurationModeSix`(`_id`),
  `resultsId` INT NOT NULL,
  FOREIGN KEY (`resultsId`) REFERENCES `SessionResult`(`_id`),
  `status` VARCHAR(255),
  `createdBy` VARCHAR(255) NOT NULL,
  `createdDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastUpdatedDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE IF NOT EXISTS `ModeTwoSessionResult` (
  `modeTwoId` INT NOT NULL,
  FOREIGN KEY (`modeTwoId`) REFERENCES `ModeTwo`(`_id`),
  `resultId` INT NOT NULL,
  FOREIGN KEY (`resultId`) REFERENCES `SessionResult`(`_id`),
  PRIMARY KEY (`modeTwoId`, `resultId`));

CREATE TABLE IF NOT EXISTS `ModeOneSessionResult` (
  `modeOneId` INT NOT NULL,
  FOREIGN KEY (`modeOneId`) REFERENCES `ModeOne`(`_id`),
  `resultId` INT NOT NULL,
  FOREIGN KEY (`resultId`) REFERENCES `SessionResult`(`_id`),
  PRIMARY KEY (`modeOneId`, `resultId`));


