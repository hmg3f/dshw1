### --- Data Cleaning ---
## Read the raw csv file from the data_raw directory
raw_students_performance <- read.csv("../data_raw/raw_students_performance.csv")

## make a copy of the raw data
clean_students_performance <- raw_students_performance

## add a column to the clean dataset containing the average scores accross all disciplines
clean_students_performance %>%
    mutate(mean.score = rowMeans(select(., c("math.score", "reading.score", "writing.score"))))

## total number of N/A values in the dataset. ensure this value is 0
sum(is.na(clean_students_performance))

## check for incorrect categorical values in the datasets
check_uniques <- function(df, x) {
    for (i in x) {
        print(i)
        print(unique(df[[i]]))
        print("---------------")
    }
}

cat_cols <- c("gender", "race.ethnicity", "parental.level.of.education", "lunch", "test.preparation.course")

check_uniques(clean_students_performance, cat_cols)

## write out the cleaned dataset to the data_clean directory
write.csv(clean_students_performance, "../data_clean/clean_students_performance.csv")
