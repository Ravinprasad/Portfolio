UPDATE nashvile
SET PropertyAddress = NULL 
WHERE PropertyAddress = '';

SELECT * FROM project.nashvile;

SELECT SaleDate FROM project.nashvile;

SELECT DATE_FORMAT(STR_TO_DATE(SaleDate, '%M %d, %Y'), '%m/%d/%Y') 
FROM project.nashvile;

UPDATE nashvile
SET SaleDate = DATE_FORMAT(STR_TO_DATE(SaleDate, '%M %d, %Y'), '%m/%d/%Y');

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, IFNULL(a.PropertyAddress, b.PropertyAddress)
FROM nashvile a
INNER JOIN nashvile b
ON a.ParcelID =  b.ParcelID 
AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL;

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


SELECT ParcelID FROM (
SELECT ParcelID,
  ROW_NUMBER() OVER (
    PARTITION BY LegalReference, PropertyAddress, SalePrice, ParcelID, SaleDate
    ORDER BY 
      PropertyAddress
  ) AS row_num 
FROM project.nashvile) t
WHERE row_num > 1;


