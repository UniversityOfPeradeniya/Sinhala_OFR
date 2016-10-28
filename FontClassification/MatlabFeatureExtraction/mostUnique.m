function [ minLabelArray ] = mostUnique(Anorm,labels)
%mostUnique will findout most unique characters and sort them

minLabelArray = [];

AnormMeans = mean(Anorm,2);

rows = size(AnormMeans,1);

i=1;


while(i<=rows)
    [minVal,pos] = min(AnormMeans);
    %disp([minVal,pos]);
    % get the element from the labels
    minLabel = labels(pos);
    minLabelArray = [minLabelArray,minLabel];
    %change the value to inf
    AnormMeans(pos) = inf;
    
    
    i=i+1;
end



end

