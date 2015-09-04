
#import <PushTechSDK/PushTechSDK.h>
#import <AMSmoothAlert/AMSmoothAlertView.h>

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *twoFactorLabel;

@property (weak, nonatomic) IBOutlet UIButton *textFieldButton;
@property (weak, nonatomic) IBOutlet UIButton *sendTestPushButton;
@property (weak, nonatomic) IBOutlet UIButton *sendMetricsButton;

@property (nonatomic, assign) BOOL shouldVerifyCode;

@property (nonatomic) AMSmoothAlertView *currentAlert;

@end

@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self roundButtons];
    [self setupTapGesture];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self prepareMainViewForAnimation];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self animateMainView];
    [self setupTwoFactorTextField];
}

#pragma mark - IBActions

- (IBAction)textFieldButtonPressed:(id)sender {
    [self.textField resignFirstResponder];
    if (self.shouldVerifyCode) {
        [[PSHEngine sharedInstance] validateCode:self.textField.text
                                      completion:^(NSError *error, id obj)
         {
             if (error) {
                 [self showAlertWithTitle:@"Error"
                                  message:error.localizedDescription
                                     type:AlertFailure];
             } else {
                 [self showAlertWithTitle:@"Sucess!"
                                  message:@"The code has been verified."
                                     type:AlertSuccess];
                 self.shouldVerifyCode = NO;
                 [self setupTwoFactorTextField];
             }
         }];
    } else {
        NSInteger phoneNumber = self.textField.text.integerValue;
        [[PSHEngine sharedInstance] sendAuthenticationSMSToPhoneNumber:phoneNumber
                                                           countryCode:34
                                                              senderId:nil
                                                             brandName:nil
                                                            completion:^(NSError *error, id obj)
         {
             if (error) {
                 [self showAlertWithTitle:@"Error"
                                  message:error.localizedDescription
                                     type:AlertFailure];
             } else {
                 [self showAlertWithTitle:@"Success!"
                                  message:@"Wait for your verification code."
                                     type:AlertSuccess];
                 self.shouldVerifyCode = YES;
                 [self setupTwoFactorTextField];
             }
         }];
    }
}

- (IBAction)sendMetricsButtonPressed:(id)sender {
    
    //Showcase of all the metrics avaliable.
    
    [PSHMetrics sendMetricOfType:PSHMetricTypeGender
                           value:@"MALE"];
    
    [PSHMetrics sendMetricOfType:PSHMetricTypeBirthday
                           value:[NSDate date]];
    
    [PSHMetrics sendMetricOfType:PSHMetricTypeCarrierName
                           value:@"AT&T"];
    
    [PSHMetrics sendMetricOfType:PSHMetricTypeCity
                           value:@"New York"];
    
    [PSHMetrics sendMetricOfType:PSHMetricTypeCountry
                           value:@"USA"];
    
    [PSHMetrics sendMetricOfType:PSHMetricTypeFacebookFriends
                           value:[NSNumber numberWithUnsignedInteger:10000]];
    
    [PSHMetrics sendMetricOfType:PSHMetricTypeFacebookLogin];
    
    [PSHMetrics sendMetricOfType:PSHMetricTypeGoogleLogin];
    
    [PSHMetrics sendMetricOfType:PSHMetricTypeTwitterLogin];
    
    [PSHMetrics sendMetricOfType:PSHMetricTypeEmail
                           value:@"an@email.com"];
    
    [PSHMetrics sendMetricOfType:PSHMetricTypePhoneNumber
                           value:@"+34789675928"];
    
    NSDictionary *purchase = @{
                               @"name"      : @"iPhone 6",
                               @"price"     : [NSNumber numberWithDouble:1000.0],
                               @"productId" : @"h92j38d7"
                               };
    [PSHMetrics sendMetricOfType:PSHMetricTypeProductPurchase
                           value:purchase];
    
    [PSHMetrics sendMetricOfType:PSHMetricTypeTwitterFollowers
                           value:@(5000)];
    
    [PSHMetrics sendMetricOfType:PSHMetricTypeViewedCampaign
                           value:@"campaignId9238oy933"];
    
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

- (void)setupTapGesture
{
    UITapGestureRecognizer *tapGesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    [self.textField resignFirstResponder];
}

- (void)setupTwoFactorTextField
{
    self.textField.text = @"";
    if (self.shouldVerifyCode) {
        self.textField.placeholder = @"Verification code";
        [self.textFieldButton setTitle:@"Verify code" forState:UIControlStateNormal];
    } else {
        self.textField.placeholder = @"Phone number";
        [self.textFieldButton setTitle:@"Send verification code" forState:UIControlStateNormal];
    }
}

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

- (void)hideInputs {
    [self enumerate:@[self.textField,
                      self.textFieldButton,
                      self.sendMetricsButton,
                      self.sendTestPushButton,
                      self.twoFactorLabel]
          withBlock:^(id obj) {
              [(UIView *)obj setAlpha:0];
          }];
}

- (void)showInputs {
    [self enumerate:@[self.textField,
                      self.textFieldButton,
                      self.sendMetricsButton,
                      self.sendTestPushButton,
                      self.twoFactorLabel]
          withBlock:^(id obj) {
              [(UIView *)obj setAlpha:1];
          }];
}

- (void)roundButtons
{
    [self setupButtonsWithBlock:^(UIButton *aButton) {
        aButton.layer.cornerRadius = 4;
    }];
}

- (void)setupButtonsWithBlock:(void(^)(UIButton *aButton))setupBlock
{
    [self enumerate:@[self.textFieldButton,
                      self.sendTestPushButton,
                      self.sendMetricsButton]
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

#pragma mark - Animations

- (void)prepareMainViewForAnimation
{
    if ([self systemVersionIsPostiOS8]) {
        CGFloat topPadding = 24;
        CGFloat initialMainViewVisibleHeight = 22;
        CGFloat screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
        CGFloat initialYTraslation = screenHeight - topPadding - initialMainViewVisibleHeight;
        
        self.mainView.layer.transform =
            CATransform3DMakeTranslation(0,
                                         initialYTraslation,
                                         0);
        [self hideInputs];
    }
}

- (void)animateMainView
{
    if ([self systemVersionIsPostiOS8]) {
        
        void(^showInputsAnimation)(BOOL) = ^(BOOL finished) {
            [UIView animateKeyframesWithDuration:0.6
                                           delay:0.2
                                         options:kNilOptions
                                      animations:^{
                                          [self showInputs];
                                      } completion:nil];
            
        };
        
        [UIView animateWithDuration:0.88
                              delay:0.5
             usingSpringWithDamping:0.72
              initialSpringVelocity:0.5
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.mainView.layer.transform = CATransform3DIdentity;
                         } completion:showInputsAnimation];
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    if (self.currentAlert) {
        [self.currentAlert dismissAlertView];
    }
}

@end
