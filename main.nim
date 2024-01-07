import os, std/httpclient, zippy/ziparchives, strutils

let url = "http://corvina.adora.dk:8054/liveries/Liveries.zip"
let UserProfile = getEnv("USERPROFILE")
let localFilePath = UserProfile/"Saved Games"/"DCS.openbeta"/"Liveries.zip"
let installPath = UserProfile/"Saved Games"/"DCS.openbeta"/"Liveries"

echo localFilePath

# Download the file
var client = newHttpClient()
sleep(5000)
try:
    echo "Downloading liveries"
    let content = client.getContent(url)
    echo "Installing Liveries"
    sleep(5000)
    let file = open(localFilePath, fmWrite)
    sleep(5000)
    # Write the content to the file in chunks
    const ChunkSize = 10_000_000 # 10 MB chunk size
    var i = 0
    while i < content.len:
        let endIdx = min(i + ChunkSize, content.len)
        file.write(content[i ..< endIdx])
        i = endIdx
    file.close()
    sleep(5000)
    
finally:
    client.close()

sleep(5000)

echo "Extracting files"

# Unzip the file
extractAll(localFilePath, installPath)
sleep(5000)

removeFile(localFilePath)

echo "Succesfully installed all liveries"
