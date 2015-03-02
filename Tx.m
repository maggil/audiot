% Transmiter
bits = [1];
Fs = 8000;
t = 0:1/Fs: 500/Fs; % 0.1s
for i = 1:length(bits)
    signal = sin(2*pi.*(kron(bits,1000.*t)+kron(~bits,500.*t)));
end



x =  data;
nfft = 1024;
% Length of FFT
% Take fft, padding with zeros so that length(X)is equal to nfft
X = fft(x,nfft); 
X = X(1:nfft/2);
% Take the magnitude of fft of x
mx = abs(X);
% Frequency vector
f = (0:nfft/2-1)*Fs/nfft; 
% figure(1);
% plot(t,signal);
% title('Sine Wave Signal');
% xlabel('Time (s)'); 
% ylabel('Amplitude');
figure(2);
plot(f,mx);
title('Power Spectrum of a Sine Wave');
xlabel('Frequency (Hz)'); 
ylabel('Power');

%sound(signal,10000);



    