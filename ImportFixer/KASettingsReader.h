//
//  KASettingsReader.h
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

@import Foundation;

@class KASettings;
@interface KASettingsReader : NSObject

+ (KASettings *)readSettings;

@end
