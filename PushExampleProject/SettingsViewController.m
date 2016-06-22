//
//  SettingsViewController.m
//  PushExampleProject
//
//  Created by Ben Cortes on 19/06/16.
//  Copyright © 2016 PushTech. All rights reserved.
//

#import "SettingsViewController.h"
#import <PushTechSDK/PushTechSDK.h>

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *pushSwitch;
@property (weak, nonatomic) IBOutlet UILabel *state;


@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Settings";
    [_pushSwitch addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeSwitch:(id)sender{
    if([sender isOn]){
        [PSHMetrics sendMetricSubscribe];
        self.state.text = @"Subscribed";
        // If you don't force send the metrics, the SDK will do it for you every 5 minutes.
        [PSHMetrics forceSendMetrics];
        
    } else{
        [PSHMetrics sendMetricUnsubscribe];
        self.state.text = @"Unsubscribed";
        // If you don't force send the metrics, the SDK will do it for you every 5 minutes.
        [PSHMetrics forceSendMetrics];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
