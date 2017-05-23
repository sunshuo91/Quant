function ladderPrice = get_ladder_price_mc( s0, k_itm, k_atm, k_otm, r, vol, T, N)

sT = s0*exp( (r-vol*vol/2)*T + vol*sqrt(T)*randn(N,1) );      
ladderPayoff = get_ladder_payoff(k_itm, k_atm, k_otm, sT);
discountedPayoff = ladderPayoff * exp(-r*T);
    
ladderPrice = mean(discountedPayoff);


