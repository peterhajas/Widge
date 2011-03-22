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

#import "WGRootController.h"

#define WIDGET_PATH @"/Library/Application Support/Widge/Widgets/"

@implementation WGRootController

-(void)loadWidgetBundles
{
	//Load all paths for the widget bundles
	NSArray *bundleNames = [[NSFileManager defaultManager] 
	                        contentsOfDirectoryAtPath:WIDGET_PATH
                            error:nil];
    
    NSMutableArray *paths = [[[NSMutableArray alloc] init] autorelease];
    
    widgetViewControllers = [[NSMutableArray alloc] init];
    
    for(NSString *bundleName in bundleNames)
    {
        NSString *bundlePath = [WIDGET_PATH stringByAppendingPathComponent:bundleName];
        [paths addObject:bundlePath];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        [widgetViewControllers addObject:[bundle principalClass]];
    }
}

//This is for demo purposes only:

-(WGWidgetViewController *)initDemoWidget
{
    if([widgetViewControllers count] != 0)
    {
        WGWidgetViewController* widget = [[[widgetViewControllers objectAtIndex:0] alloc] init];
        [widget.view setFrame:CGRectMake(0,0,160,110)];
        return widget;
    }
    return nil;
}



@end