
library(readr)
df1 <- readr::read_csv("./heating-load.csv", col_names = TRUE)

knitr::kable(df1, caption = 'Data for a predicting heating load in residential buildings.', align = "lrrrr")

# Define the data frame with query instances
df1 <- data.frame(
  ID = 1:4,
  Surface_Area = c(784.0, 710.5, 563.5, 637.0),
  Height = c(3.5, 3.0, 7.0, 6.0),
  Roof_Area = c(220.5, 210.5, 122.5, 147.0),
  Glazing_Area = c(0.25, 0.10, 0.40, 0.60)
)

# Compute Heating Load using the regression formula
df1$Heating_Load <- -26.030 +
  0.0497 * df1$Surface_Area +
  4.942 * df1$Height -
  0.090 * df1$Roof_Area +
  20.523 * df1$Glazing_Area

# Display the results
print(df1)

# Use knitr::kable for a clean table output
library(knitr)
knitr::kable(df1, caption = "Predicted Heating Load for Residential Buildings")


library(readr)
df2 <- readr::read_csv("./oxygen-consumption.csv", col_names = TRUE)

knitr::kable(df2, caption = 'Dataset for a predicting the amount of oxygen that an astronaut consumes when performing five minutes of intense physical work.', align = "lrrrr")

    # Load necessary libraries
    library(readr)
    library(dplyr)
    library(knitr)
    
    # Define the weights
    w0 <- -59.50
    w1 <- -0.15
    w2 <- 0.60
    
    # Compute Oxycon using correct column names
    df2 <- df2 %>%
      mutate(Oxycon_Predicted = w0 + w1 * Age + w2 * `Heart Rate`) # Use backticks for `Heart Rate`
    
    # Display the updated dataset with predictions
    knitr::kable(df2, caption = "Predictions for Oxygen Consumption Using the Given Regression Model", align = "lrrr")
    

    # Calculate the squared errors
    df2 <- df2 %>%
      mutate(Squared_Error = (Oxycon - Oxycon_Predicted)^2)
    
    # Compute the sum of squared errors
    SSE <- sum(df2$Squared_Error)
    
    # Display the results
    cat("Sum of Squared Errors (SSE):", SSE, "\n")
    
    # Display the table with squared errors
    knitr::kable(df2, caption = "Oxygen Consumption Predictions with Squared Errors", align = "lrrrr")


    # Define the learning rate
    learning_rate <- 0.000002

    # Calculate the residuals (Oxycon_actual - Oxycon_predicted)
    df2 <- df2 %>%
      mutate(Residual = Oxycon - Oxycon_Predicted)
    
    # Compute the partial derivatives
    partial_w0 <- -2 * sum(df2$Residual)
    partial_w1 <- -2 * sum(df2$Residual * df2$Age)
    partial_w2 <- -2 * sum(df2$Residual * df2$`Heart Rate`)
    
    # Define the old weights
    w0_old <- -59.50
    w1_old <- -0.15
    w2_old <- 0.60
    
    # Update the weights
    w0_new <- w0_old - learning_rate * partial_w0
    w1_new <- w1_old - learning_rate * partial_w1
    w2_new <- w2_old - learning_rate * partial_w2
    
    # Display the new weights
    cat("Updated Weights:\n")
    cat("w0:", w0_new, "\n")
    cat("w1:", w1_new, "\n")
    cat("w2:", w2_new, "\n")

    # Use the updated weights from 2c
    df2 <- df2 %>%
      mutate(
        Oxycon_Predicted_New = w0_new + w1_new * Age + w2_new * `Heart Rate`,
        Squared_Error_New = (Oxycon - Oxycon_Predicted_New)^2
      )
    
    # Compute the new SSE
    SSE_new <- sum(df2$Squared_Error_New)
    
    # Display the new SSE
    cat("New Sum of Squared Errors (SSE):", SSE_new, "\n")
    
    # Display the table with new predictions and squared errors
    knitr::kable(df2, caption = "Updated Oxygen Consumption Predictions with New Squared Errors", align = "lrrrrr")


library(readr)
df3 <- readr::read_csv("./dose.csv", col_names = TRUE)

knitr::kable(df3, caption = 'Prediction queries.', align = "lrrrr")


# Define the weights from the logistic regression model
weights <- c(-0.848, 1.545, -1.942, 1.973, 2.495, 0.104, 0.095, 3.009)

# Calculate basis functions and probabilities
df3 <- df3 %>%
  mutate(
    phi_0 = 1,                          
    phi_1 = DOSE1,
    phi_2 = DOSE2,
    phi_3 = DOSE1^2,
    phi_4 = DOSE2^2,
    phi_5 = DOSE1^3,
    phi_6 = DOSE2^3,
    phi_7 = DOSE1 * DOSE2,
    z = weights[1] * phi_0 +          
        weights[2] * phi_1 +
        weights[3] * phi_2 +
        weights[4] * phi_3 +
        weights[5] * phi_4 +
        weights[6] * phi_5 +
        weights[7] * phi_6 +
        weights[8] * phi_7,
    Probability = 1 / (1 + exp(-z))     # Logistic function
  )

# Display the results
knitr::kable(df3[, c("ID", "DOSE1", "DOSE2", "Probability")], 
             caption = 'Predicted probabilities for dangerous drug interactions.', align = "lrrr")




