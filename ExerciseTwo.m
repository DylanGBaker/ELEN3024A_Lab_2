function ExerciseTwo
fs = 50000;
t = 0:1/fs:0.2;
index = 1;
for i = 0:1/fs:0.2
    if (i <= 0.05)
        mt(index) = 4*sinc(200*i) + (10*i);
    elseif (i >= 0.05 && i <= 0.1)
        mt(index) = 4*sinc(200*i) + (1 - 10*i);
    else
        mt(index) = 0;
    end
    index = index + 1;
end

%figure(11)
%obw(mt,fs)

fc = 2000;
Kf = 999;

ut = fmmod(mt,fc,fs,Kf);

ut = 2 * ut;

figure(10)
obw(ut,fs)

figure(1)
plot(t,ut);
xlim([0 0.01])

demod_ut = fmdemod(ut,fc,fs,Kf);

figure(2)
plot(t,demod_ut);
xlim([0 0.1])

Uf = fftshift(fft(ut));
n = length(ut) - 1;
df = fs/n;
f = -fs/2:df:fs/2;

figure(3)
plot(f,abs(Uf)/(length(Uf) - 1));

noise = wgn(1, length(ut), 0.01,'linear');
filtered_noise = bandpass(noise, [1000 1750], fs);

ut_with_noise = ut + filtered_noise;

figure(3)
plot(t, ut_with_noise);


demod_noise_ut = fmdemod(ut_with_noise, fc, fs, Kf);
figure(4)
plot(t, demod_noise_ut);
title("demodulated with noise")
end