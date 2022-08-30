function [y] = echo_sfx(x,fs,amt,additive)

if nargin<3
    amt=0.03;
    additive=false;
else if nargin<4
    additive=false;        
end
y=zeros(length(x)+ceil(amt*fs),2);
if additive == true
    % Reverb Algorithm I
    y(1:length(x),:)=x;
    y(1+ceil(amt*fs):end,:)=y(1+ceil(amt*fs):end,:)+0.2*x;
else
    % Reverb Algorithm II (Better)
    y(1:length(x),1)=x(:,1);
    y(1+ceil(amt*fs):end,2)=x(:,2);
end 

end

