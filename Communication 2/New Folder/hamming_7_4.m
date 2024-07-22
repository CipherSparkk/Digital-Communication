clc
clear

disp("******* Hamming Code(7,4)*******");
disp(newline);
x = 1;
while(x)
    disp("Enter no. to perform associated operation.");
    disp("1. Enter 1 to encode a data.");
    disp("2. Enter 2 to retrieve and get corrected codeword.");
    disp("Note : Enter -1 to exit");
    x = input("> ");
    
    switch x
        case 1
            dataword = [];
            disp(newline);
            
            disp("Enter dataword :");
            for i = 1:4
                dataword(i) = input("> ");
                if dataword(i) > 1 || dataword(i) < 0
                error('Invalid Input!!!');
                end
            end

            
            % Parity bits
            p1 = xor(xor(dataword(1),dataword(2)),dataword(3));
            p2 = xor(xor(dataword(2),dataword(3)),dataword(4));
            p3 = xor(xor(dataword(1),dataword(2)),dataword(4));
            
            % Dataword
            disp("Dataword = ");
            disp(dataword);
            
            % Encoded Codeword
            codeword = [dataword p1 p2 p3];
            disp("So, encoded codeword = ");
            disp(codeword);
        
        case 2
            received_codeword = [];
            disp(newline);
            disp("Enter received codeword")
            for i = 1:7
                received_codeword(i) = input("> ");
                if received_codeword(i) > 1 || received_codeword(i) < 0
                error('Invalid Input!!!');
                end
            end
            
            % Received Codeword
            disp(newline);
            disp("Received codeword = ");
            disp(received_codeword);
    
            s1 = xor(xor(xor(received_codeword(1),received_codeword(2)),received_codeword(3)),received_codeword(5));
            s2 = xor(xor(xor(received_codeword(2),received_codeword(3)),received_codeword(4)),received_codeword(6));
            s3 = xor(xor(xor(received_codeword(1),received_codeword(2)),received_codeword(4)),received_codeword(7));
    
            % Syndrome Calculation
            s = [s1 s2 s3];
            s_num = 0;
            for i=1:length(s)
                s_num = s_num*10 + s(i);
            end
        
            % Getting error pattern associated with syndrome obtained
            switch s_num
                case 0
                    error_pattern = [zeros(1,7)];
                case 1
                    error_pattern = [zeros(1,6) 1];
                case 10
                    error_pattern = [zeros(1,5) 1 0];
                case 11
                    error_pattern = [zeros(1,4) 1 zeros(1,2)];
                case 100
                    error_pattern = [zeros(1,3) 1 zeros(1,3)];
                case 101
                    error_pattern = [zeros(1,2) 1 zeros(1,4)];
                case 110
                    error_pattern = [0 1 zeros(1,5)];
                case 111
                    error_pattern = [1 zeros(1,6)];
            end
            
            if(s_num ~= 0)
                disp("Result : Error detected!!!");
                disp(newline);
            end

            % Error Syndrome
            disp("Error Syndrome = ");
            disp(s);
            % Error pattern
            disp("Error pattern = ");
            disp(error_pattern);
    
            if(s_num == 0)
                disp("Codeword = ");
                disp(received_codeword);
                disp("Result : Received codeword is correct.");
            else
                % Correct codeword
                corrected_codeword = xor(received_codeword,error_pattern);
                disp("Corrected codeword = ");
                disp(corrected_codeword);
            end
        
        case -1
            break

        otherwise
            error('Invalid Input!!!');
    end
end