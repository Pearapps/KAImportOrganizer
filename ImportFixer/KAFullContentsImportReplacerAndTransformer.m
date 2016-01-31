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

@property (nonatomic, readonly, nonnull, copy) NSArray <NSArray <KAImportStatement *> *> *imports;
@property (nonatomic, readonly, nullable, copy) NSArray *numbersOfNewlines;
@property (nonatomic, readonly, nonnull, copy) NSString *originalContents;
@property (nonatomic, readonly) BOOL insertsNewLinesInBetweenTypes;
@property (nonatomic, copy, readonly, nullable) NSArray <KAImportTypeModel *> *sortOrderOfImportType;


@property (nonatomic, readonly) NSString *transformedString;
@property (nonatomic, readonly) BOOL didChangeAnyCharacters;
@property (nonatomic, readonly) NSInteger importAmount;

@end

@implementation KAFullContentsImportReplacerAndTransformer

- (nonnull instancetype)initWithImports:(nonnull NSArray <NSArray <KAImportStatement *> *> *)imports
                      numbersOfNewlines:(nullable NSArray *)numbersOfNewlines
                       originalContents:(nonnull NSString *)originalContents
          insertsNewLinesInBetweenTypes:(BOOL)insertsNewLinesInBetweenTypes
                  sortOrderOfImportType:(nullable NSArray <KAImportTypeModel *> *)sortOrderOfImportType {
    NSParameterAssert(imports);
    NSParameterAssert(originalContents);
    self = [super init];
    
    if (self) {
        _imports = [imports copy];
        _numbersOfNewlines = [numbersOfNewlines copy];
        _originalContents = [originalContents copy];
        _insertsNewLinesInBetweenTypes = insertsNewLinesInBetweenTypes;
        _sortOrderOfImportType = [sortOrderOfImportType copy];
        [self replace];
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
            KAImportSorter *sorter = [[KAImportSorter alloc] initWithImports:importStrings sortOrderOfImportType:self.sortOrderOfImportType];
            NSArray *sortedImports = [sorter sortedImports];
            
            if (![sortedImports isEqualTo:importStrings]) {
                everChanged = YES;
                contents = [[[KAImportStringTransformer alloc] initWithOriginalImports:importStrings
                                                                sortedImportStatements:sortedImports
                                                                      originalContents:contents
                                                                      numberOfNewlines:numberOfNewlines
                                                         insertsNewLinesInBetweenTypes:self.insertsNewLinesInBetweenTypes] transformedString];
            }
        }
    }
    
    _importAmount = importAmount;
    _transformedString = contents;
    _didChangeAnyCharacters = everChanged;
}

@end
