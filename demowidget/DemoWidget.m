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
