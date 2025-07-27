-- Street Light Controller
-- Place this program on a computer that outputs redstone to the top
-- The light will automatically turn on at night and off during the day

local CHECK_INTERVAL = 5 -- Check time every 5 seconds
local LIGHT_ON_TIME = 17.0 -- Time when lights should turn on (5 PM)
local LIGHT_OFF_TIME = 6.0 -- Time when lights should turn off (6 AM)

-- Function to check if it's nighttime
local function isNightTime()
    local mcTime = os.time()
    
    -- Night time is from 19.0 to 6.0 (Minecraft time is 0-24 scale)
    if mcTime >= 19.0 or mcTime <= 6.0 then
        return true
    else
        return false
    end
end

-- Function to turn light on (output redstone signal to top)
local function turnLightOn()
    redstone.setOutput("top", true)
    print("Street light ON - Night time detected")
end

-- Function to turn light off
local function turnLightOff()
    redstone.setOutput("top", false)
    print("Street light OFF - Day time detected")
end

-- Function to get current time in readable format
local function getTimeString()
    local mcTime = os.time()
    local hours = math.floor(mcTime)
    local minutes = math.floor((mcTime - hours) * 60)
    return string.format("%02d:%02d", hours, minutes)
end

-- Main program
print("Street Light Controller Starting...")
print("Light turns ON at 19:00 (7 PM)")
print("Light turns OFF at 06:00 (6 AM)")
print("Press Ctrl+T to stop")
print("------------------------")

local lastState = nil

while true do
    local currentTime = getTimeString()
    local shouldBeOn = isNightTime()
    
    -- Only change state if needed
    if shouldBeOn ~= lastState then
        if shouldBeOn then
            turnLightOn()
        else
            turnLightOff()
        end
        lastState = shouldBeOn
    end
    
    -- Status update every check
    local status = shouldBeOn and "ON" or "OFF"
    print(string.format("Time: %s | Light: %s", currentTime, status))
    
    -- Wait before next check
    sleep(CHECK_INTERVAL)
end
