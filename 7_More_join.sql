-- 1. List the films where the yr is 1962 [Show id, title]
SELECT id, title
FROM movie
WHERE yr = 1962

-- 2. Give year of 'Citizen Kane'.
SELECT yr
FROM movie
WHERE title = 'Citizen Kane'

-- 3. List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title).
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr

-- 4. What id number does the actor 'Glenn Close' have?
SELECT id
FROM actor
WHERE name = 'Glenn Close'

-- 5. What is the id of the film 'Casablanca'
SELECT id
FROM movie
WHERE title = 'Casablanca'

-- 6. Obtain the cast list for 'Casablanca'. Use movieid=11768, (or whatever value you got from the previous question)
SELECT name
FROM actor JOIN casting
ON actorid = id
WHERE movieid = 11768

-- 7. Obtain the cast list for the film 'Alien'
SELECT name
FROM actor JOIN casting
ON actorid = id
WHERE movieid = (SELECT id FROM movie WHERE title = 'Alien')

-- 8. List the films in which 'Harrison Ford' has appeared
SELECT title
FROM movie JOIN casting
ON id = movieid
WHERE actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford')

-- 9. List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
SELECT title
FROM movie JOIN casting
ON id = movieid
WHERE actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford') AND ord <> 1

-- 10. List the films together with the leading star for all 1962 films.
SELECT m.title, a.name
FROM movie m JOIN casting c
ON movieid = m.id
JOIN actor a ON actorid = a.id
WHERE m.yr = 1962 AND c.ord = 1

-- 11. Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT yr,COUNT(title)
FROM movie JOIN casting
ON movie.id = movieid
JOIN actor
ON actorid = actor.id
WHERE name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT title, name
FROM casting JOIN movie
ON movieid = movie.id AND ord = 1
JOIN actor
ON (actorid = actor.id)
WHERE movie.id IN (SELECT movieid FROM casting WHERE actorid IN (SELECT id FROM actor where name = 'Julie Andrews'));

-- 13. Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.
SELECT name
FROM actor join casting
ON actor.id = actorid AND ord = 1
GROUP BY name
HAVING COUNT(name) >= 15
ORDER BY name

-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT title, COUNT(title)
FROM movie JOIN casting
ON movie.id = movieid
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(title) desc, title

-- 15. List all the people who have worked with 'Art Garfunkel'.
SELECT DISTINCT name
FROM actor JOIN casting
ON actor.id = actorid
WHERE movieid IN (SELECT movieid FROM casting JOIN actor on actor.id = actorid WHERE actor.name = 'Art Garfunkel') AND actor.name <> 'Art Garfunkel'