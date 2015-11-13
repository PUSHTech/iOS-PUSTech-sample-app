
#import <Foundation/Foundation.h>
#import "PSHCampaignDAO.h"
#import "PSHCustomDAO.h"

typedef NS_ENUM(NSUInteger, PSHNotificationDefaultAction) {
    PSHNotificationDefaultActionLandingPage,
    PSHNotificationDefaultActionNone
};

@interface PSHNotification : NSObject

@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, strong) PSHCampaignDAO *campaign;
@property (nonatomic, strong) PSHCustomDAO *custom;
@property (nonatomic, assign) PSHNotificationDefaultAction defaultAction;

@end
