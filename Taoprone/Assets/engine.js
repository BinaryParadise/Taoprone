var global = this;
global["SNViewController"] = {__oc_class: "SNViewController"}
global["UIColor"] = {__oc_class: "UIColor"}
global["UIView"] = {__oc_class: "TPView"}
global["UIScreen"] = {__oc_class: "UIScreen"}
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
    var replaced = args.length == 1 ? methodName+":" : methodName;
    return forwardMethod(self, replaced, args)
  }
}});

function forwardMethod(obj, methodName, args) {
  if (args == undefined) {
    return TPBridge.__invoke(obj, methodName, args)
  }
  var newArg = [];
  for (var i = 0; i < args.length; i++) {
    var item = args[i];
    if (item != undefined) {
      newArg[i] = item.__oc_class ? item.__oc_obj : item;
    }
  }
  return TPBridge.__invoke(obj, methodName, newArg)
}

function toObjC(jobj){
  return jobj.__oc_obj;
}
