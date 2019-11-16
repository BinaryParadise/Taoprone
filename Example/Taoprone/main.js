function initModule() {
    hellooc();
    var vc = TPViewController.alloc().init();
    // 冒号用双下划线代替

    vc.viewDidLoad = function() {
        vc.view().setBackgroundColor(UIColor.tp_colorWithHex(0xF6F6F6));
        var width = UIScreen.mainScreen().bounds().width;
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
    }
    return toObjC(vc);
}
