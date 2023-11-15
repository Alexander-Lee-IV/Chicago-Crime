-- Time of arrests--
SELECT
    DISTINCT(district) AS district,
    TO_CHAR(date, 'mm/dd/yyyy') AS dates,
    COUNT(CASE WHEN arrest = true THEN 1 END) AS arrests,
    COUNT(crimes) AS crimes
FROM crimes
WHERE district NOT IN ('13', '21', '23', '31')
GROUP BY district, dates
ORDER BY district;
--crimes commited the most--
SELECT
    district,
	TO_CHAR(date, 'mm/dd/yyyy') AS dates,
    primary_type,
    description,
    COUNT(primary_type) AS num_of_crimes
FROM crimes
WHERE district NOT IN ('13', '21', '23', '31') 
GROUP BY district, primary_type, description, date
ORDER BY district ASC;
-- crime location--
SELECT
    district,
	TO_CHAR(date, 'mm/dd/yyyy') AS dates,
    location_description,
    COUNT(location_description)
FROM crimes
WHERE district NOT IN ('13', '21', '23', '31')
GROUP BY district, location_description, date
ORDER BY count DESC;  


--exporting data--

COPY(SELECT
    DISTINCT(district) AS district,
    TO_CHAR(date, 'mm/dd/yyyy') AS dates,
    COUNT(CASE WHEN arrest = true THEN 1 END) AS arrests,
    COUNT(crimes) AS crimes
FROM crimes
WHERE district NOT IN ('13', '21', '23', '31')
GROUP BY district, date
ORDER BY district) to 'C:\Users\alexa\OneDrive\Desktop\Chicago_crime\Query Results\time_of_arrests.csv' DELIMITER ',' CSV HEADER;


COPY(SELECT
    district,
	TO_CHAR(date, 'mm/dd/yyyy') AS dates,
    primary_type,
    description,
    COUNT(primary_type) AS num_of_crimes
FROM crimes
WHERE district NOT IN ('13', '21', '23', '31') 
GROUP BY district, primary_type, description, date
ORDER BY district ASC) to 'C:\Users\alexa\OneDrive\Desktop\Chicago_crime\Query Results\crimes_commited.csv' DELIMITER ',' CSV HEADER;

COPY(SELECT
    district,
	TO_CHAR(date, 'mm/dd/yyyy') AS dates,
    location_description,
    COUNT(location_description)
FROM crimes
WHERE district NOT IN ('13', '21', '23', '31')
GROUP BY district, location_description, date
ORDER BY count DESC) to 'C:\Users\alexa\OneDrive\Desktop\Chicago_crime\Query Results\crime_location.csv' DELIMITER ',' CSV HEADER;