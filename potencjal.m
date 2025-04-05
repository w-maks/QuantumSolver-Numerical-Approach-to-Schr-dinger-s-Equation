%Wiktoria Maksmyiak
function [V_st] = potencjal(Nx,x,V0,d,temp)
V_st=zeros(Nx,1);
for i=1:Nx
    if temp<4
        if  abs(x(i))<=d/2
            if temp==1
                V_st(i)=-(4*V0/(d^2))*x(i)^2+V0; %skorzystanie z zaleznosci energetycznych w oscylatorze
            elseif temp==2
                V_st(i)=V0; %potencjal studni
            else
                V_st(i)=V0; %potencjał bariery
            end
        end
    else
        if x(i)>=0
            V_st(i)=V0; %potencjał skoku
        end
    end
end
end


