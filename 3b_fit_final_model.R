# L05 Resampling ----
# Define and fit random forest (train data)

# random processes present

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load training data----
load(here("data/kc_train.rda"))

# load pre-processing/feature engineering/recipe----
load(here("data/kc_recipe_tree.rda"))

# model specifciations----

# set seed
set.seed(072384)

rf_spec <- 
  rand_forest(trees = 600, min_n = 10) %>%
  set_engine("ranger") %>% 
  set_mode("regression")

# define workflows ----
rf_wflow <-
  workflow() |> 
  add_model(rf_spec) |> 
  add_recipe(kc_recipe_tree)

# fit workflows/models ----
fit_rf_train <- fit(rf_wflow, kc_train)

# write out results (fitted/trained workflows) ----
save(fit_rf_train, file = here("data/fit_rf_train.rda"))

