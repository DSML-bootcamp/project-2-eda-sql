USE project_football;

/*Question 1:
AVG market value per country (TOP 20) (More than 20 players)*/
SELECT country_of_birth, AVG(highest_market_value_in_eur) AS AVG_Highest_Market_in_EUR
FROM active_players
GROUP BY country_of_birth
HAVING COUNT(country_of_birth) > 10
ORDER BY AVG_Highest_Market_in_EUR DESC
LIMIT 20;

SELECT country_of_birth, AVG(market_value_in_eur) AS AVG_Market_in_EUR
FROM active_players
GROUP BY country_of_birth
HAVING COUNT(country_of_birth) > 10
ORDER BY AVG_Market_in_EUR DESC
LIMIT 20;


/*Question 2:
AVG market value per current club (TOP10)*/
SELECT current_club_name, AVG(highest_market_value_in_eur) AS AVG_Highest_Market_in_EUR
FROM active_players
GROUP BY current_club_name
ORDER BY AVG_Highest_Market_in_EUR DESC
LIMIT 10;


/*Question 3:
Num players per country*/
SELECT country_of_birth, COUNT(DISTINCT player_id)
FROM active_players
GROUP BY country_of_birth
ORDER BY COUNT(DISTINCT player_id) DESC;

SELECT country_of_citizenship, COUNT(DISTINCT player_id)
FROM active_players
GROUP BY country_of_citizenship
ORDER BY COUNT(DISTINCT player_id) DESC;


/*Question 4:
Num homegrown players per country (European competitions)*/
SELECT active_players.country_of_citizenship, COUNT(DISTINCT active_players.player_id) AS homegrown_player_count
FROM active_players RIGHT JOIN competitions
ON active_players.current_club_domestic_competition_id = competitions.competition_id
WHERE active_players.country_of_citizenship = competitions.country_name
GROUP BY active_players.country_of_citizenship
ORDER BY homegrown_player_count DESC;


/*Question 5:
count foreigns players per country (PLAYING) (European competitions)*/
SELECT active_players.country_of_citizenship, COUNT(DISTINCT active_players.player_id) AS foreigns_player_count
FROM active_players RIGHT JOIN competitions
ON active_players.current_club_domestic_competition_id = competitions.competition_id
WHERE active_players.country_of_citizenship != competitions.country_name
GROUP BY active_players.country_of_citizenship
ORDER BY foreigns_player_count DESC;


/*Question 6:
AVG market value for foreigns players per country (European competitions)*/
SELECT active_players.country_of_citizenship, AVG(active_players.highest_market_value_in_eur) AS AVG_Highest_Market_in_EUR
FROM active_players RIGHT JOIN competitions
ON active_players.current_club_domestic_competition_id = competitions.competition_id
WHERE active_players.country_of_citizenship != competitions.country_name
GROUP BY active_players.country_of_citizenship
HAVING COUNT(active_players.country_of_birth) > 50
ORDER BY AVG_Highest_Market_in_EUR DESC;

SELECT active_players.country_of_citizenship, AVG(active_players.market_value_in_eur) AS AVG_Market_in_EUR
FROM active_players RIGHT JOIN competitions
ON active_players.current_club_domestic_competition_id = competitions.competition_id
WHERE active_players.country_of_citizenship != competitions.country_name
GROUP BY active_players.country_of_citizenship
HAVING COUNT(active_players.country_of_birth) > 50
ORDER BY AVG_Market_in_EUR DESC;


/*Question 7:
AVG market value for homegrown players per country (European competitions)*/
SELECT active_players.country_of_citizenship, AVG(active_players.market_value_in_eur) AS AVG_Market_in_EUR
FROM active_players RIGHT JOIN competitions
ON active_players.current_club_domestic_competition_id = competitions.competition_id
WHERE active_players.country_of_citizenship = competitions.country_name
GROUP BY active_players.country_of_citizenship
ORDER BY AVG_Market_in_EUR DESC;


/*Question 8:
AVG market value per country (European competitions)*/
SELECT competitions.country_name, AVG(active_players.market_value_in_eur) AS AVG_Market_in_EUR
FROM active_players RIGHT JOIN competitions
ON active_players.current_club_domestic_competition_id = competitions.competition_id
GROUP BY competitions.country_name
ORDER BY AVG_Market_in_EUR DESC;


/*Question 9:
AVG market value per num Goals*/
SELECT active_players.name, SUM(active_appearances.goals) AS Goals, active_players.highest_market_value_in_eur AS Market_Value
FROM active_players INNER JOIN active_appearances
ON active_players.player_id = active_appearances.player_id
GROUP BY active_players.name, active_players.highest_market_value_in_eur
ORDER BY Goals DESC
LIMIT 10;


/*Question 10:
AVG market value per age*/
SELECT active_players.name, active_players.market_value_in_eur AS Market_Value, active_players.date_of_birth
FROM active_players
ORDER BY Market_Value DESC
LIMIT 10;
SELECT 
    active_players.name, 
    active_players.highest_market_value_in_eur AS Market_Value, 
    active_players.date_of_birth,
    FLOOR(DATEDIFF(CURDATE(), active_players.date_of_birth) / 365.25) AS age
FROM active_players
ORDER BY Market_Value DESC
LIMIT 10;





















