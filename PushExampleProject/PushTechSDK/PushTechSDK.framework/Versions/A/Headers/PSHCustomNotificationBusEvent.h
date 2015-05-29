#import <Foundation/Foundation.h>
#import "PSHCustomDAO.h"

/**
 Bus event emitted after a successful app registration, that is when local model has been updated with the necessary info from Push Technologies platform in order to perform any operation. Event bus listeners (see `PSHBusProvider`) must implement the following method for event awareness:
 
    -(void)onCustomNotificationBusEvent:(NSNotification*)notification
    {
        PSHCustomNotificationBusEvent* event = (PSHCustomNotificationBusEvent*) notification.object;
        PSHCustomDAO *custom = event.custom;
        ...
    }
 */

@interface PSHCustomNotificationBusEvent : NSObject

/**
 *  Custom notification.
 */
@property (nonatomic, strong) PSHCustomDAO *custom;

@end
