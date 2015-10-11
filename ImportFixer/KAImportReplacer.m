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

@end

@implementation KAImportReplacer

- (instancetype)initWithOriginalImportStrings:(NSArray <KAImportStatement *> *)importStrings sorted:(NSArray <KAImportStatement *> *)sortedImportStatements fileURL:(NSURL *)fileURL {
    self = [super init];
    
    _fileURL = fileURL;
    _originalImports = [importStrings copy];
    _sortedImportStatements = [sortedImportStatements copy];
    
    return self;
}

- (NSString *)fileContents {
    return [[NSString alloc] initWithContentsOfURL:_fileURL encoding:NSUTF8StringEncoding error:nil];
}

- (void)replace {
    if (_originalImports.count == 0) { return; }
    if ([self.originalImports isEqual:self.sortedImportStatements]) { return; }
    
    NSMutableString *fileContents = [self fileContents].mutableCopy;

    NSArray <NSString *> *oldImportStrings = [_originalImports valueForKey:@"importString"];
    NSString *importString = [oldImportStrings componentsJoinedByString:@""];
    
    NSArray <NSString *> *newImportStrings = [_sortedImportStatements valueForKey:@"importString"];
    NSString *newImportString = [newImportStrings componentsJoinedByString:@""];
    
    NSRange range = [fileContents rangeOfString:importString];
    
    if (range.location != NSNotFound) {
        [fileContents replaceCharactersInRange:range withString:newImportString];
    }
    
    
    [fileContents writeToURL:self.fileURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
}


@end
