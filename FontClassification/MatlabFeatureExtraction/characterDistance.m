function [ distanceArray ] = characterDistance(dirName,Anorm,labels)
%characterDistance will sort out characters by their distance

finalImage = [];

AnormU = triu(Anorm);

AnormU(AnormU==0) = inf;

disp(size(AnormU));
[row,col] = size(AnormU);
disp(AnormU);
i=1;
count = 0;
while(i<=row)
    j=i;
    %disp(i);
    while(j<=col)
        if(count>1000)
            break;
        end
        
        %get the min value
        [minvalcol,rowNum] = min(AnormU);
        [minvalrow,colNum] = min(minvalcol);
        %disp(minvalcol);
        %disp(rowNum);
        %disp(minvalrow);
        %disp(colNum);
        rowNum = rowNum(colNum);
        %disp(rowNum);
        %fprintf('row= %d col= %d\n',rowNum,colNum);
        labelx = labels(colNum);
        labely = labels(rowNum);
        %fprintf('labelx= %c labely= %c\n',labelx,labely);
        
        AnormU(rowNum,colNum) = inf;
        %disp(AnormU);
        
        
        
        %handle label values
        
        %crate the file name
        fileName1 = [dirName,'/',char(labelx),'.png'];
        fileName2 = [dirName,'/',char(labely),'.png'];
        
        char1= im2bw(imread(fileName1));
        char2 = im2bw(imread(fileName2));
        
        tmp = [char1,char2];
        finalImage = [finalImage;tmp];
        
        count = count+1;
        
        disp(count);
        
        j=j+1;
    end

    i=i+1;
end

imwrite(finalImage,[dirName,'/compareDoubles.png']);

disp(AnormU);

end

