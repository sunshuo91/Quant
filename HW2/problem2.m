%
% Problem 2: Bond Price and Duration
%


yield = 0.11;
coupon_rate = 0.08;

[Price, Duration] = PD(yield, coupon_rate);


disp('Problem 2: *********************');
disp('');
disp('The bond price is');
disp(Price);
disp('The bond duration is');
disp(Duration);
disp('');disp('');

function [price, duration] = PD(yield, coupon)
    face_value = 100; 
    time = 5;
    PMT = ones(1, time);
    for count = 1:(time - 1)
        PMT(count) = face_value * coupon;
    end
    PMT(time) = face_value * (1 + coupon);
    
    PV = ones(1, time);
    for count2 = 1:time
        PV(count2) = PMT(count2) * exp(-yield * count2);
    end
    
    price = sum(PV);
    
    WAPV = ones(1, time);
    for count2 = 1:time
        WAPV(count2) = count2 * PMT(count2) * exp(-yield * count2);
    end
    
    duration = sum(WAPV) / price;
end