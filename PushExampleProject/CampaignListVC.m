//
//  CampaignListVC.m
//  PushExampleProject
//
//  Created by Andreu Santaren Llop on 11/2/16.
//  Copyright © 2016 PushTech. All rights reserved.
//

#import "CampaignListVC.h"
#import <PushTechSDK/PushTechSDK.h>

@interface CampaignListVC ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *campaignList;

@end

@interface CampaignCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (void)mapData:(PSHCampaignDAO *)campaignDAO;

@end

@implementation CampaignListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"CAMPAIGN LIST VC");
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.contentView.hidden = YES;
    
    self.campaignList = [[PSHEngine sharedInstance] campaignList];
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

#pragma mark - Table View Controller stuff

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.campaignList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CampaignCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CampaignCell" forIndexPath:indexPath];
    
    [cell mapData:(PSHCampaignDAO *)self.campaignList[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

@implementation CampaignCell

- (void)mapData:(PSHCampaignDAO *)campaignDAO {
    
    self.titleLabel.text = campaignDAO.title;
    self.testLabel.text = campaignDAO.text;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    
    NSString *stringFromDate = [formatter stringFromDate:campaignDAO.date];
    
    self.dateLabel.text = stringFromDate;
}

@end
