package net.wg.gui.lobby.questsWindow.components
{
    import flash.events.MouseEvent;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.gui.lobby.questsWindow.data.QuestIconElementVO;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.events.UILoaderEvent;
    import scaleform.clik.constants.InvalidationType;
    import flash.display.DisplayObject;

    public class QuestIconElement extends AbstractResizableContent
    {

        public static const TEXT_PADDING:int = 5;

        public var icon:UILoaderAlt;

        public var labelTF:TextField;

        public var counterTF:TextField = null;

        private var dataVO:QuestIconElementVO = null;

        public function QuestIconElement()
        {
            super();
        }

        private static function hideTooltip(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }

        override public function setData(param1:Object) : void
        {
            if(this.dataVO)
            {
                this.dataVO.dispose();
            }
            this.dataVO = new QuestIconElementVO(param1);
            invalidateData();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.counterTF.autoSize = TextFieldAutoSize.LEFT;
            this.updateTooltipEventListeners(this.icon);
        }

        override protected function onDispose() : void
        {
            this.updateTooltipEventListeners(this.icon,false);
            this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadedHandler);
            this.icon.dispose();
            if(this.dataVO.label != "" && this.dataVO.isWulfTooltip)
            {
                this.updateTooltipEventListeners(this.labelTF,false);
            }
            this.labelTF = null;
            this.counterTF = null;
            if(this.dataVO)
            {
                this.dataVO.dispose();
                this.dataVO = null;
            }
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:* = 0;
            super.draw();
            if(isInvalid(InvalidationType.DATA) && this.dataVO)
            {
                this.icon.source = this.dataVO.icon;
                this.icon.autoSize = this.dataVO.iconAutoSize;
                this.counterTF.htmlText = this.dataVO.counter;
                this.labelTF.htmlText = this.dataVO.label;
                if(this.dataVO.label != "" && this.dataVO.isWulfTooltip)
                {
                    App.utils.commons.updateTextFieldSize(this.labelTF,true,false);
                    this.updateTooltipEventListeners(this.labelTF);
                }
                _loc1_ = Math.round(this.labelTF.height);
                _loc2_ = 0;
                if(this.dataVO.counter)
                {
                    _loc2_ = this.counterTF.textWidth + TEXT_PADDING;
                }
                if(this.dataVO.icon)
                {
                    this.icon.x = _loc2_;
                    _loc2_ = _loc2_ + (this.icon.width + TEXT_PADDING);
                }
                this.labelTF.x = _loc2_;
                setSize(this.width,_loc1_);
                if(!this.dataVO.iconAutoSize)
                {
                    this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadedHandler);
                }
                else
                {
                    this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadedHandler);
                }
            }
        }

        private function updateTooltipEventListeners(param1:DisplayObject, param2:Boolean = true) : void
        {
            if(param2)
            {
                param1.addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
                param1.addEventListener(MouseEvent.CLICK,hideTooltip);
                param1.addEventListener(MouseEvent.ROLL_OVER,this.showTooltip);
            }
            else
            {
                param1.removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
                param1.removeEventListener(MouseEvent.CLICK,hideTooltip);
                param1.removeEventListener(MouseEvent.ROLL_OVER,this.showTooltip);
            }
        }

        private function showTooltip(param1:MouseEvent) : void
        {
            if(this.dataVO.isWulfTooltip)
            {
                App.toolTipMgr.showWulfTooltip(this.dataVO.dataType);
            }
            else if(this.dataVO.dataType && this.dataVO.dataName && this.dataVO.dataBlock)
            {
                App.toolTipMgr.showSpecial(this.dataVO.dataType,null,this.dataVO.dataBlock,this.dataVO.dataName,this.dataVO.dataValue);
            }
            else if(this.dataVO.dataType)
            {
                App.toolTipMgr.showComplex(this.dataVO.dataType);
            }
        }

        private function onIconLoadedHandler(param1:UILoaderEvent) : void
        {
            this.icon.y = _height - this.icon.height >> 1;
        }
    }
}
