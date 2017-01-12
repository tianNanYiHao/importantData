//
//  Util.m
//  QuickPos
//
//  Created by 糊涂 on 15/3/24.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "Utils.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation Utils

+ (NSString*)base64Encode:(NSData*)data {
    
    const uint8_t* input = (const uint8_t*)[data bytes];
    NSInteger length = [data length];
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
   
    NSMutableData* mData = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)mData.mutableBytes;
    
    NSInteger i,i2;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        for (i2=0; i2<3; i2++) {
            value <<= 8;
            if (i+i2 < length) {
                value |= (0xFF & input[i+i2]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    NSString *encode = [[NSString alloc] initWithData:mData encoding:NSASCIIStringEncoding];
//    NSString *encode = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return encode;
}

+ (NSData*)base64Decode:(NSString*)string {
    
    static char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:nil];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

+ (NSString*)urlDecode:(NSString*)data {
    NSString * decode = CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)data, (CFStringRef)@"!*'();:@&+$,?%#[]", kCFStringEncodingUTF8));
//    decode = [decode stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    return decode;
}

+ (NSString*)urlEncode:(NSString*)data {
    
    NSString *encode = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)data,NULL,(CFStringRef)@"!*'();:@&=$,/?%#[]",kCFStringEncodingUTF8));
    encode = [encode stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    encode = [encode stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
    encode = [encode stringByReplacingOccurrencesOfString:@"%2A" withString:@"*"];
    
    return encode;
}

+ (NSString*)getImageWithData:(NSData*)data {
    NSString *img = nil;
//    img = [Utils stringWithData:data];
    img = [Utils base64Encode:data];
    img = [Utils urlEncode:img];
    return img;
}

+ (NSString*)stringWithData:(NSData*)data {
    NSString *str = [NSString stringWithFormat:@"%@", data];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    str = [str substringFromIndex:1];
    str = [str substringToIndex:str.length-1];
    return str;
}

+ (NSString*)getImageWithImage:(UIImage*)img{
    NSData *data = UIImagePNGRepresentation(img);
    return [Utils getImageWithData:data];
}

+ (NSString*)md5WithData:(NSData*)data {
//    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
//    
//    CC_MD5_CTX md5;
//    
//    CC_MD5_Init(&md5);
//    
//    CC_MD5_Update(&md5, [data bytes], [data length]);
//    
//    unsigned char digest[CC_MD5_DIGEST_LENGTH];
//    CC_MD5_Final(digest, &md5);
//    
//    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
//        [output appendFormat:@"%02X", digest[i]];
//    }
//    
//    return output;
    void *cData = malloc([data length]);
    unsigned char result[16];
    [data getBytes:cData length:[data length]];
    
    CC_MD5(cData, [data length], result);
    free(cData);
    
    NSString *imageHash = [NSString stringWithFormat:
                           @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                           result[0], result[1], result[2], result[3],
                           result[4], result[5], result[6], result[7],
                           result[8], result[9], result[10], result[11],
                           result[12], result[13], result[14], result[15]
                           ];
    return imageHash;
}

// 签名用md5
+ (NSString*)md5WithString:(NSString*)str{
    const char * cstr = [str UTF8String];
    unsigned char result[32];
    CC_MD5(cstr, strlen(cstr), result);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02X", result[i]];
    }
    
    return output;
}

@end
