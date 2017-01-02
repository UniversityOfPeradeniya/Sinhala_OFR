function [roundness] = roundnessAnalyzer(fname,singlepngfile,pattern)
%This will analyze the roundness of the each character in the image and return
%save one file per folder
close all;
disp(fname);
%open image

word = imread(singlepngfile);
%word = imresize(word,16);
if ~islogical(word)
    wordbw = im2bw(word);
else
    wordbw = word;
end


%imshow(wordbw);


%I need to get the horizontal projection to measure the major line
image=padarray(wordbw,[0 1]);
horizontalProjection = sum(image, 2);
%figure;plot(horizontalProjection)
%if data liese around 80% of mean, then it considered as the center line
meanofData = mean(horizontalProjection)*0.8;
adjustedHorizontalProjection = horizontalProjection;
adjustedHorizontalProjection(adjustedHorizontalProjection<meanofData) = 0;
adjustedHorizontalProjection(adjustedHorizontalProjection>=meanofData) = 1;
adjustedHorizontalProjection = im2bw(adjustedHorizontalProjection);
%hold on;
%plot(adjustedHorizontalProjection);
%disp(meanofData);

%get the largest connected component
CC = bwconncomp(adjustedHorizontalProjection);
largestSize = 0;
largetsElementIndexes = [];
for i=1:CC.NumObjects
    tmp = CC.PixelIdxList{i};
    if size(tmp,1)>largestSize
        largestSize= size(tmp,1);
        largetsElementIndexes = tmp;
    end
end

%disp(largestSize);
%disp(largetsElementIndexes);


%max and min of largetsElementIndexes is the starting and end positions of
%the major part of the character

% I should go backword to check the first white pixel
startingIndex = min(largetsElementIndexes);
endIndex = max(largetsElementIndexes);

positionArray = [];
for i=startingIndex:endIndex
    current = image(i,:);
    
    lastposition = 0;
    count = 0;
    for j=numel(current):-1:1
        count=count+1;
        if(current(j)==1)
           lastposition = count;
           break;
        end
    
    end
    positionArray = [positionArray;lastposition];
end

%figure;plot(positionArray);

firstDerivative = abs(diff(positionArray));
%disp(firstDerivative);
%figure;plot(firstDerivative);
roundnessIndex = sum(sum(firstDerivative))/numel(positionArray);

roundness = roundnessIndex;
%open the file
%fileID = fopen([fname,'/',pattern,'.txt'],'a');
%fprintf(fileID,'%.5f\n',density);
%fclose(fileID);

return


end

