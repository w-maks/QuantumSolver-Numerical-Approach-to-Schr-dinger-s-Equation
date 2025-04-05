%Wiktoria Maksymiak
function [psi_M,prob_M,t] = psit_zwiazane(psi_w,E,M,N,poj_czy_sup,osc_czy_st)
%stale
hbar=1.05457182e-34;
e=1.60217663e-19;
%jednostki
eV=e;
%punkty siatki
Nx=801;   
Nt=181;
T_N=(2*pi*hbar/eV)/-E(N);
%dostosowywanie t w zaleznosci od przypadku
if poj_czy_sup==0
    t=linspace(0,3*T_N,Nt);
else
    if osc_czy_st==0
        t=linspace(0,15*T_N,Nt);
    else
        t=linspace(0,45*T_N,Nt);
    end
end
%wyliczanie funkcji z czescia czasowa
psi_M=zeros(Nx,Nt);
for i=1:Nt
    psi_M(:,i)=psi_w(:,M).*exp(-1i*E(M)*eV*(t(i))/hbar); 
end
prob_M=abs(psi_M).^2;
end

