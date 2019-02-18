% U ovom primeru, dodali smo teorijsku vrednost za BER za QPSK modulaciju
% koju cemo uporediti sa simuliranom. Nastavljamo se na video 1.

%%% u ovom primeru, videcemo kako se racuna Bit Error Rate (BER) vs. Signal
%%% to Noise Ratio (SNR) u Gausovom kanalu i kako se simulira sistem sa
%%% BPSK modulacijom
%%%%%%%%%%%%%%%%%%%%%
clear all;close all;warning off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sada cemo generisati 1000 slucajnih simbola, tj. 0 i 1
x=randint(1,100000);
%%%%%%%%%%%%%%%%%%%%%%%%%
%buduci da koristimo BPSK modulaciju u predajniku, 0 cemo mapirati u -1 dok
%1 ostaju nepromenjene
%%% potrebno je da prodjemo sve simbole, pa pravimo petlju
for i=1:length(x)
    if x(i)==1;
        xmod(i)=1;
    else
        xmod(i)=-1;
    end;
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sada cemo simulirati Gausov kanal tako sto cemo sum dodavati na
% promenljivu xmod
% Genericka funkcija u matlabu AWGN(xmod, SNR) dodaje na signal snage 0dB
% AWGN sa snagom koja je u odnosu sa snagom signala data konstantom SNR
% (Signal to Noise Ratio)
% Mi zelimo da ispitamo BER za razlicite vrednosti SNR
berSim=[];
for snr=0:2:20 %% od 0 do 20 sa korakom 2
    y=awgn(complex(xmod),snr); %% U Octave-ama rade samo bez funkcije complex
    %%%%% dobili smo izlaz iz kanala y na koji cemo primeniti metod
    %%%%% odlucivanja tako sto cemo vrednost porediti sa 0. Istovremeno
    %%%%% radimo i demodulaciju
    for i=1:length(y)
        if y(i)>=0
            det(i)=1;
        else
            det(i)=0;
            
        end;
    end;
    %%% Izracunali smo detektovanu vrednost det koju zelimo da uporedimo sa
    %%% ulaznom promenljivom x i izracunamo broj pogresnih bitova i BER
    [noe ber]=biterr(x,det);
    %%% u svakoj SNR iteraciji, racunacemo poslednju vrednost BER i
    %%% stavljamo je u promenljivu ber. Potrebno je da u neki prazan vektor
    %%% smestamo te vrednosti kako bismo ih zapamtili
    
    berSim=[berSim ber]; %% u svakoj iteraciji u prvobitno prazan vektor berSim dodaje poslednju vrednost ber
end;

% sada cemo iscrtati BER vs. SNR
snr=0:2:20
theorySer_BPSK = erfc(sqrt((10.^(snr/10)))) %% ovo je teorijska vrednost za BPSK modulaciju u AWGN kanalu
semilogy(snr,berSim,'b')
hold on
semilogy(snr,theorySer_BPSK,'g')
hold on;
grid on;
xlabel('SNR')
ylabel=('BER');
    
    
            
    
    