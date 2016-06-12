//
//  WebViewController.h
//  PushExampleProject
//
//  Created by Ben Cortes on 06/06/16.
//  Copyright © 2016 PushTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) NSURL *landingPage;

@end
