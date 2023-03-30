[x,Fs] = audioread('goodsingletone.wav');

% window size
ws = 2048;

% windowed input signal
xW = x(1:ws,1);
% windowed input signal, shift buffer
xWS = xW;
% biased autocorrelation coefficents (the triangle)
r = zeros(ws,1);
% specially normalised autocorrelation coefficents (the triangle)
R = zeros(ws,1);

% for loop as long as window size, shift buffer by 1
% each itteration

for i = 1:ws
% biased = sum(input .* shifted)    
r(i) =  sum(xW(i:end) .* xWS(i:end));
% specially normalised = 2* sum(input .* shifted) / sum(input^2 + shifted^2)   
R(i) = (2*sum(xW(i:end) .* xWS(i:end))) ./ sum(pow2(xW(i:end)) .* pow2(xWS(i:end))) ;
% shift along by one samples
xWS = circshift(xWS,1);
end

pks = findpeaks(R,'minpeakdistance',100);
m=mean(pks);
[pks,locs] = findpeaks(R,'minpeakheight',m/2);
freq = (Fs / mean(diff(locs))) / 2;

figure;
plot(r);
title('Biased Auto correlation');
xlabel('Time in samps');
ylabel('Biased Autocorrelation Coefficent');
figure;
plot(R)
title('SNAC')
xlabel('Time in samps');
ylabel('Normalised Autocorrelation Coefficent');
figure;
plot(xW);
title('Windowed Input Signal')
xlabel('Time in samps');
ylabel('Amplitude');
soundsc(xW,Fs);

