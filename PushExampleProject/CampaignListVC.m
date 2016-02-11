//
//  CampaignListVC.m
//  PushExampleProject
//
//  Created by Andreu Santaren Llop on 11/2/16.
//  Copyright © 2016 PushTech. All rights reserved.
//

#import "CampaignListVC.h"

@interface CampaignListVC ()

@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation CampaignListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"CAMPAIGN LIST VC");
    
    self.contentView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.contentView.alpha = 0;
    self.contentView.hidden = NO;
    
    [UIView animateKeyframesWithDuration:0.5
                                   delay:0.1
                                 options:kNilOptions
                              animations:^{
                                  
                                  self.contentView.alpha = 1.0f;
                                  
                              } completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeButtonPressed:(id)sender {
    
    NSLog(@"GO BACK");
    
    [UIView animateKeyframesWithDuration:0.5
                                   delay:0.0
                                 options:kNilOptions
                              animations:^{
                                  
                                  self.contentView.alpha = 0;
                                  
                              } completion:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
