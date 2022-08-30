function [y] = surround_sfx(x,fs,amt)
if nargin<3
    amt=12;
end
y=x;
whos y fs
olp=amt/2;
gauss=0.75+0.25*sin(2*pi/amt/fs.*(1:amt*fs))';
%plot(gauss)
gauss1=repmat(gauss,[floor(length(y(:,1))/length(gauss)) 1]);
gauss2=repmat(gauss,[floor(length(x((amt-olp)*fs+1:end,2))/length(gauss)) 1]);
y(1:length(gauss1),1)=x(1:length(gauss1),1).*gauss1;
y((amt-olp)*fs+1:(amt-olp)*fs+length(gauss2),2)=x((amt-olp)*fs+1:(amt-olp)*fs+length(gauss2),2).*gauss2;

end

