
function y=BPF(N,x,Fs,Fstop1,Fstop2,Apass)

%Fs Sampling Frequency
%N% Order
%Fstop1 First Stopband Frequency
%Fstop2 Second Stopband Frequency
%Astop  Stopband Attenuation (dB)
%Apass  Passband Attenuation (dB)

b=fir1(N,[Fstop1/(Fs/2) Fstop2/(Fs/2)],'bandpass');
y=(10^(Apass/10))*filter(b,1,x);


