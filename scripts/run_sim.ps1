# =============================================================================
# run_sim.ps1 - Vivado 2019.1 xsim 仿真脚本
# 用法：
#   powershell -ExecutionPolicy Bypass -File scripts\run_sim.ps1 -TB tb_rvtest -HEX sw\testprog\rvtest\hex\add.hex
# =============================================================================
param(
    [Parameter(Mandatory=$true)][string]$TB,
    [string]$HEX = "",
    [string]$DATA = "",
    [switch]$Wave,
    [string]$Define = ""
)

$vivado = "D:\xilinx\Vivado\2019.1\bin"
$root   = "D:\my_project\Ultra RISC-V"
$work   = Join-Path $root ("sim\work\" + $TB)

New-Item -ItemType Directory -Force -Path $work | Out-Null
if ($HEX  -and (Test-Path $HEX))  { Copy-Item $HEX  (Join-Path $work "program.hex") -Force }
if ($DATA -and (Test-Path $DATA)) { Copy-Item $DATA (Join-Path $work "data.hex") -Force }

Set-Location $work

# ---- 1. 编译所有RTL + TB ----
$rtlFiles = @()
Get-ChildItem (Join-Path $root "rtl") -Filter *.v -Recurse | Sort-Object FullName |
    ForEach-Object { $rtlFiles += $_.FullName }
$tbFile = Join-Path $root ("tb\" + $TB + ".v")
if (-not (Test-Path $tbFile)) { Write-Host "ERROR: TB not found: $tbFile"; exit 1 }

Write-Host "== xvlog 编译 =="
$defineArgs = @()
if ($DATA) { $defineArgs += "-d"; $defineArgs += "DMEM_INIT" }
if ($Define) { foreach ($m in ($Define -split ',')) { if ($m) { $defineArgs += "-d"; $defineArgs += $m } } }
& "$vivado\xvlog.bat" -work work $defineArgs $rtlFiles $tbFile 2>&1 | Out-Host
if ($LASTEXITCODE -ne 0) { Write-Host "COMPILE FAILED"; exit 1 }

# ---- 2.  elaborate ----
Write-Host "== xelab 详细展开 =="
& "$vivado\xelab.bat" -L work -debug typical $TB -s sim_snapshot 2>&1 | Out-Host
if ($LASTEXITCODE -ne 0) { Write-Host "ELAB FAILED"; exit 1 }

# ---- 3. 仿真 ----
Write-Host "== xsim 运行 =="
if ($Wave) {
    $tcl = "open_vcd `"waves.vcd`"`nlog_vcd [get_objects -r /$TB/*]`nrun all`nclose_vcd`nquit`n"
} else {
    $tcl = "run all`nquit`n"
}
$tcl | Out-File -FilePath (Join-Path $work "run.tcl") -Encoding ascii
$simout = & "$vivado\xsim.bat" sim_snapshot -t run.tcl 2>&1
$simout | Out-Host

# ---- 4. 判定结果 ----
if ($simout -match "TEST PASSED") {
    Write-Host ">>> RESULT: PASS"
    exit 0
} elseif ($simout -match "TEST FAILED") {
    Write-Host ">>> RESULT: FAIL"
    exit 1
} else {
    Write-Host ">>> RESULT: UNKNOWN"
    exit 2
}
