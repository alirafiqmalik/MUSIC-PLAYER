
function y=LPF(N,x,Fs,Fstop,Apass)

%Fs Sampling Frequency
%N% Order
%Fstop  Stopband Frequency
%Astop  Stopband Attenuation (dB)
%Apass  Passband Attenuation (dB)
a=fir1(N,Fstop/(Fs/2),'low');
y=(10^(Apass/10))*filter(a,1,x);

