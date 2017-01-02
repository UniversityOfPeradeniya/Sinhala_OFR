function [ featureArray ] = circularFeatures360FromCornersToNearest( fname )
%circularFeatures will write features of circular 
close all;
featureArray = [];
step = 10;

fileID = fopen([fname,'-cornerNearest.txt'],'w');
char = imread([fname]);


if ~islogical(char)
    char = im2bw(char);
end
char = imcomplement(char);
originaldim = size(char);
%disp(originaldim(1));
limit = round(sqrt(2*((originaldim(1)/2)^2)));
%disp(limit);
figure
imagesc(char);
axis([-1 201 -1 201]);
colormap(flipud(gray));
hold on;

i = 0;
while i<90
    angle = (pi/180)*i;
    rho = [0:1:limit];
    theta = zeros(1,size(rho,2))+angle;
    [x,y] = pol2cart(theta,rho);
     plot(x,y,'r','LineWidth',2);
    x=round(x);%+originaldim(1)/2);
    y=round(y);%+originaldim(2)/2);
    
    
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
    if(CC.NumObjects ==0)
        centroids = [0,0];
    else
        maxone=max(CC.PixelIdxList{1});
        minone=min(CC.PixelIdxList{1});
        
        centroids = [maxone,minone];
    end
    %S = regionprops(CC,'Centroid');
    
    %disp(centroids);
    %if(size(centroids,1) == 0)
    %    centroids = [0,0];
    %end
    %centroids = centroids(:,1);
    subofElements = max(centroids)-min(centroids);
    
    featureArray = [featureArray,subofElements];
    
    [x,y] = pol2cart(angle,max(centroids));
    x=round(x);%+originaldim(1)/2);
    y=round(y);%+originaldim(2)/2);
    plot(x,y,'*g','LineWidth',4);
    [x,y] = pol2cart(angle,min(centroids));
    x=round(x);%+originaldim(1)/2);
    y=round(y);%+originaldim(2)/2);
    plot(x,y,'*g','LineWidth',4);
    
    i=i+step;
end

i = 90;
while i<180
    angle = (pi/180)*i;
    rho = [0:1:limit];
    theta = zeros(1,size(rho,2))+angle;
    [x,y] = pol2cart(theta,rho);
    x = x+originaldim(1);
     plot(x,y,'r','LineWidth',2);
    x=round(x);
    y=round(y);%+originaldim(2)/2);
    
    
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
    if(CC.NumObjects ==0)
        centroids = [0,0];
    else
        maxone=max(CC.PixelIdxList{1});
        minone=min(CC.PixelIdxList{1});
        
        centroids = [maxone,minone];
    end
    %S = regionprops(CC,'Centroid');
    
    %disp(centroids);
    %if(size(centroids,1) == 0)
    %    centroids = [0,0];
    %end
    %centroids = centroids(:,1);
    subofElements = max(centroids)-min(centroids);
    
    featureArray = [featureArray,subofElements];
    
    [x,y] = pol2cart(angle,max(centroids));
    x = x+originaldim(1);
    x=round(x);
    y=round(y);
    plot(x,y,'*g','LineWidth',4);
    [x,y] = pol2cart(angle,min(centroids));
    x = x+originaldim(1);
    x=round(x);
    y=round(y);
    plot(x,y,'*g','LineWidth',4);
    
    i=i+step;
end

i = 180;
while i<270
    angle = (pi/180)*i;
    rho = [0:1:limit];
    theta = zeros(1,size(rho,2))+angle;
    [x,y] = pol2cart(theta,rho);
    x=x+originaldim(1);
    y=y+originaldim(2);
     plot(x,y,'r','LineWidth',2);
    x=round(x);%+originaldim(1));
    y=round(y);%+originaldim(2));
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
    if(CC.NumObjects ==0)
        centroids = [0,0];
    else
        maxone=max(CC.PixelIdxList{1});
        minone=min(CC.PixelIdxList{1});
        
        centroids = [maxone,minone];
    end
    %S = regionprops(CC,'Centroid');
    
    %disp(centroids);
    %if(size(centroids,1) == 0)
    %    centroids = [0,0];
    %end
    %centroids = centroids(:,1);
    subofElements = max(centroids)-min(centroids);
    
    featureArray = [featureArray,subofElements];
    
    [x,y] = pol2cart(angle,max(centroids));
    x=x+originaldim(1);
    y=y+originaldim(2);
    x=round(x);
    y=round(y);
    plot(x,y,'*g','LineWidth',4);
    [x,y] = pol2cart(angle,min(centroids));
    x=x+originaldim(1);
    y=y+originaldim(2);
    x=round(x);
    y=round(y);
    plot(x,y,'*g','LineWidth',4);
    
    i=i+step;
end

i = 270;
while i<360
    angle = (pi/180)*i;
    rho = [0:1:limit];
    theta = zeros(1,size(rho,2))+angle;
    [x,y] = pol2cart(theta,rho);
    y=y+originaldim(2);
     plot(x,y,'r','LineWidth',2);
    x=round(x);%+originaldim(1)/2);
    y=round(y);%+originaldim(2));
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
    if(CC.NumObjects ==0)
        centroids = [0,0];
    else
        maxone=max(CC.PixelIdxList{1});
        minone=min(CC.PixelIdxList{1});
        
        centroids = [maxone,minone];
    end
    %S = regionprops(CC,'Centroid');
    
    %disp(centroids);
    %if(size(centroids,1) == 0)
    %    centroids = [0,0];
    %end
    %centroids = centroids(:,1);
    subofElements = max(centroids)-min(centroids);
    
    featureArray = [featureArray,subofElements];
    
    [x,y] = pol2cart(angle,max(centroids));
    y=y+originaldim(2);
    x=round(x);
    y=round(y);
    plot(x,y,'*g','LineWidth',4);
    [x,y] = pol2cart(angle,min(centroids));
    y=y+originaldim(2);
    x=round(x);
    y=round(y);
    plot(x,y,'*g','LineWidth',4);
    
    i=i+step;
end


%set(gca,'FontWeight','bold','fontsize',12);
%print('circularFromcornerA.pdf','-dpdf');
%featureArray = normalize_var(featureArray,0,100);

fprintf(fileID,'%f ',featureArray);
fprintf(fileID,'\n');
fclose(fileID);

return;
end

