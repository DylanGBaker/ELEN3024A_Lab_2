function ExerciseTwo
%Higher frequency than question one so that the chnaging frequency can be
%seen as a smoother curve in the plotted u(t) in figure 1.
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
%When looking at the plotted |M(f)| from question one, infinite frequencies
%can be seen and this is due to the 10t and (1-10t) in the equations for
%the message signal. Normally there is no fourier transform for a ramp
%function however since it is bounded in time it can be calculated using
%the fourier transform equation. (The calculation is shown in the report).

%The sinc functions have a bandwidth of 100Hz but, because of the ramp
%functions i have decided to include frequencies up to 600Hz as this is
%where the magnitude is very small and is negligible. If just the sinc
%function was included then information contained in 10t and (1-10t) will
%only be sent if their freqeuncies are in the 0-100Hz range, so to include
%more message information I have decided to include up to 600Hz.

%This leads to a calculated freqeuncy devaition of 999Hz. Calculation is
%shown in the report.
Kf = 999;

%Multiply by 2 for modulated signal due to the carrier having an amplitude
%of 2.
modulated_signal = 2 * fmmod(message_signal,fc,fs,Kf); 

modulated_signal_f = fftshift(fft(modulated_signal));
n = length(message_signal) - 1;
df = fs/n; 
f = -fs/2:df:fs/2;

figure(1)
plot(t,modulated_signal)
title("Modulated Signal in the Time Domain Limited between 0 and 0.02")
xlabel("Time(s)")
ylabel("u(t)")
set(gca,'XLim',[0 0.02]);

figure(2)
plot(t,modulated_signal)
title("Modulated Signal in the Time Domain")
xlabel("Time(s)")
ylabel("u(t)")

figure(3)
plot(f, abs(modulated_signal_f)/n)
title("Magnitude Spectrum of the Modulated Message Signal.")
xlabel("Frequency(Hz)")
ylabel("|U(f)|")
set(gca,'XLim',[-10000 10000]);

figure(4)
plot(f, unwrap(angle(modulated_signal_f)))
title("Phase Spectrum of the Modulated Message Signal.")
xlabel("Frequency(Hz)")
ylabel("Phase of U(f)")
end