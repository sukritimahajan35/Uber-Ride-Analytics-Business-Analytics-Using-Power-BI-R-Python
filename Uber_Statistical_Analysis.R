# Install packages 
install.packages(c("readxl","dplyr","ggplot2","corrplot","lubridate","tidyr","car","caret"))

# Load libraries
library(readxl)   # To read Excel files
library(dplyr)    # For data manipulation
library(ggplot2)  # For visualization
library(corrplot) # For correlation plots
library(tidyr)    # For handling missing values
library(car)      # For VIF

# Print message
cat("\nLoading Data\n")

# File path
file_path <- "Uber.xlsx"

# Stop if file not found
if (!file.exists(file_path)) {
  stop("File not found")
}

# Read all 3 sheets
location_table <- read_excel(file_path, sheet = "Location Table")   # Sheet 1
trip_details <- read_excel(file_path, sheet = "Trip Details")       # Sheet 2
uber_rides_data <- read_excel(file_path, sheet = "Uber Rides Data") # Sheet 3

# Show first few rows 
cat("\nLocation Table Preview:\n")
print(head(location_table))

cat("\nTrip Details Preview:\n")
print(head(trip_details))

cat("\nUber Rides Data Preview:\n")
print(head(uber_rides_data))

# CLEANING 

# Fix column names
names(trip_details) <- make.names(names(trip_details))
names(uber_rides_data) <- make.names(names(uber_rides_data))

# Clean PURPOSE column (remove spaces & fix case)
uber_rides_data$PURPOSE <- trimws(uber_rides_data$PURPOSE)   # remove extra spaces
uber_rides_data$PURPOSE <- tolower(uber_rides_data$PURPOSE)  # convert to lowercase

# Clean Vehicle column
trip_details$Vehicle <- trimws(trip_details$Vehicle)
trip_details$Vehicle <- tolower(trip_details$Vehicle)

# Replace missing values with median
trip_details <- trip_details %>%
  mutate(across(where(is.numeric),
                ~replace_na(., median(., na.rm = TRUE))))

uber_rides_data <- uber_rides_data %>%
  mutate(across(where(is.numeric),
                ~replace_na(., median(., na.rm = TRUE))))

# Remove duplicates
trip_details <- distinct(trip_details)
uber_rides_data <- distinct(uber_rides_data)
location_table <- distinct(location_table)

# Remove invalid values
trip_details <- trip_details %>%
  filter(trip_distance > 0, fare_amount > 0)

uber_rides_data <- uber_rides_data %>%
  filter(MILES > 0, duration > 0)

# Create new features
trip_details$fare_per_mile <- trip_details$fare_amount / trip_details$trip_distance
uber_rides_data$speed <- uber_rides_data$MILES / uber_rides_data$duration

# ---------------- DESCRIPTIVE STATS ----------------

cat("\nDescriptive Statistics:\n")

cat("\nTrip Details Summary:\n")
print(summary(trip_details))

cat("\nUber Rides Data Summary:\n")
print(summary(uber_rides_data))

# ---------------- CORRELATION ----------------

cat("\nCorrelation Analysis:\n")

trip_cor <- cor(select_if(trip_details, is.numeric), use="complete.obs")
rides_cor <- cor(select_if(uber_rides_data, is.numeric), use="complete.obs")

cat("\nDistance vs Fare:",
    round(trip_cor["trip_distance","fare_amount"],3))

cat("\nMiles vs Duration:",
    round(rides_cor["MILES","duration"],3))

# ---------------- VISUALIZATIONS ----------------

# GRAPH 1: Trip Distance vs Fare
plot(trip_details$trip_distance, trip_details$fare_amount,
     main = "Graph 1: Distance vs Fare",
     xlab = "Trip Distance",
     ylab = "Fare Amount",
     col = "blue", pch = 16)

abline(lm(fare_amount ~ trip_distance, data=trip_details), col="red")

# GRAPH 2: Miles vs Duration
plot(uber_rides_data$MILES, uber_rides_data$duration,
     main = "Graph 2: Miles vs Duration",
     xlab = "Miles",
     ylab = "Duration",
     col = "green", pch = 16)

abline(lm(duration ~ MILES, data=uber_rides_data), col="red")

# GRAPH 3: Vehicle Distribution (ALL labels visible)
vehicle_counts <- sort(table(trip_details$Vehicle), decreasing = TRUE)

barplot(vehicle_counts,
        main = "Graph 3: Vehicle Distribution",
        col = "lightblue",
        las = 2,          # rotate labels
        cex.names = 0.7)  # shrink text

# GRAPH 4: Payment Type Distribution
payment_counts <- table(trip_details$Payment_type)

barplot(payment_counts,
        main = "Graph 4: Payment Type",
        col = "pink",
        las = 2)

# GRAPH 5: Ride Purpose (ALL categories shown clearly)
purpose_counts <- sort(table(uber_rides_data$PURPOSE), decreasing = TRUE)

barplot(purpose_counts,
        main = "Graph 5: Ride Purpose",
        col = "orange",
        las = 2,          # rotate labels
        cex.names = 0.6)  # shrink text so all fit

# GRAPH 6: Miles Distribution
hist(uber_rides_data$MILES,
     main = "Graph 6: Miles Distribution",
     col = "cyan",
     xlab = "Miles")

# GRAPH 7: Fare Distribution
hist(trip_details$fare_amount,
     main = "Graph 7: Fare Distribution",
     col = "yellow",
     xlab = "Fare")

# ---------------- REGRESSION MODELS ----------------

cat("\nRegression Models:\n")

model1 <- lm(fare_amount ~ trip_distance, data=trip_details)
model2 <- lm(fare_amount ~ trip_distance + passenger_count, data=trip_details)
model3 <- lm(fare_amount ~ trip_distance + fare_per_mile, data=trip_details)
model4 <- lm(fare_amount ~ trip_distance + passenger_count + fare_per_mile, data=trip_details)
model5 <- lm(duration ~ MILES, data=uber_rides_data)

# Print summaries
print(summary(model1))
print(summary(model2))
print(summary(model3))
print(summary(model4))
print(summary(model5))

# ---------------- MODEL COMPARISON ----------------

cat("\nModel Comparison:\n")

cat("\nModel 1 R2:", summary(model1)$r.squared)
cat("\nModel 2 R2:", summary(model2)$r.squared)
cat("\nModel 3 R2:", summary(model3)$r.squared)
cat("\nModel 4 R2:", summary(model4)$r.squared)
cat("\nModel 5 R2:", summary(model5)$r.squared)

# ---------------- VIF CHECK ----------------

cat("\nVIF Values:\n")
print(vif(model4))

# ---------------- FINAL INSIGHTS ----------------

cat("\nFinal Insights:\n")

cat("\nMost Used Vehicle:",
    names(sort(table(trip_details$Vehicle), decreasing = TRUE))[1])

cat("\nMost Common Purpose:",
    names(sort(table(uber_rides_data$PURPOSE), decreasing = TRUE))[1])