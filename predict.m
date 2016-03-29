function [count]=predict(p,Test,M,UTrain)
% Function [count]=predict(p,Test,M,UTrain) counts topN predictions on test dataset
%
% Input: Prediction matrix (p)
%        Test dataset (Test)
%        Train dataset (M)
%        Utility matrix of train dataset (UTrain)
% Output: Number of topN predictions on test dataset (count)

% Usefull values and initialization
UTrain=UTrain';
[m,n]=size(Test);
count=0;

% Create vectors with unique users and items
unUser=unique(M(:,6));
unItem=unique([M(:,2) M(:,5)]);
[k,l]=size(unItem);

% Create matrix with unique items and corresponding publisher
for i=1:k

    [x,idy]=max(unItem(i)==M(:,5));
    unItemPub(i,1)=unItem(i);
    unItemPub(i,2)=M(idy,3);
end


for i=1:m

% Initialize values
    predictions=zeros(1,k);
    Pub=zeros(1,k);
    topprediction=zeros(1,30);

% Predict topN items by userid and publisher  
%
%
%
% Include unknown user. Predict random items by publisher for unknown user 
  if   max(Test(i,6)==unUser)==0     

	     topprediction = (Test(i,3)==unItemPub(:,2)).*unItem;
 	     topprediction = topprediction(topprediction~=0);
	     topprediction = topprediction(randperm(size(topprediction,1)),:);

% Item user is currently reading is not predicted
		if max(Test(i,5)==topprediction)~=0

             	  topprediction=topprediction(topprediction~=Test(i,5));
             	    
         	end

	     topprediction = topprediction(1:5);
       
       
% Predict rating for user with UserId=0. Predict ratings most seen on train dataset because user is not in prediction matrix p     
  elseif    Test(i,6)==unUser(1)
   
  	     predictions = UTrain(:,1);  
  	     Pub = (Test(i,3)==unItemPub(:,2));
   	     [r,idy] =sort(predictions.*Pub,'descend'); 

    		 for j=1:5

                   topprediction(j) = unItem(idy(j));	% Top 5 predicted Items

		 end

% Item user is currently reading is not predicted
	 	 if max(Test(i,5)==topprediction)~=0

             	   topprediction=topprediction(topprediction~=Test(i,5));
             	   topprediction(5)= unItem(idy(6));
  
         	 end
   
% Predict ratings for other users   
    else  
 	 	
 	       [r,idw]=max(Test(i,6)==unUser(2:end));
  	       predictions = [0;p(:,idw)]; 
  	       Pub = (Test(i,3)==unItemPub(:,2));
   	       [r,idx] =sort(predictions.*Pub,'descend'); 

    		for j=1:5

                   topprediction(j) = unItem(idx(j));	% Top 5 predicted Items

		end

% Item user is currently reading is not predicted
	 	if max(Test(i,5)==topprediction)~=0

             	   topprediction=topprediction(topprediction~=Test(i,5));
             	   topprediction(5)= unItem(idx(6));
     
       		end
    end
    
% Count prediction on Testset
    if  max(topprediction==Test(i,2))~=0 

         	   count++;
 
    end

end

end

