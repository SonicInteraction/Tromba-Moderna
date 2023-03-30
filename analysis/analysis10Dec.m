clc
clear
close all;
% open File
file='BridgeOn';
path='C:\Users\Peter\Documents\REAPER Media\Tromba Recordings 2\9Dec\';
[sound2 fs] = audioread([path file '.wav']);
% take 4 second chunks
rem=mod(length(sound2),fs*4);
sound2=sound2(1:length(sound2)-rem);
% normalise and remove dc offset
sound2=sound2-mean(sound2);
sound2=sound2/max(sound2);
temp=[];
% markers are points of interest in sound files, found by audition
markers = [44104 132301 444001];
% set up appropriate names for sound clips
names = {'Bowed Open String'...
    'Second Harmonic Bowed' 'Third Harmonic Bowed'}; 
% plot and save the samples as .8 second clips at the marker points, also
% plot the periodgram (power spectral density) graph. Finally plot close
% ups of the wave plots
for i = 1:length(markers);
    close all;
    temp=sound2(markers(i):markers(i)+(0.8*fs));
   
    h = figure;
    plot(temp); 
    hold on;
    xlim([0 fs*0.8])
    title(sprintf([names{i} ' Bridge Off DSP On']));
    xlabel('Time in Samples');
    ylabel('Amplitude');
    saveas(h,sprintf([names{i} 'Bridge-Off-DSP.jpg']));
    saveas(h,sprintf([names{i} 'Bridge-Off-DSP.fig']));
    audiowrite(sprintf([names{i} 'Bridge-Off-DSP.wav']),temp,fs);
    hold off;
    clear h;
   
    [P,F] = periodogram(temp,hamming(length(temp)),length(temp),fs,'power');
	h=figure;
    plot(F,P,'r');
    hold on;
    title(sprintf([names{i} 'Bridge Off DSP on Periodgram']));
    xlabel('Frequency');
    ylabel('Power');
    set(gca,'xlim', [0 0.15*10^4]);
    saveas(h,sprintf([names{i} 'DSP-Bridge-Off-periodgram.jpg']));  
    saveas(h,sprintf([names{i} 'DSP-Bridge-Off-periodgram.fig']));  
    hold off;
    clear h;
    

    temp=sound2(markers(i)+(fs*.2):markers(i)+(fs*.2)+3000);
    h = figure;
    plot(temp); 
    hold on;
    title(sprintf([names{i} ' Bridge Off DSP Close Up']));
    xlabel('Time in Samples');
    ylabel('Amplitude');
    xlim([0 3000]);
    saveas(h,sprintf([names{i} 'Close-up-Bridge-Off-DSP-on.jpg']));
    saveas(h,sprintf([names{i} 'Close-up-Bridge-Off-DSP-on.fig']));
    hold off;
    clear h;
end
close all;

