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

@property (nonatomic, strong) NSMutableArray *campaignList;

@end

@interface CampaignCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imagecampaign;

- (void)mapData:(PSHCampaignDAO *)campaignDAO;

@end

@implementation CampaignListVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.contentView.hidden = YES;
    
    self.campaignList = [[PSHEngine sharedInstance] campaignList].mutableCopy;
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
    
    PSHCampaignDAO *camp = self.campaignList[indexPath.row];
    
    if ([[UIApplication sharedApplication] canOpenURL:camp.URL]) {
        [[UIApplication sharedApplication] openURL:camp.URL];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *button =
    [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                       title:@"Delete"
                                     handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
     {
         PSHCampaignDAO *campaign = self.campaignList[indexPath.row];
         [[PSHEngine sharedInstance] deleteCampaign:campaign];
         
         [self.campaignList removeObjectAtIndex:indexPath.row];
         
         [self.tableView beginUpdates];
         [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
         [self.tableView endUpdates];
     }];
    
    button.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:0 blue:84.0f/255.0f alpha:1.0f];
    
    return @[button];
}

@end

@implementation CampaignCell

- (void)mapData:(PSHCampaignDAO *)campaignDAO {
    
    self.titleLabel.text = campaignDAO.title;
    self.testLabel.text = campaignDAO.text;
    
//    NSURL *url = [NSURL URLWithString:[campaignDAO.thumbnailURL absoluteString]];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    UIImage *image = [UIImage imageWithData:data];
//    [self.imagecampaign setImage:image];
//    self.imagecampaign.image = image;
    
//    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
//        //Background Thread
//        NSURL *url = [NSURL URLWithString:[campaignDAO.thumbnailURL absoluteString]];
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        UIImage *image = [UIImage imageWithData:data];
//        
//        dispatch_async(dispatch_get_main_queue(), ^(void){
//            //Run UI Updates
//            self.imagecampaign.image = image;
//        });
//    });
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    
    NSString *stringFromDate = [formatter stringFromDate:campaignDAO.date];
    
    self.dateLabel.text = stringFromDate;
}

@end
