local uuidFilePath = "UUID"
local appScriptPath = "app.lua"
local registerUrl = "http://192.168.23.155:8081/register"

-- Function to get the computer's cc:tweaked ID
local function getComputerID()
    return os.getComputerID()
end

-- Function to write UUID to file
local function writeUUIDToFile(uuid)
    local file = fs.open(uuidFilePath, "w")
    file.write(uuid)
    file.close()
end

-- Function to read UUID from file
local function readUUIDFromFile()
    if fs.exists(uuidFilePath) then
        local file = fs.open(uuidFilePath, "r")
        local uuid = file.readAll()
        file.close()
        return uuid
    end
    return nil
end

-- Function to start the app script
local function startApp()
    shell.run(appScriptPath)
end

-- Main logic
local uuid = readUUIDFromFile()

if not uuid then
    local response = http.post(registerUrl, textutils.serializeJSON({ id = getComputerID() }), { ["Content-Type"] = "application/json" })
    if response then
        uuid = textutils.unserializeJSON(response.readAll()).uuid
        response.close()
        writeUUIDToFile(uuid)
    else
        print("Failed to register and obtain UUID.")
        return
    end
end

startApp()
