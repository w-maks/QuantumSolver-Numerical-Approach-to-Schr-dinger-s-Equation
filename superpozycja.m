%Wiktoria Maksymiak
function [psi_MN,prob_MN] = superpozycja(psi_M,psi_N)
c1=2; 
c2=5;
A=c1^2+c2^2; 
c1=c1/sqrt(A); 
c2=c2/sqrt(A);
psi_MN =c1.*psi_M+c2.*psi_N;
prob_MN=abs(psi_MN).^2;
end

