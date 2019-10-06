package net.wg.gui.lobby.store.actions.cards
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import org.idmedia.as3commons.util.StringUtils;

    public class StoreActionDiscount extends MovieClip implements IDisposable
    {

        public static const LABEL_HERO:String = "hero";

        public static const LABEL_NORMAL:String = "normal";

        public static const LABEL_SMALL:String = "small";

        public var textField:TextField = null;

        private var _labelsHash:Vector.<String> = null;

        private var _curState:String = "";

        public function StoreActionDiscount()
        {
            super();
            var _loc1_:Array = this.currentLabels;
            var _loc2_:uint = _loc1_.length;
            this._labelsHash = new Vector.<String>(_loc2_);
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                this._labelsHash[_loc3_] = _loc1_[_loc3_].name;
                _loc3_++;
            }
            this.visible = false;
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        public function setData(param1:String, param2:String) : void
        {
            if(this._curState == param1)
            {
                return;
            }
            if(this._labelsHash.indexOf(param1) >= 0 && StringUtils.isNotEmpty(param2))
            {
                this._curState = param1;
                this.gotoAndStop(this._curState);
                this.textField.htmlText = param2;
                if(!this.visible)
                {
                    this.visible = true;
                }
            }
            else
            {
                this.visible = false;
            }
        }

        protected function onDispose() : void
        {
            this.textField = null;
            this._labelsHash.splice(0,this._labelsHash.length);
            this._labelsHash = null;
        }
    }
}
