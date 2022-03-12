function ease_outback(x)
    local c1,c3=1.7015,2.7015
    x-=1
    return 1+c3*x*x*x+c1*x*x
end