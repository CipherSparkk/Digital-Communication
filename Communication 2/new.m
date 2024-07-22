disp("Too high step size results in Granular Noise and too low step size results in Slope Overloading")
delta_zero = input("Enter the step size: ");
amp = input("Enter the amplitude of the message signal: ");

t = 0:0.01:1;
msg_signal = amp*sin(2*pi*t);

% Delta Modulated Output Signal
predicted_output_dm = zeros(size(msg_signal));

for i = 1:length(msg_signal)-1
    if msg_signal(i) >= predicted_output_dm(i)
        predicted_output_dm(i+1) = predicted_output_dm(i) + delta_zero;
    else
        predicted_output_dm(i+1) = predicted_output_dm(i) - delta_zero;
    end
end

% Adaptive Delta Modulation (ADM)
predicted_output_adm = zeros(size(msg_signal));
step_size_adm = delta_zero;

for i = 2:length(msg_signal)
    if msg_signal(i) >= predicted_output_adm(i-1)
        predicted_output_adm(i) = predicted_output_adm(i-1) + step_size_adm;
    else
        predicted_output_adm(i) = predicted_output_adm(i-1) - step_size_adm;
    end
end

% Plotting both signals
figure;
subplot(2,1,1);
plot(t, msg_signal, 'LineWidth', 2, 'DisplayName', 'Message Signal');
hold on
stairs(t, predicted_output_dm, 'LineWidth', 1.5, 'DisplayName', 'Delta Modulated Signal');
hold off
title("Delta Modulation");
xlabel("Time");
ylabel("Amplitude");
legend('show');

subplot(2,1,2);
plot(t, msg_signal, 'LineWidth', 2, 'DisplayName', 'Message Signal');
hold on
stairs(t, predicted_output_adm, 'LineWidth', 1.5, 'DisplayName', 'Adaptive Delta Modulated Signal');
hold off
title("Adaptive Delta Modulation");
xlabel("Time");
ylabel("Amplitude");
legend('show');