
#import <PushTechSDK/PushTechSDK.h>

#import "AppDelegate.h"
#import "NotificationDelegate.h"
#import "EventBusDelegate.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>


@interface AppDelegate () <PSHLandingPageDelegate>

@property (nonatomic, strong) NotificationDelegate *notificationDelegate;
@property (nonatomic, strong) EventBusDelegate *eventBusDelegate;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
        didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupPushTechSDK];
    [self setupFabric];
    return YES;
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

- (void)willShowLandingPageWithURLString:(NSString *)URLString
{
    NSLog(@"willshow LP");
}

- (void)willDismissLandingPageWithURLString:(NSString *)URLString
{
    NSLog(@"willdismiss LP");
}
- (BOOL)shouldNavigateToPageWithURLRequest:(NSURLRequest *)request
{
    NSLog(@"will navigate");
    return YES;
}

- (void)setupFabric
{
    [Fabric with:@[CrashlyticsKit]];
}

@end
