% Message Signal
fm = input("Enter message signal frequency: ");
am = input("Enter message signal amplitude: ");
disp(newline);

% Carrier Signal
fc = input("Enter carrier signal frequency: ");
ac = input("Enter carrier signal amplitude: ");
disp(newline);

Fs = 50*fc;     % Sampling Frequency

dt = 1/Fs;          
T = 5*(1/fm);

% Defining time vector
t = 0:dt:T-dt;

% Message Signal equation
msg_signal = am*sin(2*pi*fm*t);

% Carrier Signal equation
carrier_signal = ac+ac*square(2*pi*fc*t);

% Modulated Signal equation
mod_s = msg_signal .* carrier_signal;

% Plotting signals
figure(1);
subplot(3,1,1);
plot(t,msg_signal);
xlabel('time (sec) --->');
ylabel('Amplitude (V)');
title('Message Signal');
subplot(3,1,2);
plot(t,carrier_signal);
xlabel('time (sec) --->');
ylabel('Amplitude (V)');
title('Carrier Signal');
subplot(3,1,3);
plot(t,mod_s);
xlabel('time (sec) --->');
ylabel('Amplitude (V)');
title('Pulse Amplitude Modulated Signal');

figure(2);
% Demodulation using low-pass filter:
demod_s = mod_s.*carrier_signal;

[b, a] = butter(5, fm/(Fs/2));  % Design a low-pass filter with cutoff at fm
demod_s = filter(b, a, demod_s); % Apply the filter

subplot(2,1,1)
plot(t, demod_s);
xlabel('time (sec) --->');
ylabel('Amplitude (V)');
title('Demodulated Signal (Low-Pass Filtered)');


