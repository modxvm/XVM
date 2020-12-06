package net.wg.gui.lobby.questsWindow.components
{
    import flash.text.TextField;
    import net.wg.gui.lobby.questsWindow.data.TextBlockVO;
    import flash.events.MouseEvent;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.managers.impl.TooltipProps;
    import net.wg.data.constants.BaseTooltips;

    public class QuestTextAwardBlock extends AbstractResizableContent
    {

        private static const MAX_TOOLTIP_WIDTH:int = 300;

        private static const TEXT_FIELD_PADDING:int = 5;

        private static const WARNING_STR:String = "Warn: not one items can be visible. Full items text: ";

        public var textTf:TextField = null;

        private var _tooltip:String = "";

        private var _complexTooltip:Boolean = false;

        public function QuestTextAwardBlock()
        {
            super();
        }

        override public function setData(param1:Object) : void
        {
            var _loc2_:TextBlockVO = new TextBlockVO(param1);
            var _loc3_:Vector.<String> = _loc2_.items;
            var _loc4_:String = _loc2_.separator;
            var _loc5_:String = _loc3_.join(_loc4_) + _loc2_.endline;
            if(this.calcVisibleItemsLen(_loc3_,_loc5_,_loc2_.ellipsis,_loc4_.length) == 0)
            {
                DebugUtils.LOG_WARNING(WARNING_STR + _loc5_);
            }
            else
            {
                App.utils.commons.updateTextFieldSize(this.textTf,false,true);
                this.updateSize();
                if(this.textTf.htmlText != _loc5_)
                {
                    this.textTf.addEventListener(MouseEvent.ROLL_OVER,this.onTextTfRollOverHandler);
                    this.textTf.addEventListener(MouseEvent.ROLL_OUT,this.onTextTfRollOutHandler);
                    this._complexTooltip = StringUtils.isNotEmpty(_loc2_.complexTooltip);
                    if(this._complexTooltip)
                    {
                        this._tooltip = _loc2_.complexTooltip;
                    }
                    else
                    {
                        this._tooltip = _loc5_;
                    }
                }
            }
            _loc2_.dispose();
        }

        override protected function onDispose() : void
        {
            this.textTf.removeEventListener(MouseEvent.ROLL_OVER,this.onTextTfRollOverHandler);
            this.textTf.removeEventListener(MouseEvent.ROLL_OUT,this.onTextTfRollOutHandler);
            this.textTf = null;
            super.onDispose();
        }

        protected function updateSize() : void
        {
            setSize(width,actualHeight);
        }

        protected function calcVisibleItemsLen(param1:Vector.<String>, param2:String, param3:String, param4:int) : int
        {
            var _loc5_:Number = this.textTf.height;
            var _loc6_:int = param1.length;
            this.textTf.htmlText = param2;
            while(this.textTf.textHeight + TEXT_FIELD_PADDING > _loc5_)
            {
                this.textTf.htmlText = param2.substr(0,this.getItemsStringLen(param1,--_loc6_,param4)) + param3;
            }
            return _loc6_;
        }

        private function getItemsStringLen(param1:Vector.<String>, param2:int, param3:int) : int
        {
            var _loc4_:* = 0;
            var _loc5_:* = 0;
            while(_loc5_ < param2)
            {
                _loc4_ = _loc4_ + (param1[_loc5_].length + param3);
                _loc5_++;
            }
            return _loc4_;
        }

        private function onTextTfRollOverHandler(param1:MouseEvent) : void
        {
            if(this._complexTooltip)
            {
                App.toolTipMgr.showComplex(this._tooltip);
            }
            else
            {
                App.toolTipMgr.show(this._tooltip,new TooltipProps(BaseTooltips.TYPE_INFO,0,0,0,-1,0,MAX_TOOLTIP_WIDTH));
            }
        }

        private function onTextTfRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
    }
}
