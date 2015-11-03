//
//  KASettingsReader.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KASettingsReader.h"
#import "KASettings.h"

@implementation KASettingsReader

+ (KASettings *)readSettings {
    return [[KASettings alloc] initWithDirectories:@[@"/Users/Kenny/Desktop/Classes"] fileExtensions:@[@"h", @"swift", @"m"]];
}

@end
