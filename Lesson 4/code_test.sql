CREATE TABLE Participants (
	id_participants INTEGER PRIMARY KEY AUTOINCREMENT,
	first_name TEXT,
	last_name TEXT
);

DROP TABLE Participants;

ALTER TABLE Participants
ADD email TEXT;

INSERT INTO Participants VALUES ('3', 'Sandra', 'Thunder', 's.th@gmail.com'), ('2', 'Pepe', 'Der', 'P.d@gmail.com');

UPDATE Participants
SET email='algo@gmail.com'
WHERE id_participants=3;

DELETE FROM Participants
WHERE id_participants=3;