
function [] = emptyCenter(fname,sizeof,pattern)

close all;

widthArray = [];
fileID = fopen([fname,pattern,'.txt'],'w');
char = imread([fname,'.png']);
char = im2bw(char);
char = imcomplement(char);
originaldim = size(char);

% figure
% imagesc(char);
% colormap(flipud(gray));
% hold on;
stepSizeOutwards = 25;
NoOfRounds = 1;

while NoOfRounds<=1 %int32(originaldim(1)/(2*stepSizeOutwards))

    numPixels = 0;
    i = -90;
    step = round(360/sizeof);
    while i<270
        angle = (pi/180)*i;
        rho = [0:1:NoOfRounds*stepSizeOutwards];
        theta = zeros(1,size(rho,2))+angle;
        [x,y] = pol2cart(theta,rho);
        x=round(x+originaldim(1)/2);
        y=round(y+originaldim(2)/2);
        %plot(x,y,'r','LineWidth',2);

        valarray=[];
        %iterate through x,y
        for n = 1:size(x,2)
                if(n<NoOfRounds*stepSizeOutwards)
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
        %disp(valarray);
        numPixels = numPixels +sum(sum(valarray));
        i=i+step;
    end


    fprintf(fileID,'%f ',numPixels);

    NoOfRounds = NoOfRounds+1;

end

fprintf(fileID,'\n');
fclose(fileID);

return;

end
