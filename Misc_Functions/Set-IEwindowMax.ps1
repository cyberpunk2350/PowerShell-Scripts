Function Set-IEwindowMax {
    param (
        [Parameter(Mandatory = $true)]
        [object] $ie
    )

$sw = @'
[DllImport("user32.dll")]
public static extern int ShowWindow(int hwnd, int nCmdShow);
'@

    $type = Add-Type -Name ShowWindow2 -MemberDefinition $sw -Language CSharpVersion3 -Namespace Utils -PassThru
    $type::ShowWindow($ie.hwnd, 3) # 3 = maximize 

}
