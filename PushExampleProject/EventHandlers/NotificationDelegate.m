
#import <AMSmoothAlert/AMSmoothAlertView.h>

#import "NotificationDelegate.h"

@implementation NotificationDelegate

- (BOOL)shouldPerformDefaultActionForRemoteNotification:(PSHNotification *)notification
                                      completionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    if ([self applicationIsInBackground]) {
        //
    } else {
        if (notification.defaultAction == PSHNotificationDefaultActionLandingPage) {
            //
        } else {
            [self showAlertWithTitle:notification.campaign.title subtitle:notification.campaign.text];
        }
    }
    completionHandler(UIBackgroundFetchResultNewData);
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

- (BOOL)applicationIsInBackground
{
    return ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground ||
            [UIApplication sharedApplication].applicationState == UIApplicationStateInactive);
}

@end
