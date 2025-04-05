%Wiktoria Maksymiak
function [psi_w,ro_square,V_st,E,n,x] = psi_zwiazane(V0,d,temp)
%stale fizyczne
hbar=1.05457182e-34;
me=9.1093837e-31;
e=1.60217663e-19;
%jednostki
nm=1e-9; 
eV=e;
%zmienne przestrzenne
Nx=801;               
xmin=-d; 
xmax=d;  
x=linspace(xmin,xmax,Nx);
dx=x(2)-x(1);
%stala
C=-hbar^2/(2*me*nm^2*eV); 
%tworzenie potencjalu
V_st=potencjal(Nx,x,V0,d,temp);
V=zeros(Nx-2);
%tworzenie macierzy potencjalu
for i=1:(Nx-2)
    V(i,i)=V_st(i+1);
end
%budowanie wspolczynnikow przy rozniczce 2 rzedu
K=eye(Nx-2,Nx-2)*(-2);
for i=1:(Nx-3)
    K(i,i+1)=1;
    K(i+1,i)=1;
end
K=K/dx^2;
%budowanie hamiltonianu
H=C*K+V;
%znajdywanie funkcji i wartosci wlasnych
[psi_x,En_x]=eig(H);
%znajdowanie energii wiazacych
if temp
zm=0;
n=1;
while zm==0
    E(n)=En_x(n,n);
    if E(n)>0 
        zm=1; 
    end 
    n=n+1;
end  
E(n-1)=[];  %usuniecie ostatniej wartosci, ktora bedzie dodatnia
n=n-2;      %okreslenie ilosci takich funkcji
%wybranie odpowiadajacych tym energia funkcji falowych
psi_w=zeros(Nx,n);
pole=zeros(1,n);
for i=1:n
    psi_w(:,i)=[0; psi_x(:,i); 0];
    pole(i)=calka((psi_w(:,i).*psi_w(:,i))',xmin,xmax);
end 
%normalizacja
psi_w=psi_w./sqrt(pole);
%gestosc prawdopodobienstwa dla potencjalu niezaleznego od czasu
ro_square =psi_w.*psi_w;
end

