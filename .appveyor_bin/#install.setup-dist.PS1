# install ~ setup distribution (dependencies, ...)
if ( $null -ne $env:CI_DEBUG ) { set-PSdebug -trace 1 }

$exit_val = 0

if ( $null -eq $env:CI_HELPERS ) { $env:CI_HELPERS = [IO.Path]::GetFullPath(".") }

& "${env:CI_HELPERS}\_install.setup-dist.BAT"
if ( $LASTEXITCODE -ne 0 ) { $exit_val = $LASTEXITCODE }

if ( "${env:DIST_TOOLING}".trim() -ieq 'build' -and $($_=$(perl -MModule::Build -e "print Module::Build->VERSION()").Replace("_",""); $_ -lt 0.421) ) { write-host $("WARN: using flawed early version of Module::Build ($_); consider requiring later version (v0.421+)") -f yellow }

set-PSdebug -off
exit $exit_val
