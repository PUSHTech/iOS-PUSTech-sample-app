#import <Foundation/Foundation.h>
#import "PSHCampaignDAO.h"

/**
 Bus event emitted after a successful app registration, that is when local model has been updated with the necessary info from Push Technologies platform in order to perform any operation. Event bus listeners (see `PSHBusProvider`) must implement the following method for event awareness:
 
    -(void)onCampaignNotificationBusEvent:(NSNotification*)notification
    {
        PSHCampaignNotificationBusEvent* event = (PSHCampaignNotificationBusEvent*) notification.object;
        PSHCampaignDAO *campaign = event.campaign;
        ...
    }
 */

@interface PSHCampaignNotificationBusEvent : NSObject

/**
 *  Campaign notification.
 */
@property (nonatomic, strong) PSHCampaignDAO *campaign;

@end
