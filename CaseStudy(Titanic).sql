use Titanic_CaseStudy;

# 1. Show the first 10 rows of the dataset.
SELECT * from titanic limit 10;
SELECT * FROM titanic ORDER BY PassengerId DESC LIMIT 10;

# 2. Find the number of passengers who survived.
SELECT count(*) as "Passagers Survived"  FROM titanic WHERE Survived = 1;

# 3. Find the average age of all passengers.
SELECT avg(age) as "Average Age" FROM titanic; 

# 4. Find the number of passengers in each class.
SELECT count(*) as "Class_1" FROM titanic WHERE Pclass = 1;
SELECT count(*) as "Class_2" FROM titanic WHERE Pclass = 2;
SELECT count(*) as "Class_3" FROM titanic WHERE Pclass = 3;
#OR
SELECT Pclass, count(*) as "Number of Passangers" FROM titanic GROUP BY Pclass ORDER BY Pclass DESC;

# 5. Find the first 10 rows of the dataset sorted by passenger class in descending order.
SELECT * FROM titanic ORDER BY Pclass DESC LIMIT 10;

# 6. Find the number of passengers in each class sorted by class in ascending order.
SELECT Pclass, count(*) as "Number of Passangers" FROM titanic GROUP BY Pclass ORDER BY Pclass;

# 7. Find the average fare paid by passengers in each class.
SELECT Pclass, avg(Fare) as "Average Fare" FROM titanic GROUP BY Pclass ORDER BY Pclass;

# 8. Find the name of the passenger with the highest fare.
SELECT Name,Fare FROM titanic WHERE Fare = (SELECT MAX(Fare) FROM titanic);

# 9. Find the name of the passenger who had the highest age among the survivors.
SELECT Name,Age FROM titanic WHERE Age = (SELECT MAX(Age) FROM titanic WHERE Survived = 1);

# 10. Find the number of passengers who paid more than the average fare.
SELECT count(*) as "Passangers Overpaid" FROM titanic WHERE Fare > (SELECT avg(Fare) FROM titanic);

# 11. Find the name of the passenger who had the most parents or children on board.
SELECT Name,Parch FROM titanic WHERE Parch = (SELECT MAX(Parch) FROM titanic);

# 12. Find the number of male and female passengers who survived, and order the results by sex in ascending order:
SELECT sex,count(*) as "Passangers Survived" FROM titanic WHERE Survived = 1
GROUP BY sex
ORDER BY sex;

# 13. Find the name, age, and fare of the oldest passenger who survived.
SELECT Name,Age,Fare FROM titanic WHERE Age = (SELECT MAX(Age) FROM titanic WHERE Survived = 1);

# 14. Find the name and age of the youngest female passenger who survived in third class.
SELECT Name,Age FROM titanic WHERE Sex = 'female' and Pclass = 3 and Survived = 1 and Age = (SELECT MIN(Age) FROM Titanic WHERE Pclass = 3 AND Sex = 'female' AND Survived = 1);

# 15. Find Number of male and female passengers.
SELECT sex,count(*) as "Number of Passangers" FROM titanic GROUP BY Sex;
#OR
SELECT 

SUM(CASE WHEN Sex = 'male' THEN 1 ELSE 0 END) as "Number of Males",
SUM(CASE WHEN Sex = 'female' THEN 1 ELSE 0 END) as "Number of Females"

FROM titanic;

# 16. Select all passengers who traveled in a cabin that was not shared by other passengers.
SELECT * FROM titanic WHERE Cabin NOT IN (SELECT Cabin FROM titanic GROUP BY Cabin HAVING count(*) > 1);

