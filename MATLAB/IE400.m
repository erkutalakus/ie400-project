clear all, clc
%% Creating Random Study Time
x = zeros(1,76); 
for k = 2:76
    x(k) = randi([300,500]);
end
%% Random Matrices for N=5,10,15 ... 75
for h = 1:15
M = zeros(h*5+1);
P = zeros(h*5+1);
N = h*5;
for t = 1: round(N*log(N))
    for k = 1:N+1
        for l = 1:N+1
            if k == l
                M(k,l) = 0;
            else
                M(k,l) = randi([100,300]); %%random integers between 100 and 300
            end
        end
    end
    for k = 1:h*5+1
            M(k,:) = M(:,k);
    end
    P = P + M;
end
P = round(P/round(N*log(N)));% Average Matrix
P = [P; x(1:N+1)]; %Adding the first N+1 element of the random vector.
s = strcat("P",int2str(h*5),".csv"); %Exporting the data as csv file.
writematrix(P,s);
end
