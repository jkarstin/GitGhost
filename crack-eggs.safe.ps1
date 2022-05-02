$GG_KITCHEN = Split-Path $MyInvocation.MyCommand.Path -Parent
Invoke-Expression "$GG_KITCHEN\crack-eggs --Safe $Args"
