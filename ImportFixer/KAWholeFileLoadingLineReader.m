//
//  KAWholeFileLoadingLineReader.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAWholeFileLoadingLineReader.h"

@interface KAWholeFileLoadingLineReader ()

@property (nonatomic, readonly) NSURL *fileURL;

@property (nonatomic, readonly) NSArray *allLines;

@property (nonatomic) NSInteger currentOffset;

@end

@implementation KAWholeFileLoadingLineReader

- (instancetype)initWithFileURL:(NSURL *)URL {
    self = [super init];
    
    _fileURL = URL;
    NSString *fileContents = [self fileContents];
    
    _allLines = [fileContents componentsSeparatedByString:@"\n"];
    
    return self;
}

- (NSString *)fileContents {
    return [[NSString alloc] initWithContentsOfURL:_fileURL encoding:NSUTF8StringEncoding error:nil];
}

- (NSString *)readLine {
    NSString *line = _allLines[_currentOffset];
    _currentOffset++;
    return line;
}

- (BOOL)hasAnotherLine {
    return _currentOffset != _allLines.count;
}


@end
