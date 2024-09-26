library(tidyverse)
library(patchwork)

### --- Data Analysis ---
## read the cleaned dataset
clean_students_performance <- read.csv("../data_clean/clean_students_performance.csv")

### --- VISUALIZATIONS ---
## plot 1 demonstrates the difference in average scores per discipline based on
## whether or not the preparation course was completed. we can see from the
## results that, on average, students who completed the preparation course did
## better in each subject compared to students who did not finish the course.
plot1 <- ggplot(clean_students_performance,
                aes(test.preparation.course, math.score)) +
    geom_bar(position="dodge", stat="summary", fun="mean") +
    labs(x="Test Preparation Course", y="Math Score") +
    ggplot(clean_students_performance,
           aes(test.preparation.course, reading.score)) +
    geom_bar(position="dodge", stat="summary", fun="mean") +
    labs(x="Test Preparation Course", y="Reading Score") +
    ggplot(clean_students_performance,
           aes(test.preparation.course, writing.score)) +
    geom_bar(position="dodge", stat="summary", fun="mean") +
    labs(x="Test Preparation Course", y="Writing Score") 

ggsave("../results/plot1.png", plot=plot1, width=10)


## plot 2 demonstrates the amount of students who completed the test preparation
## course based on their parental level of education. the graph suggests that
## all students, regardless of parental level of education, are more likely to
## not complete the preparation course, though students within certain
## categories of parental level of education, such as students with parents who
## completed high school only, are slightly more likely to complete the
## preparation course.
plot2 <- ggplot(clean_students_performance, aes(parental.level.of.education)) +
    geom_bar(aes(fill = test.preparation.course)) +
    labs(x="Parental Level of Education")

ggsave("../results/plot2.png", plot=plot2, width=10)


## plot 3 demonstrates the major distribution characteristics of the mean score
## of the students based on parental level of education, along with test
## preparation completion. the results of this visualization show that on
## average, students with college-educated parents may have a slightly higher
## mean scores than other students. additionally, we can again see the
## significant increase in test scores among students who have taken the test
## preparation course vs. those who did not, with generally higher means, but
## overall similar distributions around the mean.
plot3 <- ggplot(clean_students_performance,
                aes(x=parental.level.of.education,
                    y=mean.score,
                    fill=test.preparation.course)) +
    geom_boxplot() +
    labs(x="Parental Level of Education", y="Mean Score", fill="Test Preparation Course")

ggsave("../results/plot3.png", plot=plot3, width=10)


## plot 4 demonstrates the difference writing scores based on math score and
## reading score. The graph shows a much tighter variance from reading score
## compared to math scores, meaning that reading score may be a better predictor
## of writing score.
plot4 <- ggplot(clean_students_performance, aes(x=math.score, y=writing.score)) +
    geom_point() +
    labs(x="Math Score", y="Writing Score") +
    ggplot(clean_students_performance, aes(x=reading.score, y=writing.score)) +
    geom_point() +
    labs(x="Reading Score", y="Writing Score")

ggsave("../results/plot4.png", plot=plot4, width=10)


## plot 5 demonstrates the difference in the amount of students who completed
## the test preparation course vs. the amount who did not. The graph shows that
## a fairly large majority of students did not complete the test preparation
## course.
plot5 <- clean_students_performance %>%
    count(test.preparation.course) %>%
    ggplot(aes(x="", y=n, fill=test.preparation.course)) +
    geom_bar(stat="identity", width=1, color="white") +
    coord_polar("y", start=0) +
    labs(fill="Test Preparation Course")

ggsave("../results/plot5.png", plot=plot5, width=10)
