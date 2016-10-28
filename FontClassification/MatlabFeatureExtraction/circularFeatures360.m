function [ ] = circularFeatures360( fname,sizeofside,pattern )
%circularFeatures will write features of circular 
close all;
featureArray = [];

fileID = fopen([fname,pattern,'.txt'],'w');
char = imread([fname,'.png']);
char = im2bw(char);
char = imcomplement(char);
originaldim = size(char);

% figure
% imagesc(char);
% colormap(flipud(gray));
% hold on;

i = -90;
step = 360/sizeofside;
while i<270
    angle = (pi/180)*i;
    rho = [0:1:100];
    theta = zeros(1,size(rho,2))+angle;
    [x,y] = pol2cart(theta,rho);
    x=round(x+originaldim(1)/2);
    y=round(y+originaldim(2)/2);
%     plot(x,y,'r','LineWidth',2);
    
    valarray=[];
    %iterate through x,y
    for n = 1:size(x,2)
            if(n<originaldim(1))
                xpos = x(1,n);
                if xpos<=0
                    xpos = 1;
                end
                ypos = y(1,n);
                if ypos<=0
                    ypos = 1;
                end
                val = char(ypos,xpos);
                valarray = [valarray,val];
               
            end
    end
    CC = bwconncomp(valarray);
    %disp(CC);
    
    %disp(numPixels);
    S = regionprops(CC,'Centroid');
    centroids = cat(1, S.Centroid);
    %disp(centroids);
    if(size(centroids,1) == 0)
        centroids = [0,0];
    end
    centroids = centroids(:,1);
    sumofElements = max(centroids)+min(centroids);
    
    featureArray = [featureArray,sumofElements];
%     [x,y] = pol2cart(angle,max(centroids));
%     x=round(x+originaldim(1)/2);
%     y=round(y+originaldim(2)/2);
%     plot(x,y,'*g','LineWidth',4);
%     [x,y] = pol2cart(angle,min(centroids));
%     x=round(x+originaldim(1)/2);
%     y=round(y+originaldim(2)/2);
%     plot(x,y,'*g','LineWidth',4);
    i=i+step;
end


%set(gca,'FontWeight','bold','fontsize',12);
%print('circularA.pdf','-dpdf');
featureArray = normalize_var(featureArray,0,100);

fprintf(fileID,'%f ',featureArray);
fprintf(fileID,'\n');
fclose(fileID);

return;
end

