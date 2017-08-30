//
//  UIImage+tv.h
//  
//
//  Created by Tik on 30/8/17.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (tv)

+(UIImage *)tvChannelByName:(NSString *)channelName;
+(UIImage *)tvRatingByCode:(NSString *)code;

@end
