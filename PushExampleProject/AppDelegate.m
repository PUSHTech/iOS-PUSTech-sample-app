
#import <PushTechSDK/PushTechSDK.h>
#import <AMSmoothAlert/AMSmoothAlertView.h>

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
        didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    [PSHEngine initializeWithAppId:@""
                         appSecret:@""
                          listener:self
                          logLevel:PSHLogLevelNone];
    
    PSHNotificationType notificationTypes = PSHNotificationTypeAlert |
                                            PSHNotificationTypeBadge |
                                            PSHNotificationTypeSound;
    [PSHEngine registerApplication:application forNotificationTypes:notificationTypes];
    
    return YES;
}

- (void)application:(UIApplication *)application
        didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"Token registered with apple = %@", deviceToken);
    [[PSHEngine sharedInstance] registerPushToken:deviceToken];
}

- (void)application:(UIApplication *)application
        didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Error registering token = %@", error);
}

- (void)application:(UIApplication *)application
        didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [self handleRemotePushNotification:userInfo completion:^{
        //
    }];
}

- (void)application:(UIApplication*)application
        didReceiveRemoteNotification:(NSDictionary*)userInfo
        fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [self handleRemotePushNotification:userInfo completion:^{
        completionHandler(UIBackgroundFetchResultNewData);
    }];
}

- (void)handleRemotePushNotification:(NSDictionary *)userInfo
                          completion:(void (^)())completionHandler
{
    __weak __typeof(self) weakSelf = self;
    
    void (^onCustomCompletion)(BOOL, PSHCustomDAO *) = ^(BOOL completion,
                                                         PSHCustomDAO *custom) {
        [weakSelf showAlertWithTitle:@"Custom notification!" subtitle:custom.title];
        completionHandler();
    };
    void (^onCampaignCompletion)(BOOL, PSHCampaignDAO *) = ^(BOOL completion,
                                                             PSHCampaignDAO *campaign) {
        [weakSelf showAlertWithTitle:campaign.title subtitle:campaign.text];
        completionHandler();
    };
    void (^onOtherCompletion)(NSDictionary *) = ^(NSDictionary *userInfo) {
        [weakSelf showAlertWithTitle:@"Other notification!" subtitle:@""];
        completionHandler();
    };
    void (^onFailure)(NSError *error) = ^(NSError *error){
        [weakSelf showAlertWithTitle:@"Something went wrong..." subtitle:@""];
        completionHandler();
    };
    
    PSHEngine *engine = [PSHEngine sharedInstance];
    [engine handleRemotePushWithUserInfo:userInfo
                        completionCustom:onCustomCompletion
                      completionCampaign:onCampaignCompletion
                         completionOther:onOtherCompletion
                                    fail:onFailure];
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

#pragma mark - Event bus listener

-(void)onSuccessfulAppRegistrationBusEvent:(NSNotification*)notification
{
    NSLog(@"App is registered.");
}

-(void)onSuccessfulDeviceIdBusEvent:(NSNotification*)notification
{
    NSString *deviceId = [PSHEngine sharedInstance].deviceId;
    // Need a DeviceID to be able to send notifications using the PUSH Techoloigies server API.
    // The app will normally send the DeviceID to a backend server that later will use it to send
    // requests to the PUSH Tecnologies server.
    NSLog(@"Received DeviceID = %@.", deviceId);
}

#pragma mark - Application state

- (void)applicationWillResignActive:(UIApplication *)application {
    //
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    //
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //
}

- (void)applicationWillTerminate:(UIApplication *)application {
    //
}

@end
