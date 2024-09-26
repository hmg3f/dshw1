library(tidyverse)
library(patchwork)

clean_grip_strength <- read.csv("../data_clean/clean_grip_strength.csv")

## Q-Q plots to test for normality of features. the following tests will rely
## on features which are approximately normally distributed, so we must select
## features which appear to match the line displayed in the Q-Q plots.
qq_age <- qplot(sample = Age, data = clean_grip_strength)+
    stat_qq()+
    stat_qq_line()+
    labs(y="Age", x="Theoretical", title="Q-Q Plot for Age")
qq_height <- qplot(sample = Height, data = clean_grip_strength)+
    stat_qq()+
    stat_qq_line()+
    labs(y="Height", x="Theoretical", title="Q-Q Plot for Height")
qq_grip_strength <- qplot(sample = Grip_Strength, data = clean_grip_strength)+
    stat_qq()+
    stat_qq_line()+
    labs(y="Grip Strength", x="Theoretical", title="Q-Q Plot for Grip Strength")
qq_weight <- qplot(sample = Weight, data = clean_grip_strength)+
    stat_qq()+
    stat_qq_line()+
    labs(y="Weight", x="Theoretical", title="Q-Q Plot for Weight")

## combine all Q-Q plots into one file and export to qq-plots.png in results
qq_plots <- qq_age + qq_height + qq_grip_strength + qq_weight
ggsave("../results/qq-plots.png", plot=qq_plots)

## based on the results of the Q-Q plots, it appears that Height and Weight are
## the only normally-distributed features. thus, a t-test would be appropriate
## only for those two approximately normal features.

## t-test for Frailty. 
t_test_Weight_Frailty <- with(clean_grip_strength, t.test(Weight ~ Frailty))
t_test_Height_Frailty <- with(clean_grip_strength, t.test(Height ~ Frailty))
t_test_Grip_Strength_Frailty <- with(clean_grip_strength, t.test(Grip_Strength ~ Frailty))
t_test_Age_Frailty <- with(clean_grip_strength, t.test(Age ~ Frailty))

## write the t-test results to the results directory
capture.output(t_test_Weight_Frailty,
               t_test_Height_Frailty,
               t_test_Grip_Strength_Frailty,
               t_test_Age_Frailty,
               file = "../results/test_results.txt")

## this script runs the t-test for each feature, despite the results of the Q-Q
## plots. hence, even if the age and grip_strength features have a t-value which
## rejects the null hypothesis, this would not necessarily indicate a true
## difference between the means of the given groups. however, based on the
## output of the t_tests, we can conclude that none of the features have a low
## enough p-value (0.05) to reject the null hypothesis regardless.
