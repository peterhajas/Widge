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

-(int)iconColumnsWide
{
    return 2;
}

@end

// vim:ft=objc
