//
//  KAWholeFileLoadingLineReader.h
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

@import Foundation;
#import "KALineReader.h"

@interface KAWholeFileLoadingLineReader : NSObject <KALineReader>

- (instancetype)initWithFileContents:(NSString *)fileContents;

@end
