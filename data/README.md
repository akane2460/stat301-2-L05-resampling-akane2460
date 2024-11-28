## Data

This folder contains the original data and the data generated to analyze this original data.


## Original Data

The King County, Washington housing data was sourced from [Kaggle.com](https://www.kaggle.com/datasets/harlfoxem/housesalesprediction/data).

- `kc_house_data.csv`
- `kc_house_data_codebook.csv`

Quick reference for `kc_house_data_codebook.csv`:

| variable      | Description                                            |
|---------------|--------------------------------------------------------|
|`id`           |Unique ID for each home sold                            |
|`date`| Date of the home sale|
|`price`| Price of each home sold|
|`bedrooms`| Number of bedrooms|
|`bathrooms`| Number of bathrooms, where 0.5 accounts for a room with a toilet but no shower|
|`sqft_living`| Square footage of the apartments interior living space|
|`sqft_lot`| Square footage of the land space|
|`floors`| Number of floors|
|`waterfront`| A dummy variable for whether the apartment was overlooking the waterfront or not|
|`view`| An index from 0 to 4 of how good the view of the property was|
|`condition`| An index from 1 to 5 on the condition of the apartment|
|`grade`| An index from 1 to 13, where 1-3 falls short of building construction and design, 7 has an average level of construction and design, and 11-13 have a high quality level of construction and design.|
|`sqft_above`| The square footage of the interior housing space that is above ground level|
|`sqft_basement`| The square footage of the interior housing space that is below ground level|
|`yr_built`| The year the house was initially built|
|`yr_renovated`| The year of the house’s last renovation|
|`zipcode`| What zipcode area the house is in|
|`lat`| Latitude|
|`long`| Longitude|
|`sqft_living15`| The square footage of interior housing living space for the nearest 15 neighbors|
|`sqft_lot15`| The square footage of the land lots of the nearest 15 neighbors|