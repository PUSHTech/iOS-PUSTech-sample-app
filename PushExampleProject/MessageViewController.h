//
//  MessageViewController.h
//  PushExampleProject
//
//  Created by Ben Cortes on 06/06/16.
//  Copyright © 2016 PushTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

@interface MessageCell : UITableViewCell

@end