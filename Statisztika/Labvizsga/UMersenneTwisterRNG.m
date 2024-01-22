% -----------
% Description
% -----------
% The function generates continuous uniform pseudorandom numbers on the interval $\Green{\left(0,1\right)}$.
% Its implementation is based on the article $\text{\cite{MatsumotoNishimura1998}}$.
%
% ----------------
% Usage and syntax
% ----------------
%   scalar     = UMersenneTwisterRNG
%   row_matrix = UMersenneTwisterRNG(column_count)
%   matrix     = UMersenneTwisterRNG(row_count, column_count)
%
function result = UMersenneTwisterRNG(varargin)

persistent MT
persistent index

% initialize the generator from a seed
    function initialize_generator(seed)
        
        index = 0;
        
        MT = zeros(1, 624);
        MT(1) = uint64(seed);
        
        for k = 1:623
            MT(k+1) = bitand(...
                uint64(1812433253 * bitxor(MT(k), bitshift(MT(k), -30)) + k), ...
                4294967295);
        end
        
    end

% generate an array of 624 untempered numbers
    function generate_numbers()
        
        for k = 0:623
            y = bitand(MT(k + 1), 2147483648) + ...
                bitand(2147483647, MT( mod(k + 1, 624) + 1));
            
            MT(k + 1) = bitxor(MT(mod(k + 397, 624) + 1), bitshift(uint32(y), -1));
            
            if (mod(y, 2) ~= 0)
                MT(k + 1) = bitxor(MT(k + 1), 2567483615);
            end
        end
        
    end

%  extract a tempered pseudorandom number based on the index-th value,
%  calling generate_numbers() every 624 numbers
    function y = extract_number()
        
        if (index == 0)
            generate_numbers();
        end
        
        y = MT(index + 1);
        y = bitxor(y, bitshift(y, -11));
        y = bitxor(y, bitand(bitshift(y, 7), 2636928640));
        y = bitxor(y, bitand(bitshift(y, 15), 4022730752));
        y = bitxor(y, bitshift(y, -18));
        
        index = mod(index + 1, 624);
        
    end

% checking the possible input parameters
optional_input_argument_count = size(varargin,2);

if (optional_input_argument_count == 0)
    row_count = 1;
    column_count = 1;
else
    if (optional_input_argument_count == 1)
        row_count = 1;
        if (isscalar(varargin{1}))
            column_count = round(varargin{1});
        else
            error('Wrong column number!');
        end
    else
        if (optional_input_argument_count == 2)
            if (isscalar(varargin{1}))
                row_count = round(varargin{1});
            else
                error('Wrong row number!');
            end
            
            if (isscalar(varargin{2}))
                column_count = round(varargin{2});
            else
                error('Wrong column number!');
            end
        else
            error('Too many input arguments!');
        end
    end
end

% we use a default initial value that is equal to the prime number 6199
if (isempty(MT) && isempty(index))
    initialize_generator(6199);
end

% allocate memory for the output sequence of uniform
result = zeros(row_count, column_count);

% generate random uniform integers and normalize them
for i = 1:row_count
    for j = 1:column_count
        result(i, j) = extract_number() / 4294967295;
    end
end

end

