package net.wg.gui.components.tooltips
{
    import net.wg.gui.components.tooltips.VO.VehicleBaseVO;
    import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
    import flash.text.TextField;
    import net.wg.gui.components.controls.IconText;
    import net.wg.gui.components.tooltips.helpers.Utils;
    import net.wg.utils.ILocale;
    import net.wg.data.constants.IconsTypes;
    
    public class ToolTipSpecial extends ToolTipBase
    {
        
        public function ToolTipSpecial()
        {
            super();
        }
        
        public static var ID_BUY_PRICE:String = "buy_price";
        
        public static var ID_SELL_PRICE:String = "sell_price";
        
        public static var ID_DAILY_XP_FACTOR:String = "dailyXPFactor";
        
        public static var ID_ACTION_XP_FACTOR:String = "actionXPFactor";
        
        public static var ID_DOUBLE_XP_FACTOR:String = "doubleXPFactor";
        
        public static var ID_UNLOCK_PRICE:String = "unlock_price";
        
        public static var ID_HIDDEN_VEHICLE_COUNT:String = "hiddenVehicleCount";
        
        public static var RENTALS:String = "rentals";
        
        public static var MIN_RENTALS_PRICE:String = "minRentalsPrice";
        
        public static var SKIP_FIELDS:Array = [VehicleBaseVO.DEF_BUY_PRICE,VehicleBaseVO.DEF_SELL_PRICE,VehicleBaseVO.ACTION_PRC,VehicleBaseVO.DEF_RENT_PRICE,VehicleBaseVO.RENT_ACTION_PRC];
        
        protected var blockResults:Vector.<ToolTipBlockResultVO> = null;
        
        override protected function onDispose() : void
        {
            var _loc1_:ToolTipBlockResultVO = null;
            var _loc2_:TextField = null;
            var _loc3_:TextField = null;
            var _loc4_:Vector.<IconText> = null;
            var _loc5_:IconText = null;
            if(this.blockResults)
            {
                while(this.blockResults.length > 0)
                {
                    _loc1_ = this.blockResults.pop();
                    _loc2_ = _loc1_.headerTextField;
                    if(_loc2_ != null)
                    {
                        content.removeChild(_loc2_);
                        _loc1_.headerTextField = null;
                        _loc2_ = null;
                    }
                    _loc3_ = _loc1_.leftTextField;
                    if(_loc3_ != null)
                    {
                        content.removeChild(_loc3_);
                        _loc1_.leftTextField = null;
                        _loc3_ = null;
                    }
                    _loc4_ = _loc1_.elRightList;
                    while(_loc4_.length > 0)
                    {
                        _loc5_ = _loc4_.pop();
                        content.removeChild(_loc5_);
                        _loc5_ = null;
                    }
                    _loc1_ = null;
                }
                this.blockResults = null;
            }
            super.onDispose();
        }
        
        override protected function updateSize() : void
        {
            if(contentWidth == 0 || contentWidth < content.width)
            {
                contentWidth = content.width;
            }
            background.width = contentWidth + contentMargin.right + bgShadowMargin.right | 0;
            background.height = content.height + contentMargin.bottom + bgShadowMargin.bottom | 0;
        }
        
        protected function updatePositions() : void
        {
            var _loc2_:uint = 0;
            var _loc3_:uint = 0;
            var _loc4_:uint = 0;
            var _loc5_:* = NaN;
            var _loc6_:Separator = null;
            var _loc1_:uint = 0;
            if(this.blockResults)
            {
                _loc1_ = this.blockResults.length;
                _loc2_ = 0;
                _loc3_ = 0;
                _loc3_ = 0;
                while(_loc3_ < _loc1_)
                {
                    this.blockResults[_loc3_].leftTextField.width = leftPartMaxW;
                    _loc2_ = this.blockResults[_loc3_].elRightList.length;
                    _loc4_ = 0;
                    while(_loc4_ < _loc2_)
                    {
                        this.blockResults[_loc3_].elRightList[_loc4_].x = this.blockResults[_loc3_].leftTextField.x + leftPartMaxW + Utils.instance.MARGIN_BEETWEEN_LEFT_AND_RIGHT_BLOCKS | 0;
                        _loc4_++;
                    }
                    _loc3_++;
                }
            }
            if(separators)
            {
                _loc1_ = separators.length;
                _loc5_ = content.width + contentMargin.right + bgShadowMargin.right;
                _loc3_ = 0;
                while(_loc3_ < _loc1_)
                {
                    _loc6_ = separators[_loc3_];
                    _loc6_.x = _loc5_ - _loc6_.width >> 1;
                    _loc3_++;
                }
            }
        }
        
        protected function getAlertInfo(param1:ILocale, param2:Number, param3:String, param4:String) : String
        {
            if(param2 == 0)
            {
                return "";
            }
            var _loc5_:* = " ( <font color=\"#8c0000\">" + param3 + "</font> ";
            _loc5_ = _loc5_ + (param4 == IconsTypes.GOLD?param1.gold(param2):param1.integer(param2));
            _loc5_ = _loc5_ + (this.getIcoForText(param4) + ")");
            return _loc5_;
        }
        
        protected function getIcoForText(param1:String) : String
        {
            switch(param1)
            {
                case IconsTypes.ELITE_XP:
                case IconsTypes.XP:
                    param1 = IconsTypes.XP_PRICE;
                    break;
            }
            return App.utils.icons.getIcon16StrPath(param1);
        }
        
        protected function getActionInfo(param1:ILocale, param2:Number, param3:Number, param4:String) : String
        {
            var _loc5_:String = Utils.instance.htmlWrapper(param2.toString() + "%",Utils.instance.COLOR_HEADER);
            var _loc6_:String = param4 == IconsTypes.GOLD?param1.gold(param3):param1.integer(param3);
            var _loc7_:String = param1.makeString(TOOLTIPS.VEHICLE_ACTION_PRC,{"actionPrc":_loc5_,
            "oldPrice":_loc6_
        }) + this.getIcoForText(param4);
        return _loc7_;
    }
}
}
