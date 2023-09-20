function ExerciseOne
fs = 10000;
t = 0:1/fs:0.15;
%mt = zeros(length(t));
index = 1;
for i = 0:1/fs:0.15
    if (i <= 0.05)
        mt(index) = 4*sinc(200*i) + (10*i);
    elseif (i >= 0.05 && i <= 0.1)
        mt(index) = 4*sinc(200*i) + (1 - 10*i);
    else
        mt(index) = 0;
    end
    index = index + 1;
end
Mf = fftshift(fft(mt));
n = length(mt) - 1;
df = fs/n;
f = -fs/2:df:fs/2;

figure(1)
plot(t,mt);
xlim([0 0.12])

figure(2)
plot(f,abs(Mf)/(length(Mf) - 1));
xlim([-800 800])
end