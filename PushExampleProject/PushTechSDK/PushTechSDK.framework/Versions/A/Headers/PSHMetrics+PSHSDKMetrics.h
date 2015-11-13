
#import <UIKit/UIKit.h>

#import "PSHMetrics.h"

@interface PSHMetrics (PSHSDKMetrics)

+ (instancetype)sharedInstance;

- (NSString *)valueTypeForValue:(id)value;
- (void)sendReceivedCampaignMetricWithId:(NSString *)campaignId;
- (void)sendInternalMetrics;

@end
