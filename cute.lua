-- cute: coroutine cutscene lib

cute={
    -- visibility for draw state
    -- 0=hidden,1=fully visible
    vis=0,
    -- current frame
    frame={},
    -- autoplay interval delay
    autoplay_interval=60
}

-- draw/update the bound
-- coroutine, if there is one.
function cute:draw()
    if self.co then
        if costatus(self.co)=="dead" then
            -- unset if a cutscene
            -- is not being played,
            -- allowing games to
            -- test if a cutscene
            -- is currently active
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
    local enter=cocreate(cute.slide_in)
    local leave=cocreate(cute.slide_out)
    local func=cocreate(label)

    -- calling once draws the first
    -- cutscene frame before doing anim
    coresume(func)

    local list={
        enter,
        func,
        leave
    }

    for co in all(list) do
        repeat
            yield(coresume(co))
        until costatus(co)=="dead"
    end
end

-- cute dialogue
function cute:d(a,m,auto)
    -- todo: resolve actor
    -- could be string, object..

    if type(a)=="string" then
        a={name=a,color=7}
    end

    local frame={
        a=a,
        ⬇️=false,
        ⧗=0
    }

    local rows=2
    local row=1
    local twidth=25
    local lines=split(m,twidth)
    local progress=0
    local autoplay_timeout=self.autoplay_interval

    -- workaround for bug where a single line of
    -- text is skipped, fix this...
    if (#lines==1) add(lines,"")

    -- typewriter speed
    local speed=0.4

    repeat
        local text=join({lines[row],lines[row+1]},"\n")

        frame.⬇️=row+rows-1<#lines
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
                progress=#lines[row]
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
    until row>=#lines

    printh("dialogue event completed: "..m)
end

function cute:play(func)
    cute.co=cocreate(func)
end

-- draw frame
function cute:draw_frame()
    local frame=self.frame

    -- y position
    -- we start low enough that the frame
    -- transitions without any elements
    -- popping into view too soon
    local oy=100+(1-self.vis)*36
    local top_bar=self.vis*16

    -- draw nothing if we are too far
    -- off screen
    if (oy>130) return

    rectfill(0,0,128,top_bar,0)
    line(0,top_bar,128,top_bar,7)

    rectfill(0,oy+4,128,128,0)
    line(0,oy+4,128,oy+4,7)

    if frame.a then
        -- actor name
        local nw=#frame.a.name*4
        rectfill(2,oy,nw+4,oy+8,0)
        rect(2,oy,nw+4,oy+8,7)
        print(frame.a.name,4,oy+2,frame.a.color)

        if frame.a.spr then
            local x,y=108,oy-4
            rectfill(x,y,x+18,y+18,0)
            rect(x,y,x+18,y+18,7)
            frame.a.spr(x+1,y+1)
        end
    end

    if frame.m then
        -- text
        print(frame.m,2,oy+11,7)
    end

    local shake=0

    if frame.⧗ then
        shake=(frame.⧗/30)%2
    end

    local button,c="❎",7

    -- if more text, show ⬇️
    -- otherwise show ❎
    if frame.⬇️ then
        button,c="⬇️",12
    end

    print(button,120,oy+20+shake,c)
    self.frame=frame
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

-- split a string into an array
-- of lines based on position
-- of spacing characters
-- todo: transform
-- into cursor-oriented
-- coroutine for memory
-- efficiency?
function split(str,w)
    local out,from,len={},1,#str

    repeat
        local to=min(from+w,len)

        if to<len then
            -- look ahead to width and
            -- backtrack until we
            -- see a space
            for c=min(to,len),from,-1 do
                if sub(str,c,c)==" " then
                    to=c
                    break
                end
            end
        end

        add(out,sub(
            str,
            from,
            to
        ))

        from=to+1
    until to>=len

    return out
end