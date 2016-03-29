function [UtTrain]=UtilMatrix(M)
% Function [UtTrain]=UtilMatrix(M) creates (unUser x unItems) utility matrix UtTrain counting
%          how many times user read an article 
% 
% Input: Train dataset (M)
% Potput: Utlity matrix of train dataset (UtTrain)

% Create vectors with unique users and items
unUser=unique(M(:,6));
unItem=unique([M(:,2) M(:,5)]);
[n,m]=size(M);

% Initialize test Data Utlity Matrix 
UtTrain=zeros(size(unUser),size(unItem));

% Create utility Matrices UtTrain 
	for i=1:n
   
  	 [x,iUser]=max(User=M(i,6)==unUser(:)); 
  	 [y,iItemIn]=max(ItemIn=M(i,5)==unItem(:));
  	 [z,iItemOut]=max(ItemOut=M(i,1).*(M(i,2)==unItem(:)));
   
  	 UtTrain(iUser,iItemIn)=UtTrain(iUser,iItemIn)+1;
   	 UtTrain(iUser,iItemOut)=UtTrain(iUser,iItemOut)+1;

	end

end
