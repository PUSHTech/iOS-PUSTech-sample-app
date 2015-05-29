#import <Foundation/Foundation.h>

/**
 Bus event emitted after a successful app registration, that is when local model has been updated with the necessary info from Push Technologies platform in order to perform any operation. Event bus listeners (see `PSHBusProvider`) must implement the following method for event awareness:
 
    -(void)onFailNotificationBusEvent:(NSNotification*)notification
    {
        PSHFailNotificationBusEvent* event = (PSHFailNotificationBusEvent*) notification.object;
        NSError *error = event.error;
        ...
    }
 */

@interface PSHFailNotificationBusEvent : NSObject

/**
 *  Error while hetting notification.
 */
@property (nonatomic, strong) NSError *error;

@end
