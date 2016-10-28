function [ summaryArray,uniqueArray ] = SummaryForProjection(dirName)
%SummaryForProjection will give the resultant summary for projection
%for feature size [8 16 32 64 128 192 256 320 360]
pattern = '-projection';
summaryArray = [];
featureSizes = [16 32 64 128 192 256 320 360];
featureSizes = [32];
files = dir( fullfile(dirName,'*.png') );   %list all *.png files
files = {files.name}';                      % file names

data = cell(numel(files),1);                % store file contents


for onesize = featureSizes
    fprintf('Feature selection for size: %d\n',onesize)
    count = 1;
    for i=1:numel(files)
        fname = fullfile(dirName,files{i});     % full path to file
        [pathstr, name, ~] = fileparts(fname);
        fpath = [pathstr,'\',name];
        fprintf('%d %s\n',count,fpath);
        %projectionProfiles( fpath,onesize,pattern);
        circularFeatures360( fpath,onesize,pattern );
        %circularFeatures360improved(fpath,onesize,pattern );
        %circularFeatures360FromCorners(fpath,onesize,pattern);
        %circularFeatures180FromCornersImproved(fpath,onesize,pattern);
        %pixelViseCompare(fpath,onesize,pattern);
        %circularProjection360( fpath,onesize,pattern);
        %verticalAndHorisontalDistance(fpath,onesize,pattern)
        count = count+1;
    end
    [meanis,Anorm,outputData,inputNames] = featureDifference( dirName,pattern,onesize);
    
    uniqueArray = mostUnique(Anorm,inputNames);
    
    summaryArray = [summaryArray,meanis];
    
end

return;
end

