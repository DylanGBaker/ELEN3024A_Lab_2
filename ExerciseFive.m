function ExerciseFive
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