pkg load communications;
x=1:8;
p=[0.35 0.25 0.12 0.1 0.08 0.06 0.03 0.01];
dict=huffmandict(x,p);% formiranje recnika za svaki od simbola
%I=-log(p);
%H=-sum(log2(p+(p==0)));
sig=randsrc(100,1,[x; p]);%generisanje niza od 100 slucajnih elemenata
comp=huffmanenco(sig,dict); % kompresija pomocu huffmanovog kodera
dsig=huffmandeco(comp,dict);%dekompresija pomocu huffmanovog dekodera
isequal(sig,dsig')%provera da li su kodirani i dekodirani signal jednaki
binarySig=de2bi(sig);% konverzija iz dekadnog u binarni originalnog niza
binaryComp=de2bi(comp); % konverzija iz dekadnog u binarni kompresovanog niza
lpre=numel(binarySig);% broj bita originalnog niza
lposle=numel(binaryComp);% broj bita kompresovanog niza
disp(lpre);
disp(lposle);