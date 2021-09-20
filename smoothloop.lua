SmoothLoop = {}

-- Public Functions
function SmoothLoop.new(tbl, ms, callback)
    assert(type(tbl) == "table", "Expected table at argument 1, got " .. type(tbl))
    assert(type(ms) == "number", "Expected number at argument 2, got " .. type(ms))
    assert(type(callback) == "function", "Expected function at argument 3, got " .. type(callback))
    
    ms = math.max(50, ms)
    local delta = ms / #tbl
    
    if delta <= 0 then
        return false
    end
    
    local data = {
        tbl = tbl,
        ms = delta,
        callback = callback
    }
    setmetatable(data, { __index = SmoothLoop })
    
    data:prepare()
    return data
end

function SmoothLoop:prepare()   
    self.resume = function()
        if coroutine.status(self.thread) == "suspended" then
            coroutine.resume(self.thread)
        else
            self:destroy()
        end
    end
    
    self.processor = function()
        for i = 1, #self.tbl do
            local v = self.tbl[i]
            self.callback(v, i)
            coroutine.yield()
        end
    end
    
    self.thread = coroutine.create(self.processor)
    self.is_running = false
end

function SmoothLoop:run()
    if self.is_running then
        return false
    end

    self.is_running = true
    self.timer = setTimer(self.resume, self.ms, 0)
end

function SmoothLoop:destroy()
    if self.timer and isTimer(self.timer) then
        killTimer(self.timer)
    end
    setmetatable(self, nil)
end
