--Filling in the empty cells with null 
UPDATE nashvile
SET PropertyAddress = NULL 
WHERE PropertyAddress = '';

--Selecting all the columns from the table
SELECT * FROM project.nashvile;

--Changing the sale date format 
SELECT SaleDate FROM project.nashvile;

SELECT DATE_FORMAT(STR_TO_DATE(SaleDate, '%M %d, %Y'), '%m/%d/%Y') 
FROM project.nashvile;

--Updating the sale date format
UPDATE nashvile
SET SaleDate = DATE_FORMAT(STR_TO_DATE(SaleDate, '%M %d, %Y'), '%m/%d/%Y');

--Populating the null values in the property address column using joins
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, IFNULL(a.PropertyAddress, b.PropertyAddress)
FROM nashvile a
INNER JOIN nashvile b
ON a.ParcelID =  b.ParcelID 
AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL;

--Splitting the address to make it more usable
SELECT
SUBSTRING_INDEX(PropertyAddress, ",", 1) AS Address,
SUBSTRING_INDEX(PropertyAddress, ",", -1) AS City
FROM project.nashvile;

ALTER TABLE nashvile
ADD SplitCity CHAR(50);
ALTER TABLE nashvile
ADD SplitAdress CHAR(50);

UPDATE nashvile
SET SplitAdress = SUBSTRING_INDEX(PropertyAddress, ",", 1);
UPDATE nashvile
SET SplitCity = SUBSTRING_INDEX(PropertyAddress, ",", -1);

--Changing the sold as vacant column into a more standardized format of Yes or No
SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM project.nashvile
GROUP BY SoldAsVacant
ORDER BY 2;

SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
WHEN SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant
END
FROM project.nashvile;

UPDATE nashvile
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
WHEN SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant
END;

--Finding out any duplicate columns
SELECT ParcelID FROM (
SELECT ParcelID,
  ROW_NUMBER() OVER (
    PARTITION BY LegalReference, PropertyAddress, SalePrice, ParcelID, SaleDate
    ORDER BY 
      PropertyAddress
  ) AS row_num 
FROM project.nashvile) t
WHERE row_num > 1;


