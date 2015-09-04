
#import <UIKit/UIKit.h>

#import "PSHNotification.h"

@protocol PSHNotificationDelegate <NSObject>

@required
/**
 *  This method is called when a notification is received in foreground of background.
 *
 *  @param completionHandler Execute this callback when you are finished performing the background
 *  operations. It's important to execute this callback once you have finished all your operations,
 *  since this tells the system to terminate your application. If you don't execute the callback,
 *  the system will assume your application is not working and no more notifications will be 
 *  delivered to your app.
 *
 *  @return Wether the SDK can execute the default actions for this notification of not.
 */
- (BOOL)shouldPerformDefaultActionForRemoteNotification:(PSHNotification *)notification
        completionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

@end