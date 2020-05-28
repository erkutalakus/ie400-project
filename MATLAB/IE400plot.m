clear, clc, close all
y = [1 144 13929 931484];
x = 1:5:20;
figure
plot(x,y);
title("Solving Time VS N");
xlabel("N(5,10,15 and 20)");
ylabel("Solving time (ms)");