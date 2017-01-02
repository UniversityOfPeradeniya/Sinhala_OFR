function [outputImg] = cropWord(imagePath,height)
%This will crop and add pading of 1px to the matrix
padding = 1;

word = imread(imagePath);

if ~islogical(word)
    wordbw = im2bw(word);
else
    wordbw = word;
end

%imshow(wordbw);

verticalProjection = sum(wordbw, 1);

if(sum(verticalProjection)<height)
    outputImg = NaN;
    return
end

horizontalProjection = sum(wordbw, 2);

%figure,plot(verticalProjection);
%figure,plot(horizontalProjection);


%iterate until find a 1
hstart=0;
hend=0;
vstart=0;
vend=0;

%disp(size(verticalProjection,2));
%disp(size(horizontalProjection,1));

for(i=1:size(verticalProjection,2))
    %disp(verticalProjection(i));
    if(verticalProjection(i)>0)
        vstart = i;
        break
    end
end

for(i=size(verticalProjection,2):-1:1)
    %disp(verticalProjection(i));
    if(verticalProjection(i)>0)
        vend = i;
        break
    end
end

for(i=1:size(horizontalProjection,1))
    %disp(horizontalProjection(i));
    if(horizontalProjection(i)>0)
        hstart = i;
        break
    end
end

for(i=size(horizontalProjection,1):-1:1)
    %disp(verticalProjection(i));
    if(horizontalProjection(i)>0)
        hend = i;
        break
    end
end



%disp(vstart);
%disp(vend);
%disp(hstart);
%disp(hend);


%now crop image
cropped = imcrop(wordbw,[vstart hstart  vend-vstart hend-hstart]);
%figure;imshow(cropped);
padcropped = padarray(cropped,[padding padding],'both');


%now resize image to be 40 height
width = round(size(padcropped,2)/(size(padcropped,1)/height));

resizedImg = imresize(padcropped,[height width]);

%figure;imshow(resizedImg);

outputImg = resizedImg;

end

