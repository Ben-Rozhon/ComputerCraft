-- startup.lua or receiver.lua on the turtle
local modem = peripheral.find("modem") or error("No modem attached", 0)
rednet.open(peripheral.getName(modem))

local id = os.getComputerID()
print("Turtle " .. id .. " ready to receive code")

while true do
    local senderId, message = rednet.receive()
    if type(message) == "string" then
        local func, err = load(message)
        if func then
            local success, result = pcall(func)
            if not success then
                print("Execution error:", result)
            end
        else
            print("Load error:", err)
        end
    end
end
