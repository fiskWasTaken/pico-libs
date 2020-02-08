-- cute default cutscene frame function
-- games should probably implement their own...

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