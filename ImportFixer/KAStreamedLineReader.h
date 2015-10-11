//
//  KAStreamedLineReader.h
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/10/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

@import Foundation;
#import "KALineReader.h"

@interface KAStreamedLineReader : NSObject <KALineReader>

- (instancetype)initWithInputStream:(NSInputStream *)inputStream;

@end
