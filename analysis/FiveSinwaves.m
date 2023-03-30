clear all
close all
clc

path = 'C:\Users\Peter\Documents\MATLAB\Project Work\';
Gopen = 'goodclean1.wav';

[noRattle fs] = audioread('3rdHarmonicNoRattle.wav');
[Rattle fs] = audioread('3rdHarmonicRattle.wav');

% remove DC

noRattle=noRattle-mean(noRattle);
Rattle=Rattle-mean(Rattle);

% Start at a point where there is a good signal from both waves
noRattle=noRattle((fs*.4):end);
Rattle=Rattle((fs*.4):end);
noRattle=noRattle/max(noRattle);
Rattle=Rattle/max(Rattle);
% invert signal
noRattle = -1*noRattle;
% Farly succsesful plot of clean bridge and model using first 5 partial
% sine waves.  Incomplete attempt to model rattly sound

phase1=10;
% set variables
f=187;
start=8860;
l=[0:50000];
% partial 1  - accounts for least part of the first 3
phi1=1.1*pi;
pdist1=1;
A1=0.8;
% partial 2  - second place
phi2=0*pi;
pdist2=1;
A2=5;
% partial 3  - third place
phi3=0.1*pi;
pdist3=1;
A3=3;
% partial 4  - equal fourth place
phi4=0*pi;
pdist4=1;
A4=0.5;
% partial 5  - equal fourth place
phi5=0*pi;
pdist5=1;
A5=0.5;

figure(6)
% plot(Rattle(start-phase1:start+1000-phase1),'r');
hold on;
plot(noRattle(start:start+1000),'g');

% partial functions
% partial 1
x1=A1*sin((2*pi*f/fs*l)+phi1);
% plot(x1,'b-.')
% partial 2
x2=A2*sin((2*pi*f*2/fs*l)+phi2);
for i=1:length(l);
    if x2(i)<0;
        x2(i)=x2(i)*.4;
    else
        x2(i)=x2(i)*1;
    end
end

% plot(x2,'c--')
% partial 3
x3=A3*sin((2*pi*f*3/fs*l)+phi3);
% plot(x3,'m.-');
% partial 4
x4=A4*sin((2*pi*f*4/fs*l)+phi4);
% plot(x4,'r--');
% partial 4
x5=A5*sin((2*pi*f*5/fs*l)+phi5);
% plot(x5,'r-.');




y=x1+x2+x3+x4+x5;
y=y./max(y);



plot(y,'k');
legend('No Rattle','5 sin waves, weighted, with phase and -ve clipping');
title('5 sine waves modeling wave contour');
set(gca,'xlim', [0 1000],'ylim',[-1 1]);
line([1000 0], [0 0],'col','k','LineStyle','--');
xlabel('Time in Samples');
ylabel('Amplitude');