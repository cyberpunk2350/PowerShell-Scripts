Function Date {
    [CmdletBinding()]
    param(
        [int]$sub
    )

    if($sub -ne $null){
        $date = (get-date).AddDays(-$sub)
    }else{
        $date = get-date
    }

	$Day		= ($date.day)
	$MonthNumber = ($date.month)
	$MonthNumberLong = (Convert-Month -MonthWord ((Convert-Month -MonthNumber $date.month)) -TwoDigit)
	$MonthLong	= ((Convert-Month -MonthNumber $date.month))
	$MonthShort	= ((Convert-Month -MonthNumber $date.month -MonthShort))
	$year		= ($date.year)
	[string]$yyyymmdd =  "$year-$MonthNumberLong-$day"
	[string]$yyyyMMMdd = "$year-$MonthShort-$day"
	[string]$ddMMMyyyy = "$day $MonthShort $year"
	
	
	
	$properties = [ordered]@{
		Day = $Day
		MonthNumber = $MonthNumber
		MonthNumberLong = $MonthNumberLong
		MonthLong = $MonthLong
		MonthShort = $MonthShort
		year = $year
		yyyymmdd =  $yyyymmdd 
		yyyyMMMdd = $yyyyMMMdd
		ddMMMyyyy = $ddMMMyyyy
	}

	$obj = New-Object -TypeName PSObject -Property $properties
		Return $obj	
}

Function Convert-Month {
	[CmdletBinding()]
    param(
		[ValidateRange(1,12)]
		[Int]$MonthNumber = $null, 
		[ValidateSet("January","February","March","April","May","June","July","August","September","October","November","December")]
		[String]$MonthWord = "",
		[Switch]$MonthShort = $false,
		[switch]$TwoDigit = $false
	)
	
	Write-Debug "MonthNumber: $MonthNumber"
	Write-Debug "MonthWord: $MonthWord"
	Write-Debug "MonthShort: $MonthShort"
	Write-Debug "TwoDigit: $TwoDigit"
	
	
	if (($MonthNumber -gt 0) -and ($MonthWord -ne "")){throw "Pick ONE! not both!"}
	
	if ($MonthNumber -gt 0){
		Write-Debug "MonthShort: $MonthShort -> Long Month IF Statement"	
				if($MonthNumber -eq 1) {$month="January"}
			elseif($MonthNumber -eq 2) {$month="February"}
			elseif($MonthNumber -eq 3) {$month="March"}
			elseif($MonthNumber -eq 4) {$month="April"}
			elseif($MonthNumber -eq 5) {$month="May"}
			elseif($MonthNumber -eq 6) {$month="June"}
			elseif($MonthNumber -eq 7) {$month="July"}
			elseif($MonthNumber -eq 8) {$month="August"}
			elseif($MonthNumber -eq 9) {$month="September"}
			elseif($MonthNumber -eq 10){$month="October"}
			elseif($MonthNumber -eq 11){$month="November"}
			elseif($MonthNumber -eq 12){$month="December"}
			else{throw "Error in Long Month Part of Function"}
			if($MonthShort){
			$month = $month.substring(0, 3)
			}
		Write-Debug "Results: $month"
		} 
	
	if ($MonthWord -ne ""){
		Write-Debug "MonthWord: $MonthWord -> Month Word IF Statement"	
			if($MonthWord.StartsWith("Jan","CurrentCultureIgnoreCase") ) {$month =  1}
		elseif($MonthWord.StartsWith("Feb","CurrentCultureIgnoreCase") ) {$month =  2}
		elseif($MonthWord.StartsWith("Mar","CurrentCultureIgnoreCase") ) {$month =  3}
		elseif($MonthWord.StartsWith("Apr","CurrentCultureIgnoreCase") ) {$month =  4}
		elseif($MonthWord.StartsWith("May","CurrentCultureIgnoreCase") ) {$month =  5}
		elseif($MonthWord.StartsWith("Jun","CurrentCultureIgnoreCase") ) {$month =  6}
		elseif($MonthWord.StartsWith("Jul","CurrentCultureIgnoreCase") ) {$month =  7}
		elseif($MonthWord.StartsWith("Aug","CurrentCultureIgnoreCase") ) {$month =  8}
		elseif($MonthWord.StartsWith("Sep","CurrentCultureIgnoreCase") ) {$month =  9}
		elseif($MonthWord.StartsWith("Oct","CurrentCultureIgnoreCase") ) {$month = 10}
		elseif($MonthWord.StartsWith("Nov","CurrentCultureIgnoreCase") ) {$month = 11}
		elseif($MonthWord.StartsWith("Dec","CurrentCultureIgnoreCase") ) {$month = 12}
		else{throw "Error in One Digit Month Number Part of Function"}
		if($TwoDigit){
			Write-Debug "TwoDigit: $TwoDigit -> Two Digit IF Statement"	
				if($month -lt 10){$month="0$month"}
			}
		Write-Debug "Results: $month"	
	
	}
	$month
}
