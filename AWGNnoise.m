clear all
close all
clc
x=-10:0.1:10;
mu=0;
sigma=1;
noise=1/(sqrt(2)*pi*sigma)*exp(-(x-mu).^2/(2*pi*sigma).^2);%% Gausova fynkcija

%plot(x,noise);
awgn=randn(1,10^6);% generisanje belog gausovog ?uma

[y,x]=hist(awgn,100)
plot(x,y)
%%autokorelaciona funkcija

 [acor,lag] = xcorr(awgn,'bias');
 figure(2)
 plot(lag,acor)
 
 %% generisanje PSD, tj. Furijeova transformacija autokorelacione funkcije
 psd=fft(acor);
 figure(3)
 plot(10*log10(abs(psd)))
 

 %%% SNR i Eb/No (Eb je energija po bitu, a No je PSD)Komunikacioni sistem
 %Generi?emo signal
 
 signal=randn(1,10);
 mean(mean((signal).^2))
 %%
 %%S/N=2*Eb/No*K*(fs/Bw) K broj bita potreban za prenos signala
  %%SNRdB=3+EbNodB+10log10(K)% u decibelima
 
 signali=2*(randn(1,10^5)>0.5)-1;
 signalq=2*(randn(1,10^5)>0.5)-1;
 signal=complex(signali,signalq);
 pSignal=mean(abs(signal).^2)
 eSignal=(abs(signal).^2)
 
 
 %% dodavanje suma
 for snr=0:1:10% dB
     snrlin=10^(snr/10)
     var=snrlin/pSignal;
     noise=1/sqrt(2)*randn(1,10^5)+j*randn(1,10^5)*var;
     addNoise=signal+noise
 end
     
 