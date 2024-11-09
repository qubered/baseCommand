local url = "https://raw.githubusercontent.com/qubered/baseCommand/refs/heads/main/client/wrapper.lua"
local path = "wrapper.lua"

-- Function to download the file
local function downloadFile(url, path)
    local response = http.get(url)
    if response then
        local content = response.readAll()
        response.close()
        
        local file = fs.open(path, "w")
        file.write(content)
        file.close()
        
        print("Downloaded " .. path)
    else
        print("Failed to download " .. url)
    end
end

-- Download the file
downloadFile(url, path)

-- Run the downloaded file
shell.run(path)