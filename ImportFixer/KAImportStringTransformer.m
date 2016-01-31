//
//  KAImportStringTransformer.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 11/3/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAImportStringTransformer.h"
#import "KAImportStatement.h"

@interface KAImportStringTransformer ()

@property (nonatomic, copy, readonly) NSArray <KAImportStatement *> *originalImports;
@property (nonatomic, copy, readonly) NSArray <KAImportStatement *> *sortedImportStatements;
@property (nonatomic, readonly) NSString *originalContents;
@property (nonatomic, readonly) NSInteger numberOfNewlines;
@property (nonatomic, readonly) BOOL insertsNewLinesInBetweenTypes;

@end

@implementation KAImportStringTransformer

- (instancetype)initWithOriginalImports:(NSArray <KAImportStatement *> *)originalImports
                 sortedImportStatements:(NSArray <KAImportStatement *> *)sortedImportStatements
                       originalContents:(NSString *)originalContents
                       numberOfNewlines:(NSInteger)numberOfNewlines
          insertsNewLinesInBetweenTypes:(BOOL)insertsNewLinesInBetweenTypes {
    self = [super init];
    
    if (self) {
        _originalImports = [originalImports copy];
        _sortedImportStatements = [sortedImportStatements copy];
        _originalContents = originalContents;
        _numberOfNewlines = numberOfNewlines;
        _insertsNewLinesInBetweenTypes = insertsNewLinesInBetweenTypes;
    }
    
    return self;
}

- (NSString *)transformedString {
    NSMutableString *fileContents = _originalContents.mutableCopy;
    
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
    
    NSMutableArray <NSNumber *> *indicesOfTypeChange = [NSMutableArray new];
    
    if (self.insertsNewLinesInBetweenTypes) {
        /**
         *  Initial value has no meaning.
         */
        __block KAImportType lastImportType = KAImportTypeAtSign;
        [self.sortedImportStatements enumerateObjectsUsingBlock:^(KAImportStatement * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == 0) {
                lastImportType = obj.importType;
                return;
            }
            
            if (lastImportType != obj.importType) {
                [indicesOfTypeChange addObject:@(idx)];
                
                lastImportType = obj.importType;
            }
        }];
        
        NSInteger numberAdjusted = 0;
        if (indicesOfTypeChange.count > 0) {
            
            for (NSNumber *number in indicesOfTypeChange) {
                NSInteger index = [number integerValue] + numberAdjusted;
                
                NSMutableArray *newImportStringsMutable = [newImportStrings mutableCopy];
                [newImportStringsMutable insertObject:@"\n" atIndex:index];
                newImportStrings = [newImportStringsMutable copy];
                numberAdjusted += 1;
            }
            
        }
    }
    
    NSString *importString = [newImportStrings componentsJoinedByString:@""];
    [fileContents insertString:importString atIndex:rangeOfFirstObject.location];
    
    BOOL endSearchForNewLines = NO;
    NSInteger foundNewlines = 1;
    
    while (!endSearchForNewLines && foundNewlines <= self.numberOfNewlines) {
        const NSInteger location = [fileContents rangeOfString:importString].location + [fileContents rangeOfString:importString].length;
        
        if (location >= fileContents.length) { break; }
        
        NSString *substring = [fileContents substringWithRange:NSMakeRange(location, 1)];
        
        if ([substring isEqualToString:@"\n"]) {
            [fileContents deleteCharactersInRange:NSMakeRange(location, 1)];
            foundNewlines++;
        }
        else {
            endSearchForNewLines = YES;
        }
    }

    return [fileContents copy];
}


@end
