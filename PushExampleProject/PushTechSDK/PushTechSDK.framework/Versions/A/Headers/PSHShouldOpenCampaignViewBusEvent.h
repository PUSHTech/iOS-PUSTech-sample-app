#import <Foundation/Foundation.h>
#import "PSHCampaignDAO.h"

/**
 Bus event emitted whenever user taps on a row in the campaigns tab, so this only makes sense when `instantiateMainTabBarViewController` of `PSHEngine` is used. Event bus listeners (see `PSHBusProvider`) must implement the following method for event awareness:
 
    -(void)onShouldOpenCampaignViewBusEvent:(NSNotification*)notification
    {
        PSHShouldOpenCampaignViewBusEvent* event = (PSHShouldOpenCampaignViewBusEvent*) notification.object;
        ...
    }
 */
@interface PSHShouldOpenCampaignViewBusEvent : NSObject

/**
 *  `PSHCampaignDAO` instance with Push Technologies Manager campaign related information.
 */
@property (nonatomic, strong) PSHCampaignDAO* campaign;

@end
