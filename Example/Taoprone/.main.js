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
  if (!jobj.isObject) {
    return null;
  }
  for (var variable in jobj) {
    if (typeof jobj[variable] === 'function') {
      TPBridge.__add(jobj, jobj[variable], methodNameForOC(variable, jobj[variable].length));
    }
  }
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

//--------------------业务代码----------------------
function initModule() {
  var vc = TPViewController.__c("init")();

  /*vc.viewDidLoad = function() {
      vc.__c("view")().__c("setBackgroundColor")(UIColor.__c("tp_colorWithHex")(0xF6F6F6));
      var width = UIScreen.__c("mainScreen")().__c("bounds")().width;
      var height = UIScreen.__c("mainScreen")().__c("bounds")().height;
      var contentView = UIView.__c("alloc")().__c("initWithFrame")({x:16,y:108, width: width - 32, height: width - 32});
      contentView.__c("setBackgroundColor")(UIColor.__c("tp_colorWithHex")(0x290099));
      var size = contentView.__c("bounds")();
      var inset = width/10.0;
      var subView = contentView;
      for (var i = 0; i < 8; i++) {
        size = subView.__c("bounds")()
        newView = UIView.__c("alloc")().__c("initWithFrame")({x:inset,y:inset,width:size.width-inset,height:size.height-inset});
        newView.__c("setBackgroundColor")(UIColor.__c("tp_colorWithHex")((i+2)*0x290099));
        subView.__c("addSubview")(newView);
        subView = newView;
      }

      vc.__c("view")().__c("addSubview")(contentView);

      var button = UIButton.__c("buttonWithType")(0);
      button.__c("setFrame")({x:16,y:height-50-44, width: width - 32, height: 50})
      button.__c("setBackgroundColor")(UIColor.__c("tp_colorWithHex")(0xFF8000));
      //多参数调用直接去掉冒号
      button.__c("setTitleforState")("Taoprone", UIControlStateNormal);
      button.__c("setTitleColorforState")(UIColor.__c("tp_colorWithHex")(0xFFFFFF), UIControlStateNormal);
      button.doActionFunction = function() {
        console.__c("error")("action finished");
      }
      button.__c("addTargetactionforControlEvents")(vc, null, UIControlEventTouchUpInside);
      vc.__c("view")().__c("addSubview")(button);
  }*/
  return toObjC(vc);
}
