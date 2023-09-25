function ExerciseFive
fs = 100000;
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
modulated_signal = 2 * fmmod(message_signal,fc,fs,Kf);

figure(6)
obw(modulated_signal, fs);

%plotting the modulated signal with no noise to compare how the noise
%effects the moudlated signal.
figure(1)
plot(t,modulated_signal)
title("Modulated Signal in the Time Domain")
xlabel("Time(s)")
ylabel("u(t)")
set(gca,'XLim',[0 0.01]);

white_noise_variance = 1/100;

%Setting the last parameter in the wgn() function to 'linear' allows you
%to use a variance.
%Generating white gaussian noise.
noise = wgn(1, length(modulated_signal), white_noise_variance,'linear'); 

%Filtering the noise to bandwidth that contains 99% of energy in 
%modulated signal to make it a narrowband noise.
filtered_noise = bandpass(noise, [1218 5852], fs);

%adding noise to modulated signal.
modulated_signal_with_noise = modulated_signal + filtered_noise; 

figure(3)
plot(t, modulated_signal_with_noise);
title("Modulated Signal with Noise in the Time Domain")
xlabel("Time(s)")
ylabel("u(t) + n(t)")
set(gca,'XLim',[0 0.01]);

%Demodulate the modulated signal with noise. Increased the sampling rate to
%get better accuracy when plotting it with noise. if the sampling rate is
%not high enough then the signal is very noisy and not an accurate
%representation of the demodulated signal. I did not increase it so much
%that it affected the amplitude of the first point in the demodulated
%signal.
demodulated_signal_with_noise = fmdemod(modulated_signal_with_noise, fc, fs, Kf);
figure(4)
plot(t, demodulated_signal_with_noise);
title("Demodulated Message Signal with Noise")
xlabel("Time(s)")
ylabel("m_d(t) + u_d(t)")
set(gca,'XLim',[0 0.1]);

demodulated_signal_f_with_noise = fftshift(fft(demodulated_signal_with_noise));
n = length(demodulated_signal_with_noise) - 1;
df = fs/n; 
f = -fs/2:df:fs/2;

%Plotting the magnitude spectrum to see how much the magnitude spectrum
%differes from the original message.
figure(5)
plot(f, abs(demodulated_signal_f_with_noise)/n);
title("Demodulated Message Signal with Noise in the Frequency Domain")
xlabel("Frequency(Hz)")
ylabel("|M_d(f) + U_d(f)|")
set(gca,'XLim',[-1000 1000]);
end