%Accept input arguments.
function [qarr]=a2b(input)

%Read input file.
fileID = fopen(input, 'r');
array = fread(fileID);

%Convert to binary and then quaternary.
quaternary = zeros(1, numel(array)*4);

%key encoder.
coder = containers.Map;
coder('00') = 0;
coder('01') = 1;
coder('10') = 2;
coder('11') = 3;

%Put quaternary represenation into output array.
for i = 0:numel(array)-1
   char = array(i+1);
   str = dec2bin(char, 8);
   quaternary(i*4+1) = coder(str(1:2));
   quaternary(i*4+2) = coder(str(3:4));
   quaternary(i*4+3) = coder(str(5:6));
   quaternary(i*4+4) = coder(str(7:8));
end

%close file.
fclose('all');

%return value
qarr = quaternary;

