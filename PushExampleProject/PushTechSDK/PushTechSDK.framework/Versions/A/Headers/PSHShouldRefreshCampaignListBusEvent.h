#import <Foundation/Foundation.h>

/**
 Bus event emitted after a push notification has been parsed and a new campaign information has been detected. Event bus listeners (see `PSHBusProvider`) must implement the following method for event awareness:
 
    -(void)onShouldRefreshCampaignListBusEvent:(NSNotification*)notification
    {
        PSHShouldRefreshCampaignListBusEvent* event = (PSHShouldRefreshCampaignListBusEvent*) notification.object;
    }
 */
@interface PSHShouldRefreshCampaignListBusEvent : NSObject

@end
