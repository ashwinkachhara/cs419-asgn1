fid = fopen('machine.data.txt', 'r');
C = textscan(fid, '%s%s%u%u%u%u%u%u%u%u', 'Delimiter', ',');

X = [C{3}, C{4}, C{5}, C{6}, C{7}, C{8}];
y = [C{9}];
X = double(X);
y = double(y);
% X1 = zeros(20,6);
% y1 = zeros(20,1);
% X1 = X(1:21,:);
% y1 = y(1:21,:);
% 
% X2 = zeros(20,6);
% y2 = zeros(20,1);
% X2 = X(22:42,:);
% y1 = y(22:42,:);
% 
% X3 = zeros(20,6);
% y3 = zeros(20,1);
% X3 = X(43:63,:);
% y1 = y(43:63,:);
% 
% X4 = zeros(20,6);
% y4 = zeros(20,1);
% X4 = X(64:84,:);
% y1 = y(64:84,:);
% 
% X5 = zeros(20,6);
% y5 = zeros(20,1);
% X5 = X(85:105,:);
% y1 = y(85:105,:);
% 
% X6 = zeros(20,6);
% y6 = zeros(20,1);
% X6 = X(106:126,:);
% y1 = y(106:126,:);
% 
% X7 = zeros(20,6);
% y7 = zeros(20,1);
% X7 = X(127:147,:);
% y1 = y(127:147,:);
% 
% X8 = zeros(20,6);
% y8 = zeros(20,1);
% X8 = X(148:168,:);
% y1 = y(148:168,:);
% 
% X9 = zeros(20,6);
% y9 = zeros(20,1);
% X9 = X(169:189,:);
% y1 = y(169:189,:);
% 
% X10 = zeros(20,6);
% y10 = zeros(20,1);
% X10 = X(190:209,:);
% y1 = y(190:209,:);

% X1 = zeros(9, 21, 6);
% for i=1:9,
%     X1(i,:,:) = X(21*(i-1)+1:21*i,:);
% end
% X2 = zeros(20, 6);
% X2 = X(21*i+1:end,:);
% Now we have divided the data into different sets X1(1:9) and X2 for the
% crossvalidation


% regf = @(XTRAIN, ytrain, XTEST)(XTEST*((XTRAIN'*XTRAIN)\(XTRAIN'*ytrain)));
% cvMse = crossval('mse', X, y, 'predfun', regf);

% p = randperm(209)
% train = p(1:100);
% test =  p(101:end);

test = [108,23,13,73,130,169,184,4,76,179,45,6,193,8,44,200,207,102,203,173,84,3,140,141,68,38,187,150,98,156,117,29,136,209,90,125,89,80,53,16,175,115,111,164,40,9,83,60,42,126,163,132,147,198,199,120,131,181,186,77,161,62,32,11,92,127,172,34,124,165,166,133,171,202,138,70,28,142,109,188,71,31,22,101,86,144,205,139,35,118,5,39,116,52,81,190,137,129,43,106,204,72,26,112,182,94,189,180,93;];
train = [192,54,59,51,10,97,55,143,146,110,65,66,185,1,128,47,67,49,159,197,99,107,95,58,114,12,149,148,123,134,82,157,17,88,25,48,158,119,20,19,194,104,56,195,74,75,96,176,162,183,69,151,14,174,18,113,167,2,168,46,160,152,170,196,21,91,37,201,121,208,78,61,206,103,15,30,41,178,155,87,153,24,154,27,100,145,191,122,36,7,85,64,63,105,57,177,135,79,50,33;];

% x = ones(10,1)'*10;
% 
% B = mat2cell(train,1,x);
% 
% i = nchoosek(1:10, 9);
% 
% for j=1:size(i,1),
%     cvtrainind = cell2mat(B(i(j,:)));
%     cvtestind = B{setdiff(1:10, i(j,:))};
%     Xtrain = X(cvtrainind,:,:,:,:,:);
%     Xtest = X(cvtestind,:,:,:,:,:);
%     ytrain = y(cvtrainind);
%     ytest = y(cvtestind);
%     
%     b1 = regress(ytrain, Xtrain);
%     
% end

% b1 = b1/size(i,1);
% 
% Xtr = X(train,:,:,:,:,:);
% Xtst =  X(test,:,:,:,:,:);
% 
% trainErrorLSE = sum((y(train) - Xtr*b1).^2)/size(train,2);
% testErrorLSE = sum((y(test) - Xtst*b1).^2)/size(test,2);

% Min LSE Linear Regression

Xtrain = X(train,:,:,:,:,:);
Xtest =  X(test,:,:,:,:,:);
ytrain = y(train);
ytest = y(test);


b1 = regress(y(train),Xtrain);

trainErrorLSE = mean((ytrain - Xtrain*b1).^2);
testErrorLSE = mean((ytest - Xtest*b1).^2);

% Ridge Regression
% Cross validation is required here to estimate the value of lambda

x = ones(10,1)'*10;

B = mat2cell(train,1,x);

i = nchoosek(1:10, 9);
lambdas = logspace(-10,10);
NL = length(lambdas);
% testMseRidge = zeros(1,NL);
% trainMseRidge = zeros(1,NL);

% for j=1:NL,
%     lambda = lambdas(j);
%     b2 = (Xtrain'*Xtrain+lambda*eye(6))\(Xtrain'*ytrain);
%     trainMseRidge(j) = mean((ytrain - Xtrain*b2).^2);
%     testMseRidge(j) = mean((ytest - Xtest*b2).^2);
% end

% hlam=figure(1);hold on
% ndx = log10(lambdas);
% plot(ndx, trainMseRidge, 'bs:', 'linewidth', 2, 'markersize', 12);
% plot(ndx, testMseRidge, 'rx-', 'linewidth', 2, 'markersize', 12);
% legend('train mse', 'test mse', 'location', 'northwest')
% xlabel('log lambda')
% title('mean squared error');
% hold off

%Choosing the best lambda using cross-validation

cvMse = zeros(NL,1);

for k=1:NL,
    mse = 0;
    lambda = lambdas(k);
    for j=1:size(i,1),
        cvtrainind = cell2mat(B(i(j,:)));
        cvtestind = B{setdiff(1:10, i(j,:))};
        Xtrain = X(cvtrainind,:,:,:,:,:);
        Xtest = X(cvtestind,:,:,:,:,:);
        ytrain = y(cvtrainind);
        ytest = y(cvtestind);
        b2 = (Xtrain'*Xtrain+lambda*eye(6))\(Xtrain'*ytrain);
        mse = mse + mean((ytest-Xtest*b2).^2);
    end
    cvMse(k) = mse/size(i,1);
end

[cvMsemin I] = min(cvMse);

%Required Lambda is 
lambda_opt = lambdas(I);
b2 = (Xtrain'*Xtrain+lambda_opt*eye(6))\(Xtrain'*ytrain);
trainMseRidge = mean((ytrain - Xtrain*b2).^2)
testMseRidge = mean((ytest - Xtest*b2).^2)



