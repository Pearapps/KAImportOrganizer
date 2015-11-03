//
//  KAFullContentsImportReplacerAndTransformer.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAFullContentsImportReplacerAndTransformer.h"
#import "KAImportStatement.h"
#import "KAImportStringTransformer.h"
#import "KAImportSorter.h"

@interface KAFullContentsImportReplacerAndTransformer ()

@property (nonatomic, readonly) NSArray <NSArray <KAImportStatement *> *> *imports;
@property (nonatomic, readonly) NSArray *numbersOfNewlines;
@property (nonatomic, readonly) NSString *originalContents;

@property (nonatomic, readonly) NSString *transformedString;
@property (nonatomic, readonly) BOOL didChangeAnyCharacters;
@property (nonatomic, readonly) NSInteger importAmount;

@end

@implementation KAFullContentsImportReplacerAndTransformer

- (instancetype)initWithImports:(NSArray <NSArray <KAImportStatement *> *> *)imports numbersOfNewlines:(NSArray *)numbersOfNewlines originalContents:(NSString *)originalContents {
    self = [super init];
    
    if (self) {
        _imports = imports;
        _numbersOfNewlines = numbersOfNewlines;
        _originalContents = originalContents;
    }
    
    return self;
}

- (void)replace {
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
    
    _importAmount = importAmount;
    _transformedString = contents;
    _didChangeAnyCharacters = everChanged;
}

@end
