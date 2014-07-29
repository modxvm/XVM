package net.wg.gui.lobby.questsWindow.components
{
    import flash.events.MouseEvent;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.gui.lobby.questsWindow.data.QuestIconElementVO;
    import scaleform.clik.constants.InvalidationType;
    
    public class QuestIconElement extends AbstractResizableContent
    {
        
        public function QuestIconElement()
        {
            super();
        }
        
        public static var TEXT_PADDING:int = 5;
        
        private static function hideTooltip(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var icon:UILoaderAlt;
        
        public var labelTF:TextField;
        
        private var dataVO:QuestIconElementVO = null;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.icon.addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            this.icon.addEventListener(MouseEvent.CLICK,hideTooltip);
            this.icon.addEventListener(MouseEvent.ROLL_OVER,this.showTooltip);
        }
        
        override protected function onDispose() : void
        {
            this.icon.removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            this.icon.removeEventListener(MouseEvent.CLICK,hideTooltip);
            this.icon.removeEventListener(MouseEvent.ROLL_OVER,this.showTooltip);
            this.icon.dispose();
            this.labelTF = null;
            if(this.dataVO)
            {
                this.dataVO.dispose();
                this.dataVO = null;
            }
            super.onDispose();
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
        
        override protected function draw() : void
        {
            var _loc1_:* = NaN;
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (this.dataVO))
            {
                this.icon.source = this.dataVO.icon;
                this.labelTF.htmlText = this.dataVO.label;
                _loc1_ = Math.round(this.labelTF.height);
                if(this.dataVO.icon)
                {
                    this.labelTF.x = this.icon.width + TEXT_PADDING;
                }
                else
                {
                    this.labelTF.x = 0;
                }
                setSize(this.width,_loc1_);
            }
        }
        
        private function showTooltip(param1:MouseEvent) : void
        {
            if((this.dataVO.dataType) && (this.dataVO.dataName) && (this.dataVO.dataBlock))
            {
                App.toolTipMgr.showSpecial(this.dataVO.dataType,null,this.dataVO.dataBlock,this.dataVO.dataName);
            }
        }
    }
}
