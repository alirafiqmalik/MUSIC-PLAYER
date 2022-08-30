function y=HPF(N,x,Fs,Fstop,Apass)

%Fs = 48100;  % Sampling Frequency
%N     = 30;     % Order
%Fstop = 16000;  % Stopband Frequency

b=fir1(N,Fstop/(Fs/2),'high');
y=(10^(Apass/10))*filter(b,1,x);

end
