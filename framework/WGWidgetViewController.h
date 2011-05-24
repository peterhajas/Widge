/*
Copyright (C) 2010-2011 Peter Hajas, Dustin Howett

This work is licensed under the LGPL.

Please see the included License file in the framework directory.
*/

#import <UIKit/UIKit.h>

/** WGWidgetViewController is the primary class used in WidgeKit.
Internally, WGWidgetViewController is a subclass of UIViewController. 
You have access to all of UIViewController's methods and signals, but
you should use the widget lifecycle functions here to control widget
behavior, not the UIKit view lifecycle functions.

Widge will provide conveniences to your widget. The only defined
resource (currently) that Widge provides is a shared timer instance,
which will be fired when your widget should update itself.

Please avoid using a timer internally, as this can degrade
performance. Instead, use the shared timer resource, as it is user
controlled.
*/

@interface WGWidgetViewController : UIViewController

/** The name of the widget. */
-(NSString*)widgetName;
/** How many icons (SpringBoard icons) wide the widget is. */
-(int)iconColumnsWide;
/** How many icons (SpringBoard icons) tall the widget is. */
-(int)iconRowsTall;
/** Your widget will have this method called when it is about to appear. */
-(void)widgetWillAppear;
/** Your widget will have this method called when it has appeared. */
-(void)widgetDidAppear;
/** Your widget will have this method called when it is about to dissapear. */
-(void)widgetWillDissapear;
/** Your widget will have this method called when it has dissapeared. */
-(void)widgetDidDissapear;
/** Your widget will have this method called when the shared Widge timer, a communal resouce, has fired. */
-(void)refreshTimerDidFire;

@end