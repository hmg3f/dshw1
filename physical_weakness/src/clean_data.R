### --- Data Cleaning ---
## reads the raw csv file from the data_raw directory
raw_grip_strength <- read.csv("../data_raw/raw_grip_strength.csv")

clean_grip_strength <- raw_grip_strength

## writes the cleaned dataset to the data_clean directory
write.csv(clean_grip_strength, "../data_clean/clean_grip_strength.csv")
