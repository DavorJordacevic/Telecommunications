clear all;
%%%%%%%%Matlab i Octave razlika-Kada se radi u Octave mora da se doda pket
%%%%%%%%communications, tj. naredba 'pkg load communications' i pri
%%%%%%%%generisanju gausovog ?uma,ne stavlja se kompleksna vrednost 
x = randint(1, 1000);  %generi?emo slu?ajne promenjive 

xkodovano = encode(x, 7, 4, 'hamming/binary'); %kodujemo ih Hemmingovim kodom (7,4)
%%mapping (BPSK modulacija)
for i=1:length(xkodovano)
    if xkodovano(i)==1;
       xkodovano(i)=1;
    else
    xkodovano(i)=-1;
    end;
end;

berSim = [];
%% za razli?ite vrednosti SNR, dodajemo beli Gausov ?um
for snr=0:1:20
    y = awgn(complex(xkodovano), snr);
    
    %%% odlu?ivanje i demodulacija
    for i=1:length(y)
        if(y(i) >= 0)
            det(i) = 1;
        else
            det(i) = 0;
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%dekodujemo pomo?u Hemmingovog dekodera
    xdekodovano = decode(det, 7, 4, 'hamming/binary');
    [noe ber] = biterr(x, xdekodovano);   
    berSim = [berSim ber];
end

%%%%%%%%%%%%%poredimo slu?aj iz predhodnog primera kada nemamo Hemmingov
%%%%%%%%%%%%%dekoder
%%%%%%%%%%%bez kodovanja

for i=1:length(x)
    if x(i)==1;
        xmod(i)=1;
    else
        xmod(i)=-1;
    end;
end;
berSim1=[];
for snr=0:1:20;
    y1=awgn(complex(xmod),snr); %adds white Gaussian noise to X.? The SNR is in dB.
    %The power of X is assumed to be 0 dBW.? If X is complex, then awgn adds complex noise
    %scatterplot(y)
    for i=1:length(y1)
        if y1(i)>=0
            det1(i)=1;
        else
            det1(i)=0;
        end
    end
    [noe ber1]=biterr(x,det1);
    berSim1=[berSim1 ber1];
end
snr=0:1:20;
semilogy(snr,berSim,'g');
hold on;

semilogy(snr,berSim1);%%%%%%%%bez kodovanja
grid on;

xlabel('SNR');
ylabel('BER');

    
    
    
    
