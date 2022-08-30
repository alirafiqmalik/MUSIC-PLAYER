function y = muffle_sfx(x,fs)
%UNTITLED6 Summary of this function goes here
bp=fir1(88,2000/fs);
dat1=filter(bp,1,x(:,1));
y=[dat1,filter(bp,1,x(:,2))];
end

