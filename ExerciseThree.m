function ExerciseThree

%Determining bandwidth using Carson's rule Bc = 2(beta + 1)fm:
frequency_modulation_index = 6.66;
messsage_signal_bandwidth = 600;
effective_bandwidth_of_modulated_signal = 2 * (frequency_modulation_index + 1) * messsage_signal_bandwidth;
disp(effective_bandwidth_of_modulated_signal);

%Using the equation Bf = (kf * carrier_amplitude)/fm, the ranges of
%instantaneous frequencies can be calculated. We know Bf, carrier
%amplituide and set the fm = 600Hz. kf will give the maximum frequency
%deviation and hence the range of instantaneous frequencies. Calculation is
%shown in the report but, kf = 999Hz.
end