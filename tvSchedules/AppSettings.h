//
//  AppSettings.h
//  tvSchedules
//
//  Created by Tik on 30/8/17.
//  Copyright © 2017 tipayanond. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppSettings : NSObject

@property (readonly) NSString *showURL;

+(AppSettings *)sharedInstance;

@end
