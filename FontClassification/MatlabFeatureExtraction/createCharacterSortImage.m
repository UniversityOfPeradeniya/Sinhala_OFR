function [] = createCharacterSortImage(dirName,uniqueArray)
%createCharacterSortImage will create a large image based on the given
%unique array



totalImage = [];
for image=uniqueArray
    
    pathname = [dirName,'/',char(image),'.png'];
    disp([dirName,'/',char(image),'.png']);
    tmp = imread(pathname);
    tmp = im2bw(tmp);
    totalImage = [totalImage,tmp];
    
end


imwrite(totalImage,[dirName,'/total.png']);




end

