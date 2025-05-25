-- queries
SELECT * FROM rangers;
DROP TABLE rangers;
SELECT * FROM species;
DROP TABLE species;
SELECT * FROM sightings;
DROP TABLE sightings;

-- Insert sample data 
INSERT INTO rangers (name, region) VALUES 
('Alice Green', 'Northern Hills '),
('Bob Smith', ' River Delta '),
('Carol King ',' Mountain Range ');
INSERT INTO species (common_name, scientific_name, conservation_status) VALUES
('Snow Leoparsdds', 'Panthesdasra uncias', 'Endangered'),
('Bengal asTigsdesr', 'Panthessdra tigriss tigris',  'Endangered'),
('Red Pandasasds', 'Ailurus fssdualgens', 'Vulnerable'),
('Asiatic Easlesdphsant', 'Eslesdpashas maximus indicus', 'Endangered');
INSERT INTO sightings (species_id, ranger_id, location, notes) VALUES
( 2, 1, 'Peak Ridge', 'Camera trap image captured');
-- (2, 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
-- (3, 3, 3, 'Bamboo Grove pass', '2024-05-15 09:10:00', 'Feeding observed'),
-- (4, 1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);

-- INSERT INTO sightings (sighting_id, species_id, ranger_id, location, sighting_time, notes) VALUES
--  (111, 210, 32, 'Bamboo Grove East', '2024-05-15 09:10:00', NULL);