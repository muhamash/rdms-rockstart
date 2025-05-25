-- Active: 1747900683952@@127.0.0.1@5432@conservation_db
--connection: conservation_db
-- Create rangers table
CREATE TABLE rangers (
  ranger_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  region VARCHAR(100) NOT NULL
);

-- Create species table
CREATE TABLE species (
  species_id SERIAL PRIMARY KEY,
  common_name VARCHAR(100) UNIQUE NOT NULL,
  scientific_name VARCHAR(150) UNIQUE NOT NULL,
  discovery_date DATE NOT NULL,
  conservation_status VARCHAR(50) CHECK (conservation_status IN ('Endangered', 'Vulnerable')) NOT NULL
);

-- Create sightings table
CREATE TABLE sightings (
  sighting_id SERIAL PRIMARY KEY,
  ranger_id INT NOT NULL,
  species_id INT NOT NULL,
  sighting_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  location VARCHAR(150) NOT NULL,
  notes TEXT,
  FOREIGN KEY (ranger_id) REFERENCES rangers(ranger_id),
  FOREIGN KEY (species_id) REFERENCES species(species_id)
);

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
INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');
INSERT INTO sightings (sighting_id, species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(4, 1, 2, 'Snowfall Pass', '2024-05-18 18:30:00');
INSERT INTO sightings (sighting_id, species_id, ranger_id, location, sighting_time, notes) VALUES
 (111, 210, 32, 'Bamboo Grove East', '2024-05-15 09:10:00', NULL);


--solution

--answer 1
INSERT INTO rangers (name, region) VALUES ('Derek Fox', 'cc Plain')

--answer 2
SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings;

--answer 3
SELECT sighting_id, species_id, ranger_id, location, sighting_time, notes
FROM sightings
WHERE location ILIKE '%Pass%';

--answer 4
SELECT r.name, COUNT(s.sighting_id) AS total_sightings
FROM rangers r
LEFT JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY r.name
ORDER BY r.name;

--answer 5
SELECT sp.common_name
FROM species sp
LEFT JOIN sightings s ON sp.species_id = s.species_id
WHERE s.sighting_id IS NULL;

--answer 6
SELECT 
    sp.common_name,
    s.sighting_time,
    r.name
FROM sightings s
JOIN species sp ON s.species_id = sp.species_id
JOIN rangers r ON s.ranger_id = r.ranger_id
ORDER BY s.sighting_time DESC
LIMIT 2;

--answer 7
CREATE OR REPLACE FUNCTION update_historic_species_and_constraint()
RETURNS INTEGER AS $$
DECLARE
    affected_rows INTEGER;
    constraint_name TEXT;
    constraint_def TEXT;
    historic_allowed BOOLEAN := FALSE;
BEGIN
    -- Find the check constraint 
    SELECT conname, pg_get_constraintdef(c.oid)
    INTO constraint_name, constraint_def
    FROM pg_constraint c
    JOIN pg_class t ON c.conrelid = t.oid
    WHERE t.relname = 'species'
      AND c.contype = 'c'
      AND pg_get_constraintdef(c.oid) LIKE '%conservation_status%';

    -- Check 'Historic' 
    IF constraint_def LIKE '%Historic%' THEN
        historic_allowed := TRUE;
    END IF;

    -- If 'Historic' is not allowed recreate constraint with 'Historic'
    IF NOT historic_allowed THEN
        EXECUTE format('ALTER TABLE species DROP CONSTRAINT %I', constraint_name);
        EXECUTE 'ALTER TABLE species ADD CONSTRAINT species_conservation_status_check
                 CHECK (conservation_status IN (''Endangered'', ''Vulnerable'', ''Historic''))';
    END IF;

    -- Update the species
    UPDATE species
    SET conservation_status = 'Historic'
    WHERE discovery_date < DATE '1800-01-01';

    GET DIAGNOSTICS affected_rows = ROW_COUNT;
    RETURN affected_rows;
END;
$$ LANGUAGE plpgsql;
SELECT update_historic_species_and_constraint();

--answer 8
SELECT 
    sighting_id,
    CASE 
        WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sighting_time) < 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sightings
ORDER BY sighting_id;

--answer 9
CREATE OR REPLACE FUNCTION delete_inactive_rangers()
RETURNS INTEGER AS $$
DECLARE
    affected_rows INTEGER;
BEGIN
    DELETE FROM rangers
    WHERE ranger_id NOT IN (
        SELECT DISTINCT ranger_id FROM sightings
    );
    
    GET DIAGNOSTICS affected_rows = ROW_COUNT;
    RETURN affected_rows;
END;
$$ LANGUAGE plpgsql;

SELECT delete_inactive_rangers();