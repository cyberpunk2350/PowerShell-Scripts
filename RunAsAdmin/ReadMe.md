Recently I ran into an issue with an enterprise implementation of Win 10 where the Enterprise System Admins thought it would be 
prudent to disable the option to "run as admin"

Now while this might seem like a great security feature to implement at the user level, it really hinders 
the efforts of the Network Management Team, as well as the Server Admins, the Help Desk Tech, and the Field Techs...
aka all the power users.

After getting fed up with the 'work around' (shift + right click -> "run as other user" [we use secondary accounts for admin actions]) 
I tracked down how the change was implemented on the local level and now to "fix it", turned out to be a really simple reg hack. 

Then I decided to get clever and try to script it to run more automatically, because why not, and oh yeah there is GPO that would 
flip the bit back every night; that and the 30 seconds I spend running the reg hack was starting to grade on me...so yeah scripting...

Here is what I figured out so far...once I get it uploaded that is; but this is where it will go...more notes to follow.

