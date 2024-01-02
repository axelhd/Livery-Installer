import os, std/httpclient, osproc

let url = "http://127.0.0.1:8000/Liveries.exe"
let localFilePath = "%USERPROFILE%\\Saved Games\\DCS.openbeta"
# Create the directory if it doesn't exist

# Download the file
var client = newHttpClient()
try:
    let content = client.getContent(url)
    echo "1"
    let file = open(localFilePath, fmWrite)
    # Write the content to the file in chunks
    const ChunkSize = 10_000_000 # 10 MB chunk size
    var i = 0
    while i < content.len:
        let endIdx = min(i + ChunkSize, content.len)
        file.write(content[i ..< endIdx])
        i = endIdx
    file.close()
    
finally:
    client.close()
    
# Execute the file
let args = ["-y"]
echo "here"
discard execProcess(localFilePath, args = args, options = {poUsePath, poStdErrToStdOut})
echo "here"

# Delete the file
removeFile(localFilePath)

