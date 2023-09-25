function ExerciseThree

%Determining bandwidth using Carson's rule Bc = 2(beta + 1)fm:
frequency_modulation_index = 6.66;
messsage_signal_bandwidth = 600;
effective_bandwidth_of_modulated_signal = 2 * (frequency_modulation_index + 1) * messsage_signal_bandwidth;
disp("The effective bandwidth is: "+ effective_bandwidth_of_modulated_signal);

%Using fi(t) - fc = kf*m(t) we can find the range of instantaneous
%frequency ranges by modifying the equation to be fi(t) = fc + kf*m(t).
%We can then loop through the size of the message signals array and get
%different values of m(t) and apply the above equation.

fs = 100000;
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

kf = 999;
fc = 2000;
frequency_deviations = zeros(size(message_signal));
for i = 1:length(message_signal)
    frequency_deviations(i) = fc + kf*message_signal(i);
end

max_freq_deviation = max(frequency_deviations(:));
disp("Maximum frequency deviation: " + max_freq_deviation);
disp("");
min_freq_deviation = min(frequency_deviations(:));
disp("Minimum frequency deviation: " + min_freq_deviation);
disp("");

range_freq_deviations = max_freq_deviation - min_freq_deviation;

disp("The range of instantaneous frequency deviations is: " + range_freq_deviations);

end