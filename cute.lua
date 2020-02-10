-- cute: coroutine cutscene lib

cute={
    -- visibility for draw state
    -- 0=hidden,1=fully visible
    vis=0,
    -- current frame
    frame={},
    -- max text width
    width=25,
    rows=2,
    -- autoplay interval delay
    autoplay_interval=60
}

-- draw/update the bound
-- coroutine, if there is one.
function cute:draw()
    if self.co then
        if costatus(self.co)=="dead" then
            -- gc
            self.co=nil
        else
            coresume(self.co)
            cute:draw_frame()
        end
    end
end

-- slide in.
function cute:slide_in(⧗)
    ⧗=⧗ or 30
    for t=1,⧗ do
        cute.vis=ease_outquint(t,0,1,⧗)
        yield()
    end
end

-- slide out.
function cute:slide_out(⧗)
    ⧗=⧗ or 30
    for t=1,⧗ do
        cute.vis=ease_inquint(t,1,-1,⧗)
        yield()
    end
end

-- wraps a cutscene routine
-- in a function that will
-- provide
-- enter/leave transitions
function cute:cinematic(label)
    local func=cocreate(label)

    -- buffer first cutscene frame
    coresume(func)

    for co in all({
     cocreate(cute.slide_in),
     func,
     cocreate(cute.slide_out)
    }) do
        repeat
            yield(coresume(co))
        until costatus(co)=="dead"
    end
end

function slice(arr,start,fin)
 local out={}
 for i=start,fin do
    add(out,arr[i])
 end
 return out
end

-- cute dialogue
function cute:d(a,m,auto)
    -- todo: should not be up to cute to handle actor
    if type(a)=="string" then
        a={name=a,color=7}
    end

    local frame={
        a=a,
        ⬇️=false,
        ⧗=0
    }

    local row=1
    local lines=wrap(m,self.width)
    local progress=0
    local autoplay_timeout=self.autoplay_interval

    -- typewriter speed
    local speed=0.4

    local trow=max(#lines-self.rows+2,2)

    repeat
        local text=join(slice(lines,row,row+self.rows-1),"\n")

        frame.⬇️=row+1<trow
        frame.⧗+=1
        frame.m=sub(text,0,progress)
        self.frame=frame
        yield()

        if auto then
            autoplay_timeout-=1

            if autoplay_timeout==0 then
                if progress>=#text then
                    row+=1
                    progress=#lines[row]
                end

                autoplay_timeout=self.autoplay_interval
            end
        elseif btnp(❎) then
            if progress>=#text then
                row+=1
                progress=0
                for i=row,row+self.rows-2 do
                 if (lines[i]) progress+=#lines[i]
                end
            else
                progress=#text
            end
        end

        if progress<#text then
            local mult=1

            if btn(❎) then
                mult=2
            end

            progress+=speed*mult
        end
    until row>=trow
end

function cute:play(func)
    cute.co=cocreate(func)
end

-- ease functions from easing.lua
-- quintic ease out
function ease_outquint(t,b,c,d)
    t/=d
    t-=1
    return c*(t*t*t*t*t+1)+b
end

-- quintic ease in/out
function ease_inquint(t,b,c,d)
    t/=d/2
    if (t<1) return c/2*t*t*t*t*t+b
    t-=2
    return c/2*(t*t*t*t*t+2)+b
end

-- join an array of strings per the delimiter
function join(strings,delimiter)
    local ret=""

    for l in all(strings) do
     if ret=="" then
      ret=l
     else
     ret=ret..delimiter..l
     end
    end

    return ret
end

-- soft wrap a string, split
-- by space
function wrap(str,w)
    local out,from,len={},1,#str

    repeat
        local to=min(from+w,len)

        if to<len then
            for c=min(to,len),from,-1 do
                if sub(str,c,c)==" " then
                    to=c
                    break
                end
            end
        end

        add(out,sub(str,from,to))
        from=to+1
    until to>=len

    return out
end