CREATE DATABASE IF NOT EXISTS MusicDB;
USE MusicDB;

## 18. Music Streaming Database
-- Tables: Users, Songs, Playlists, PlaylistSongs.
-- Insert user playlists and song data.
-- Query most played songs.
-- List users with more than 2 playlists.

CREATE TABLE IF NOT EXISTS Users (
  UserID INT PRIMARY KEY AUTO_INCREMENT,
  UserName VARCHAR(100) NOT NULL,
  Email VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Songs (
  SongID INT PRIMARY KEY AUTO_INCREMENT,
  Title VARCHAR(255) NOT NULL,
  Artist VARCHAR(255),
  DurationSec INT
);

CREATE TABLE IF NOT EXISTS Playlists (
  PlaylistID INT PRIMARY KEY AUTO_INCREMENT,
  UserID INT NOT NULL,
  Name VARCHAR(255) NOT NULL,
  CreationDate DATE NOT NULL,
  FOREIGN KEY (UserID) REFERENCES Users(UserID)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS PlaylistSongs (
  PlaylistID INT NOT NULL,
  SongID INT NOT NULL,
  AddedDate DATE NOT NULL,
  PRIMARY KEY (PlaylistID, SongID),
  FOREIGN KEY (PlaylistID) REFERENCES Playlists(PlaylistID)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (SongID) REFERENCES Songs(SongID)
    ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Users (UserName, Email) VALUES
  ('Alice', 'alice@example.com'),
  ('Bob', 'bob@example.com'),
  ('Charlie', 'charlie@example.com');

INSERT INTO Songs (Title, Artist, DurationSec) VALUES
  ('Song A', 'Artist X', 200),
  ('Song B', 'Artist Y', 180),
  ('Song C', 'Artist X', 240),
  ('Song D', 'Artist Z', 210);

INSERT INTO Playlists (UserID, Name, CreationDate) VALUES
  (1, 'Chill Hits', CURDATE() - INTERVAL 10 DAY),
  (1, 'Workout', CURDATE() - INTERVAL 5 DAY),
  (2, 'Favorites', CURDATE() - INTERVAL 7 DAY),
  (3, 'Study', CURDATE() - INTERVAL 3 DAY);

INSERT INTO PlaylistSongs (PlaylistID, SongID, AddedDate) VALUES
  (1, 1, CURDATE() - INTERVAL 9 DAY),
  (1, 2, CURDATE() - INTERVAL 8 DAY),
  (2, 2, CURDATE() - INTERVAL 4 DAY),
  (2, 3, CURDATE() - INTERVAL 4 DAY),
  (3, 1, CURDATE() - INTERVAL 7 DAY),
  (3, 4, CURDATE() - INTERVAL 6 DAY),
  (4, 3, CURDATE() - INTERVAL 2 DAY),
  (4, 4, CURDATE() - INTERVAL 2 DAY);
  
  SELECT s.SongID, s.Title, s.Artist, COUNT(ps.SongID) AS PlayCount
FROM PlaylistSongs ps
JOIN Songs s USING (SongID)
GROUP BY s.SongID, s.Title, s.Artist
ORDER BY PlayCount DESC;

SELECT u.UserID, u.UserName, COUNT(p.PlaylistID) AS PlaylistCount
FROM Users u
JOIN Playlists p USING (UserID)
GROUP BY u.UserID, u.UserName
HAVING COUNT(p.PlaylistID) > 2;



