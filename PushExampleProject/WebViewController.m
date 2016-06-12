//
//  WebViewController.m
//  PushExampleProject
//
//  Created by Ben Cortes on 06/06/16.
//  Copyright © 2016 PushTech. All rights reserved.
//

#import "WebViewController.h"
#import "MessageViewController.h"


@interface WebViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end

@implementation WebViewController

@synthesize landingPage;

- (void)viewDidLoad {
    self.webView.delegate = self;
    
    // Load the URL of the Landing page
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:landingPage];
    [_webView loadRequest:requestObj];
    
    [super viewDidLoad];
    
}

#pragma mark - UIWebViewDelegate Protocol Methods

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)wv didFailLoadWithError:(NSError *)error
{
    NSLog(@"Failed: %@", error);
    if([error code] == NSURLErrorCancelled){
        return;
    }
    [self.activityIndicator stopAnimating];
    [[[UIAlertView alloc] initWithTitle:@"Cannot find the Landing page" message:@"Check your internet connection and try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]show];
}

@end
