-- Street Lamp Controller for ComputerCraft
-- This program will turn on a redstone signal from the 'top' side
-- when it detects that it is night time in Minecraft.

-- Function to check if it's night time
-- In Minecraft, a full day/night cycle is 24000 ticks.
-- Night time typically starts around 13000 ticks (dusk) and ends around 23000 ticks (dawn).
-- We'll consider night from 13000 to 23000.
function isNight()
    local time = os.time() -- Get the current in-game time (0-23999)
    -- print("Current time: " .. time) -- Uncomment for debugging to see the time value
    return time >= 13000 and time <= 23000
end

-- Main loop for the controller
print("Street Lamp Controller started.")
print("Monitoring time for night detection...")

while true do
    if isNight() then
        -- It's night, turn on the redstone signal at the top
        if not rs.getOutput("top") then -- Check if it's not already on to avoid unnecessary calls
            rs.setOutput("top", true)
            print("It's night time. Street lamp ON.")
        end
    else
        -- It's day, turn off the redstone signal at the top
        if rs.getOutput("top") then -- Check if it's not already off
            rs.setOutput("top", false)
            print("It's day time. Street lamp OFF.")
        end
    end

    -- Wait for a short period before checking again
    -- 5 seconds (5 ticks) is a good balance to not hog resources but still be responsive.
    os.sleep(5)
end
