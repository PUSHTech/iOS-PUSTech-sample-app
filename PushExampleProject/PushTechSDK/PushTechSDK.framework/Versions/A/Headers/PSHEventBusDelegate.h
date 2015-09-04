
@protocol PSHEventBusDelegate <NSObject>

@optional
- (void)onSuccessfulAppRegistrationBusEvent:(NSNotification *)notification;
- (void)onSuccessfulDeviceIdBusEvent:(NSNotification *)notification;
- (void)onSDKVersionDowngradedBusEvent:(NSNotification *)notification;
- (void)onSDKVersionUpgradedBusEvent:(NSNotification *)notification;
- (void)onDidFailToRegisterForRemoteNotificationsBusEvent:(NSNotification *)notification;
- (void)onDidRegisterForRemoteNotificationsBusEvent:(NSNotification *)notification;

@end