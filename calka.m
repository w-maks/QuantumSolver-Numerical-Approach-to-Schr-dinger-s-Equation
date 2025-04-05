%Wiktoria Maksymiak
function integral = calka(f,a,b)
%calkowanie metoda simpsona 1/3
l=length(f);               
if mod(l,2)==1
    wsp=2*ones(l,1);
    wsp(2:2:l-1)=4;
    wsp(1)=1;
    wsp(l)=1;
    h = (b-a)/(l-1);
    integral=(h/3)*f*wsp;
else
    integral='dlugosc musi byc nieparzysta wielkoscia';
end
