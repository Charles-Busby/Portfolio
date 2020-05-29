#****************************
#Install the packages
#****************************

library(arules)
library(rpart)
library(rpart.plot)
library(caret)
library(neuralnet)
library(nnet)

#****************************
#Set the working directory
#****************************

setwd("C:/Users/buzzt/Desktop/CSU GLObal/MIS510 DAta mining and viz/Final")
# set working directory

#****************************
#reads intital data
#****************************

GC.df <- read.csv("GermanCredit.csv", header = TRUE)

#****************************
#gives data summarry
#****************************
  
head(GC.df)
data.frame(mean=round(sapply(GC.df, mean, na.rm=TRUE),2),
           #gave the average for the data 
           sd=round(sapply(GC.df, sd, na.rm = TRUE),2), 
           #gave the standard deviation for the table
           min=round(sapply(GC.df, min, na.rm = TRUE),2), 
           #gave the minimum for the table
           max=round(sapply(GC.df, max, na.rm = TRUE),2), 
           #gave the max for the table
           median=round(sapply(GC.df, median, na.rm = TRUE),2), 
           #gavet he median for the table
           length=sapply(GC.df, length), 
           #gives the number of entries
           miss.val=sapply(GC.df, function(x) sum(length(which(is.na(x))))))
#****************************
#converts to useable forms
#****************************

GC.df <- GC.df[,-c(1)]

#****************************
#sets new data tables
#****************************
set.seed(1) #sets seed fr testing
train.index <- sample(c(1:dim(GC.df)[1]), dim(GC.df)[1]*0.6) # sets the training data for 60%
train.df <- GC.df[train.index, ] # creates the data frame for the test data
valid.df <- GC.df[-train.index, ] # Creates the data frame for the validation data

#****************************
#Train classification tree Model
#****************************

Class.tree.train <- rpart(EDUCATION ~., data = train.df, method = "class")
Class.tree.Valid <- rpart(EDUCATION ~., data = valid.df, method = "class")

#****************************
#view classification tree Model
#****************************

prp(Class.tree.train, type = 1, extra = 1, under = TRUE, split.font = 1, varlen = -10)
#displays th training class tree
prp(Class.tree.Valid, type = 1, extra = 1, under = TRUE, split.font = 1, varlen = -10)
#Display the valid class tree

#****************************
#Test Model
#****************************

Class.tree.train.Pred <- predict(Class.tree.train, train.df, type = "class")
#creates the prediction class model
confusionMatrix(Class.tree.train.Pred, as.factor(train.df$EDUCATION))
#Creates the confusion matrix for the trining data
Class.tree.Valid.Pred <- predict(Class.tree.Valid, valid.df, type = "class")
#creates the prediction model for the validation data
confusionMatrix(Class.tree.Valid.Pred, as.factor(valid.df$EDUCATION))

#****************************
#Normilize data
#****************************

NN.df <- GC.df
NN.df$CHK_ACCT <- (NN.df$CHK_ACCT - min(NN.df$CHK_ACCT))/(max(NN.df$CHK_ACCT) - min(NN.df$CHK_ACCT))
NN.df$DURATION <- (NN.df$DURATION -min(NN.df$DURATION))/(max(NN.df$DURATION) - min(NN.df$DURATION))
NN.df$HISTORY <- (NN.df$HISTORY - min(NN.df$HISTORY))/(max(NN.df$HISTORY) - min(NN.df$HISTORY))
NN.df$AMOUNT <- (NN.df$AMOUNT - min(NN.df$AMOUNT))/(max(NN.df$AMOUNT) - min(NN.df$AMOUNT))
NN.df$EMPLOYMENT <- (NN.df$EMPLOYMENT - min(NN.df$EMPLOYMENT))/(max(NN.df$EMPLOYMENT) - min(NN.df$EMPLOYMENT))
NN.df$INSTALL_RATE <- (NN.df$INSTALL_RATE - min(NN.df$INSTALL_RATE))/(max(NN.df$INSTALL_RATE) - min(NN.df$INSTALL_RATE))
NN.df$PRESENT_RESIDENT <- (NN.df$PRESENT_RESIDENT - min(NN.df$PRESENT_RESIDENT))/(max(NN.df$PRESENT_RESIDENT) - min(NN.df$PRESENT_RESIDENT))
NN.df$AGE <- (NN.df$AGE - min(NN.df$AGE))/(max(NN.df$AGE) - min(NN.df$AGE))
NN.df$NUM_CREDITS <- (NN.df$NUM_CREDITS - min(NN.df$NUM_CREDITS))/(max(NN.df$NUM_CREDITS) - min(NN.df$NUM_CREDITS))
NN.df$JOB <- (NN.df$JOB - min(NN.df$JOB))/(max(NN.df$JOB) - min(NN.df$JOB))
NN.df$NUM_DEPENDENTS <- (NN.df$NUM_DEPENDENTS - min(NN.df$NUM_DEPENDENTS))/(max(NN.df$NUM_DEPENDENTS) - min(NN.df$NUM_DEPENDENTS))

#****************************
#sets new data tables
#****************************

set.seed(2) #sets seed fr testing 
NN.Index <- sample(c(1:dim(NN.df)[1]), dim(NN.df)[1]*0.6)
Training = NN.df[NN.Index, ]
Validation = NN.df[-NN.Index, ]

#****************************
#Creat neural network
#****************************

nn <- neuralnet(EDUCATION ~ JOB + AGE  + OWN_RES + AMOUNT + DURATION + EMPLOYMENT + PRESENT_RESIDENT + CHK_ACCT + DURATION + HISTORY + INSTALL_RATE,
                data = Training, 
                linear.output = F, 
                hidden = 2)

#****************************
#Plot Nerual Network
#****************************

plot(nn, rep = "best")

#****************************
#Nerual Network Test
#****************************

Training.Prediction = compute(nn, Training)
Training.class = apply(Training.Prediction$net.result, 1, which.max)-1
confusionMatrix(as.factor(Training.class), as.factor(Training$EDUCATION))

Validation.Prediction = compute(nn, Validation)
Validation.class = apply(Validation.Prediction$net.result, 1, which.max)-1
confusionMatrix(as.factor(Validation.class), as.factor(Validation$EDUCATION))