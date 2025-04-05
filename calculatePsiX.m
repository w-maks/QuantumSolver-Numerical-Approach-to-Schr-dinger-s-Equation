%Ewelina Borkowska
%FUNKCJA FALOWA
function [psi_X,psi_T,xR,psi_X_odbita]= calculatePsiX(E_ev, V_ev)
X=linspace(-1,1,155000);%[nm]
x=1e-9.*X; %[m]
%os x od -1 do 1
if E_ev==V_ev
     E_ev=V_ev-0.01;
end
%STAŁE I ZAMIANA JEDNOSTEK---------------------------------------------
E=1.6021766208e-19*E_ev; %[J]
V=1.6021766208e-19*V_ev; %[J]
m_e=9.10938291e-31; %[kg]
e=1.6021766208e-19; %[C]
h=6.626070040e-34;
h_k=h/(2*pi); % h kreslone
k_1=sqrt(2*m_e*E)/h_k; %[1/m]

%DO ANIMACJA---------------------------------------------------
w=E/h_k;   %czestosc -> E=h_k*w
T=2*pi/w;  %okres
nT=110;
t=linspace(0,1*T,nT);
psi_T=exp(-1i*w*t); %FUNCKJA FALOWA ZALEZNA OD CZASU
U_ev = zeros(size(X));
    for i = 1:numel(X)
            U_ev(i)=potencjal_skok(X(i),V_ev); %potencjal [ev]
    end
U=1.6021766208e-19*U_ev;

%--------------------
  u0=[1,1i*k_1];  %warunki początkowe
  options=odeset('RelTol',1e-6);
  [xR,u] = ode45(@row_skoku, flip(x), u0, options);
    psi_X=u(:,1);
 
if E_ev <= V_ev
    % Dla E<V całkowite odbicie
    R_point = 1;
else
    % Dla E>=V
    R_point = ((sqrt(E) - sqrt(E-V))/(sqrt(E) + sqrt(E-V)))^2;
end

psi_X_odbita=zeros(size(psi_X));
  for i = 1:length(xR)
        if xR(i) < 0
            % odbita
            psi_X_odbita(i) =R_point * exp(1i * k_1 * xR(i));   
        end
  end


function U_ev=potencjal_skok(x,V)
        if x>0
            U_ev=V;
        else
            U_ev=0;
        end
end

function du=row_skoku(x,u)
  U=potencjal_skok(x,V);
  y=u(1);
  yd=u(2);
  du=zeros(2,1);
  du(1)=yd;
  du(2)=-(2*m_e/(h_k*h_k))*(E-U)*y;

end
end
