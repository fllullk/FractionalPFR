% gammac is the gamma function but allowing complex numbers like 1 + i
% mlf is the 2 parameters (alpha, beta) Mittag-Leffler function, the c is 
% the vector z and I still don't know what is the fi

disp("0!")
gammac(1) % 0!

disp("[1:4]!")
gammac(2:5) % [1:4]!

disp("0.5! = sqrt(pi) / 2")
gammac(1.5) % 0.5! = sqrt(pi) / 2

disp("i!")
gammac(1 + 1i) % i!

disp("exp(1)")
mlf(1, 1, 1) % exp(1)

disp("exp(2)")
mlf(1, 1, 2) % exp(2)

disp("exp([0:4])")
mlf(1, 1, 0:4) % exp([0:4])
