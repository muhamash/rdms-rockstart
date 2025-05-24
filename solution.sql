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
  common_name VARCHAR(100) NOT NULL,
  scientific_name VARCHAR(150) NOT NULL,
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
SELECT * FROM species;
SELECT * FROM sightings;

--solution

--answer 1
CREATE FUNCTION register_ranger(ranger_name TEXT, ranger_region TEXT)
RETURNS INTEGER AS $$
DECLARE
    affected_rows INTEGER;
BEGIN
    INSERT INTO rangers (name, region)
    SELECT ranger_name, ranger_region
    WHERE NOT EXISTS (
        SELECT 1 FROM rangers WHERE name = ranger_name AND region = ranger_region
    );

    GET DIAGNOSTICS affected_rows = ROW_COUNT;
    RETURN affected_rows;
END;
$$ LANGUAGE plpgsql;

SELECT register_ranger('Derek Fox', 'Coastal Plains');

--answer 2

