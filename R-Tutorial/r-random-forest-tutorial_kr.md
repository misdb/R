# 랜덤 포리스트 분석 (예제 포함)



## 랜덤 포리스트

Random forests are based on a simple idea: 'the wisdom of the crowd'. Aggregate of the results of multiple predictors gives a better prediction than the best individual predictor. A group of predictors is called an **ensemble**. Thus, this technique is called **Ensemble Learning**.

In earlier tutorial, you learned how to use **Decision trees** to make a binary prediction. To improve our technique, we can train a group of **Decision Tree classifiers**, each on a different random subset of the train set. To make a prediction, we just obtain the predictions of all individuals trees, then predict the class that gets the most votes. This technique is called **Random Forest**.

We will proceed as follow to train the Random Forest:

- [Step 1) Import the data](https://www.guru99.com/r-random-forest-tutorial.html#1)
- [Step 2) Train the model](https://www.guru99.com/r-random-forest-tutorial.html#2)
- [Step 3) Construct accuracy function](https://www.guru99.com/r-random-forest-tutorial.html#3)
- [Step 4) Visualize the model](https://www.guru99.com/r-random-forest-tutorial.html#4)
- [Step 5) Evaluate the model](https://www.guru99.com/r-random-forest-tutorial.html#5)
- [Step 6) Visualize Result](https://www.guru99.com/r-random-forest-tutorial.html#6)

## **Step 1)** Import the data

To make sure you have the same dataset as in the tutorial for decision trees, the train test and test set are stored on the internet. You can import them without make any change.

```
library(dplyr)
data_train <- read.csv("https://raw.githubusercontent.com/guru99-edu/R-Programming/master/train.csv")
glimpse(data_train)
data_test <- read.csv("https://raw.githubusercontent.com/guru99-edu/R-Programming/master/test.csv") 
glimpse(data_test)
```

## **Step 2)** Train the model

One way to evaluate the performance of a model is to train it on a number of different smaller datasets and evaluate them over the other smaller testing set. This is called the **F-fold cross-validation** feature. R has a function to randomly split number of datasets of almost the same size. For example, if k=9, the model is evaluated over the nine folder and tested on the remaining test set. This process is repeated until all the subsets have been evaluated. This technique is widely used for model selection, especially when the model has parameters to tune.

Now that we have a way to evaluate our model, we need to figure out how to choose the parameters that generalized best the data.

Random forest chooses a random subset of features and builds many Decision Trees. The model averages out all the predictions of the Decisions trees.

Random forest has some parameters that can be changed to improve the generalization of the prediction. You will use the function RandomForest() to train the model.

Syntax for Randon Forest is

```
RandomForest(formula, ntree=n, mtry=FALSE, maxnodes = NULL)
Arguments:
- Formula: Formula of the fitted model
- ntree: number of trees in the forest
- mtry: Number of candidates draw to feed the algorithm. By default, it is the square of the number of columns.
- maxnodes: Set the maximum amount of terminal nodes in the forest
- importance=TRUE: Whether independent variables importance in the random forest be assessed
```

**Note**: Random forest can be trained on more parameters. You can refer to the [vignette](https://cran.r-project.org/web/packages/randomForest/randomForest.pdf) to see the different parameters.

Tuning a model is very tedious work. There are lot of combination possible between the parameters. You don't necessarily have the time to try all of them. A good alternative is to let the machine find the best combination for you. There are two methods available:

- Random Search
- Grid Search

We will define both methods but during the tutorial, we will train the model using grid search

### Grid Search definition

The grid search method is simple, the model will be evaluated over all the combination you pass in the function, using cross-validation.

For instance, you want to try the model with 10, 20, 30 number of trees and each tree will be tested over a number of mtry equals to 1, 2, 3, 4, 5. Then the machine will test 15 different models:

```
    .mtry ntrees
 1      1     10
 2      2     10
 3      3     10
 4      4     10
 5      5     10
 6      1     20
 7      2     20
 8      3     20
 9      4     20
 10     5     20
 11     1     30
 12     2     30
 13     3     30
 14     4     30
 15     5     30	
```

The algorithm will evaluate:

```
RandomForest(formula, ntree=10, mtry=1)
RandomForest(formula, ntree=10, mtry=2)
RandomForest(formula, ntree=10, mtry=3)
RandomForest(formula, ntree=20, mtry=2)
...
```

Each time, the random forest experiments with a cross-validation. One shortcoming of the grid search is the number of experimentations. It can become very easily explosive when the number of combination is high. To overcome this issue, you can use the random search

### Random Search definition

The big difference between random search and grid search is, random search will not evaluate all the combination of hyperparameter in the searching space. Instead, it will randomly choose combination at every iteration. The advantage is it lower the computational cost.

### Set the control parameter

You will proceed as follow to construct and evaluate the model:

- Evaluate the model with the default setting
- Find the best number of mtry
- Find the best number of maxnodes
- Find the best number of ntrees
- Evaluate the model on the test dataset

Before you begin with the parameters exploration, you need to install two libraries.

- caret: R machine learning library. If you have install R with r-essential. It is already in the library
  - [Anaconda](https://anaconda.org/r/r-caret): conda install -c r r-caret
- e1071: R machine learning library.
  - [Anaconda](https://anaconda.org/r/r-caret): conda install -c r r-e1071

You can import them along with RandomForest



```
library(randomForest)
library(caret)
library(e1071)
```

### Default setting

K-fold cross validation is controlled by the trainControl() function

```
trainControl(method = "cv", number = n, search ="grid")
arguments
- method = "cv": The method used to resample the dataset. 
- number = n: Number of folders to create
- search = "grid": Use the search grid method. For randomized method, use "grid"
Note: You can refer to the vignette to see the other arguments of the function.
```

You can try to run the model with the default parameters and see the accuracy score.

**Note**: You will use the same controls during all the tutorial.

```
# Define the control
trControl <- trainControl(method = "cv",
    number = 10,
    search = "grid")
```

You will use caret library to evaluate your model. The library has one function called train() to evaluate almost all machine learning algorithm. Say differently, you can use this function to train other algorithms.

The basic syntax is:

```
train(formula, df, method = "rf", metric= "Accuracy", trControl = trainControl(), tuneGrid = NULL)
argument
- `formula`: Define the formula of the algorithm
- `method`: Define which model to train. Note, at the end of the tutorial, there is a list of all the models that can be trained
- `metric` = "Accuracy": Define how to select the optimal model
- `trControl = trainControl()`: Define the control parameters
- `tuneGrid = NULL`: Return a data frame with all the possible combination
```

Let's try the build the model with the default values.

```
set.seed(1234)
# Run the model
rf_default <- train(survived~.,
    data = data_train,
    method = "rf",
    metric = "Accuracy",
    trControl = trControl)
# Print the results
print(rf_default)
```

Code Explanation

- trainControl(method="cv", number=10, search="grid"): Evaluate the model with a grid search of 10 folder
- train(...): Train a random forest model. Best model is chosen with the accuracy measure.

**Output:**

```
## Random Forest 
## 
## 836 samples
##   7 predictor
##   2 classes: 'No', 'Yes' 
## 
## No pre-processing
## Resampling: Cross-Validated (10 fold) 
## Summary of sample sizes: 753, 752, 753, 752, 752, 752, ... 
## Resampling results across tuning parameters:
## 
##   mtry  Accuracy   Kappa    
##    2    0.7919248  0.5536486
##    6    0.7811245  0.5391611
##   10    0.7572002  0.4939620
## 
## Accuracy was used to select the optimal model using  the largest value.
## The final value used for the model was mtry = 2.
```

The algorithm uses 500 trees and tested three different values of mtry: 2, 6, 10.

The final value used for the model was mtry = 2 with an accuracy of 0.78. Let's try to get a higher score.

**Step 2)** Search best mtry

You can test the model with values of mtry from 1 to 10

```
set.seed(1234)
tuneGrid <- expand.grid(.mtry = c(1: 10))
rf_mtry <- train(survived~.,
    data = data_train,
    method = "rf",
    metric = "Accuracy",
    tuneGrid = tuneGrid,
    trControl = trControl,
    importance = TRUE,
    nodesize = 14,
    ntree = 300)
print(rf_mtry)
```

Code Explanation

- tuneGrid <- expand.grid(.mtry=c(3:10)): Construct a vector with value from 3:10

The final value used for the model was mtry = 4.

**Output:**

```
## Random Forest 
## 
## 836 samples
##   7 predictor
##   2 classes: 'No', 'Yes' 
## 
## No pre-processing
## Resampling: Cross-Validated (10 fold) 
## Summary of sample sizes: 753, 752, 753, 752, 752, 752, ... 
## Resampling results across tuning parameters:
## 
##   mtry  Accuracy   Kappa    
##    1    0.7572576  0.4647368
##    2    0.7979346  0.5662364
##    3    0.8075158  0.5884815
##    4    0.8110729  0.5970664
##    5    0.8074727  0.5900030
##    6    0.8099111  0.5949342
##    7    0.8050918  0.5866415
##    8    0.8050918  0.5855399
##    9    0.8050631  0.5855035
##   10    0.7978916  0.5707336
## 
## Accuracy was used to select the optimal model using  the largest value.
## The final value used for the model was mtry = 4.
```

The best value of mtry is stored in:

```
rf_mtry$bestTune$mtry
```

You can store it and use it when you need to tune the other parameters.

```
max(rf_mtry$results$Accuracy)
```

**Output:**

```
## [1] 0.8110729
best_mtry <- rf_mtry$bestTune$mtry 
best_mtry
```

**Output:**

```
## [1] 4
```

## **Step 3)** Search the best maxnodes

You need to create a loop to evaluate the different values of maxnodes. In the following code, you will:

- Create a list
- Create a variable with the best value of the parameter mtry; Compulsory
- Create the loop
- Store the current value of maxnode
- Summarize the results

```
store_maxnode <- list()
tuneGrid <- expand.grid(.mtry = best_mtry)
for (maxnodes in c(5: 15)) {
    set.seed(1234)
    rf_maxnode <- train(survived~.,
        data = data_train,
        method = "rf",
        metric = "Accuracy",
        tuneGrid = tuneGrid,
        trControl = trControl,
        importance = TRUE,
        nodesize = 14,
        maxnodes = maxnodes,
        ntree = 300)
    current_iteration <- toString(maxnodes)
    store_maxnode[[current_iteration]] <- rf_maxnode
}
results_mtry <- resamples(store_maxnode)
summary(results_mtry)
```

Code explanation:

- store_maxnode <- list(): The results of the model will be stored in this list
- expand.grid(.mtry=best_mtry): Use the best value of mtry
- for (maxnodes in c(15:25)) { ... }: Compute the model with values of maxnodes starting from 15 to 25.
- maxnodes=maxnodes: For each iteration, maxnodes is equal to the current value of maxnodes. i.e 15, 16, 17, ...
- key <- toString(maxnodes): Store as a string variable the value of maxnode.
- store_maxnode[[key]] <- rf_maxnode: Save the result of the model in the list.
- resamples(store_maxnode): Arrange the results of the model
- summary(results_mtry): Print the summary of all the combination.

**Output:**

```
## 
## Call:
## summary.resamples(object = results_mtry)
## 
## Models: 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 
## Number of resamples: 10 
## 
## Accuracy 
##         Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NA's
## 5  0.6785714 0.7529762 0.7903758 0.7799771 0.8168388 0.8433735    0
## 6  0.6904762 0.7648810 0.7784710 0.7811962 0.8125000 0.8313253    0
## 7  0.6904762 0.7619048 0.7738095 0.7788009 0.8102410 0.8333333    0
## 8  0.6904762 0.7627295 0.7844234 0.7847820 0.8184524 0.8433735    0
## 9  0.7261905 0.7747418 0.8083764 0.7955250 0.8258749 0.8333333    0
## 10 0.6904762 0.7837780 0.7904475 0.7895869 0.8214286 0.8433735    0
## 11 0.7023810 0.7791523 0.8024240 0.7943775 0.8184524 0.8433735    0
## 12 0.7380952 0.7910929 0.8144005 0.8051205 0.8288511 0.8452381    0
## 13 0.7142857 0.8005952 0.8192771 0.8075158 0.8403614 0.8452381    0
## 14 0.7380952 0.7941050 0.8203528 0.8098967 0.8403614 0.8452381    0
## 15 0.7142857 0.8000215 0.8203528 0.8075301 0.8378873 0.8554217    0
## 
## Kappa 
##         Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NA's
## 5  0.3297872 0.4640436 0.5459706 0.5270773 0.6068751 0.6717371    0
## 6  0.3576471 0.4981484 0.5248805 0.5366310 0.6031287 0.6480921    0
## 7  0.3576471 0.4927448 0.5192771 0.5297159 0.5996437 0.6508314    0
## 8  0.3576471 0.4848320 0.5408159 0.5427127 0.6200253 0.6717371    0
## 9  0.4236277 0.5074421 0.5859472 0.5601687 0.6228626 0.6480921    0
## 10 0.3576471 0.5255698 0.5527057 0.5497490 0.6204819 0.6717371    0
## 11 0.3794326 0.5235007 0.5783191 0.5600467 0.6126720 0.6717371    0
## 12 0.4460432 0.5480930 0.5999072 0.5808134 0.6296780 0.6717371    0
## 13 0.4014252 0.5725752 0.6087279 0.5875305 0.6576219 0.6678832    0
## 14 0.4460432 0.5585005 0.6117973 0.5911995 0.6590982 0.6717371    0
## 15 0.4014252 0.5689401 0.6117973 0.5867010 0.6507194 0.6955990    0
```

The last value of maxnode has the highest accuracy. You can try with higher values to see if you can get a higher score.

```
store_maxnode <- list()
tuneGrid <- expand.grid(.mtry = best_mtry)
for (maxnodes in c(20: 30)) {
    set.seed(1234)
    rf_maxnode <- train(survived~.,
        data = data_train,
        method = "rf",
        metric = "Accuracy",
        tuneGrid = tuneGrid,
        trControl = trControl,
        importance = TRUE,
        nodesize = 14,
        maxnodes = maxnodes,
        ntree = 300)
    key <- toString(maxnodes)
    store_maxnode[[key]] <- rf_maxnode
}
results_node <- resamples(store_maxnode)
summary(results_node)
```

**Output:**

```
## 
## Call:
## summary.resamples(object = results_node)
## 
## Models: 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 
## Number of resamples: 10 
## 
## Accuracy 
##         Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NA's
## 20 0.7142857 0.7821644 0.8144005 0.8075301 0.8447719 0.8571429    0
## 21 0.7142857 0.8000215 0.8144005 0.8075014 0.8403614 0.8571429    0
## 22 0.7023810 0.7941050 0.8263769 0.8099254 0.8328313 0.8690476    0
## 23 0.7023810 0.7941050 0.8263769 0.8111302 0.8447719 0.8571429    0
## 24 0.7142857 0.7946429 0.8313253 0.8135112 0.8417599 0.8690476    0
## 25 0.7142857 0.7916667 0.8313253 0.8099398 0.8408635 0.8690476    0
## 26 0.7142857 0.7941050 0.8203528 0.8123207 0.8528758 0.8571429    0
## 27 0.7023810 0.8060456 0.8313253 0.8135112 0.8333333 0.8690476    0
## 28 0.7261905 0.7941050 0.8203528 0.8111015 0.8328313 0.8690476    0
## 29 0.7142857 0.7910929 0.8313253 0.8087063 0.8333333 0.8571429    0
## 30 0.6785714 0.7910929 0.8263769 0.8063253 0.8403614 0.8690476    0
## 
## Kappa 
##         Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NA's
## 20 0.3956835 0.5316120 0.5961830 0.5854366 0.6661120 0.6955990    0
## 21 0.3956835 0.5699332 0.5960343 0.5853247 0.6590982 0.6919315    0
## 22 0.3735084 0.5560661 0.6221836 0.5914492 0.6422128 0.7189781    0
## 23 0.3735084 0.5594228 0.6228827 0.5939786 0.6657372 0.6955990    0
## 24 0.3956835 0.5600352 0.6337821 0.5992188 0.6604703 0.7189781    0
## 25 0.3956835 0.5530760 0.6354875 0.5912239 0.6554912 0.7189781    0
## 26 0.3956835 0.5589331 0.6136074 0.5969142 0.6822128 0.6955990    0
## 27 0.3735084 0.5852459 0.6368425 0.5998148 0.6426088 0.7189781    0
## 28 0.4290780 0.5589331 0.6154905 0.5946859 0.6356141 0.7189781    0
## 29 0.4070588 0.5534173 0.6337821 0.5901173 0.6423101 0.6919315    0
## 30 0.3297872 0.5534173 0.6202632 0.5843432 0.6590982 0.7189781    0
```

The highest accuracy score is obtained with a value of maxnode equals to 22.

## **Step 4)** Search the best ntrees

Now that you have the best value of mtry and maxnode, you can tune the number of trees. The method is exactly the same as maxnode.

```
store_maxtrees <- list()
for (ntree in c(250, 300, 350, 400, 450, 500, 550, 600, 800, 1000, 2000)) {
    set.seed(5678)
    rf_maxtrees <- train(survived~.,
        data = data_train,
        method = "rf",
        metric = "Accuracy",
        tuneGrid = tuneGrid,
        trControl = trControl,
        importance = TRUE,
        nodesize = 14,
        maxnodes = 24,
        ntree = ntree)
    key <- toString(ntree)
    store_maxtrees[[key]] <- rf_maxtrees
}
results_tree <- resamples(store_maxtrees)
summary(results_tree)
```

**Output:**

```
## 
## Call:
## summary.resamples(object = results_tree)
## 
## Models: 250, 300, 350, 400, 450, 500, 550, 600, 800, 1000, 2000 
## Number of resamples: 10 
## 
## Accuracy 
##           Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NA's
## 250  0.7380952 0.7976190 0.8083764 0.8087010 0.8292683 0.8674699    0
## 300  0.7500000 0.7886905 0.8024240 0.8027199 0.8203397 0.8452381    0
## 350  0.7500000 0.7886905 0.8024240 0.8027056 0.8277623 0.8452381    0
## 400  0.7500000 0.7886905 0.8083764 0.8051009 0.8292683 0.8452381    0
## 450  0.7500000 0.7886905 0.8024240 0.8039104 0.8292683 0.8452381    0
## 500  0.7619048 0.7886905 0.8024240 0.8062914 0.8292683 0.8571429    0
## 550  0.7619048 0.7886905 0.8083764 0.8099062 0.8323171 0.8571429    0
## 600  0.7619048 0.7886905 0.8083764 0.8099205 0.8323171 0.8674699    0
## 800  0.7619048 0.7976190 0.8083764 0.8110820 0.8292683 0.8674699    0
## 1000 0.7619048 0.7976190 0.8121510 0.8086723 0.8303571 0.8452381    0
## 2000 0.7619048 0.7886905 0.8121510 0.8086723 0.8333333 0.8452381    0
## 
## Kappa 
##           Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NA's
## 250  0.4061697 0.5667400 0.5836013 0.5856103 0.6335363 0.7196807    0
## 300  0.4302326 0.5449376 0.5780349 0.5723307 0.6130767 0.6710843    0
## 350  0.4302326 0.5449376 0.5780349 0.5723185 0.6291592 0.6710843    0
## 400  0.4302326 0.5482030 0.5836013 0.5774782 0.6335363 0.6710843    0
## 450  0.4302326 0.5449376 0.5780349 0.5750587 0.6335363 0.6710843    0
## 500  0.4601542 0.5449376 0.5780349 0.5804340 0.6335363 0.6949153    0
## 550  0.4601542 0.5482030 0.5857118 0.5884507 0.6396872 0.6949153    0
## 600  0.4601542 0.5482030 0.5857118 0.5884374 0.6396872 0.7196807    0
## 800  0.4601542 0.5667400 0.5836013 0.5910088 0.6335363 0.7196807    0
## 1000 0.4601542 0.5667400 0.5961590 0.5857446 0.6343666 0.6678832    0
## 2000 0.4601542 0.5482030 0.5961590 0.5862151 0.6440678 0.6656337    0
```

You have your final model. You can train the random forest with the following parameters:

- ntree =800: 800 trees will be trained
- mtry=4: 4 features is chosen for each iteration
- maxnodes = 24: Maximum 24 nodes in the terminal nodes (leaves)

```
fit_rf <- train(survived~.,
    data_train,
    method = "rf",
    metric = "Accuracy",
    tuneGrid = tuneGrid,
    trControl = trControl,
    importance = TRUE,
    nodesize = 14,
    ntree = 800,
    maxnodes = 24)
```

## **Step 5)** Evaluate the model

The library caret has a function to make prediction.



```
predict(model, newdata= df)
argument
- `model`: Define the model evaluated before. 
- `newdata`: Define the dataset to make prediction
prediction <-predict(fit_rf, data_test)
```

You can use the prediction to compute the confusion matrix and see the accuracy score

```
confusionMatrix(prediction, data_test$survived)
```

**Output:**

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction  No Yes
##        No  110  32
##        Yes  11  56
##                                          
##                Accuracy : 0.7943         
##                  95% CI : (0.733, 0.8469)
##     No Information Rate : 0.5789         
##     P-Value [Acc > NIR] : 3.959e-11      
##                                          
##                   Kappa : 0.5638         
##  Mcnemar's Test P-Value : 0.002289       
##                                          
##             Sensitivity : 0.9091         
##             Specificity : 0.6364         
##          Pos Pred Value : 0.7746         
##          Neg Pred Value : 0.8358         
##              Prevalence : 0.5789         
##          Detection Rate : 0.5263         
##    Detection Prevalence : 0.6794         
##       Balanced Accuracy : 0.7727         
##                                          
##        'Positive' Class : No             
## 
```

You have an accuracy of 0.7943 percent, which is higher than the default value

## **Step 6)** Visualize Result

Lastly, you can look at the feature importance with the function varImp(). It seems that the most important features are the sex and age. That is not surprising because the important features are likely to appear closer to the root of the tree, while less important features will often appear closed to the leaves.

```
varImpPlot(fit_rf)
```

**Output:**

```
varImp(fit_rf)
## rf variable importance
## 
##              Importance
## sexmale         100.000
## age              28.014
## pclassMiddle     27.016
## fare             21.557
## pclassUpper      16.324
## sibsp            11.246
## parch             5.522
## embarkedC         4.908
## embarkedQ         1.420
## embarkedS         0.000		
```

## Summary

We can summarize how to train and evaluate a random forest with the table below:

| Library      | Objective                        | function          | parameter                                                    |
| :----------- | :------------------------------- | :---------------- | :----------------------------------------------------------- |
| randomForest | Create a Random forest           | RandomForest()    | formula, ntree=n, mtry=FALSE, maxnodes = NULL                |
| caret        | Create K folder cross validation | trainControl()    | method = "cv", number = n, search ="grid"                    |
| caret        | Train a Random Forest            | train()           | formula, df, method = "rf", metric= "Accuracy", trControl = trainControl(), tuneGrid = NULL |
| caret        | Predict out of sample            | predict           | model, newdata= df                                           |
| caret        | Confusion Matrix and Statistics  | confusionMatrix() | model, y test                                                |
| caret        | variable importance              | cvarImp()         | model                                                        |

## Appendix

List of model used in caret

```
names>(getModelInfo())
```

**Output:**

```
##   [1] "ada"                 "AdaBag"              "AdaBoost.M1"        ##   [4] "adaboost"            "amdai"               "ANFIS"              ##   [7] "avNNet"              "awnb"                "awtan"              ##  [10] "bag"                 "bagEarth"            "bagEarthGCV"        ##  [13] "bagFDA"              "bagFDAGCV"           "bam"                ##  [16] "bartMachine"         "bayesglm"            "binda"              ##  [19] "blackboost"          "blasso"              "blassoAveraged"     ##  [22] "bridge"              "brnn"                "BstLm"              ##  [25] "bstSm"               "bstTree"             "C5.0"               ##  [28] "C5.0Cost"            "C5.0Rules"           "C5.0Tree"           ##  [31] "cforest"             "chaid"               "CSimca"             ##  [34] "ctree"               "ctree2"              "cubist"             ##  [37] "dda"                 "deepboost"           "DENFIS"             ##  [40] "dnn"                 "dwdLinear"           "dwdPoly"            ##  [43] "dwdRadial"           "earth"               "elm"                ##  [46] "enet"                "evtree"              "extraTrees"         ##  [49] "fda"                 "FH.GBML"             "FIR.DM"             ##  [52] "foba"                "FRBCS.CHI"           "FRBCS.W"            ##  [55] "FS.HGD"              "gam"                 "gamboost"           ##  [58] "gamLoess"            "gamSpline"           "gaussprLinear"      ##  [61] "gaussprPoly"         "gaussprRadial"       "gbm_h3o"            ##  [64] "gbm"                 "gcvEarth"            "GFS.FR.MOGUL"       ##  [67] "GFS.GCCL"            "GFS.LT.RS"           "GFS.THRIFT"         ##  [70] "glm.nb"              "glm"                 "glmboost"           ##  [73] "glmnet_h3o"          "glmnet"              "glmStepAIC"         ##  [76] "gpls"                "hda"                 "hdda"               ##  [79] "hdrda"               "HYFIS"               "icr"                ##  [82] "J48"                 "JRip"                "kernelpls"          ##  [85] "kknn"                "knn"                 "krlsPoly"           ##  [88] "krlsRadial"          "lars"                "lars2"              ##  [91] "lasso"               "lda"                 "lda2"               ##  [94] "leapBackward"        "leapForward"         "leapSeq"            ##  [97] "Linda"               "lm"                  "lmStepAIC"          ## [100] "LMT"                 "loclda"              "logicBag"           ## [103] "LogitBoost"          "logreg"              "lssvmLinear"        ## [106] "lssvmPoly"           "lssvmRadial"         "lvq"                ## [109] "M5"                  "M5Rules"             "manb"               ## [112] "mda"                 "Mlda"                "mlp"                ## [115] "mlpKerasDecay"       "mlpKerasDecayCost"   "mlpKerasDropout"    ## [118] "mlpKerasDropoutCost" "mlpML"               "mlpSGD"             ## [121] "mlpWeightDecay"      "mlpWeightDecayML"    "monmlp"             ## [124] "msaenet"             "multinom"            "mxnet"              ## [127] "mxnetAdam"           "naive_bayes"         "nb"                 ## [130] "nbDiscrete"          "nbSearch"            "neuralnet"          ## [133] "nnet"                "nnls"                "nodeHarvest"        ## [136] "null"                "OneR"                "ordinalNet"         ## [139] "ORFlog"              "ORFpls"              "ORFridge"           ## [142] "ORFsvm"              "ownn"                "pam"                ## [145] "parRF"               "PART"                "partDSA"            ## [148] "pcaNNet"             "pcr"                 "pda"                ## [151] "pda2"                "penalized"           "PenalizedLDA"       ## [154] "plr"                 "pls"                 "plsRglm"            ## [157] "polr"                "ppr"                 "PRIM"               ## [160] "protoclass"          "pythonKnnReg"        "qda"                ## [163] "QdaCov"              "qrf"                 "qrnn"               ## [166] "randomGLM"           "ranger"              "rbf"                ## [169] "rbfDDA"              "Rborist"             "rda"                ## [172] "regLogistic"         "relaxo"              "rf"                 ## [175] "rFerns"              "RFlda"               "rfRules"            ## [178] "ridge"               "rlda"                "rlm"                ## [181] "rmda"                "rocc"                "rotationForest"     ## [184] "rotationForestCp"    "rpart"               "rpart1SE"           ## [187] "rpart2"              "rpartCost"           "rpartScore"         ## [190] "rqlasso"             "rqnc"                "RRF"                ## [193] "RRFglobal"           "rrlda"               "RSimca"             ## [196] "rvmLinear"           "rvmPoly"             "rvmRadial"          ## [199] "SBC"                 "sda"                 "sdwd"               ## [202] "simpls"              "SLAVE"               "slda"               ## [205] "smda"                "snn"                 "sparseLDA"          ## [208] "spikeslab"           "spls"                "stepLDA"            ## [211] "stepQDA"             "superpc"             "svmBoundrangeString"## [214] "svmExpoString"       "svmLinear"           "svmLinear2"         ## [217] "svmLinear3"          "svmLinearWeights"    "svmLinearWeights2"  ## [220] "svmPoly"             "svmRadial"           "svmRadialCost"      ## [223] "svmRadialSigma"      "svmRadialWeights"    "svmSpectrumString"  ## [226] "tan"                 "tanSearch"           "treebag"            ## [229] "vbmpRadial"          "vglmAdjCat"          "vglmContRatio"      ## [232] "vglmCumulative"      "widekernelpls"       "WM"                 ## [235] "wsrf"                "xgbLinear"           "xgbTree"            ## [238] "xyf"
```

 