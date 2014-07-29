package net.wg.gui.components.tooltips
{
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.utils.ILocale;
    import net.wg.gui.rally.vo.VehicleVO;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.components.tooltips.helpers.Utils;
    import flash.display.MovieClip;
    
    public class ToolTipSelectedVehicle extends ToolTipSpecial
    {
        
        public function ToolTipSelectedVehicle()
        {
            super();
            this.headerTF = content.headerTF;
            this.whiteBg = content.whiteBg;
        }
        
        public var headerTF:TextField = null;
        
        public var whiteBg:Sprite = null;
        
        public var vehicle:SuitableVehicleBlockItem = null;
        
        private var MIN_CONTENT_WIDTH:Number = 275;
        
        private var MARGIN_BEETWEEN_BLOCKS:Number = 3;
        
        override public function toString() : String
        {
            return "[WG ToolTipSelectedVehicle " + name + "]";
        }
        
        override protected function updateSize() : void
        {
            var _loc1_:Separator = null;
            if(content.width < this.MIN_CONTENT_WIDTH)
            {
                contentWidth = this.MIN_CONTENT_WIDTH;
            }
            super.updateSize();
            if(this.whiteBg.visible)
            {
                _loc1_ = separators[separators.length - 1];
                this.whiteBg.width = contentWidth + bgShadowMargin.horizontal;
                this.whiteBg.height = content.height + contentMargin.bottom - _loc1_.y;
            }
        }
        
        override protected function redraw() : void
        {
            var _loc1_:ILocale = null;
            var _loc2_:VehicleVO = null;
            var _loc3_:Separator = null;
            _loc1_ = App.utils.locale;
            _loc2_ = new VehicleVO(_data);
            separators = new Vector.<Separator>();
            this.headerTF.autoSize = TextFieldAutoSize.LEFT;
            this.headerTF.htmlText = Utils.instance.htmlWrapper(_loc1_.makeString(TOOLTIPS.SELECTEDVEHICLE_HEADER),Utils.instance.COLOR_HEADER,18,"$TitleFont");
            this.headerTF.width = this.headerTF.textWidth + 5;
            this.headerTF.x = bgShadowMargin.left + contentMargin.left;
            this.headerTF.y = topPosition;
            topPosition = topPosition + (this.headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK);
            _loc3_ = Utils.instance.createSeparate(content);
            _loc3_.y = topPosition ^ 0;
            separators.push(_loc3_);
            this.whiteBg.y = _loc3_.y;
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
            topPosition = this.addSuitableVehicleBlockItem(content,_loc2_,topPosition);
            contentMargin.bottom = Utils.instance.MARGIN_AFTER_BLOCK;
            _loc2_.dispose();
            _loc2_ = null;
            updatePositions();
            super.redraw();
        }
        
        private function addSuitableVehicleBlockItem(param1:MovieClip, param2:VehicleVO, param3:Number) : Number
        {
            var _loc4_:SuitableVehicleBlockItem = App.utils.classFactory.getComponent("SuitableVehicleBlockItemUI",SuitableVehicleBlockItem);
            _loc4_.setData(App.utils.nations.getNationIcon(param2.nationID),param2.level,param2.smallIconPath,"../maps/icons/filters/tanks/" + param2.type + ".png",param2.shortUserName);
            _loc4_.x = contentMargin.left + bgShadowMargin.left;
            _loc4_.y = param3 ^ 0;
            param1.addChild(_loc4_);
            var param3:Number = param3 + (_loc4_.height + this.MARGIN_BEETWEEN_BLOCKS);
            return param3;
        }
    }
}
