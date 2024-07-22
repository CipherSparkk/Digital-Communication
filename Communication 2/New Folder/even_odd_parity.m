clc
clear

disp("Enter no. to perform associated operation.");
disp("1. Enter 1 for Even Parity.");
disp("2. Enter 2 for Odd Parity.");
parity_type = input("> ");

if parity_type == 1
    disp(newline);
    disp("******* Even Parity *******")
    disp(newline);
else
    if parity_type == 2
        disp(newline);
        disp("******* Odd Parity *******")
        disp(newline);
    else
        error('Invalid Input!!!');
    end
end

y=1;
while(y)
    disp("Enter no. to perform associated operation.");
    disp("1. Enter 1 to Encode a codeword.");
    disp("2. Enter 2 to retrieve and get corrected codeword.");
    disp("Note: Enter -1 to exit.")
    y = input("> ");
    
    switch y
        case 1
            k = input("Enter information bits length : ");
            disp("Enter info word : ");
            dataword = [];
            xor_result = 0;
            for i=1:k
                dataword(i) = input("> ");
                if dataword(i) > 1 || dataword(i) < 0
                    error('Invalid Input!!!');
                end
                xor_result = xor(xor_result,dataword(i));
            end
            
            if parity_type == 1
                if(xor_result == 0)
                    codeword = [dataword 0];
                else
                    codeword = [dataword 1];
                end
            else
                if xor_result == 0
                    codeword = [dataword 1];
                else
                    codeword = [dataword 0];
                end
            end
    
            disp("So, Encoded Codeword = ");
            disp(codeword);
         
        case 2 
            disp(newline);
            n = input("Enter block code length : ");
            disp("Enter Received Codeword ");
            received_codeword = [];
            xor_result = 0;
            for i=1:n
                received_codeword(i) = input("> ");
                if received_codeword(i) > 1 || received_codeword(i) < 0
                    error('Invalid Input!!!');
                end
                xor_result = xor(xor_result,received_codeword(i));
            end
            
            disp(newline);
            disp("So, Received Codeword = ");
            disp(received_codeword);
            disp(newline);
            if parity_type == 1
                if(xor_result == 0)
                    disp("Result : Received Codeword is Correct");
                else
                    disp("Result : Error detected!!!")
                end
            else
                if xor_result == 0
                    disp("Result : Error detected!!!")
                else
                    disp("Result : Received Codeword is Correct");
                end
            end

        case -1
            break

        otherwise
            error('Invalid Input!!!');
            
    end
    disp(newline);
    
end

