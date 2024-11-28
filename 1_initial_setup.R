# L05 Resampling ----
# Initial data checks, data splitting, & data folding

# random processes present

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)
library(patchwork)


# handle common conflicts
tidymodels_prefer()

# load data
kc_transformed <- read.csv(here("data/kc_house_data.csv")) |> 
  janitor::clean_names() |> 
  mutate(price_log10 = log10(price)) 

kc_transformed |> 
  skimr::skim_without_charts()

p1 <- kc_transformed |> 
  ggplot(aes(price)) + 
  geom_density() +
  theme_minimal() +
  theme(
    axis.text.y = element_blank(),
    axis.title.y = element_blank(),
    axis.ticks.y = element_blank()
  ) 
# unimodal

p2 <- kc_transformed |> 
  ggplot(aes(price)) + 
  geom_boxplot() +
  theme_void()

p2/p1 + plot_layout(heights = unit(c(1, 5), c("cm", "cm"))) &
  scale_x_log10(name = "log10 price")

# set seed
set.seed(22222)

# splitting data
kc_split <- kc_transformed |> 
  initial_split(prop = .8, strata = price_log10)

# making train and test data
kc_train <- kc_split |> training()
kc_test <- kc_split |> testing()

# folding data (resamples)
set.seed(1245780)
kc_fold <- kc_train |> 
  vfold_cv(v = 5, repeats = 3, strata = price_log10)

# # set up controls for fitting resamples
# keep_pred <- control_resamples(save_pred = TRUE, save_workflow = TRUE)

# write out split, train, fold and test data
save(kc_split, file = here("data/kc_split.rda"))
save(kc_train, file = here("data/kc_train.rda"))
save(kc_test, file = here("data/kc_test.rda"))
# save(keep_pred, file = here("data/keep_preds.rda"))
