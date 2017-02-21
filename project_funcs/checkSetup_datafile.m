function [  ] = checkSetup_datafile(selectedFile)
%Checks whether an inputted file name has a valid extension, if not then it
%returns and error message.
%Inputs:    selectedFile = a file name (including extension)

[path,file,ext] = fileparts(selectedFile);

if ~strcmp('.RAW', ext) & ~strcmp('.set', ext)
    error('The file you''ve selected to load isn''t a valid file type for this software. Please check the README for supported file formats')
end

end

