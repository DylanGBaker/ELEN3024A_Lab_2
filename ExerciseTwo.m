function ExerciseTwo
fs = 20000;
t = 0:1/fs:0.15;
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

fc = 2000;
Kf = 999;

ut = fmmod(mt,fc,fs,Kf);

ut = 2 * ut;

figure(1)
plot(t,ut);
xlim([0 0.01])

demod_ut = fmdemod(ut,fc,fs,Kf);

figure(2)
plot(t,demod_ut);
xlim([0 0.1])

noise = wgn(1, length(ut), 0.01,'linear');

ut_with_noise = ut + noise;

figure(3)
plot(t, ut_with_noise);

demod_noise_ut = fmdemod(ut_with_noise, fc, fs, Kf);
figure(4)
plot(t, demod_noise_ut);
end