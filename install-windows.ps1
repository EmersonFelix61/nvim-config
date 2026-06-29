$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$RepositoryUrl = "https://github.com/EmersonFelix61/nvim-config"
$RepositoryBranch = "configs-casa"
$NeovimVersion = "0.11.5"

if ([string]::IsNullOrWhiteSpace($env:LOCALAPPDATA)) {
    throw "A variável LOCALAPPDATA não está definida."
}

$ConfigDir = Join-Path $env:LOCALAPPDATA "nvim"
$StagingDir = Join-Path $env:LOCALAPPDATA ("nvim.installing." + $PID)
$BackupDir = $null
$StagingCreated = $false
$InstallComplete = $false

function Write-Info {
    param([Parameter(Mandatory = $true)][string]$Message)
    Write-Host "[INFO] $Message"
}

function Test-ExternalCommand {
    param([Parameter(Mandatory = $true)][string]$Name)
    return $null -ne (Get-Command -Name $Name -ErrorAction SilentlyContinue)
}

function Get-MissingDependencies {
    $dependencies = @(
        @{ Name = "git"; Command = "git" },
        @{ Name = "nvim"; Command = "nvim" },
        @{ Name = "node"; Command = "node" },
        @{ Name = "npm"; Command = "npm" },
        @{ Name = "rg"; Command = "rg" },
        @{ Name = "fd"; Command = "fd" },
        @{ Name = "python"; Command = "python" },
        @{ Name = "curl"; Command = "curl.exe" },
        @{ Name = "make"; Command = "make" }
    )

    $missing = @()
    foreach ($dependency in $dependencies) {
        if (Test-ExternalCommand $dependency.Command) {
            Write-Info "Dependência encontrada: $($dependency.Name)"
        }
        else {
            Write-Warning "Dependência ausente: $($dependency.Name)"
            $missing += $dependency.Name
        }
    }

    if ((Test-ExternalCommand "cc") -or (Test-ExternalCommand "gcc") -or (Test-ExternalCommand "clang") -or (Test-ExternalCommand "cl")) {
        Write-Info "Dependência encontrada: C compiler"
    }
    else {
        Write-Warning "Dependência ausente: C compiler"
        $missing += "C compiler"
    }

    if (Test-ExternalCommand "nvim") {
        $versionLine = (& nvim --version | Select-Object -First 1)
        if ($versionLine -notmatch '^NVIM v0\.11\.') {
            Write-Warning "Versão incompatível do Neovim: $versionLine. Esta configuração requer Neovim 0.11.x."
            if ($missing -notcontains "nvim") {
                $missing += "nvim"
            }
        }
    }

    return $missing
}

function Show-WingetSuggestions {
    param([string[]]$MissingDependencies)

    if ($MissingDependencies.Count -eq 0) {
        return
    }

    if (-not (Test-ExternalCommand "winget")) {
        Write-Warning "winget não está disponível. Instale as dependências ausentes manualmente."
        return
    }

    $suggestions = @(
        @{ Dependency = "git"; Command = "winget install --id Git.Git -e" },
        @{ Dependency = "nvim"; Command = "winget install --id Neovim.Neovim -e --version $NeovimVersion" },
        @{ Dependency = "node"; Command = "winget install --id OpenJS.NodeJS.LTS -e" },
        @{ Dependency = "npm"; Command = "winget install --id OpenJS.NodeJS.LTS -e" },
        @{ Dependency = "rg"; Command = "winget install --id BurntSushi.ripgrep.MSVC -e" },
        @{ Dependency = "fd"; Command = "winget install --id sharkdp.fd -e" },
        @{ Dependency = "python"; Command = "winget install --id Python.Python.3.13 -e" },
        @{ Dependency = "curl"; Command = "winget install --id cURL.cURL -e" },
        @{ Dependency = "make"; Command = "winget install --id GnuWin32.Make -e" },
        @{ Dependency = "C compiler"; Command = "winget install --id LLVM.LLVM -e" }
    )

    Write-Info "Comandos sugeridos; nenhum será executado automaticamente:"
    foreach ($suggestion in $suggestions) {
        if ($MissingDependencies -contains $suggestion.Dependency) {
            Write-Host "  $($suggestion.Command)"
        }
    }
}

function Backup-ExistingConfig {
    if (-not (Test-Path -LiteralPath $ConfigDir)) {
        return
    }

    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $script:BackupDir = "$ConfigDir.backup.$timestamp"
    if (Test-Path -LiteralPath $script:BackupDir) {
        $script:BackupDir = "$($script:BackupDir).$PID"
    }

    Move-Item -LiteralPath $ConfigDir -Destination $script:BackupDir
    Write-Info "Configuração existente movida para: $script:BackupDir"
}

function Install-Config {
    if (-not (Test-ExternalCommand "git")) {
        throw "git é necessário para clonar a configuração."
    }

    if (Test-Path -LiteralPath $StagingDir) {
        throw "O diretório temporário já existe: $StagingDir"
    }

    Write-Info "Clonando $RepositoryUrl, branch $RepositoryBranch..."
    $script:StagingCreated = $true
    & git clone --branch $RepositoryBranch --single-branch $RepositoryUrl $StagingDir
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "O clone falhou; o diretório parcial será removido."
        throw "A configuração atual não foi alterada."
    }

    Backup-ExistingConfig
    try {
        Move-Item -LiteralPath $StagingDir -Destination $ConfigDir
    }
    catch {
        Write-Warning "Não foi possível ativar a nova configuração."
        if ($null -ne $script:BackupDir -and -not (Test-Path -LiteralPath $ConfigDir)) {
            try {
                Move-Item -LiteralPath $script:BackupDir -Destination $ConfigDir
                Write-Warning "A configuração anterior foi restaurada."
            }
            catch {
                Write-Warning "Restaure manualmente o backup: $script:BackupDir"
            }
        }
        throw
    }

    Write-Info "Configuração instalada em: $ConfigDir"
}

function Test-NeovimBoot {
    if (-not (Test-ExternalCommand "nvim")) {
        Write-Warning "Neovim não está disponível; o teste de boot não pôde ser executado."
        return
    }

    $tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("nvim-audit-" + $PID)
    $stateHome = Join-Path $tempRoot "state"
    $cacheHome = Join-Path $tempRoot "cache"
    $outputFile = Join-Path $tempRoot "nvim-output.log"
    $verboseLog = Join-Path $tempRoot "nvim-verbose.log"
    New-Item -ItemType Directory -Path $stateHome, $cacheHome -Force | Out-Null

    $previousLogFile = $env:NVIM_LOG_FILE
    $previousStateHome = $env:XDG_STATE_HOME
    $previousCacheHome = $env:XDG_CACHE_HOME

    try {
        $env:NVIM_LOG_FILE = Join-Path $tempRoot "nvim.log"
        $env:XDG_STATE_HOME = $stateHome
        $env:XDG_CACHE_HOME = $cacheHome

        Write-Info "Instalando/sincronizando plugins conforme o lazy-lock.json..."
        $syncOutput = @(& nvim --headless -i NONE ("-V1" + $verboseLog) -u (Join-Path $ConfigDir "init.lua") '+Lazy! sync' +qa 2>&1)
        $syncExitCode = $LASTEXITCODE
        $syncOutput | Set-Content -LiteralPath $outputFile
        if ($syncExitCode -ne 0 -or ($syncOutput -join "`n") -match 'Error detected|Error in .*init\.lua|\bE\d+:|stack traceback') {
            $syncOutput | Write-Host
            throw "A sincronização dos plugins falhou."
        }

        Write-Info "Validando o boot do Neovim..."
        $bootOutput = @(& nvim --headless -i NONE ("-V1" + $verboseLog) -u (Join-Path $ConfigDir "init.lua") '+lua if vim.v.errmsg ~= "" then vim.cmd("cquit 1") end' +qa 2>&1)
        $bootExitCode = $LASTEXITCODE
        $bootOutput | Set-Content -LiteralPath $outputFile
        if ($bootExitCode -ne 0 -or ($bootOutput -join "`n") -match 'Error detected|Error in .*init\.lua|\bE\d+:|stack traceback') {
            $bootOutput | Write-Host
            throw "O teste de boot do Neovim falhou."
        }
    }
    finally {
        $env:NVIM_LOG_FILE = $previousLogFile
        $env:XDG_STATE_HOME = $previousStateHome
        $env:XDG_CACHE_HOME = $previousCacheHome
        if (Test-Path -LiteralPath $tempRoot) {
            Remove-Item -LiteralPath $tempRoot -Recurse -Force
        }
    }
    Write-Info "Boot validado."
}

try {
    $missingDependencies = @(Get-MissingDependencies)
    Show-WingetSuggestions -MissingDependencies $missingDependencies
    if ($missingDependencies.Count -ne 0) {
        throw "Instale as dependências ausentes e execute este script novamente."
    }
    Install-Config
    Test-NeovimBoot
    $script:InstallComplete = $true
}
finally {
    if ($script:StagingCreated -and (Test-Path -LiteralPath $StagingDir)) {
        Remove-Item -LiteralPath $StagingDir -Recurse -Force
    }
    if (-not $script:InstallComplete -and $null -ne $script:BackupDir -and (Test-Path -LiteralPath $script:BackupDir)) {
        if (Test-Path -LiteralPath $ConfigDir) {
            $failedDir = "$ConfigDir.failed.$PID"
            Move-Item -LiteralPath $ConfigDir -Destination $failedDir
            Write-Warning "A instalação incompleta foi preservada em: $failedDir"
        }
        Move-Item -LiteralPath $script:BackupDir -Destination $ConfigDir
        Write-Warning "A configuração anterior foi restaurada porque a instalação não foi concluída."
    }
}
