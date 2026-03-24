In this project, I transformed a small  dataset of  cafe sales into an interactive excel dashboard. The goal was to clean the data, extract insights and visaulize the sales trends to help the cafe management system make meaningingful decisions basedoff data generated from the cafe.
The dataset contained deatils like:Transaction ID, item, quantity, price per unit, total spent, payment method, location and transaction date. This dataset had inconsistent values; such as 'UNKNOWN', 'ERROR' and blank spaces.
To clean the data I had to:
1. A query was run to ensure that there were duplicate transactions/ data in this dataset.


2. In the quantity field, all values that were "Unknown" and "ERROR" where cahnged to 'null' with the field data type changed to INT


3. In the price_per_unit field, all values that were "Unknown" and "ERROR" where cahnged to 'null' with the field data type changed to Money.


4. In the total_spent field, all values that were "Unknown" and "ERROR" where cahnged to 'null' with the field data type changed to Money.
In the payment_method field, all values that were "Unknown" and "ERROR" where cahnged to 'null' and using the TRIM() function all leading and trailing whitespaces were removed.


5. In the location field, all values that were "Unknown"  where cahnged to 'Unknown' and 'ERROR' changed to 'null'.


6. In the item field, all the 'ERROR' values were changed to null and all the 'UNKNOWN' items chanage to 'Unknown ' and later updated the Unknown item to unknown sales so as to keep track of every sale/person who visited the shop.

7. Some entries were deleted that added no analytical value; such as rows where the price_per_unit and total_spent were null and rows where quantity and total_spent were null and lastly rows were price_per_unit and quantity was null.


8. Calculated values were also generated 
(a) total_spent = price-per_unit * quantity

(b) price-per_unit = total_spent / quantity

(c) quantity = total_spent / price_per_unit


9. Link to the google sheets where the data was visualized 
[click here](https://docs.google.com/spreadsheets/d/18gJR6PwbI9wZ9vrDHF5aPuexdUv47NJw1CMs_Jxvlgg/edit?usp=sharing)
