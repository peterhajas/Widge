#import <SpringBoard/SpringBoard.h>

%hook SBIconController

-(id)scrollView
{
	//Modify the parameters of the scrollView to add another page
	
	SBIconScrollView* scroll = %orig;

	//Expand contentSize (by 320pt, change this for iPad/Wildcat)
	scroll.contentSize = CGSizeMake(scroll.contentSize.width + 320, scroll.contentSize.height);

	//Move every page over one (by 320pt, this will need to be changed for iPad/Wildcat
	//We don't want to move the search view!
	unsigned int i;
	for(i = 0; i < [[scroll subviews] count] - 1; i++)
	{
		UIView *temp = [[scroll subviews] objectAtIndex:i];
	
		temp.frame = CGRectMake(temp.frame.origin.x+320, 0, 320, 351);
	}

	return scroll;
}

%end

/* How to Hook with Logos
Hooks are written with syntax similar to that of an Objective-C @implementation.
You don't need to #include <substrate.h>, it will be done automatically, as will
the generation of a class list and an automatic constructor.

%hook ClassName

// Hooking a class method
+ (id)sharedInstance {
	return %orig;
}

// Hooking an instance method with an argument.
- (void)messageName:(int)argument {
	%log; // Write a message about this call, including its class, name and arguments, to the system log.

	%orig; // Call through to the original function with its original arguments.
	%orig(nil); // Call through to the original function with a custom argument.

	// If you use %orig(), you MUST supply all arguments (except for self and _cmd, the automatically generated ones.)
}

// Hooking an instance method with no arguments.
- (id)noArguments {
	%log;
	id awesome = %orig;
	[awesome doSomethingElse];

	return awesome;
}

// Always make sure you clean up after yourself; Not doing so could have grave conseqeuences!
%end
*/
