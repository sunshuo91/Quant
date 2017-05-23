function payoff = get_ladder_payoff(k_itm, k_atm, k_otm, sT)

ITM_payoff = get_call_payoff(sT, k_itm);
ATM_payoff = -get_call_payoff(sT, k_atm);
OTM_payoff = -get_call_payoff(sT, k_otm);

payoff = ITM_payoff + ATM_payoff + OTM_payoff;