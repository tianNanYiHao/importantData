//
//  MqttProperties.m
//  MQTTClient
//
//  Created by Christoph Krey on 04.04.17.
//  Copyright © 2017 Christoph Krey. All rights reserved.
//

#import "MqttProperties.h"

@implementation MqttProperties
- (instancetype)initFromData:(NSData *)data {
    self = [super init];

    int propertyLength = [MqttProperties getVariableLength:data];
    int offset = [MqttProperties variableIntLength:propertyLength];
    NSData *remainingData = [data subdataWithRange:NSMakeRange(offset, data.length - offset)];
    offset = 0;
    if (remainingData.length >= propertyLength) {
        while (propertyLength - offset > 0) {
            const UInt8 *bytes = remainingData.bytes;
            UInt8 propertyType = bytes[offset];
            switch (propertyType) {
                case MQTTPayloadFormatIndicator:
                    if (propertyLength - offset > 1) {
                        self.payloadFormatIndicator = [NSNumber numberWithInt:bytes[offset + 1]];
                        offset += 2;
                    }
                    break;
                case MQTTPublicationExpiryInterval:
                    if (propertyLength - offset > 4) {
                        self.publicationExpiryInterval = [NSNumber numberWithInt:[MqttProperties getFourByteInt:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]]];
                        offset += 5;
                    }
                    break;
                case MQTTContentType:
                    if (propertyLength - offset > 2) {
                        int l = [MqttProperties getTwoByteInt:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]];

                        self.contentType = [MqttProperties getUtf8String:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]];
                        offset += 1 + 2 + l;
                    }
                    break;

                case MQTTResponseTopic:
                    if (propertyLength - offset > 2) {
                        int l = [MqttProperties getTwoByteInt:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]];

                        self.responseTopic = [MqttProperties getUtf8String:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]];
                        offset += 1 + 2 + l;
                    }
                    break;

                case MQTTCorrelationData:
                    if (propertyLength - offset > 2) {
                        int l = [MqttProperties getTwoByteInt:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]];

                        self.correlationData = [MqttProperties getBinaryData:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]];
                        offset += 1 + 2 + l;
                    }
                    break;

                case MQTTSubscriptionIdentifier:
                    if (propertyLength - offset > 1) {
                        int subscriptionIdentifier = [MqttProperties getVariableLength:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]];
                        int l = [MqttProperties variableIntLength:subscriptionIdentifier];
                        self.subscriptionIdentifier = [NSNumber numberWithInt:subscriptionIdentifier];
                        offset += 1 + l;

                    }
                    break;

                case MQTTSessionExpiryInterval:
                    if (propertyLength - offset > 4) {
                        self.sessionExpiryInterval = [NSNumber numberWithInt:[MqttProperties getFourByteInt:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]]];
                        offset += 5;
                    }
                    break;
                case MQTTAssignedClientIdentifier:
                    if (propertyLength - offset > 2) {
                        int l = [MqttProperties getTwoByteInt:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]];

                        self.assignedClientIdentifier = [MqttProperties getUtf8String:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]];
                        offset += 1 + 2 + l;
                    }
                    break;


                case MQTTServerKeepAlive:
                    if (propertyLength - offset > 2) {
                        self.serverKeepAlive = [NSNumber numberWithInt:[MqttProperties getTwoByteInt:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]]];
                        offset += 3;
                    }
                    break;

                case MQTTAuthMethod:
                    if (propertyLength - offset > 2) {
                        int l = [MqttProperties getTwoByteInt:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]];

                        self.authMethod = [MqttProperties getUtf8String:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]];
                        offset += 1 + 2 + l;
                    }
                    break;


                case MQTTAuthData:
                    if (propertyLength - offset > 2) {
                        int l = [MqttProperties getTwoByteInt:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]];

                        self.authData = [MqttProperties getBinaryData:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]];
                        offset += 1 + 2 + l;
                    }
                    break;
                    

                case MQTTRequestProblemInformation:
                    if (propertyLength - offset > 1) {
                        self.requestProblemInformation = [NSNumber numberWithInt:bytes[offset + 1]];
                        offset += 2;
                    }
                    break;

                case MQTTWillDelayInterval:
                    if (propertyLength - offset > 4) {
                        self.willDelayInterval = [NSNumber numberWithInt:[MqttProperties getFourByteInt:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]]];
                        offset += 5;
                    }
                    break;

                case MQTTRequestResponseInformation:
                    if (propertyLength - offset > 1) {
                        self.requestResponseInformation = [NSNumber numberWithInt:bytes[offset + 1]];
                        offset += 2;
                    }
                    break;

                case MQTTResponseInformation:
                    if (propertyLength - offset > 2) {
                        int l = [MqttProperties getTwoByteInt:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]];

                        self.responseInformation = [MqttProperties getUtf8String:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]];
                        offset += 1 + 2 + l;
                    }
                    break;


                case MQTTServerReference:
                    if (propertyLength - offset > 2) {
                        int l = [MqttProperties getTwoByteInt:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]];

                        self.serverReference = [MqttProperties getUtf8String:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]];
                        offset += 1 + 2 + l;
                    }
                    break;


                case MQTTReasonString:
                    if (propertyLength - offset > 2) {
                        int l = [MqttProperties getTwoByteInt:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]];

                        self.reasonString = [MqttProperties getUtf8String:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]];
                        offset += 1 + 2 + l;
                    }
                    break;


                case MQTTReceiveMaximum:
                    if (propertyLength - offset > 2) {
                        self.receiveMaximum = [NSNumber numberWithInt:[MqttProperties getTwoByteInt:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]]];
                        offset += 3;
                    }
                    break;

                case MQTTTopicAliasMaximum:
                    if (propertyLength - offset > 2) {
                        self.topicAliasMaximum = [NSNumber numberWithInt:[MqttProperties getTwoByteInt:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]]];
                        offset += 3;
                    }
                    break;

                case MQTTTopicAlias:
                    if (propertyLength - offset > 2) {
                        self.topicAlias = [NSNumber numberWithInt:[MqttProperties getTwoByteInt:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]]];
                        offset += 3;
                    }
                    break;

                case MQTTMaximumQoS:
                    if (propertyLength - offset > 1) {
                        self.maximumQoS = [NSNumber numberWithInt:bytes[offset + 1]];
                        offset += 2;
                    }
                    break;

                case MQTTRetainAvailable:
                    if (propertyLength - offset > 1) {
                        self.retainAvailable = [NSNumber numberWithInt:bytes[offset + 1]];
                        offset += 2;
                    }
                    break;

                case MQTTUserProperty:
                    if (propertyLength - offset > 4) {
                        int keyL = [MqttProperties getTwoByteInt:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]];

                        NSString *key = [MqttProperties getUtf8String:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]];

                        int valueL = [MqttProperties getTwoByteInt:[remainingData subdataWithRange:NSMakeRange(offset + 1 + 2 + keyL, remainingData.length - (offset + 1))]];

                        NSString *value = [MqttProperties getUtf8String:[remainingData subdataWithRange:NSMakeRange(offset + 1 + 2 + keyL, remainingData.length - (offset + 1))]];

                        if (!self.userProperty) {
                            self.userProperty = [[NSMutableDictionary alloc] init];
                        }
                        self.userProperty[key] = value;
                        offset += 1 + 2 + keyL + 2 + valueL;
                    }
                    break;

                case MQTTMaximumPacketSize:
                    if (propertyLength - offset > 4) {
                        self.maximumPacketSize = [NSNumber numberWithInt:[MqttProperties getFourByteInt:[remainingData subdataWithRange:NSMakeRange(offset + 1, remainingData.length - (offset + 1))]]];
                        offset += 5;
                    }
                    break;

                case MQTTWildcardSubscriptionAvailable:
                    if (propertyLength - offset > 1) {
                        self.wildcardSubscriptionAvailable = [NSNumber numberWithInt:bytes[offset + 1]];
                        offset += 2;
                    }
                    break;

                case MQTTSubscriptionIdentifiersAvailable:
                    if (propertyLength - offset > 1) {
                        self.subscriptionIdentifiersAvailable = [NSNumber numberWithInt:bytes[offset + 1]];
                        offset += 2;
                    }
                    break;

                case MQTTSharedSubscriptionAvailable:
                    if (propertyLength - offset > 1) {
                        self.sharedSubscriptionAvailable = [NSNumber numberWithInt:bytes[offset + 1]];
                        offset += 2;
                    }
                    break;

                default:
                    return self;
            }
        }
    }
    return self;
}

+ (int)getVariableLength:(NSData *)data {
    int length = 0;
    int offset = 0;
    int multiplier = 1;
    UInt8 digit;

    do {
        if (data.length < offset) {
            return -1;
        }
        [data getBytes:&digit range:NSMakeRange(offset, 1)];
        offset++;
        length += (digit & 0x7f) * multiplier;
        multiplier *= 128;
        if (multiplier > 128 * 128 * 128) {
            return -2;
        }
    } while ((digit & 0x80) != 0);
    return length;
}

+ (int)getTwoByteInt:(NSData *)data {
    int i = 0;
    if (data.length >= 2) {
        const UInt8 *bytes = data.bytes;
        i = bytes[0] * 256 +
        bytes[1];
    }
    return i;
}

+ (int)getFourByteInt:(NSData *)data {
    int i = 0;
    if (data.length >= 4) {
        const UInt8 *bytes = data.bytes;
        i = bytes[0] * 256 * 256 * 256 +
        bytes[1] * 256 * 256 +
        bytes[2] * 256 +
        bytes[3];
    }
    return i;
}

+ (NSString *)getUtf8String:(NSData *)data {
    NSString *s;
    int l = [MqttProperties getTwoByteInt:data];
    if (data.length >= l + 2) {
        s = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(2, l)] encoding:NSUTF8StringEncoding];
    }
    return s;
}

+ (NSData *)getBinaryData:(NSData *)data {
    NSData *d;
    int l = [MqttProperties getTwoByteInt:data];
    if (data.length >= l + 2) {
        d = [data subdataWithRange:NSMakeRange(2, l)];
    }
    return d;
}

+ (int)variableIntLength:(int)length {
    int l = 0;
    if (length <= 127) {
        l = 1;
    } else if (length <= 16383) {
        l = 2;
    } else if (length <= 2097151) {
        l = 3;
    } else if (length <= 268435455) {
        l = 4;
    }
    return l;
}
@end


