//
//  KAImportReplacer.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAImportReplacer.h"
#import "KAImportStatement.h"
#import "KAImportStringTransformer.h"
#import "KAImportSorter.h"

@interface KAImportReplacer ()

@property (nonatomic, readonly) NSURL *fileURL;
@property (nonatomic, readonly) NSArray *imports;
@property (nonatomic, readonly) NSArray *numbersOfNewlines;
@property (nonatomic, readonly) NSString *originalContents;

@end

@implementation KAImportReplacer

- (instancetype)initWithFileURL:(NSURL *)fileURL imports:(NSArray *)imports numbersOfNewlines:(NSArray *)numbersOfNewlines originalContents:(NSString *)originalContents {
    self = [super init];
    
    if (self) {
        _fileURL = fileURL;
        _imports = imports;
        _numbersOfNewlines = numbersOfNewlines;
        _originalContents = originalContents;
    }
    
    return self;
}

- (NSInteger)replace {
    NSString *contents = [_originalContents copy];
    BOOL everChanged = NO;
    
    NSInteger importAmount = 0;
    
    NSInteger i = 0;
    for (NSArray *importStrings in _imports) {
        const NSInteger numberOfNewlines = [_numbersOfNewlines[i] integerValue];
        i++;
        
        importAmount += importStrings.count;
        
        if (importStrings.count > 0) {
            KAImportSorter *sorter = [[KAImportSorter alloc] initWithImports:importStrings];
            NSArray *sortedImports = [sorter sortedImports];
            
            if (![sortedImports isEqualTo:importStrings]) {
                everChanged = YES;
                contents = [[[KAImportStringTransformer alloc] initWithOriginalImports:importStrings sortedImportStatements:sortedImports originalContents:contents numberOfNewlines:numberOfNewlines] transformedString];
            }
        }
    }
    
    if (everChanged) { [contents writeToURL:self.fileURL atomically:YES encoding:NSUTF8StringEncoding error:nil]; }
    return importAmount;
}

@end
