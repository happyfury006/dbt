# Prepare dbt sur n'importe quel poste.
# Usage (depuis K:\Bureau\zz3\BI\dbt) :
#   Set-ExecutionPolicy -Scope Process Bypass; . .\setup_dbt.ps1
# Le point + espace au debut est obligatoire pour que le venv reste active.

$venv = Join-Path $env:LOCALAPPDATA "dbt_venv"
$uvBin = Join-Path $env:USERPROFILE ".local\bin"
$env:Path = "$uvBin;$env:Path"

# 1. Installer uv s'il n'est pas sur ce poste
if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
    Write-Host "Installation de uv..." -ForegroundColor Cyan
    powershell -ExecutionPolicy Bypass -c "irm https://astral.sh/uv/install.ps1 | iex"
}

# 2. Creer le venv local + installer dbt s'il n'existe pas sur ce poste
if (-not (Test-Path (Join-Path $venv "Scripts\dbt.exe"))) {
    Write-Host "Creation du venv dans $venv ..." -ForegroundColor Cyan
    uv venv --python 3.11 $venv
    uv pip install --python (Join-Path $venv "Scripts\python.exe") dbt-mysql
}

# 3. Activer le venv
. (Join-Path $venv "Scripts\Activate.ps1")
Write-Host "dbt pret." -ForegroundColor Green
