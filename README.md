# Taoprone

[![CI Status](https://img.shields.io/travis/rakeyang/Taoprone.svg?style=flat)](https://travis-ci.org/rakeyang/Taoprone)
[![Version](https://img.shields.io/cocoapods/v/Taoprone.svg?style=flat)](https://cocoapods.org/pods/Taoprone)
[![License](https://img.shields.io/cocoapods/l/Taoprone.svg?style=flat)](https://cocoapods.org/pods/Taoprone)
[![Platform](https://img.shields.io/cocoapods/p/Taoprone.svg?style=flat)](https://cocoapods.org/pods/Taoprone)

## JavaScriptCore是什么?

JavaScriptCore本身仅实现[ECMAScript](http://ecma-international.org/)规范，方便网页交互。不包含来自WebKit框架的XMLHTTPRequest，WebSocket，DOM等之类的东西。

**主要类**:

名称 | 说明
---- | ----
JSContext | 脚本执行上下文
JSValue | 对象转换
JSManagedValue | 内存管理辅助对象
JSVirtualMachine | 虚拟机，有独立的空间和垃圾回收机制
JSExport | 导出协议


## JSVirtualMachine

## JSContext

## JSValue

### 映射关系

|Objective-C type  |   JavaScript type|
|----------------- | ---------------------|
|      nil         |     undefined    |
|     NSNull       |        null    |
|    NSString      |       string   |
|    NSNumber      |   number, boolean    |
|  NSDictionary    |   Object object    |
|    NSArray       |    Array object    |
|     NSDate       |     Date object    |
|    NSBlock       |   Function object    |
|       id         |   Wrapper object   |
|     Class        | Constructor object   |


## 预览

<img width="414" height="896" src="https://user-images.githubusercontent.com/8289395/68991560-041a3180-089b-11ea-9500-5d279748515d.png"/>


## 安装

Taoprone is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Taoprone'
```

## 开发计划

- [ ] 支持脚本热加载
- [ ] 支持圆角等二级属性设置

## License

Taoprone is available under the MIT license. See the LICENSE file for more info.
