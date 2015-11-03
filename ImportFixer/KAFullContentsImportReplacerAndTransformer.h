//
//  KAFullContentsImportReplacerAndTransformer.h
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

@import Foundation;
#import "KAStringTransformer.h"

@class KAImportStatement;
@interface KAFullContentsImportReplacerAndTransformer : NSObject <KAStringTransformer>

- (instancetype)initWithImports:(NSArray <NSArray <KAImportStatement *> *> *)imports numbersOfNewlines:(NSArray *)numbersOfNewlines originalContents:(NSString *)originalContents;

- (NSString *)transformedString;

- (BOOL)didChangeAnyCharacters;

- (NSInteger)importAmount;

@end
