function payoff = get_gap_payoff(sT, k1, k2)
    payoff = zeros(length(sT), 1);

    %STU: see my solutions for how to vectorize this. 
    for i = 1:length(payoff)
        if sT(i) > k2
                payoff(i) = sT(i) - k1;
            else
                payoff(i) = 0;
        end
    end