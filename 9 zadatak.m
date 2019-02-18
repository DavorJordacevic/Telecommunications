function H = ComputeEntropy(s)  
if (ischar(s)==1)    % Proverava da li je uneti string ispravan
l=length(s);
uniqueChars = unique(s);   % sortiranirazlicitikarakteri
lenChar=length(uniqueChars);
f=zeros(1,lenChar);
for i=1:lenChar
    f(i)=length(findstr(s,uniqueChars(i)));  % Broj pojavljivanja jedinstvenih karaktera 
end
p=zeros(1,lenChar);
for i=1:lenChar
    p(i)=f(i)/l;       %  verovatnoce od jedinstvenih karaktera
end
H=0;
for  i=1:lenChar
    H = H + (-p(i)*log2(p(i)));  % Racunanje entropije
end 
else
    disp('Invalid String');
end
