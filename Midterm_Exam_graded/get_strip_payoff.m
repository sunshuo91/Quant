function payoff = get_strip_payoff(sT, K)
    put_payoff = get_put_payoff(sT, K);
    call_payoff = get_call_payoff(sT, K);
    payoff = call_payoff + 2 * put_payoff;
end