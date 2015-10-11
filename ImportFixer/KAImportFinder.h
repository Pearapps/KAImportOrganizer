//
//  ImportFinder.h
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/10/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

@import Foundation;
#import "KALineReader.h"

@interface KAImportFinder : NSObject

- (instancetype)initWithLineReader:(id <KALineReader>)lineReader;

- (NSArray *)importStrings;

@end
