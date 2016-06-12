
#import <PushTechSDK/PushTechSDK.h>

#import "AppDelegate.h"
#import "NotificationDelegate.h"
#import "EventBusDelegate.h"

@interface AppDelegate () <PSHLandingPageDelegate>

@property (nonatomic, strong) NotificationDelegate *notificationDelegate;
@property (nonatomic, strong) EventBusDelegate *eventBusDelegate;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
        didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupPushTechSDK];
    
    NSDictionary *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (notification) {
        // App received notification from remote
        NSLog(@"app received notification from remote%@",notification);
        [self application:application didReceiveRemoteNotification:notification];
    }else{
        // App did not receive notification
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
    [[tabController.viewControllers objectAtIndex:1] tabBarItem].badgeValue = @"New!";
}

- (void)setupPushTechSDK
{
    [self setupLandingPageTheme];
    [PSHEngine startWithEventBusDelegate:self.eventBusDelegate = [EventBusDelegate new]
                    notificationDelegate:self.notificationDelegate = [NotificationDelegate new]];     
}

- (void)setupLandingPageTheme
{
    PSHLandingPageTheme *theme = [PSHLandingPageTheme defaultTheme];
    theme.borderColor = [UIColor colorWithRed:236.0/255.0 green:0 blue:84.0/255.0 alpha:1.0];
    [PSHLandingPage useTheme:theme];
    [PSHLandingPage setDelegate:self];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)willShowLandingPageWithURLString:(NSString *)URLString
{
    NSLog(@"will show landing page");
}

- (void)willDismissLandingPageWithURLString:(NSString *)URLString
{
    NSLog(@"will dismiss landing page");
}
- (BOOL)shouldNavigateToPageWithURLRequest:(NSURLRequest *)request
{
    NSLog(@"will navigate");
    return YES;
}

@end
