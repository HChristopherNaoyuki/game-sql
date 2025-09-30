-- QUESTION 1
-- Q.1.1.
-- DATABASE
CREATE DATABASE GAMES;
USE GAMES;

-- TABLE: Team
CREATE TABLE Team
(
    TeamID CHAR(4) PRIMARY KEY NOT NULL,
    TeamName VARCHAR(100) NOT NULL
);

-- TABLE: Stadium
CREATE TABLE Stadium
(
    StadiumID CHAR(4) PRIMARY KEY NOT NULL,
    StadiumName VARCHAR(100) NOT NULL,
    StadiumAddress VARCHAR(100) NOT NULL
);

-- TABLE: Game
CREATE TABLE Game
(
    GameID CHAR(4) NOT NULL,
    TeamID_TeamA CHAR(4) NOT NULL,
    TeamID_TeamB CHAR(4) NOT NULL,
    StadiumID CHAR(4) NOT NULL,
    GameDate DATE NOT NULL,
    GameTime CHAR(5) NOT NULL,
    GameDuration INT NOT NULL,
    -- Constraints
    PRIMARY KEY (GameID, TeamID_TeamA, TeamID_TeamB, StadiumID),
    FOREIGN KEY (TeamID_TeamA) REFERENCES Team(TeamID),
    FOREIGN KEY (TeamID_TeamB) REFERENCES Team(TeamID),
    FOREIGN KEY (StadiumID) REFERENCES Stadium(StadiumID)
);

-- Q.1.2.
-- Populate: Team
INSERT INTO Team (TeamID, TeamName)
VALUES
    ('T001', 'Blaze Battalion'),
    ('T002', 'Phantom Striker'),
    ('T003', 'Wild Stallions'),
    ('T004', 'Crimson Vipers'),
    ('T005', 'Midnight Raiders');

-- Populate: Stadium
INSERT INTO Stadium (StadiumID, StadiumName, StadiumAddress)
VALUES
    ('S001', 'Titan Field', '167 Pert Road, Johannesburg'),
    ('S002', 'Victory Park', '5 Second Avenue, Gqeberha'),
    ('S003', 'Apex Arena', '33 Bertha Mkhize Street, Durban'),
    ('S004', 'Thunder Dome', '27 Bram Fischer Road, Durban'),
    ('S005', 'Horison Stadium', '210 Du Toit Street, Tshwane');

-- Populate: Game
INSERT INTO Game (GameID, TeamID_TeamA, TeamID_TeamB, StadiumID, GameDate, GameTime, GameDuration)
VALUES
    ('G001', 'T001', 'T002', 'S001', '2025-07-05', '14h00', 90),
    ('G002', 'T003', 'T005', 'S004', '2025-07-06', '11h00', 90),
    ('G003', 'T002', 'T003', 'S005', '2025-07-07', '19h00', 90),
    ('G004', 'T001', 'T005', 'S003', '2025-07-08', '18h00', 120),
    ('G005', 'T002', 'T005', 'S001', '2025-07-09', '18h00', 120);

-- Q.1.3.
ALTER TABLE Game
ADD Number_Of_Tickets_Available INT DEFAULT 0;

SELECT * FROM Game;

-- Q.1.4.
UPDATE Game
SET Number_Of_Tickets_Available = 950
WHERE GameID = 'G003';

SELECT * FROM Game;

-- QUESTION 2
-- Q.2.1.
SELECT Stadium.StadiumName
FROM Stadium
LEFT JOIN Game ON Stadium.StadiumID = Game.StadiumID
WHERE Game.StadiumID IS NULL;

-- Q.2.2.
SELECT
    Stadium.StadiumName,
    Game.GameDate,
    Game.GameDuration
FROM
    Game
JOIN
    Stadium ON Game.StadiumID = Stadium.StadiumID
WHERE
    Game.StadiumID = 'S001'
    AND Game.GameDuration = (
        SELECT MAX(GameDuration)
        FROM Game
        WHERE StadiumID = 'S001'
    );
