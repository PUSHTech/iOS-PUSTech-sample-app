
#import <PushTechSDK/PushTechSDK.h>
#import <AMSmoothAlert/AMSmoothAlertView.h>

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIButton *sendTestPushButton;
@property (weak, nonatomic) IBOutlet UIButton *sendMetricsButton;
@property (weak, nonatomic) IBOutlet UIButton *campaignListButton;

@property (nonatomic, assign) BOOL shouldVerifyCode;

@property (nonatomic) AMSmoothAlertView *currentAlert;

@end

@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self roundButtons];
}

#pragma mark - IBActions

- (IBAction)sendMetricsButtonPressed:(id)sender {
    
    //Showcase of all the metrics avaliable.
    
    // Custom metrics
    [PSHMetrics sendCustomMetricBoolean:YES type:@"boolean_type" subtype:@"boolean_subtype"];
    
    [PSHMetrics sendCustomMetricDate:[NSDate date] type:@"date_type" subtype:@"date_subtype"];
    
    [PSHMetrics sendCustomMetricString:@"This is a string" type:@"string_type" subtype:@"string_subtype"];
    
    [PSHMetrics sendCustomMetricNumber:@(123.456) type:@"number_type" subtype:@"number_subtype"];
    
    // Model metrics
    [PSHMetrics sendMetricGender:PSHGenderTypeMale];
    
    [PSHMetrics sendMetricBirthday:[NSDate date]];
    
    [PSHMetrics sendMetricCarrierName:@"AT&T"];
    
    [PSHMetrics sendMetricCity:@"New York"];
    
    [PSHMetrics sendMetricCountry:@"US"];
    
    [PSHMetrics sendMetricFacebookFriends:1234];
    
    [PSHMetrics sendMetricFacebookLogin];
    
    [PSHMetrics sendMetricTwitterFollowers:1234];
    
    [PSHMetrics sendMetricTwitterLogin];
    
    [PSHMetrics sendMetricGoogleLogin];
    
    [PSHMetrics sendMetricFirstName:@"John"];
    
    [PSHMetrics sendMetricLastName:@"Doe"];
    
    [PSHMetrics sendMetricEmail:@"email@email.me"];
    
    [PSHMetrics sendMetricPhone:@"+15417543010"];
    
    [PSHMetrics sendMetricPurchaseProduct:@"iPhone 6" productId:@"h92j38d7" price:@(799.99) currency:@"USD"];
    
    //If you don't force send the metrics, the SDK will do it for you every 5 minutes.
    [PSHMetrics forceSendMetrics];
    
    [self showAlertWithTitle:@"Success!" message:@"Metrics sent." type:AlertSuccess];
}


- (IBAction)sendTestPushButtonPressed:(id)sender {
    [[PSHEngine sharedInstance]
        sendTestPushNotificationWithAccountID:@""
                                 masterSecret:@""
                                   completion:^(NSError *error, id obj)
     {
         if (!error) {
             [self showAlertWithTitle:@"Info"
                              message:@"Push notification is on it's way..."
                                 type:AlertInfo];
         } else {
             [self showAlertWithTitle:@"Error"
                              message:@"Something went wrong"
                                 type:AlertFailure];
         }
     }];
}

#pragma mark - Utils

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message type:(AlertType)type
{
    self.currentAlert = [[AMSmoothAlertView alloc] initDropAlertWithTitle:title
                                                                  andText:message
                                                          andCancelButton:NO
                                                             forAlertType:type];

    __weak __typeof(self) wself = self;
    self.currentAlert.completionBlock = ^(AMSmoothAlertView *alert, UIButton *button){
        wself.currentAlert = nil;
    };
    [self.currentAlert show];
}

- (BOOL)systemVersionIsPostiOS8 {
    SEL selector = @selector(registerUserNotificationSettings:);
    return [[UIApplication sharedApplication] respondsToSelector:selector];
}

- (void)roundButtons
{
    [self setupButtonsWithBlock:^(UIButton *aButton) {
        aButton.layer.cornerRadius = 4;
    }];
}

- (void)setupButtonsWithBlock:(void(^)(UIButton *aButton))setupBlock
{
    [self enumerate:@[self.sendTestPushButton,
                      self.sendMetricsButton,
                      self.campaignListButton]
          withBlock:^(id obj) {
              setupBlock(obj);
          }];
}

- (void)enumerate:(NSArray *)array withBlock:(void(^)(id obj))block {
    [array enumerateObjectsWithOptions:kNilOptions usingBlock:^(id obj,
                                                                NSUInteger idx,
                                                                BOOL *stop) {
        block(obj);
    }];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    if (self.currentAlert) {
        [self.currentAlert dismissAlertView];
    }
}

@end
