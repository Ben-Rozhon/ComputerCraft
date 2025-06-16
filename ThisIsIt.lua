local repo = "Ben-Rozhon/ComputerCraft"
local path = "run"
local apiUrl = "https://api.github.com/repos/" .. repo .. "/contents/" .. path

local response = http.get(apiUrl)
-- update server pls
if response then
    local data = textutils.unserializeJSON(response.readAll())
    response.close()

    for _, file in ipairs(data) do
        if file.type == "file" and file.download_url then
            print("Downloading: " .. file.name)
            local fileRes = http.get(file.download_url)

            if fileRes then
                local content = fileRes.readAll()
                fileRes.close()

                local outFile = fs.open(file.name, "w")
                outFile.write(content)
                outFile.close()
                print("Saved: " .. file.name)
            else
                print("Failed to download: " .. file.name)
            end
        end
    end

    if fs.exists("main.lua") then
        print("Running main.lua...")
        shell.run("main.lua")
    end
else
    print("Failed to fetch GitHub directory listing.")
end
