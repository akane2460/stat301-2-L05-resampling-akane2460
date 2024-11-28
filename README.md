## Lab 5 Overview

The goal for this lab is to start using resampling methods to compare models. Ultimately leading to the selection of a final/winning/best model.

This lab covers material up to and including [11. Comparing models with resampling (11.2)](https://www.tmwr.org/compare.html) from [Tidy Modeling with R](https://www.tmwr.org/).

## What's in the Repo

### Folders
- `data/` can find the original dataset `kc_house_data.csv` and its codebook and data generated and used for model fitting and analysis.
- `plots/` can find the plot `predicted_vs_price_plot.png`

### R Scripts
- `1_initial_setup.R` can find the early code processing, establishing the folds, and splitting into train/test  sets
- `2_recipes.R` can find the recipes for lm and tree based models
  - Fitting using fold dataset
    - `3_fit_lm.R` can find the fitting for lm model
    - `3_fit_lasso.R` can find the fitting for the lasso model
    - `3_fit_ridge.R` can find the fitting for the ridge model
    - `3_fit_nn.R` can find the fitting for the nearest neighbor model
    - `3_fit_rf.R` can find the fitting for the random forest model
  - Fitting using the train dataset
    - `3b_fit_final_model.R` can find the fitting for the selected final model
- `4_model_analysis.R` can find the analysis of all the models and calculations to answer tasks

### Quarto Documents
- `Kane_Allison_L04.qmd` contains the exercises in their concise form and answers to questions.

### HTML Documents
- `Kane_Allison_L04.html` contains the rendered exercises in their concise form and answers to questions.

- `L04_resampling.html` contains a template of the lab.