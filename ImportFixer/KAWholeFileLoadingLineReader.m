//
//  KAWholeFileLoadingLineReader.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAWholeFileLoadingLineReader.h"

@interface KAWholeFileLoadingLineReader () {
    NSURL *_fileURL;
    NSArray *_allLines;
    NSInteger _currentOffset;
}

@end

@implementation KAWholeFileLoadingLineReader

- (instancetype)initWithFileURL:(NSURL *)URL {
    self = [super init];
    
    _fileURL = URL;
    const NSString * const fileContents = [[NSString alloc] initWithContentsOfURL:_fileURL encoding:NSUTF8StringEncoding error:nil];
    
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
