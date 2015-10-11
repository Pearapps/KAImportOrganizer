//
//  KAStreamedLineReader.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/10/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAStreamedLineReader.h"

@interface KAStreamedLineReader ()

@property (nonatomic, readonly) NSInputStream *inputStream;

@end

@implementation KAStreamedLineReader

- (instancetype)initWithInputStream:(NSInputStream *)inputStream {
    self = [super init];
    
    _inputStream = inputStream;
    [_inputStream open];
    
    return self;
}

- (void)dealloc {
    [_inputStream close];
}

- (NSString *)readLine {
    NSMutableData *data = [NSMutableData data];
    uint8_t byte;
    do {
        if ([_inputStream read:&byte maxLength:1] == 1) { [data appendBytes:&byte length:1]; }
        else { break; }
    }
    while (byte != '\n');
    
    return [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
}

- (BOOL)hasAnotherLine {
    return _inputStream.hasBytesAvailable;
}

@end
