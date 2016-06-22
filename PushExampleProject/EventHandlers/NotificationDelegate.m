
#import <AMSmoothAlert/AMSmoothAlertView.h>

#import "NotificationDelegate.h"
#import "AppDelegate.h"


@implementation NotificationDelegate

- (BOOL)shouldPerformDefaultActionForRemoteNotification:(PSHNotification *)notification
                                      completionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{    
    if ([self applicationIsInBackground]) {
        // App is in background
    } else {
        if (notification.defaultAction == PSHNotificationDefaultActionLandingPage) {
            // The notification contains a landing page. Return NO here if your app will handle landing pages by its own
        } else {
            // The notification is a normal push, explore "notification" object to extract poyload like:
            // notification.campaign.title
            // notification.campaign.text
            // ...
            [self showAlertWithTitle:notification.campaign.title subtitle:notification.campaign.text];
        }
    }
    completionHandler(UIBackgroundFetchResultNewData);
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] setBadgeTabBar];
    
    return YES;
}

- (void)showAlertWithTitle:(NSString *)title subtitle:(NSString *)subtitle
{
    AMSmoothAlertView *alert =
        [[AMSmoothAlertView alloc] initDropAlertWithTitle:title
                                                  andText:subtitle
                                          andCancelButton:NO
                                             forAlertType:AlertSuccess];
    [alert show];
}

- (void)performInteraction:(NSString *)actionID onNotification:(PSHNotification *)notification {
    
    // Handle your interactive Push notification when a user select one of the options
    NSLog(@"PUSH action = %@ on notification = %@", actionID, notification);
    [self showAlertWithTitle:actionID subtitle:@"Call your method to handle the interative Push notification!"];
}

- (BOOL)applicationIsInBackground
{
    return ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground ||
            [UIApplication sharedApplication].applicationState == UIApplicationStateInactive);
}



@end
