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

#import "DemoWidget.h"

@implementation DemoWidgetListController

-(void)viewDidLoad
{
    NSLog(@"view loaded! wow!");
    self.view.backgroundColor = [UIColor redColor];
}

-(NSString *)widgetName
{
    return @"Demo Widget";
}

-(int)iconRowsWide
{
    return 2;
}

-(int)iconColumnsTall
{
    return 2;
}

//Widget lifecycle

-(void)widgetWillAppear
{
	// We don't need any special behavior for this demo widget here.
}

-(void)widgetDidAppear
{
	// We don't need any special behavior for this demo widget here.
}

-(void)widgetWillDissapear
{
	// We don't need any special behavior for this demo widget here.
}

-(void)widgetDidDissapear
{
	// We don't need any special behavior for this demo widget here.
}

//Widget convenience methods

-(void)refreshTimerDidFire
{
	// We don't need any special behavior for this demo widget here.
}

@end

// vim:ft=objc
