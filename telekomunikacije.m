clear all;
clc;
pkg load communications

SNRdB = 0:1:10
M=4
%MQAM
%theoretical BER of AWGN channel
tBer_4QAM = (4/log2(M))*(1-1/sqrt(M))*erfc(sqrt(3*log2(M)*(10.^(SNRdB/10)))/((M-1)*sqrt(2)));

%MPSK
%M=2
tBer_bpsk = 0.5*erfc(sqrt(10.^(SNRdB/10))); %theoretical ber of bpsk
%M>=4
tBer_4psk = (1/log2(M))*erfc(sqrt(log2(M)*10.^(SNRdB/10))*sin(pi/log2(M)));
%theoretical ber of 
%MFSK

tBer_4fsk = (M-1)/2*erfc(sqrt(log2(M)*10.^(SNRdB/10))/2)
SNR = 10.^(SNRdB/10);

M = 8
%MQAM
%theoretical BER of AWGN channel
tBer_8QAM = (4/log2(M))*(1-1/sqrt(M))*erfc(sqrt(3*log2(M)*(10.^(SNRdB/10)))/((M-1)*sqrt(2)));

%MPSK
%M>=4
tBer_8psk = (1/log2(M))*erfc(sqrt(log2(M)*10.^(SNRdB/10))*sin(pi/log2(M)));
%theoretical ber of
%MFSK

tBer_8fsk = (M-1)/2*erfc(sqrt(log2(M)*10.^(SNRdB/10))/2)

semilogy(SNRdB,tBer_4QAM,'yd-','linewidth',3);
hold on
semilogy(SNRdB,tBer_bpsk,'k-','linewidth',4);
hold on
semilogy(SNRdB,tBer_4psk,'p-','linewidth',2);
hold on
semilogy(SNRdB,tBer_4fsk,'r-','linewidth',2);
hold on
semilogy(SNRdB,tBer_8QAM,'b-','linewidth',3);
hold on
semilogy(SNRdB,tBer_8psk,'c-','linewidth',2);
hold on
semilogy(SNRdB,tBer_8fsk,'m-','linewidth',2);

legend('theoretical 4qam','theoretical BPSK','theoretical 4-PSK','theoretical 4FSK','theoretical 8QAM','theoretical 8-PSK','theoretical 8-FSK');
xlabel('SNRdB')
ylabel('BER')
title('BER vs SNR psk,qam,fsk comparison')