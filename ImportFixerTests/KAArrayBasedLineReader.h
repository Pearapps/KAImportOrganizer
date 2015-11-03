//
//  KAArrayBasedLineReader.h
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 11/2/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KALineReader.h"

@interface KAArrayBasedLineReader : NSObject <KALineReader>

- (instancetype)initWithLines:(NSArray <NSString *> *)lines;

@end
