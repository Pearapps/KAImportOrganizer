//
//  KAImportStringTransformer.h
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 11/3/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KAStringTransformer.h"
#import "KAImportStatement.h"

@interface KAImportStringTransformer : NSObject <KAStringTransformer>

- (instancetype)initWithOriginalImports:(NSArray <KAImportStatement *> *)originalImports sortedImportStatements:(NSArray <KAImportStatement *> *)sortedImportStatements originalContents:(NSString *)originalContents numberOfNewlines:(NSInteger)numberOfNewlines;

@end
