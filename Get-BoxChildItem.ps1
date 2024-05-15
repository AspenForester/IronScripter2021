function Get-BoxChildItem
{
    param (
        # Parameter help description
        [Parameter()]
        [Switch]
        $DoThing
    )

    Get-ChildItem -Path . -File
}
