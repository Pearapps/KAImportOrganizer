//
//  KAFullContentsImportReplacerAndTransformer.h
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

@import Foundation;
#import "KAStringTransformer.h"
#import "KAImportTypeModel.h"

@class KAImportStatement;
@interface KAFullContentsImportReplacerAndTransformer : NSObject <KAStringTransformer>

- (nonnull instancetype)initWithImports:(nonnull NSArray <NSArray <KAImportStatement *> *> *)imports
                      numbersOfNewlines:(nullable NSArray *)numbersOfNewlines
                       originalContents:(nonnull NSString *)originalContents
          insertsNewLinesInBetweenTypes:(BOOL)insertsNewLinesInBetweenTypes
                  sortOrderOfImportType:(nullable NSArray <KAImportTypeModel *> *)sortOrderOfImportType;

- (nonnull NSString *)transformedString;

- (BOOL)didChangeAnyCharacters;

- (NSInteger)importAmount;

@end
