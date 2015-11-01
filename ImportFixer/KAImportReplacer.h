//
//  KAImportReplacer.h
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

@import Foundation;

@class KAImportStatement;
@interface KAImportReplacer : NSObject

- (instancetype)initWithOriginalImportStrings:(NSArray <KAImportStatement *> *)importStrings sorted:(NSArray <KAImportStatement *> *)sortedImportStatements fileURL:(NSURL *)fileURL numberOfNewlines:(NSInteger)numberOfNewlines;

- (void)replace;

@end
