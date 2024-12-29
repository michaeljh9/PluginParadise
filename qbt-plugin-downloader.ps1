# PowerShell script to download qBittorrent search plugins
# Usage: irm [YOUR_GITHUB_RAW_URL] | iex

function Download-QBTPlugins {
    param (
        [string]$GithubUrl = "https://github.com/qbittorrent/search-plugins/wiki/Unofficial-search-plugins",
        [string]$OutputFolder = $null
    )

    # Create the default output folder on the desktop if not specified
    if (-not $OutputFolder) {
        $OutputFolder = Join-Path ([Environment]::GetFolderPath('Desktop')) "engines"
    }

    # Ensure the output folder exists
    if (-not (Test-Path $OutputFolder)) {
        New-Item -ItemType Directory -Path $OutputFolder | Out-Null
    }

    Write-Host "Fetching plugins list..."

    try {
        # Send request to fetch the page content
        $Response = Invoke-WebRequest -Uri $GithubUrl -UseBasicParsing
        
        if ($Response.StatusCode -ne 200) {
            Write-Host "Error: Unable to fetch page (status code $($Response.StatusCode))"
            return
        }

        # Parse the HTML content to find .py files
        $Links = ([regex]'href="([^"]+\.py)"').Matches($Response.Content)
        
        if ($Links.Count -eq 0) {
            Write-Host "No Python files found in the table."
            return
        }

        # Process each .py file
        foreach ($Link in $Links) {
            $PyFileUrl = $Link.Groups[1].Value
            
            # Ensure URL is absolute
            if (-not $PyFileUrl.StartsWith("http")) {
                $BaseUri = [System.Uri]$GithubUrl
                $PyFileUrl = [System.Uri]::new($BaseUri, $PyFileUrl).AbsoluteUri
            }

            # Get the file name from the URL
            $FileName = Split-Path $PyFileUrl -Leaf
            $FilePath = Join-Path $OutputFolder $FileName

            # Check if file already exists
            if (Test-Path $FilePath) {
                Write-Host "Skipping $FileName, already exists."
                continue
            }

            # Download the file
            Write-Host "Downloading $FileName..."
            try {
                Invoke-WebRequest -Uri $PyFileUrl -OutFile $FilePath -UseBasicParsing
                Write-Host "Downloaded: $FileName"
            }
            catch {
                Write-Host "Failed to download $FileName. Error: $($_.Exception.Message)"
            }
        }

        # Print completion message
        Write-Host "`nFiles have been downloaded to $OutputFolder"
        Write-Host "From inside of qBittorrent, use the 'Search Plugins...' button to import them."
        Write-Host "Do not copy-paste into the qBittorrent's .local subfolder. Use qBittorrent to import them.`n"
    }
    catch {
        Write-Host "An error occurred: $($_.Exception.Message)"
    }
}

# Execute the function
Download-QBTPlugins
