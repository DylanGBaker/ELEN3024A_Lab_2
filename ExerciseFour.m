function ExerciseFour
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
modulated_signal = 2 * fmmod(message_signal,fc,fs,Kf);
demodulatd_signal = fmdemod(modulated_signal,fc,fs,Kf);

%Plotting original message signal and then
%the demodulated message signal so that I can 
%compare them.
figure(1)
subplot(2,1,1);
plot(t, message_signal)
title("Original Message Signal in the Time Domain")
xlabel("Time(s)")
ylabel("m(t)")

hold on

subplot(2,1,2);
plot(t,demodulatd_signal);
title("Demodulated Signal in the Time Domain")
xlabel("Time(s)")
ylabel("m_d(t)")

%Plotting the magnitude spectrum so that it can be
%compared to the magnitude spectrum in question one.
demodulated_signal_f = fftshift(fft(demodulatd_signal));
n = length(message_signal) - 1;
df = fs/n; 
f = -fs/2:df:fs/2;

figure(2)
plot(f, abs(demodulated_signal_f)/n)
title("Magnitude Spectrum of the Demodulated Message Signal.")
xlabel("Frequency(Hz)")
ylabel("|U(f)|")
set(gca,'XLim',[-1000 1000]);
end