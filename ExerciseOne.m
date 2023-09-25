function ExerciseOne
%High sampling rate for more accuracy in the plots.
fs = 20000;
t = 0:1/fs:0.1;

index = 1;
for i = 0:1/fs:0.1
    if (i <= 0.05)
        message_signal(index) = 4*sinc(200*i) + (10*i); %Conditional equation for 0 <= t <= 0.05
    elseif (i >= 0.05 && i <= 0.1)
        message_signal(index) = 4*sinc(200*i) + (1 - 10*i); %Conditional equation for 0.05 <= t <= 0.1
    else
        message_signal(index) = 0; %For all time past 0.1 the message signal has a value of 0.
    end
    index = index + 1;
end
%Getting fourier transform of message and shifting the array so that the DC component is at the centre of the array.
Mf = fftshift(fft(message_signal)); 

% Used when plotting the magnitude spectrum and getting the frequency range 'f'.
n = length(message_signal) - 1;

%Sampled frequency steps for the frequency range 'f'
df = fs/n; 
f = -fs/2:df:fs/2;

%plot of the message signal from 0 <= t <= 0.2
figure(1)
plot(t,message_signal);
title("Message Signal in the Time Domain")
xlabel("Time(s)")
ylabel("m(t)")
set(gca,'XLim',[0 0.1]);

%Plot of the message signal in the frequency domain from -1000 <= f <= 1000
figure(2)
plot(f,abs(Mf)/n);
title("Magnitude Spectrum of Message Signal in Frequency Domain")
xlabel("Frequency(Hz)")
ylabel("|M(f)|")
set(gca,'XLim',[-1000 1000]);
end