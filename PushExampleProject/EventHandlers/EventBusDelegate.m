
#import "EventBusDelegate.h"

@implementation EventBusDelegate

- (void)onDidRegisterForRemoteNotificationsBusEvent:(NSNotification *)notification
{
    NSString *deviceToken = [PSHModel sharedInstance].managerInfo.pushToken;
    NSLog(@"Remote push notification token: %@", deviceToken);
}

- (void)onDidFailToRegisterForRemoteNotificationsBusEvent:(NSNotification *)notification
{
    NSLog(@"Failed to register push token.");
}

- (void)onSuccessfulAppRegistrationBusEvent:(NSNotification *)notification
{
    NSLog(@"SuccessfulAppRegistration");
}

- (void)onSuccessfulDeviceIdBusEvent:(NSNotification *)notification
{
    NSString *deviceId = [PSHEngine sharedInstance].deviceId;
    // Need a DeviceID to be able to send notifications using the PUSH Techoloigies server API.
    // The app will normally send the DeviceID to a backend server that later will use it to send
    // requests to the PUSH Tecnologies server.
    NSLog(@"Received DeviceID = %@.", deviceId);
}

- (void)onSDKVersionDowngradedBusEvent:(NSNotification *)notification
{
    NSLog(@"SDK version downgraded: %f", [PSHModel sharedInstance].managerInfo.currentSDKVersion);
}

- (void)onSDKVersionUpgradedBusEvent:(NSNotification *)notification
{
    NSLog(@"SDK version upgrade: %f", [PSHModel sharedInstance].managerInfo.currentSDKVersion);
}

@end
