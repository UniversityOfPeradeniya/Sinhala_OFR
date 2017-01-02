function[]= segment(inputImage,PageAndRow)

folderPath = 'output/';


rotatedImage = imrotate(inputImage,-90);

%figure;imshow(rotatedImage);
verticalProjection = sum(rotatedImage, 1);


% set(gcf, 'Name', 'Segmentation Trial', 'NumberTitle', 'Off') 
% subplot(2, 2, 1);imshow(rotatedImage); 
% subplot(2,2,3);
% plot(verticalProjection, 'b-');

verticalProjectionFiltered = verticalProjection - mean(mean(verticalProjection))*0.05;

verticalProjectionFiltered(verticalProjectionFiltered<0)=0;
verticalProjectionFiltered(verticalProjectionFiltered>0)=1;
% subplot(2,2,4);
% plot(verticalProjectionFiltered, 'b-');


%Now in this vertical projection, I need to get connected components

%disp(verticalProjectionFiltered)
startIndex=0;
endIndex=0;

%start from the first element

for i=1:numel(verticalProjectionFiltered)
    
    if(verticalProjectionFiltered(i)==1)
        startIndex = i;
        break;
    end
end
for i=[numel(verticalProjectionFiltered):-1:1]
    
    if(verticalProjectionFiltered(i)==1)
        endIndex = i;
        break;
    end
end

%disp([startIndex,endIndex]);

%Now I have the starting and end positions
%I need to crop this
verticalProjectionCroped = [];
inputImageCropped = rotatedImage(:,startIndex:endIndex);
if(endIndex>startIndex)
    verticalProjectionCroped = verticalProjectionFiltered(startIndex:endIndex);

else
    disp('Emptyline');
end


%inverse the croped
verticalProjectionCropedInversed = 1-verticalProjectionCroped;

%disp(verticalProjectionCropedInversed);
%Now check for connected components

CC = bwconncomp(verticalProjectionCropedInversed);
S = regionprops(CC,'area');

spaces = [];
for i=1:numel(S)
    %disp(S(i).Area);
    spaces = [spaces,S(i).Area];
    
end

meanofSpaces = mean(spaces)*2;
%disp(spaces);

%fill smaller holes in vertical projection with morphological operations
se = strel('line',round(meanofSpaces),0);
BW2 = imdilate(verticalProjectionCroped,se);

% subplot(2,2,2);
% plot(BW2, 'b-');


%Now I can use slicing again

CC = bwconncomp(BW2);
S = regionprops(CC,'BoundingBox');

for i=1:numel(S)
    
    rectangle = S(i).BoundingBox;
    %disp([ceil(rectangle(1)),ceil(rectangle(1))+ceil(rectangle(3))]);
    portion = inputImageCropped(:,ceil(rectangle(1)):ceil(rectangle(1))+ceil(rectangle(3))-1);
    
    
    %figure;imshow(portion);
    %Now I can process this portion
    
    %save it
    filename = [folderPath,PageAndRow,'.png'];
    imwrite(portion,filename);
    disp(filename);
    
end


end

