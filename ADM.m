
function [xn_hat,SQNR] = ADM(x,M)

%x=filter(1,[1 -0.9],randn(10000,1));

signal_sum=x(1)^2 + x(2)^2;
quant_noise=0;
%arxikes sinthikes

xq=[1 ];
k= 1.5;
xn=x(2);
y_hat_tonos_n_1 = x(1);
yn=xn - y_hat_tonos_n_1;
en=1;
Dn=[0.05 0.075];
y_hat_n=Dn(2) * en;
y_hat_tonos_n= y_hat_tonos_n_1 + y_hat_n;
xn_hat=[x(1) y_hat_n+x(1)];
xq=[xq y_hat_n*Dn(2)+xn_hat(1)];


for i=3 : length(x) 
    
    signal_sum = signal_sum + x(i)^2;
    %xn_hat = [xn x(i)]
    xn=x(i);
    y_hat_tonos_n_1 = y_hat_tonos_n;
    en_n_1=en;  
    yn=x(i)-y_hat_tonos_n_1;
    
      if (yn>0)
          en=1;
      else
          en=-1;
      end
    Dn=[Dn Dn(i-1)*k^(en_n_1*en)];
    y_hat_n = en*Dn(i);
    y_hat_tonos_n= y_hat_tonos_n_1 + y_hat_n;
    xn_hat=[xn_hat y_hat_n+xn_hat(i-1)];
    
    
    quant_noise=quant_noise+(x(i)-xn_hat(i))^2;
    signal_sum = signal_sum + x(i)^2;
    
    
    
      
end
  
aver_dist=quant_noise/(length(x));
SQNR= 10*log10(signal_sum/length(x)/aver_dist);




end