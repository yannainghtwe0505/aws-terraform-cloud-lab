# Run Checkov's Python script directly to bypass Windows .py association warnings.
$checkovScripts = & py -c "import sysconfig; print(sysconfig.get_path('scripts'))"
if ($LASTEXITCODE -ne 0) {
  throw "Python could not be located using the py launcher."
}

$checkovEntry = Join-Path $checkovScripts 'checkov'
if (-not (Test-Path -LiteralPath $checkovEntry)) {
  throw "Checkov is not installed for this Python interpreter. Install it with: py -m pip install checkov"
}

& py $checkovEntry -d $PSScriptRoot --framework terraform --compact @args
exit $LASTEXITCODE
