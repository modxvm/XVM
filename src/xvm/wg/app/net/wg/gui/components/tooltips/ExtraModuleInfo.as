package net.wg.gui.components.tooltips 
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.lobby.profile.components.*;
    
    public class ExtraModuleInfo extends net.wg.gui.lobby.profile.components.SimpleLoader
    {
        public function ExtraModuleInfo(arg1:flash.text.TextFormat, arg2:flash.text.StyleSheet=null)
        {
            super();
            this._textField = new flash.text.TextField();
            this._textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this._textField.setTextFormat(arg1);
            if (arg2) 
            {
                this._textField.styleSheet = arg2;
            }
            addChild(this._textField);
            return;
        }

        public function setData(arg1:String, arg2:String):void
        {
            disposeLoader();
            this._textField.htmlText = arg2;
            this.startLoading(arg1);
            return;
        }

        protected override function startLoading(arg1:String):void
        {
            super.startLoading(arg1);
            if (loader) 
            {
                loader.parent.setChildIndex(loader, 0);
            }
            return;
        }

        protected override function onLoadingComplete():void
        {
            super.onLoadingComplete();
            this.layoutComponents();
            return;
        }

        internal function layoutComponents():void
        {
            var loc4:*=null;
            var loc1:*=0;
            var loc2:*=5;
            var loc3:*=0;
            while (loc3 < numChildren) 
            {
                (loc4 = getChildAt(loc3)).y = Math.round((height - loc4.height) / 2);
                loc4.x = loc1;
                loc1 = loc1 + Math.round(loc2 + loc4.width);
                ++loc3;
            }
            return;
        }

        internal var _textField:flash.text.TextField;
    }
}
