//
//  KAArrayBasedLineReader.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 11/2/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAArrayBasedLineReader.h"

@interface KAArrayBasedLineReader () {
    NSInteger currentOffset;
}

@property (nonatomic, readonly) NSArray <NSString *> *lines;

@end

@implementation KAArrayBasedLineReader

- (instancetype)initWithLines:(NSArray <NSString *> *)lines {
    self = [super init];
    
    if (self) {
        _lines = lines;
    }
    
    return self;
}

- (NSString *)readLine {
    NSString *line = [_lines[currentOffset] stringByAppendingString:@"\n"];
    currentOffset++;
    return line;
}

- (BOOL)hasAnotherLine {
    return currentOffset != _lines.count;
}

@end
