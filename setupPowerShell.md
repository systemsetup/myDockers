### About your PowerShell
```
get-host
```
Alternatively,
```
$PSVersionTable
```
**Terminology**: Each of the above commands entered in the PowerShell console are called _cmdlet_ (_commandlet_).

### Get PowerShell version
```
$PSVersionTable.PSVersion
```

### Get `$host` members
```
$host | gm
```

#### Color of error messages appearing in the PowerShell console
```
$host.PrivateData | gm
```

#### Console host UI
```
$host.UI | gm
```
and
```
$host.UI.RawUI | gm
```
Available colors that comes with the installed PowerShell are: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, and White. To view these colors you need to install [TMOutput Module](https://www.powershellgallery.com/packages/TMOutput/) using the following command in the PowerShell console.
```
Install-Module -Name TMOutput
```
Then,
```
Show-TMOutputColor
```

You can use any of these colors to change the color appearing on the console. Say,
```
$host.UI.RawUI.ForegroundColor = "White"
$host.UI.RawUI.BackgroundColor = "Magenta"
```

Alternatively,
```
Set-PSReadlineOption -TokenKind Parameter -ForegroundColor White
```
or
```
Set-PSReadlineOption -TokenKind Comment -ForegroundColor White -BackgroundColor Black
```
Reset to default colors
```
Set-PSReadlineOption -ResetTokenColors
```

This is of the form `Set-PSReadlineOption -TokenKind Parameter -<Token> Blue`. To get the list of tokens (and returns the current state of the settings)
```
Get-PSReadlineOption
```

### Give custom title to the Powershell window
```
$Host.UI.RawUI.WindowTitle=”Custom Title of This Window”
```

### Determine Powershell profile location
```
$profile
```
This will return the local path to `Microsoft.PowerShell_profile.ps1`. The script could include something like
```
$Shell = $Host.UI.RawUI
$Shell.WindowTitle=”Docker PowerShell”
$Shell.BackgroundColor=”White”
$Shell.ForegroundColor=”Blue”
$size = $Shell.WindowSize
$size.width=120
$size.height=55
$Shell.WindowSize = $size
$size = $Shell.BufferSize
$size.width=120
$size.height=5000
$Shell.BufferSize = $size
Clear-Host
```

### What is the current color setting?
```
Get-PSReadlineOption | Select *color
```

### Reset color to default setting.
```
Set-PSReadlineOption -ResetTokenColors
```
