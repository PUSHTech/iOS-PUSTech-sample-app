/**
 Bus event emitted whenever a new message of any conversation has been received or any conversation message has been readed. Event bus listeners (see `PSHBusProvider`) must implement the following method for event awareness:
 
    -(void)onLocationErrorBusEvent:(NSNotification*)notification
    {
        ...
    }
 */


#import <Foundation/Foundation.h>

@interface PSHLocationErrorBusEvent : NSObject

@end
