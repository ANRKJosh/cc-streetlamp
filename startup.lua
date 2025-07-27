-- Street Light Controller
-- Place this program on a computer that outputs redstone to the top
-- The light will automatically turn on at night and off during the day

local CHECK_INTERVAL = 5 -- Check time every 5 seconds
local LIGHT_ON_TIME = 13000 -- Time when lights should turn on (7 PM in Minecraft time)
local LIGHT_OFF_TIME = 1000 -- Time when lights should turn off (6 AM in Minecraft time)

-- Function to check if it's nighttime
local function isNightTime()
    local time = os.time()
    -- Convert to 24000 scale (Minecraft day cycle)
    local mcTime = (time * 24000) % 24000
    
    -- Night time is from 19000 to 6000 (wraps around midnight)
    if mcTime >= LIGHT_ON_TIME or mcTime <= LIGHT_OFF_TIME then
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
    local time = os.time()
    local mcTime = (time * 24000) % 24000
    local hours = math.floor(mcTime / 1000)
    local minutes = math.floor((mcTime % 1000) / 16.67)
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
