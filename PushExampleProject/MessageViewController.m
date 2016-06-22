//
//  MessageViewController.m
//  PushExampleProject
//
//  Created by Ben Cortes on 06/06/16.
//  Copyright © 2016 PushTech. All rights reserved.
//

#import "MessageViewController.h"
#import <PushTechSDK/PushTechSDK.h>
#import "WebViewController.h"

@interface MessageViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong)        NSMutableArray *campaignList;
@property (strong, nonatomic)        NSString *campUrl;


@end

@interface MessageCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imagecampaign;

- (void)mapData:(PSHCampaignDAO *)campaignDAO;

@end


@implementation MessageViewController

@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Message center";
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.campaignList = [[PSHEngine sharedInstance] campaignList].mutableCopy;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    self.navigationController.tabBarItem.badgeValue = nil;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [refreshControl endRefreshing];
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View Controller stuff

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.campaignList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    [cell mapData:(PSHCampaignDAO *)self.campaignList[indexPath.row]];
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if ([self.campaignList count] >= 1) {
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return 1;
        
    } else {
        
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"You have no messages yet! \n Please, pull down to refresh.";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
        [messageLabel sizeToFit];
        
        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return 0;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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

#pragma mark - Navigation

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    PSHCampaignDAO *camp = self.campaignList[indexPath.row];
    
    if (camp.URL.absoluteString.length == 0) {
        UIAlertView *contentAlert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"There is no landing page with this campaign" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [contentAlert show];
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    WebViewController *destViewController = segue.destinationViewController;
    PSHCampaignDAO *camp = self.campaignList[indexPath.row];
    
    if ([segue.identifier isEqualToString:@"segueWebview"] && !(camp.URL == nil)) {
        destViewController.landingPage = camp.URL;
    }
}

@end

@implementation MessageCell

- (void)mapData:(PSHCampaignDAO *)campaignDAO {
    
    self.titleLabel.text = campaignDAO.title;
    self.contentLabel.text = campaignDAO.text;
    self.imagecampaign.image = [UIImage imageNamed:@"Placeholder"];
    
    NSURL *urlcamp = [NSURL URLWithString:[campaignDAO.thumbnailURL absoluteString]];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:urlcamp completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                        self.imagecampaign.image = image;
                });
            }
        }
    }];
    
    [task resume];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *stringFromDate = [formatter stringFromDate:campaignDAO.date];
    self.dateLabel.text = stringFromDate;

}

- (void)prepareForReuse {
    self.imageView.image = nil;
}

@end
