//
//  UIImage+tv.m
//  
//
//  Created by Tik on 30/8/17.
//
//

#import "UIImage+tv.h"

@implementation UIImage (tv)

+(UIImage *)tvChannelByName:(NSString *)channelName {
    
    UIImage *image;
    NSString *lcaseChannelName = [channelName lowercaseString];
    
    if([lcaseChannelName isEqualToString:@"seven"]) {
        image = [UIImage imageNamed:@"Channel_7"];
    }else if([lcaseChannelName isEqualToString:@"7mate"]) {
        image = [UIImage imageNamed:@"Channel_7Mate"];
    }else if([lcaseChannelName isEqualToString:@"7two"]) {
        image = [UIImage imageNamed:@"Channel_7Two"];
    }else if([lcaseChannelName isEqualToString:@"abc1"]) {
        image = [UIImage imageNamed:@"Channel_ABC"];
    }else if([lcaseChannelName isEqualToString:@"eleven"]) {
        image = [UIImage imageNamed:@"Channel_11"];
    }else if([lcaseChannelName isEqualToString:@"nine"]) {
        image = [UIImage imageNamed:@"Channel_9"];
    }else if([lcaseChannelName isEqualToString:@"one"]) {
        image = [UIImage imageNamed:@"Channel_1"];
    }else if([lcaseChannelName isEqualToString:@"sbs 2"]) {
        image = [UIImage imageNamed:@"Channel_SBS_2"];
    }else if([lcaseChannelName isEqualToString:@"sbs one"]) {
        image = [UIImage imageNamed:@"Channel_SBS_1"];
    }else if([lcaseChannelName isEqualToString:@"ten"]) {
        image = [UIImage imageNamed:@"Channel_10"];
    }
    return image;
}

+(UIImage *)tvRatingByCode:(NSString *)code {
    
    UIImage *image = [UIImage imageNamed:@"NoRating"];
    NSString *rating = [code uppercaseString];
    
    if([rating isEqualToString:@"AV"]) {
        image = [UIImage imageNamed:@"Rating_AV"];
    }else if([rating isEqualToString:@"G"]) {
        image = [UIImage imageNamed:@"Rating_G"];
    }else if([rating isEqualToString:@"M"]) {
        image = [UIImage imageNamed:@"Rating_M"];
    }else if([rating isEqualToString:@"MA"]) {
        image = [UIImage imageNamed:@"Rating_MA"];
    }else if([rating isEqualToString:@"PG"]) {
        image = [UIImage imageNamed:@"Rating_PG"];
    }
    return image;
}

@end
