/*
 *GDataXMLDocument解析XML
 *Created by kllmctrl on 12-5-2.
 *
 */

#import <Foundation/Foundation.h>
#import <GDataXMLNode.h>

@interface LLXMLParser:NSObject{
}


+(NSArray*)subElements:(NSString*)aSubElementName parentElement:(GDataXMLElement*)aParentElement;
+(GDataXMLElement*)pathSubElement:(NSString*)aSubElementPath parentElement:(GDataXMLElement*)aParentElement;
+(NSString*)getStringValue:(NSString*)aSubElementName parentElement:(GDataXMLElement*)aParentElement;


@end
