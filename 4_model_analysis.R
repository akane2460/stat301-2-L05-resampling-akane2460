# L05 Resampling ----
# Analysis of trained models (comparisons)
# Select final model
# Fit & analyze final model

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)
library(knitr)

# handle common conflicts
tidymodels_prefer()

# load test data----
load(here("data/kc_test.rda"))

# load trained models----
load(here("data/fit_lm.rda"))
load(here("data/fit_lasso.rda"))
load(here("data/fit_ridge.rda"))
load(here("data/fit_rf.rda"))
load(here("data/fit_nn.rda"))

# load final model----
load(here("data/fit_rf_train.rda"))

# analysis of trained models----

# lm
lm_metrics <- collect_metrics(fit_lm) |> 
  mutate(
    method = "lm"
  )

# lasso
lasso_metrics <- collect_metrics(fit_lasso) |> 
  mutate(
    method = "lasso"
  )

# ridge
ridge_metrics <- collect_metrics(fit_ridge) |> 
  mutate(
    method = "ridge"
  )

# rf
rf_metrics <- collect_metrics(fit_rf) |> 
  mutate(
    method = "rf"
  )

# nn
nn_metrics <- collect_metrics(fit_nn) |> 
  mutate(
    method = "nn"
  )

# combining metrics
combined_metrics <- bind_rows(lm_metrics, lasso_metrics, ridge_metrics, 
                              rf_metrics, nn_metrics)

# writing HTML table
combined_metrics_table <- kable(combined_metrics, format = "html")

# final model----
predicted_rf_final <- bind_cols(kc_test, predict(fit_rf_train, kc_test)) |> 
  select(price_log10, .pred)

rsme_predicted_rf <- rmse(predicted_rf_final, truth = price_log10, estimate = .pred)

# writing html table 
rf_rsme_final <- kable(rsme_predicted_rf, format = "html")

# rsme original scale----
og_scale_rf_final <- predicted_rf_final |> 
  mutate(
    price = 10^price_log10, 
    .pred = 10^.pred
  ) |> 
  select(-price_log10)

rsme_og_scale_rf <- rmse(og_scale_rf_final, truth = price, estimate = .pred)

# writing html table 
rsme_og_scale_rf_final <- kable(rsme_og_scale_rf, format = "html")

# r squared original scale----
rsq_metric <- metric_set(rsq)

rsq_og_scale_rf <- rsq_metric(og_scale_rf_final, truth = price, estimate = .pred)

# writing html table 
rsq_og_scale_rf_final <- kable(rsq_og_scale_rf, format = "html")

# within 10 pct----
within_10_table <- og_scale_rf_final |> 
  mutate(
    pct_diff = price / .pred
  ) |> 
  summarize(
    num_within = sum(pct_diff < 1.10 & pct_diff > .90),
    count = n(),
    pct_within = num_within / count * 100
  )

# writing html table 
within_10_table <- kable(within_10_table, format = "html")

# plot predicted vs actual log scale----
predicted_vs_price_plot <- predicted_rf_final |> 
ggplot(aes(x = price_log10, y = .pred))+ 
  geom_abline() + # diagonal line, indicating a completely accurate prediction
  geom_point(alpha = 0.5) + 
  labs(y = "Predicted Sale Price (log10)", x = "Sale Price (log10)") +
  coord_obs_pred()

ggsave(here("plots/predicted_vs_price_plot.png"), predicted_vs_price_plot)

