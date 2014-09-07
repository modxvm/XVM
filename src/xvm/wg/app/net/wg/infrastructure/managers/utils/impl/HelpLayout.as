package net.wg.infrastructure.managers.utils.impl
{
    import net.wg.utils.IHelpLayout;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import net.wg.utils.IUtils;
    import net.wg.utils.IAssertable;
    import net.wg.data.constants.Errors;
    import net.wg.utils.IPopUpManager;
    import net.wg.data.constants.Linkages;
    import flash.display.Stage;
    
    public class HelpLayout extends Object implements IHelpLayout
    {
        
        public function HelpLayout()
        {
            super();
        }
        
        private static var HL_MAIN_SOURCE:String = "HelpLayout";
        
        private static var DEF_CONNECTOR_LENGTH:Number = 12;
        
        private var _modalBackground:DisplayObject = null;
        
        public function create(param1:DisplayObject, param2:Object, param3:DisplayObjectContainer) : DisplayObject
        {
            var _loc4_:IUtils = App.utils;
            var _loc5_:IAssertable = _loc4_.asserter;
            _loc5_.assertNotNull(param2.text,"initproperties.text" + Errors.CANT_NULL);
            _loc5_.assert(param2.text.length > 0,"text in initproperties can`t empty!");
            var _loc6_:IPopUpManager = _loc4_.popupMgr;
            var _loc7_:DisplayObject = _loc6_.create(HL_MAIN_SOURCE,param2,param3);
            return _loc7_;
        }
        
        public function createBackground() : void
        {
            this.destroyBackground();
            this._modalBackground = App.utils.popupMgr.create(Linkages.POPUP_MODAL,{"x":0,
            "y":0,
            "alpha":0.5
        });
        var _loc1_:Stage = App.instance.stage;
        if(this._modalBackground != null)
        {
            this._modalBackground.width = _loc1_.width;
            this._modalBackground.height = _loc1_.height;
        }
    }
    
    public function destroyBackground() : void
    {
        if(this._modalBackground != null)
        {
            if(this._modalBackground.parent)
            {
                App.utils.popupMgr.remove(this._modalBackground);
            }
            this._modalBackground = null;
        }
    }
    
    public function isShowed() : Boolean
    {
        return this._modalBackground == null;
    }
    
    public function destroy(param1:DisplayObject) : void
    {
        var _loc2_:IUtils = App.utils;
        var _loc3_:Function = _loc2_.asserter.assertNotNull;
        _loc3_(param1,"helpLayoutControl" + Errors.CANT_NULL);
        if(param1.parent)
        {
            _loc2_.popupMgr.remove(param1);
        }
    }
    
    public function dispose() : void
    {
        this.destroyBackground();
    }
    
    public function getProps(param1:Number, param2:Number, param3:String, param4:String, param5:Number, param6:Number, param7:Number) : Object
    {
        return {"borderWidth":param1,
        "borderHeight":param2,
        "direction":param3,
        "text":param4,
        "x":param5,
        "y":param6,
        "connectorLength":param7
    };
}

public function get defConnectorLength() : Number
{
    return DEF_CONNECTOR_LENGTH;
}
}
}
