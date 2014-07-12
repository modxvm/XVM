package net.wg.gui.components.tooltips
{
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.components.tooltips.helpers.Utils;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO;
    import flash.filters.DropShadowFilter;
    
    public class ToolTipUnitLevel extends ToolTipBase
    {
        
        public function ToolTipUnitLevel() {
            super();
        }
        
        private function setHeader(param1:String) : Number {
            var _loc2_:TextField = content.headerTF;
            _loc2_.autoSize = TextFieldAutoSize.LEFT;
            _loc2_.htmlText = Utils.instance.htmlWrapper(param1,Utils.instance.COLOR_HEADER,18,"$TitleFont");
            _loc2_.width = _loc2_.textWidth + 5;
            _loc2_.x = bgShadowMargin.left + contentMargin.left;
            _loc2_.y = topPosition ^ 0;
            return _loc2_.textHeight + Utils.instance.MARGIN_AFTER_BLOCK;
        }
        
        private function addSeparatorWithMargin() : Separator {
            var _loc1_:Separator = Utils.instance.createSeparate(content);
            _loc1_.y = topPosition ^ 0;
            separators.push(_loc1_);
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
            return _loc1_;
        }
        
        override protected function redraw() : void {
            var _loc1_:* = 0;
            var _loc4_:MovieClip = null;
            var _loc5_:Status = null;
            var _loc6_:Sprite = null;
            var _loc7_:ToolTipStatusColorsVO = null;
            var _loc8_:uint = 0;
            var _loc9_:* = NaN;
            var _loc10_:* = NaN;
            var _loc11_:* = NaN;
            var _loc12_:String = null;
            var _loc13_:DropShadowFilter = null;
            _loc1_ = _data.level;
            var _loc2_:Separator = null;
            separators = new Vector.<Separator>();
            topPosition = topPosition + this.setHeader(App.utils.locale.makeString(TOOLTIPS.CYBERSPORT_UNITLEVEL_TITLE));
            _loc2_ = this.addSeparatorWithMargin();
            var _loc3_:TextField = content.description;
            _loc3_.y = topPosition;
            _loc3_.x = contentMargin.left + bgShadowMargin.left;
            _loc3_.text = TOOLTIPS.CYBERSPORT_UNITLEVEL_DESCRIPTION;
            _loc3_.height = _loc3_.textHeight + 5;
            topPosition = _loc3_.y + _loc3_.height + Utils.instance.MARGIN_AFTER_BLOCK;
            _loc2_ = this.addSeparatorWithMargin();
            _loc4_ = content.bodyMC;
            _loc4_.y = topPosition;
            _loc4_.x = contentMargin.left + bgShadowMargin.left;
            _loc4_.recommendedLevels.text = TOOLTIPS.CYBERSPORT_UNITLEVEL_BODY_RECOMMENDED;
            _loc4_.unrecommendedevels.text = TOOLTIPS.CYBERSPORT_UNITLEVEL_BODY_NOTRECOMMENDED;
            _loc4_.errorLevels.text = TOOLTIPS.CYBERSPORT_UNITLEVEL_BODY_ERROR;
            _loc4_.descriptions.htmlText = TOOLTIPS.CYBERSPORT_UNITLEVEL_BODY;
            topPosition = _loc4_.y + _loc4_.height;
            _loc5_ = content.tooltipStatus;
            _loc6_ = content.whiteBg;
            if(_loc1_ > 0)
            {
                topPosition = topPosition + Utils.instance.MARGIN_AFTER_BLOCK;
                _loc2_ = this.addSeparatorWithMargin();
                _loc6_.visible = true;
                _loc6_.y = _loc2_.y;
                _loc5_.visible = true;
                _loc5_.y = topPosition;
                _loc5_.x = contentMargin.left + bgShadowMargin.left;
                _loc7_ = new ToolTipStatusColorsVO();
                _loc8_ = 0;
                _loc9_ = 0;
                _loc10_ = 0;
                _loc11_ = 0;
                if(_loc1_ < 40)
                {
                    _loc7_.textColor = 15237413;
                    _loc8_ = 16711680;
                    _loc9_ = 0.5;
                    _loc10_ = 0.27;
                    _loc11_ = 11;
                    _loc12_ = TOOLTIPS.CYBERSPORT_UNITLEVEL_BODY_NOTRECOMMENDEDSTATUS;
                }
                else if(_loc1_ > 42)
                {
                    _loc7_.textColor = 16717591;
                    _loc8_ = 16711680;
                    _loc9_ = 0.5;
                    _loc10_ = 0.27;
                    _loc11_ = 11;
                    _loc12_ = TOOLTIPS.CYBERSPORT_UNITLEVEL_BODY_ERRORSTATUS;
                }
                else
                {
                    _loc7_.textColor = 8041216;
                    _loc8_ = 3997440;
                    _loc9_ = 0.5;
                    _loc10_ = 0.27;
                    _loc11_ = 11;
                    _loc12_ = TOOLTIPS.CYBERSPORT_UNITLEVEL_BODY_RECOMMENDEDSTATUS;
                }
                
                _loc7_.filters = [];
                _loc13_ = new DropShadowFilter();
                _loc13_.distance = 0;
                _loc13_.angle = 0;
                _loc13_.color = _loc8_;
                _loc13_.alpha = _loc10_;
                _loc13_.blurX = _loc11_;
                _loc13_.blurY = _loc11_;
                _loc13_.strength = _loc9_;
                _loc13_.quality = 3;
                _loc13_.inner = false;
                _loc13_.knockout = false;
                _loc13_.hideObject = false;
                _loc7_.filters.push(_loc13_);
                _loc5_.x = contentMargin.left + bgShadowMargin.left;
                _loc5_.updateWidth(content.width - contentMargin.right - bgShadowMargin.right);
                _loc5_.setData(App.utils.locale.makeString(_loc12_,{"sumLevels":_loc1_.toString()}),null,_loc7_);
                topPosition = topPosition + (_loc5_.height + Utils.instance.MARGIN_AFTER_BLOCK);
                _loc6_.height = topPosition - _loc6_.y;
            }
            else
            {
                _loc5_.visible = false;
                _loc6_.visible = false;
            }
            contentMargin.bottom = 0;
            super.redraw();
        }
        
        override protected function updateSize() : void {
            super.updateSize();
            var _loc1_:Sprite = content.whiteBg;
            if((_loc1_) && (_loc1_.visible))
            {
                _loc1_.width = contentWidth + bgShadowMargin.horizontal;
            }
        }
    }
}
