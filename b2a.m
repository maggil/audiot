function b2a(input, file)

%input is an array of elements x such that x = {0, 1, 2, 3}.
output = zeros(numel(input)/4, 1);

%decoder array
decoder = containers.Map('KeyType', 'double', 'ValueType', 'char');
decoder(0) = '00';
decoder(1) = '01';
decoder(2) = '10';
decoder(3) = '11';

for i = 0:numel(input)/4-1
    num = bin2dec(strcat(decoder(input(i*4+1)),decoder(input(i*4+2)),decoder(input(i*4+3)),decoder(input(i*4+4))));
    output(i+1) = num;
end

%open file to write
fileID = fopen(file, 'w');
fwrite(fileID, output);
fclose('all');