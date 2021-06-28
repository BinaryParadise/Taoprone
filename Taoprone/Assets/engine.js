console.log(sayHelloToSwift());
var global = this;
global["TPViewController"] = {__oc_class: "Taoprone.TPViewController"}
global["UIColor"] = {__oc_class: "UIColor"}
global["UIView"] = {__oc_class: "Taoprone.TPView"}
global["UIScreen"] = {__oc_class: "UIScreen"}
global["UIButton"] = {__oc_class: "Taoprone.TPButton"}

var UIControlStateNormal = 0;
var UIControlEventTouchUpInside = 1 << 6;
// OC方法和JS中调用的关系映射
var methodsMap = {setTitleforState: "setTitle:forState:",
                  setTitleColorforState: "setTitleColor:forState:",
                  addTargetactionforControlEvents: "addTarget:action:forControlEvents:"};

if (Object.prototype.__c == undefined) {
  Object.defineProperty(Object.prototype, '__c', {value: function(methodName) {
    if (!this.__oc_obj && !this.__oc_class) {
      if (methodName == undefined) {
        console.error(this, methodName);
      }
      return this[methodName].bind(this);
    }
    var self = this
    return function(){
      var args = Array.prototype.slice.call(arguments)
      replaced = methodNameForOC(methodName, args.length);
      return forwardMethod(self, replaced, args)
    }
  }});
}

function forwardMethod(obj, methodName, args) {
  if (args == undefined) {
    return TPBridge.__invoke(obj, methodName, args)
  }
  var newArg = [];
  for (var i = 0; i < args.length; i++) {
    var item = args[i];
    if (item != undefined) {
      toObjC(item);
      newArg[i] = item.__oc_class ? item.__oc_obj : item;
    }
  }
  return TPBridge.__invoke(obj, methodName, newArg)
}

function methodNameForOC(methodName, argcount) {
  if (methodsMap[methodName] != undefined) {
    return methodsMap[methodName];
  }
  var ocname = argcount >= 1 ? methodName+":" : methodName;
  ocname = ocname.replace('__', ':');
  return ocname;
}

function toObjC(jobj){
  if (!jobj.__oc_isObj) {
    return null;
  }
  for (var variable in jobj) {
    if (typeof jobj[variable] === 'function') {
      TPBridge.__add(jobj, jobj[variable], methodNameForOC(variable, jobj[variable].length));
    }
  }
  debugger
  return jobj.__oc_obj;
}

function testRequest(url) {
  var request = new XMLHttpRequest(); // 新建XMLHttpRequest对象
  request.onreadystatechange = function () { // 状态发生变化时，函数被回调
      if (request.readyState === 4) { // 成功完成
          // 判断响应结果:
          if (request.status === 200) {
              // 成功，通过responseText拿到响应的文本:
              return success(request.responseText);
          } else {
              // 失败，根据响应码判断失败原因:
              return fail(request.status);
          }
      } else {
          // HTTP请求还在继续...
      }
  }
  // 发送请求:
  request.open('GET', url);
  request.send();
}
