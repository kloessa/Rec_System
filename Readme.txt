Recommender system to predict the click behaviour for news articles. 

The dataset contains samples for 3 publisher. 

## Description of the Data Set
In the data folder you find a train.csv and a test.csv.
The train.csv is the actual data set in CSV format. It consist of the following columns:

|  Columns       | Description
|----------------|---------------------------
|  Output        | 1 for a click 0 for no-click
|  OsrItem       | The ID of the NewsArticle the user clicked or not clicked on
|  Publisher     | ID of the Publisher. There are 3 different in total.
|  Osfamily      | ID of the Family of the Operating system (version numbers are stripped etc..)
|  ItemSrc       | The ID of the newsarticle the user is currently reading
|  UserID        | ID of the user
|  UserClicksAd  | How often the user clicked on an ad


## Implementation
The NA_Prediction.m file is used to test the performance of the recommender sytem on the test data.
The UtilMatrix.m file creates a utility matrix UtTrain counting how many times a user read an article.
The train.m file trains the recommender system on train dataset using linear regression with regularization.
The predict.m file counts topN predictions on test dataset.
The cofiCostFunc.m file contains a implementation of a Collaborative filtering cost function.
The fmincg. m file is used to minimize the costfunction.

