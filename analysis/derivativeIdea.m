clc
close all
clear
% Load the samples
path = 'C:\Users\Peter\Documents\REAPER Media\Tromba Recordings 2\9Dec\';
[noRattle fs] = audioread([path 'bridgeOff.wav']);
[Rattle fs] = audioread([path 'BridgeOn.wav']);
% G3 notes
G3nr = noRattle(8.6*10^5:10.5*10^5);
G3nr = G3nr/max(abs(G3nr));
G3r = Rattle(1.19*10^6:1.29*10^6);
G3r = G3r/max(abs(G3r));
% Add 10 times the gradient
fakeG3r = 10*gradient(G3nr)+G3nr;
fakeG3r = fakeG3r/max(abs(fakeG3r));

figure(1)
plot(G3nr,'g');
hold on;
plot(G3r,'b');
plot(fakeG3r,'r');
title('Gradient Addition G3');
legend('No Bridge Action','Bridge Action','Gradient Addition Model');
audiowrite('G3nr.wav',G3nr,fs);
audiowrite('G3r.wav',G3r,fs);
audiowrite('fakeG3r.wav',fakeG3r,fs);

% C2
C2r = Rattle(3.4*10^6:3.5*10^6);
C2r = C2r/max(abs(C2r));
C2nr = noRattle(4.5*10^5:8*10^5);
C2nr = C2nr/max(abs(C2nr));
% Add 10 times the gradient
fakeC2r = 10*gradient(C2nr)+C2nr;
fakeC2r = fakeC2r/max(abs(fakeC2r));

figure(2)
plot(C2nr,'g');
hold on;
plot(C2r,'b');
plot(fakeC2r,'r');
title('Gradient Addition C2');
legend('No Bridge Action','Bridge Action','Gradient Addition Model');
audiowrite('C2nr.wav',C2nr,fs);
audiowrite('C2r.wav',C2r,fs);
audiowrite('fakeC2r.wav',fakeC2r,fs);

% Bb
Br = Rattle(2.3*10^6:2.4*10^6);
Br = Br/max(abs(Br));
Bnr = noRattle(3.3*10^6:3.54*10^6);
Bnr = Bnr/max(abs(Bnr));
% Add 10 times the gradient
fakeBr = 10*gradient(Bnr)+Bnr;
fakeBr = fakeBr/max(abs(fakeBr));

figure(3)
plot(Bnr,'g');
hold on;
plot(Br,'b');
plot(fakeBr,'r');
title('Gradient Addition Bb');
legend('No Bridge Action','Bridge Action','Gradient Addition Model');
audiowrite('Bnr.wav',Bnr,fs);
audiowrite('Br.wav',Br,fs);
audiowrite('fakeBr.wav',fakeBr,fs);

% pluck
pr = Rattle(2.17*10^5:4*10^5);
pr = pr/max(abs(pr));
pnr = noRattle(.97*10^5:4*10^5);
pnr = pnr/max(abs(pnr));
% Add 10 times the gradient
fakepr = 10*gradient(pnr)+pnr;
fakepr = fakepr/max(abs(fakepr));

figure(4)
plot(pnr,'g');
hold on;
plot(pr,'b');
plot(fakepr,'r');
title('Gradient Addition pluck');
legend('No Bridge Action','Bridge Action','Gradient Addition Model');
audiowrite('pnr.wav',pnr,fs);
audiowrite('pr.wav',pr,fs);
audiowrite('fakepr.wav',fakepr,fs);
