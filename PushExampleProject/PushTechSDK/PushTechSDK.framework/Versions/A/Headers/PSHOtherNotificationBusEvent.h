#import <Foundation/Foundation.h>

/**
 Bus event emitted after a successful app registration, that is when local model has been updated with the necessary info from Push Technologies platform in order to perform any operation. Event bus listeners (see `PSHBusProvider`) must implement the following method for event awareness:
 
    -(void)onOtherNotificationBusEvent:(NSNotification*)notification
    {
        PSHOtherNotificationBusEvent* event = (PSHOtherNotificationBusEvent*) notification.object;
        NSDictionary *other = event.other;
        ...
    }
 */

@interface PSHOtherNotificationBusEvent : NSObject

/**
 *  Other notification (not a PUSH Technologies notification).
 */
@property (nonatomic, strong) NSDictionary *other;

@end
