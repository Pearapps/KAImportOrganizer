//
//  KAImportReplacer.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAImportReplacer.h"
#import "KAImportStatement.h"

@interface KAImportReplacer ()

@property (nonatomic, copy, readonly) NSArray <KAImportStatement *> *originalImports;
@property (nonatomic, copy, readonly) NSArray <KAImportStatement *> *sortedImportStatements;
@property (nonatomic, readonly) NSURL *fileURL;
@property (nonatomic, readonly) NSInteger numberOfNewlines;

@end

@implementation KAImportReplacer

- (instancetype)initWithOriginalImportStrings:(NSArray <KAImportStatement *> *)importStrings sorted:(NSArray <KAImportStatement *> *)sortedImportStatements fileURL:(NSURL *)fileURL numberOfNewlines:(NSInteger)numberOfNewlines {
    self = [super init];
    
    _fileURL = fileURL;
    _originalImports = [importStrings copy];
    _sortedImportStatements = [sortedImportStatements copy];
    _numberOfNewlines = numberOfNewlines;
    
    return self;
}

- (NSString *)fileContents {
    return [[NSString alloc] initWithContentsOfURL:_fileURL encoding:NSUTF8StringEncoding error:nil];
}

- (void)replace {
    if (_originalImports.count == 0) { return; }
    if ([self.originalImports isEqual:self.sortedImportStatements]) { return; }
    
    NSMutableString *fileContents = [self fileContents].mutableCopy;

    NSRange rangeOfFirstObject = [fileContents rangeOfString:[(KAImportStatement *)(_originalImports.firstObject) importString]];
    
    for (KAImportStatement *importString in _originalImports) {
        NSRange range = [fileContents rangeOfString:importString.importString];
        if (range.location != NSNotFound) {
            [fileContents deleteCharactersInRange:range];
        }
        else {
            NSRange range = [fileContents rangeOfString:[importString.importString stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
            if (range.location != NSNotFound) {
                [fileContents deleteCharactersInRange:range];
            }
        }
    }
    
    NSArray <NSString *> *newImportStrings = [_sortedImportStatements valueForKey:@"importString"];
    NSString *importString = [newImportStrings componentsJoinedByString:@""];
    
    [fileContents insertString:importString atIndex:rangeOfFirstObject.location];
    
    BOOL endSearchForNewLines = NO;
    NSInteger foundNewlines = 1;
    
    while (!endSearchForNewLines && foundNewlines != self.numberOfNewlines) {
        NSInteger location = [fileContents rangeOfString:importString].location + [fileContents rangeOfString:importString].length;
        
        NSString *substring = [fileContents substringWithRange:NSMakeRange(location, 1)];
        
        if ([substring isEqualToString:@"\n"]) {
            [fileContents deleteCharactersInRange:NSMakeRange(location, 1)];
            foundNewlines++;
        }
        else {
            endSearchForNewLines = YES;
        }
    }
    
    [fileContents writeToURL:self.fileURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
