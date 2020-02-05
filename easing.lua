-- some easing functions inspired from http://gizma.com/easing/
-- t: current time
-- b: start value
-- c: change in value
-- d: duration

ease={}

-- linear tween
function ease.linear(t,b,c,d)
    return c*t/d+b
end

-- quadratic ease in
function ease.inquad(t,b,c,d)
    t/=d
    return c*t*t+b
end

-- quadratic ease out
function ease.outquad(t,b,c,d)
    t/=d
    return -c*t*(t-2)+b
end

-- quadratic ease in/out
function ease.inoutquad(t,b,c,d)
    t/=d/2
    if (t<1) return c/2*t*t+b
    t-=1
    return -c/2*(t*(t-2)-1)+b
end

-- quintic ease in
function ease.inquint(t,b,c,d)
    t/=d
    return c*t*t*t*t*t+b
end

-- quintic ease out
function ease.outquint(t,b,c,d)
    t/=d
    t-=1
    return c*(t*t*t*t*t+1)+b
end

-- quintic ease in/out
function ease.inoutquint(t,b,c,d)
    t/=d/2
    if (t<1) return c/2*t*t*t*t*t+b
    t-=2
    return c/2*(t*t*t*t*t+2)+b
end