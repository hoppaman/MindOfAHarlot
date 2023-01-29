Scriptname SLAT_GlobalUtility  Hidden 

bool Function IsOn(GlobalVariable var) global
	return var.GetValue() > 0
endFunction