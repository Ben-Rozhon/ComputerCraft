local wsUrl = "ws://localhost:8765"
local id = os.getComputerLabel() or ("Turtle_" .. tostring(os.getComputerID()))

local ws, err = http.websocket(wsUrl)
if not ws then
    print("Failed to connect:", err)
    return
end

ws.send(id)
print("Connected to server as", id)

while true do
    local msg = ws.receive()
    if msg then
        local func, err = load(msg)
        if not func then
            print("Error loading code:", err)
        else
            local success, result = pcall(func)
            if not success then
                print("Error running code:", result)
            else
                print("Code ran successfully")
            end
        end
    else
        print("Connection closed")
        break
    end
end
