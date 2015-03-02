clear all;

%We will assign 4 frequences for 00, 01, 10, 11
Fs = 8000;
T_bit = 0.3 ;
t = 0:1/Fs:T_bit; 
length_t = length(t);
symbols = [0 1 2 3 2 1 0 1 2 3 2 1 0];%0 1 2 3 2 1 0];
           %0 1 2 3 2 1 0 1 2 3 2 1 0 1 2 3 2 1 0];
%start and end flag;
flag_t = 0:1/Fs:0.2;
flag =  cos(2*pi*flag_t*3600);
data = zeros(1,length_t*length(symbols));

zero_freq = [1100 1400];
one_freq = [1700 2000];
two_freq = [2300 2600];
three_freq = [2900 3200];
counter = 0;

for i = 1:length(symbols)
    y = zeros(1,length_t);
    if(symbols(i) == 0)
        y = cos(2*pi*(zero_freq(counter+1))*t) + y;
    elseif(symbols(i) == 1)
        y = cos(2*pi*(one_freq(counter+1))*t) + y;
    elseif(symbols(i) == 2)
        y = cos(2*pi*(two_freq(counter+1))*t) + y;
    elseif(symbols(i) == 3)
        y = cos(2*pi*(three_freq(counter+1))*t) + y;
    end
    counter = ~counter;
    data(1,1+(i-1)*length_t:i*length_t) = y;
end

signal = [flag,data,flag];
soundsc(signal, Fs);

%soundsc(flag, Fs);
% flag(start and stop) = 3000;


