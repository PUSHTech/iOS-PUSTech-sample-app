
#import <Foundation/Foundation.h>

/**
 *  The kind of metric you want to send. 
 *  Each metric should be sent with the appropriate kind of data.
 */
typedef NS_ENUM(NSUInteger, PSHMetricType){
    /**
     *  Value has to be an NSDate object
     */
    PSHMetricTypeBirthday = 1,
    /**
     *  Value has to be an NSString object
     */
    PSHMetricTypeCountry,
    /**
     *  Value has to be an NSString object
     */
    PSHMetricTypeCity,
    /**
     *  Value has to be an NSString object with possible values @"MALE" or @"FEMALE"
     */
    PSHMetricTypeGender,
    /**
     *  Value has to be an NSNumber, the bool value will be used
     */
    PSHMetricTypeLinkedPhoneNumber,
    /**
     *  Value has to be an NSNumber, the bool value will be used
     */
    PSHMetricTypeLinkedEmail,
    /**
     *  Value has to be an NSDate object
     */
    PSHMetricTypeLastFacebookLogin,
    /**
     *  Value has to be an NSDate object
     */
    PSHMetricTypeLastTwitterLogin,
    /**
     *  Value has to be an NSNumber, the unsigned integer value will be used
     */
    PSHMetricTypeFacebookFriends,
    /**
     *  Value has to be an NSNumber, the unsigned integer value will be used
     */
    PSHMetricTypeTwitterFollowers,
    /**
     *  Value has to be an NSDate object
     */
    PSHMetricTypeLastGoogleLogin,
    /**
     *  Value has to be an NSDictionary with the following keys/values:
     *  <p>key:"name", value: An NSString with the product's name</p>
     *  <p>key:"price", value: An NSNumber containing the product's price</p>
     *  <p>key:"productId" value: An NSString with the product's id</p>
     *  <p>@{</p>
     *  <p style="text-indent: 2em;">    @"name"      : @"iPhone 6",</p>
     *  <p style="text-indent: 2em;">    @"price"     : [NSNumber numberWithDouble:1000.0],</p>
     *  <p style="text-indent: 2em;">    @"productId" : @"8932423ASDa"</p>
     *  <p>}</p>
     */
    PSHMetricTypeProductPurchase,
    /**
     *  Value has to be an NSString object
     */
    PSHMetricTypeCarrierName,
    /**
     * Value has to be an NSString object with the campaignId
     */
    PSHMetricTypeViewedCampaign
};

@interface PSHMetrics : NSObject

/**
 *  This method should be used to send the metrics;
 *
 *  @param type  The type of metric.
 *  @param value The value of the metric. It should be the specified value for each type of metric.
 */
+ (void)sendMetricOfType:(PSHMetricType)type value:(id)value;

/**
 *  Use this method to send your custom metrics to the manager.
 *
 *  @param type    An NSString defining the type of your metric.
 *  @param subtype An NSString defining the subtype of your metric.
 *  @param value   An NSString with the value of your metric.
 */
+ (void)sendCustomMetricWithType:(NSString *)type
                         subtype:(NSString *)subtype
                           value:(NSString *)value;

/**
 *  Use this method to send the metrics immediately.
 */
+ (void)forceSendMetrics;

/**
 *  By default the send interval is 5 minutes.
 *
 *  @param timeInterval
 */
+ (void)setMetricSendInterval:(NSTimeInterval)timeInterval;

@end
