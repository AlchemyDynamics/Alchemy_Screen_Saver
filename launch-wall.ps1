# Alchemy Dynamics Screensaver — multi-monitor "video wall" launcher.
#
# Opens ONE chromeless Chrome/Edge window sized to span the entire extended
# desktop, so the starfield runs as a single continuous scene across all your
# monitors. The logo lands on whichever screen is centered in the layout.
#
# Usage:  right-click  ->  "Run with PowerShell"   (or run launch-wall.bat)
#
# Notes:
#  - Uses the live GitHub Pages build (HTTPS) so webcam head tracking works.
#    To run a local copy instead, set $Url to http://localhost:8000 and serve
#    the folder first (python -m http.server 8000).
#  - Press Alt+F4 (or Esc then close) to exit. Move the mouse to wake the cursor.

$Url = "https://alchemydynamics.github.io/Alchemy_Screen_Saver/"

# --- Measure the full virtual desktop (bounding box of every monitor) --------
Add-Type -AssemblyName System.Windows.Forms
$vs = [System.Windows.Forms.SystemInformation]::VirtualScreen
$x = $vs.X; $y = $vs.Y; $w = $vs.Width; $h = $vs.Height
Write-Host "Spanning desktop: ${w}x${h} at offset ($x,$y)"

# --- Locate a Chromium-based browser -----------------------------------------
$candidates = @(
  "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
  "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
  "$env:LocalAppData\Google\Chrome\Application\chrome.exe",
  "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe",
  "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe"
)
$browser = $candidates | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $browser) { Write-Error "No Chrome or Edge found. Install Chrome or edit this script."; exit 1 }

# --- Launch one chromeless window spanning the whole wall --------------------
# A dedicated profile dir lets the window open at our exact size/position and
# keeps the camera permission remembered between runs.
$profileDir = Join-Path $env:TEMP "alchemy-wall-profile"

$args = @(
  "--app=$Url",
  "--user-data-dir=$profileDir",
  "--window-position=$x,$y",
  "--window-size=$w,$h",
  "--disable-infobars",
  "--noerrdialogs",
  "--autoplay-policy=no-user-gesture-required"
)

Start-Process -FilePath $browser -ArgumentList $args
Write-Host "Launched. If it didn't span all monitors, make sure they're arranged in one row in Display Settings."
