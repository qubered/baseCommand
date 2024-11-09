local function downloadAndRun(url, filename)
    local response = http.get(url)
    if response then
        local file = fs.open(filename, "w")
        file.write(response.readAll())
        file.close()
        response.close()
        shell.run(filename)
    else
        print("Failed to download file.")
    end
end

local url = "https://raw.githubusercontent.com/qubered/baseCommand/refs/heads/main/client/wrapper.lua"
local filename = "wrapper.lua"

downloadAndRun(url, filename)