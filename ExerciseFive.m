function ExerciseFive
fs = 15000;
t = 0:1/fs:0.1;
index = 1;
for i = 0:1/fs:0.1
    if (i <= 0.05)
        message_signal(index) = 4*sinc(200*i) + (10*i);
    elseif (i >= 0.05 && i <= 0.1)
        message_signal(index) = 4*sinc(200*i) + (1 - 10*i);
    else
        message_signal(index) = 0;
    end
    index = index + 1;
end
fc = 2000;
Kf = 999;
modulated_signal = fmmod(message_signal,fc,fs,Kf);

figure(50)
obw(modulated_signal, fs);

%plotting the modulated signal with no noise to compare how the noise
%effects the moudlated signal.
figure(1)
plot(t,modulated_signal)
title("Modulated Signal in the Time Domain")
xlabel("Time(s)")
ylabel("u(t)")
set(gca,'XLim',[0 0.01]);

%Variance = (last digit of student number)/100 = 1/100
white_noise_variance = 1/100;

%Setting the last parameter in the wgn() function to 'linear' allows you
%to use a variance.
noise = wgn(1, length(modulated_signal), white_noise_variance,'linear'); %Generating white gaussian noise.

%Filtering the noise to said bandwidth to make it a narrowband noise.
%filtered_noise = bandpass(noise, [1218 5844], fs);
filtered_noise = bandpass(noise, [9000 9240], fs);

modulated_signal_with_noise = modulated_signal + filtered_noise; %adding noise to modulated signal.
%modulated_signal_with_noise = modulated_signal + noise;

figure(3)
plot(t, modulated_signal_with_noise);
title("Modulated Signal with Noise in the Time Domain")
xlabel("Time(s)")
ylabel("u(t) + n(t)")
set(gca,'XLim',[0 0.01]);


demodulated_signal_with_noise = fmdemod(modulated_signal_with_noise, fc, fs, Kf);
figure(4)
plot(t, demodulated_signal_with_noise);
title("demodulated with noise")
xlabel("Time(s)")
ylabel("m_d(t) + u_d(t)")
set(gca,'XLim',[0 0.1]);
end