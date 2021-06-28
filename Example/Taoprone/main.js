function initModule() {
    console.log("Hello,world!")
    var vc = TPViewController.alloc().init();

    vc.viewDidLoad = function() {
        vc.view().setBackgroundColor(UIColor.tp_colorWithHex(0xF6F6F6));
        var width = UIScreen.mainScreen().bounds().width;
        var height = UIScreen.mainScreen().bounds().height;
        var contentView = UIView.alloc().initWithFrame({x:16,y:108, width: width - 32, height: width - 32});
        contentView.setBackgroundColor(UIColor.tp_colorWithHex(0x290099));
        var size = contentView.bounds();
        var inset = width/10.0;
        var subView = contentView;
        for (var i = 0; i < 8; i++) {
          size = subView.bounds()
          newView = UIView.alloc().initWithFrame({x:inset,y:inset,width:size.width-inset,height:size.height-inset});
          newView.setBackgroundColor(UIColor.tp_colorWithHex((i+2)*0x290099));
          subView.addSubview(newView);
          subView = newView;
        }

        vc.view().addSubview(contentView);

        var button = UIButton.buttonWithType(0);
        button.setFrame({x:16,y:height-50-44, width: width - 32, height: 50})
        button.setBackgroundColor(UIColor.tp_colorWithHex(0xFF8000));
        //多参数调用直接去掉冒号
        button.setTitleforState("Taoprone", UIControlStateNormal);
        button.setTitleColorforState(UIColor.tp_colorWithHex(0xFFFFFF), UIControlStateNormal);
        button.doActionFunction = function() {
          console.error("action finished");
        }
        button.addTargetactionforControlEvents(vc, null, UIControlEventTouchUpInside);
        vc.view().addSubview(button);
    }
    return toObjC(vc);
}
