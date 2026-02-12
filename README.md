# AMSI Bypass - Educational

A simple, well-commented demonstration of AMSI (Anti-Malware Scan Interface) field corruption bypass for educational purposes and security research.

## ⚠️ Disclaimer

This repository is for **educational and authorized security testing only**. Misuse of these techniques may be illegal. Always obtain proper authorization before testing.

## 📚 What is AMSI?

AMSI is a Windows security interface that allows applications and services to integrate with anti-malware products. PowerShell uses AMSI to scan scripts for malicious content before execution.

## 🎯 The Technique

**Field Corruption Bypass** - Uses .NET reflection to manipulate internal PowerShell AMSI fields

The script demonstrates three methods:
1. **`amsiInitFailed = true`** - Makes PowerShell think AMSI failed to initialize ✅ *Most reliable*
2. **`amsiContext = null`** - Removes the AMSI context handle (add these yourself! )
3. **`amsiSession = null`** - Removes the AMSI session handle (add these yourself! )

**Do you need all three?** No! Usually **one is enough** (prefer `amsiInitFailed`), but using all three:
- Provides redundancy across different PowerShell versions
- Increases success rate if one method is detected/patched
- Ensures compatibility with PS5 and PS7

## 🚀 Quick Start

```powershell
# Run the bypass
.\bypass_field_educational.ps1

# Test if AMSI is bypassed (this string normally triggers detection)
'amsiutils'
```

## 🔬 How It Works

### Field Corruption Method
1. Accesses `System.Management.Automation.AmsiUtils` class via reflection
2. Uses `BindingFlags` to access private static fields
3. Sets `amsiInitFailed = true` (makes PS think AMSI failed to initialize)

### Why One Field Is Usually Enough
- **`amsiInitFailed`** alone is typically sufficient - most reliable single method
- **Multiple fields** provide redundancy across different PS versions
- Different PowerShell versions may have different field availability

## 🛡️ Evasion Techniques

- **Code splitting** - Break signatures across multiple files
- **Obfuscation** - Variable renaming, string encoding, comment injection
- **Memory patching** - Runtime modification of AMSI functions
- **C++ DLL** - Compiled binary harder to detect than scripts

## 🔍 Detection & Defense

Defenders can detect these techniques by:
- Monitoring reflection usage on AMSI-related types (`AmsiUtils`, etc.)
- Hooking memory write operations to AMSI regions
- Detecting common bypass patterns/signatures
- Using behavioral analysis instead of static signatures
- Event logging when AMSI fields are modified

## 🎓 Learning Path

1. Study the well-commented `bypass_field_educational.ps1` code
2. Understand .NET reflection and how to access private fields
3. Learn about AMSI internals and the role of each field
4. Experiment in isolated lab environments only
5. Research defensive measures and detection methods

## ⚖️ Legal Notice

These tools are provided for educational purposes only. Use only in authorized environments. Unauthorized access to computer systems is illegal.

---

**For Security Researchers | Red Team Training | Defensive Security Education**
