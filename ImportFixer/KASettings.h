//
//  KASettings.h
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KAImportTypeModel.h"

@interface KASettings : NSObject

- (nonnull instancetype)initWithFileExtensions:(nonnull NSArray *)fileExtensions directories:(nonnull NSArray *)directories insertsNewLinesInBetweenTypes:(BOOL)insertsNewLinesInBetweenTypes sortOrder:(nullable NSArray <KAImportTypeModel *> *)sortOrder;

@property (nonatomic, nonnull, readonly, copy) NSArray *fileExtensions;
@property (nonatomic, nonnull, readonly, copy) NSArray *directories;
@property (nonatomic, readonly) BOOL insertsNewLinesInBetweenTypes;

@property (nonatomic, nullable, readonly, copy) NSArray <KAImportTypeModel *> *sortOrder;

@end
