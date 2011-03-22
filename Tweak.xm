/*
Copyright (C) 2010-2011 Peter Hajas, Dustin Howett

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#import <SpringBoard/SpringBoard.h>
#import <WidgeKit/WGWidgetViewController.h>
#import "WGRootController.h"

UIView* widgetView;

%hook SpringBoard

-(void)applicationDidFinishLaunching:(id)application
{
    %orig;
    
    //Create a root widget controller. Should we move this to a SpringBoard ivar?
    WGRootController* widgeRootController = [[WGRootController alloc] init];
    [widgeRootController loadWidgetBundles];

    //Grab the demo widget
    WGWidgetViewController* demoWidget = [widgeRootController initDemoWidget];
    
    NSLog(@"............................%@", NSStringFromClass([demoWidget class]));
    
    //Set the proportions of the widgetWindow    
    widgetView = [[UIView alloc] initWithFrame:CGRectMake(320,20,320,460)];
	widgetView.userInteractionEnabled = YES;
	widgetView.hidden = NO;
	widgetView.clipsToBounds = NO;
	widgetView.backgroundColor = [UIColor clearColor];
    
    NSLog(@"............................Adding widget");
    
    //Add the demowidget to the widgetview
    [widgetView addSubview:demoWidget.view];
    
    //Add the widgetview to the scrollview in springboard
    SBIconController *sbic = (SBIconController *)[%c(SBIconController) sharedInstance];
    UIScrollView *_scrollView = [sbic scrollView];
    [_scrollView addSubview:widgetView];
    
    NSLog(@"............................Widget added");
}

%end

%hook SBIconController

// Reimplementation of -[SBIconController updateRootIconListFrames] from 4.1
// Mightbe better to do a supercall and adjust the frames afterwards. Thoughts?
- (void)updateRootIconListFrames {
	%log;
	UIScrollView *_scrollView = MSHookIvar<UIScrollView *>(self, "_scrollView");
	UIView *_searchView = MSHookIvar<UIView *>(self, "_searchView");
	NSMutableArray *_rootIconLists = MSHookIvar<NSMutableArray *>(self, "_rootIconLists");
	float height = _scrollView.frame.size.height;
	float width = _scrollView.frame.size.width;
	int numpages = 2; // account for searchview
	float off = width * numpages;
	int i = 0;
	for(UIView *v in _rootIconLists) {
		if([v superview] != _scrollView) {
			[_scrollView addSubview:v];
		}
		[v setFrame:CGRectMake(off+(width*i),0,width,height)];
		i++;
		numpages++;
	}
	CGRect scrollViewFrame = _scrollView.frame;
	[_scrollView setContentSize:CGSizeMake(scrollViewFrame.size.width * numpages, scrollViewFrame.size.height)];
	NSLog(@"--content size is %@", NSStringFromCGSize(_scrollView.contentSize));
	[_scrollView bringSubviewToFront:_searchView];
	return;
}

- (BOOL)isShowingSearch {
	return MSHookIvar<int>(self, "_currentIconListIndex") == -2;
}

// reimplementation, 4.1
// todo: make better, i missed some of the cases in the original
// fixes the "icons are unloaded because they are on an unknown page" issue
- (int)lowestVisibleIconListIndexAndColumn:(int *)column totalLists:(unsigned)lists columnsPerList:(int)columnsPerList {
	UIScrollView *_scrollView = MSHookIvar<UIScrollView *>(self, "_scrollView");
	CGPoint contentOffset = _scrollView.contentOffset;
	CGRect frame = _scrollView.frame;
	if(contentOffset.x < frame.size.width*2) {
		if(column) {
			*column = (lists == 0 ? 0 : columnsPerList - 1);
		}
		unsigned idx = ((contentOffset.x) / frame.size.width);
		return -2+idx;
	} else {
		unsigned idx = ((contentOffset.x - frame.size.width*2) / frame.size.width);
		if(idx <= lists) {
			if(column) {
				SBIconListView *currentRootIconList = [self rootIconListAtIndex:idx];
				float x, y;
				x = fmodf(contentOffset.x, frame.size.width);
				y = contentOffset.y;
				int col = [currentRootIconList columnAtPoint:CGPointMake(x, y)];
				if(col >= 0) {
					if(col >= columnsPerList) col = columnsPerList - 1;
				} else col = 0;
				*column = col;
			}
		} else {
			idx = lists - 1;
			if(column) {
				*column = columnsPerList - 1;
			}
		}
		return idx;
	}
}

-(void)scrollToIconListAtIndex:(int)index animate:(BOOL)animate
{
	//Scroll to the location asked for plus 1 at the original animate setting
	//This retains feature parity with the traditional scrollToIconListAtIndex: animate: behavior
	%orig(index + 1, animate);
}

%end

%hook SBIconScrollView

- (CGSize)contentSize
{
	CGSize size = %orig;
	UIScreen *screen = [UIScreen mainScreen];
	CGSize newSize = CGSizeMake(size.width + screen.bounds.size.width, size.height);
	return newSize;	
}

%end

%hook SBIconListPageControl
- (void)setNumberOfPagesWithIconListCount:(int)count {
	[self setNumberOfPages:count + 2];
}

- (void)setCurrentPageWithIconListNumber:(int)number {
	[self setCurrentPage:number + 2];
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


// vim:ft=objc

