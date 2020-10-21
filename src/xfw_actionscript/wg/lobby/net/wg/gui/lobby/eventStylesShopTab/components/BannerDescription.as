package net.wg.gui.lobby.eventStylesShopTab.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import net.wg.utils.ICommons;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.eventStylesShopTab.data.BannerRewardVO;

    public class BannerDescription extends Sprite implements IDisposable
    {

        private static const OFFSET:int = 4;

        public var num1:TextField = null;

        public var num2:TextField = null;

        public var num3:TextField = null;

        public var num4:TextField = null;

        public var textField1:TextField = null;

        public var textField2:TextField = null;

        public var textField3:TextField = null;

        public var textField4:TextField = null;

        private var _numbers:Vector.<TextField> = null;

        private var _names:Vector.<TextField> = null;

        private var _commons:ICommons;

        public function BannerDescription()
        {
            this._commons = App.utils.commons;
            super();
            this._numbers = new <TextField>[this.num1,this.num2,this.num3,this.num4];
            this._names = new <TextField>[this.textField1,this.textField2,this.textField3,this.textField4];
        }

        public function setData(param1:DataProvider) : void
        {
            var _loc3_:* = 0;
            var _loc5_:BannerRewardVO = null;
            var _loc2_:* = 0;
            var _loc4_:int = Math.min(param1.length,this._numbers.length);
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
                _loc5_ = BannerRewardVO(param1[_loc3_]);
                this._numbers[_loc3_].htmlText = _loc5_.count;
                this._names[_loc3_].htmlText = _loc5_.name;
                this._commons.updateTextFieldSize(this._numbers[_loc3_],true,false);
                _loc2_ = Math.max(_loc2_,this._numbers[_loc3_].width);
                _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
                this._numbers[_loc3_].x = _loc2_ - this._numbers[_loc3_].width >> 0;
                this._names[_loc3_].x = _loc2_ + OFFSET >> 0;
                _loc3_++;
            }
        }

        public final function dispose() : void
        {
            this._numbers.splice(0,this._numbers.length);
            this._numbers = null;
            this._names.splice(0,this._names.length);
            this._names = null;
            this.num1 = null;
            this.num2 = null;
            this.num3 = null;
            this.num4 = null;
            this.textField1 = null;
            this.textField2 = null;
            this.textField3 = null;
            this.textField4 = null;
            this._commons = null;
        }
    }
}
