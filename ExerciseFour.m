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

figure(1)
plot(t,demodulatd_signal, 'o', t, message_signal, 'b--');
title("Demodulated Signal in the Time Domain")
xlabel("Time(s)")
ylabel("m_d(t)")
end