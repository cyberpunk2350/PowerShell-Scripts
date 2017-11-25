#checks for an existing PSProfile if it does exist, it opends it; if not it creates one
function pro {
  if (test-path $PROFILE.CurrentUserCurrentHost){ 
    start notepad.exe $profile.CurrentUserCurrentHost 
  }  elseif (test-path $profile.CurrentUserAllHosts) {
    start notepad.exe $profile.CurrentUserAllHosts 
  } else { 
    new-item $PROFILE.CurrentUserAllHosts -ItemType file -Force
		start notepad.exe $profile.CurrentUserAllHosts
  }
}
