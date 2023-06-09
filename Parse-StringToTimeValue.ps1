function Parse-StringToTimeValue ([string] $value, [switch] $returnString=$false)
{
    [string] $value_  = $value
    [System.Collections.ArrayList] $output_ = @()
    [int[]] $maxPosVal_ = @(24,60,60)
    [string] $subVal_ = "00"
    [bool] $isTimeVal = $true
     
    switch ($value.Length)
    {
        0   {
                $output_ = @("00","00","00")
                break
            }
        #if there are only numbers...
        {($value -replace '\D+').Length -eq $_} 
            {
                switch ($value_.length)
                {
                    1 {
                        $outHH = "0"+$value_
                        break
                       }
              default {
                do {
                        #Write-host "`"$value_`" ($($value_.Length))"
                        $subVal_ = $value_.Substring(0,2)
                        #Write-Host "$subVal_ [$($maxPosVal_[$output_.Count])] ($($output_.Count)) $([int]$subVal_ -lt $maxPosVal_[$output_.Count])"
                        if ([int]$subVal_ -lt $maxPosVal_[$output_.Count])
                        {
                            $output_.Add($subVal_)|Out-Null
                            $value_ = $value_.Substring(2,$value_.Length-2)
                        }
                        else
                        {
                            $output_.Add( "0"+$value_[0])|Out-Null
                            $value_ = $value_.Substring(1,$value_.Length-1)
                        }
                    } while ($isTimeVal -and ($output_.Count -lt 3) -and $value_.Length)
                }
            }
            break
        }
    }
    if ($returnString)
    {
        return ($output_ -join ":")
    }
    else
    {
        return [datetime] ($output_ -join ":")
    }
}
