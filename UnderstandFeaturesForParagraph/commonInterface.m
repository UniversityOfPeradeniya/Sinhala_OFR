function [] = commonInterface(dirName,pattern)
%This will analyze the density of the image and return save one file per
%folder

files = dir( fullfile(dirName) );   %list all *.png files
files = {files.name}';                      % file names

%open the file
delete([pattern,'.csv']);
fileID = fopen([pattern,'.csv'],'a');

%first two I should ommit because of . and ..
firstIter = ['label',',','linewidth',',','density',',','lineheight',',','C1',',','C2',',','C3',',','C4',',','C5',',','C6',',','C7',',','C8',',','C9',',','C10',',','C11',',','C12',',','C13',',','C14',',','C15',',','C99'];
fprintf(fileID,'%s\n',firstIter);
allIter = [];
for i=3:numel(files)
    fname = fullfile(dirName,files{i});     % full path to file
    disp(fname);
    %now take images in that folder
    pngfiles = dir( fullfile(fname,'\\','*.png') );   %list all *.png files
    pngfiles = {pngfiles.name}';% file names
    
    %remove the current file
    %delete([fname,'/',pattern,char(files{i}),'.txt']);
    
    %collecting the results
    oneIteration = [];
    
    %iterate through all the files
    for j=1:numel(pngfiles)
        singlepngfile = fullfile(fname,pngfiles{j});
        %This section for density informations
        %singledensity = densityAnalyzer(fname,singlepngfile,[pattern,char(files{i})]);
        %oneIteration = [oneIteration,',',num2str(singledensity)];
        
        %this will get the derivative of both sides to measure the
        %roundness
        %singleRoundness = roundnessAnalyzer(fname,singlepngfile,[pattern,char(files{i})]);
        %oneIteration = [oneIteration,',',num2str(singleRoundness)];
        checkword = imread(singlepngfile);
        if(size(checkword,1)>size(checkword,2))
            disp('Small Character');
            continue;
        end
        
        if ~islogical(checkword)
            wordbw = im2bw(checkword);
        else
            wordbw = checkword;
        end
        
        
        %this will measure the center line width
        linewidth = centerLineWidth(fname,wordbw,pattern);
        
        %get the pixel density and the mean height of characters
        feature2 = lowerHalfPixelCount(wordbw,'.',pattern);
        
        %get the correlation data with 10 points
        feature3 =  getCorrelationData(wordbw,pattern);
        %convert it to comma separated string
        allOneString = sprintf('%f,' , feature3);
        allOneString = allOneString(1:end-1);% strip final comma
        
        %disp(linewidth);
        oneIteration = [oneIteration,char(files{i}),',',num2str(linewidth),',',num2str(feature2(1)),',',num2str(feature2(2)),',',allOneString,char(10)];
        %disp(oneIteration);
        
    end
    %disp(oneIteration)
    fprintf(fileID,'%s',oneIteration);
    %allIter = [allIter,oneIteration];
    
    
end
%fprintf(fileID,'%s',allIter);

fclose(fileID);

end

