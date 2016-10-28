function [] = circularProjection360( fname,sizeof,pattern )
%circularFeatures will write features of circular 
close all;

widthArray = [];
fileID = fopen([fname,pattern,'.txt'],'w');
char = imread([fname,'.png']);
char = im2bw(char);
char = imcomplement(char);
originaldim = size(char);

figure
imagesc(char);
colormap(flipud(gray));
hold on;


i = -90;
step = round(360/sizeof);
while i<270
    angle = (pi/180)*i;
    rho = [0:1:100];
    theta = zeros(1,size(rho,2))+angle;
    [x,y] = pol2cart(theta,rho);
    x=round(x+originaldim(1)/2);
    y=round(y+originaldim(2)/2);
     plot(x,y,'r','LineWidth',2);
    
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
    %disp(cellfun(@numel,CC.PixelIdxList));
    numPixels = sum(cellfun(@numel,CC.PixelIdxList));
    
    if(numPixels)
        widthArray = [widthArray,numPixels];
    else
        widthArray = [widthArray,0];
    end
    %fprintf('I got %d\n',numPixels);
    %disp(widthArray);
    
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
widthArray = normalize_var(widthArray,0,100);

fprintf(fileID,'%f ',widthArray);
fprintf(fileID,'\n');
fclose(fileID);

return;
end

