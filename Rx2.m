clear all
clc
Fs = 8000;
T = 0.2; % Time per bit

r = audiorecorder(Fs, 16, 1);

num_sample = Fs*T+1; % Per bit
recordtime = 6; % Recording duration

recordblocking(r,recordtime);
data= getaudiodata(r);
threshold = 0.1; % magnitude

[pk, loc] = findpeaks(data);
index = find(pk>threshold);
i = loc(index(1));
% sum = 0;
% counter = 0;
% for i = 1:length(data)
%     counter = counter + 1;
%     sum = sum + abs(data(i));
%     if(sum >= threshold)
%         break;
%     end
%     if(counter == num_sample/2)
%         sum = 0;
%         counter = 0;
%     end
%     
% end
num_bit_del = ceil(i/num_sample);
nrow = recordtime/T-num_bit_del;

rel_data = data(i:(recordtime/T-num_bit_del)*(num_sample)+i-1); % delete the 1st portion& last portion
da = reshape(rel_data,[num_sample,nrow])';


nfft = 1024;
FT = zeros(nrow,nfft/2);

 for j = 1:nrow
    temp(1:nfft) = fft(da(j,1:nfft),nfft); 
    X = temp(1:nfft/2);
% Take the magnitude of fft, of x
    FT(j,1:nfft/2)= abs(X);
 end
 % Find the frequency has highest amplitude
 freq = zeros(1,nrow);
 for k = 1:nrow
     [M, freq(k)] = max(FT(k,1:nfft/2));
 end
  test = freq;
 % Filter out redundant frequency
 h = 1;
 le = length(freq);
 actual_freq = (Fs/nfft)*freq;
 h = 1;
 while h < le
     if(abs(freq(h) < freq(h+1)) < 5)
         freq(h) = [];
         le = le-1;
     end
     h = h+1;
 end

 
 
 while h ~= le
     if(abs(freq(h)-freq(h+1)) < 5) % 5 is threshold
         freq(h) = [];
         le = le-1;
     elseif (abs(freq(h)-freq(h+1)) >= 5)
         h = h+1;
     end
 end
 
 % Decode to integer
 result = (Fs/nfft)*freq;
 int_dec = zeros(1,length(freq));
 for l = 1:length(freq)
     if (result(l) < 1550)
         int_dec(l) = 0;
     elseif (result(l) >= 1550 && result(l) < 2150)
         int_dec(l) = 1;
     elseif (result(l) >= 2150 && result(l) < 2750)
         int_dec(l) = 2;
     elseif (result(l) >= 2750 && result(l) < 3350)
         int_dec(l) = 3;
     elseif (result(l) >= 3350)
         int_dec(l) = 4; % flag
     end
 end
 
int_dec
 %Plot the FFT
  f = (0:nfft/2-1)*Fs/nfft; 
figure(1) % create new figure
subplot(3,2,1) % first subplot
plot(f,FT(1,1:nfft/2));
grid
title('Power Spectrum of a Sine Wave 1');
xlabel('Frequency (Hz)'); 
ylabel('Power');
subplot(3,2,2) % first subplot
plot(f,FT(2,1:nfft/2));
grid
title('Power Spectrum of a Sine Wave 2');
xlabel('Frequency (Hz)'); 
ylabel('Power');
subplot(3,2,3) % first subplot
plot(f,FT(3,1:nfft/2));
grid
title('Power Spectrum of a Sine Wave 3');
xlabel('Frequency (Hz)'); 
ylabel('Power');
subplot(3,2,4) % first subplot
plot(f,FT(4,1:nfft/2));
grid
title('Power Spectrum of a Sine Wave 4');
xlabel('Frequency (Hz)'); 
ylabel('Power');
subplot(3,2,5) % first subplot
plot(f,FT(4,1:nfft/2));
grid
title('Power Spectrum of a Sine Wave 5');
xlabel('Frequency (Hz)'); 
ylabel('Power');
subplot(3,2,6) % first subplot
plot(f,FT(4,1:nfft/2));
grid
title('Power Spectrum of a Sine Wave 6');
xlabel('Frequency (Hz)'); 
ylabel('Power');

