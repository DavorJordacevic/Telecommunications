
%% U ovom primeru smo modifikovali BPSK u QPSK 
%%%%%%%%%%%%%%%%%%%%%
clear all;close all;warning off;

N=10000;
x= (2*(rand(1,N)>0.5)-1) + j*(2*(rand(1,N)>0.5)-1); %% slucajna promenjiva koju smo modifikovali
%%%%%%%%%%%%%%%%%%%%%%%%%
%buduci da koristimo QPSK modulaciju u predajniku, 
%mapiracemo simbole na sledeci nacin (u BPSK 0->-1, a 1->1). sada mapriamo
%po dva bita na sledeci nacin

%00->-1-1*j
%01->-1+1*j
%10-> 1-1*j
%11-> 1+1*j
for snr=1:20 %% od 0 do 20 sa korakom 2
    y=awgn(complex(x),snr); %% U octave rade samo bez funkcije complex
    %%%%% dobili smo izlaz iz kanala y na koji cemo primeniti metod
    %%%%% odlucivanja tako sto semo vrednost porediti sa 0. Istovremeno
    %%%%% radimo i demodulaciju
    y_re=real(y);
    y_im=imag(y);
    %% vracamo modulisane vrednosti u originalne
    det(find(y_re < 0 & y_im < 0)) = -1 + -1*j; 
    det(find(y_re >= 0 & y_im > 0)) = 1 + 1*j; 
    det(find(y_re < 0 & y_im >= 0)) = -1 + 1*j; 
    det(find(y_re >= 0 & y_im < 0)) = 1 - 1*j; 

    %%%
    nErr(snr) = size(find([x- det]),2); % couting the number of errors end sim
   Ser_QPSK = nErr/N; 
  end;
  
% sada cemo iscrtati BER vs. SNR
snr=1:20
theorySer_QPSK =(1/4)* erfc(sqrt(0.5*(10.^(snr/10)))) - (1/4)*(erfc(sqrt(0.5*(10.^(snr/10))))).^2;  %% ovo je teorijska vrednost za BPSK modulaciju u AWGN kanalu

semilogy(snr,Ser_QPSK,'b');
hold on
semilogy(snr,theorySer_QPSK,'g');
hold on;
grid on;
xlabel('SNR')
ylabel=('BER');
    