function [ featureArray,widthArray ] = verticalAndHorisontalDistance( fname,sizeof,pattern )
%circularFeatures will write features of circular 
close all;
featureArrayHL = [];
featureArrayHR = [];
featureArrayVT = [];
featureArrayVB = [];
widthArray = [];
fileID = fopen([fname,pattern,'.txt'],'w');
char = imread([fname,'.png']);
char = im2bw(char);
char = imcomplement(char);
originaldim = size(char);
sizeof = round(sizeof/4);

steps = round(linspace(1,originaldim(1),sizeof));
% disp(steps);

% figure
% imagesc(char);
% colormap(flipud(gray));
% hold on;

%horizontal lines
 for line=steps
     %disp(line)
     data = char(line,:);
%      plot(xlim,[line line],'g-','LineWidth',2);
     
     CC = bwconncomp(data);
     S = regionprops(CC,'Centroid');
     centroids = cat(1, S.Centroid);
%      disp(centroids);
     if(size(centroids,1) == 0)
         centroids = [0,0];
     end
     centroids = centroids(:,1);
     
     closestCentroid = min(centroids);
     longestCentroid = max(centroids);
     featureArrayHL = [featureArrayHL,closestCentroid];
     featureArrayHR = [featureArrayHR,longestCentroid];
%      plot(closestCentroid,line,'*g','LineWidth',4);
%      plot(longestCentroid,line,'*g','LineWidth',4);

 end
% disp(featureArrayHL);
% disp(featureArrayHR);


%vertical lines
 for line=steps
     %disp(line)
     data = char(:,line);
%      plot([line line],ylim,'g-','LineWidth',2);
     
     CC = bwconncomp(data);
     S = regionprops(CC,'Centroid');
     centroids = cat(1, S.Centroid);
%      disp(centroids);
     if(size(centroids,1) == 0)
         centroids = [0,0];
     end
     centroids = centroids(:,2);
     
     closestCentroid = min(centroids);
     longestCentroid = max(centroids);
     featureArrayVT = [featureArrayVT,closestCentroid];
     featureArrayVB = [featureArrayVB,longestCentroid];
%      plot(line,closestCentroid,'*g','LineWidth',4);
%      plot(line,longestCentroid,'*g','LineWidth',4);

 end
% disp(featureArrayVT);
% disp(featureArrayVB);

% 
% %set(gca,'FontWeight','bold','fontsize',12);
% %print('circularA.pdf','-dpdf');
 featureArrayHL = normalize_var(featureArrayHL,0,100);
 featureArrayVB = normalize_var(featureArrayVB,0,100);
 featureArrayHR = normalize_var(featureArrayHR,0,100);
 featureArrayVT = normalize_var(featureArrayVT,0,100);
% 
 
 
 finalArray = [featureArrayHL,featureArrayVB,featureArrayHR,featureArrayVT];
 finalArray(isnan(finalArray)) = 0 ;
%  disp(finalArray);
 fprintf(fileID,'%f ',finalArray);
 fprintf(fileID,'\n');
 fclose(fileID);

return;
end

