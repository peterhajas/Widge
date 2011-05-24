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

-(id)init
{
    self = [super init];
    if(self)
    {
        widgetViewControllers = [[NSMutableArray alloc] init];
        widgetObjects = [[NSMutableArray alloc] init];
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        widgetView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, bounds.width, bounds.height)];
    }
    
    return self;
}

-(void)loadWidgetBundles
{
	//Load all paths for the widget bundles
	NSArray *bundleNames = [[NSFileManager defaultManager] 
	                        contentsOfDirectoryAtPath:WIDGET_PATH
                            error:nil];
    
    NSMutableArray *paths = [[[NSMutableArray alloc] init] autorelease];
    
    for(NSString *bundleName in bundleNames)
    {
        NSString *bundlePath = [WIDGET_PATH stringByAppendingPathComponent:bundleName];
        [paths addObject:bundlePath];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        [widgetViewControllers addObject:[bundle principalClass]];
    }
}

-(void)layOutWidgets
{
    // Iterate through the widgets, laying them out in our view
    
    int xCrosshair = 0;
    int yCrosshair = 0;
    
    for(WGWidgetViewController* widgetViewController in widgetViewControllers)
    {
        // Allocate the widget
        WGWidgetViewController* widget = [[widgetViewController alloc] init];
        
        [widgetObjects addObject:widget];
        
        
        // If there's enough room for the widget to the right of our crosshair, put it there
        if((kDeviceWidgetWidth - xCrosshair) <= [widget iconColumnsWide])
        {
            widget.view.origin = CGPointMake(xCrosshair * kIconPixelDimensions, yCrosshair * kIconPixelDimensions);
            xCrosshair += [widget iconColumnsWide];
        }
        //If there's not enough room, let's put it below
        else
        {
            xCrosshair = 0;
            yCrosshair += 1; // This is not good
            widget.view.origin = CGPointMake(xCrosshair * kIconPixelDimensions, yCrosshair * kIconPixelDimensions);
            
        }
        [widgetView addSubview: widget.view];
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