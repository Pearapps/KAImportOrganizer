//
//  KAWholeFileLoadingLineReader.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAWholeFileLoadingLineReader.h"

@interface KAWholeFileLoadingLineReader ()

@property (nonatomic, readonly) NSArray *allLines;

@property (nonatomic) NSInteger currentOffset;

@end

@implementation KAWholeFileLoadingLineReader

- (instancetype)initWithFileContents:(NSString *)fileContents {
    self = [super init];
    
    _allLines = [fileContents componentsSeparatedByString:@"\n"];
    
    return self;
}

- (NSString *)readLine {
    NSString *line = [_allLines[_currentOffset] stringByAppendingString:@"\n"];
    _currentOffset++;
    return line;
}

- (BOOL)hasAnotherLine {
    return _currentOffset != _allLines.count;
}


@end
