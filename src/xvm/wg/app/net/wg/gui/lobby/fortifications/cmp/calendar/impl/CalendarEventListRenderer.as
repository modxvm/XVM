package net.wg.gui.lobby.fortifications.cmp.calendar.impl
{
    import scaleform.clik.controls.ListItemRenderer;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.lobby.fortifications.data.FortCalendarEventVO;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.utils.ComplexTooltipHelper;
    
    public class CalendarEventListRenderer extends ListItemRenderer
    {
        
        public function CalendarEventListRenderer()
        {
            super();
            preventAutosizing = true;
        }
        
        public var headerTF:TextField;
        
        public var timeTF:TextField;
        
        public var directionTF:TextField;
        
        public var resultTF:TextField;
        
        public var icon:UILoaderAlt;
        
        public var backImage:UILoaderAlt;
        
        protected var model:FortCalendarEventVO;
        
        override public function setData(param1:Object) : void
        {
            this.model = param1 as FortCalendarEventVO;
            invalidateData();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            mouseChildren = true;
            this.headerTF.addEventListener(MouseEvent.ROLL_OVER,this.onClanOver);
            this.headerTF.addEventListener(MouseEvent.ROLL_OUT,this.onControlOut);
            this.resultTF.addEventListener(MouseEvent.ROLL_OVER,this.onResultOver);
            this.resultTF.addEventListener(MouseEvent.ROLL_OUT,this.onControlOut);
        }
        
        override protected function onDispose() : void
        {
            this.headerTF.removeEventListener(MouseEvent.ROLL_OVER,this.onClanOver);
            this.headerTF.removeEventListener(MouseEvent.ROLL_OUT,this.onControlOut);
            this.resultTF.removeEventListener(MouseEvent.ROLL_OVER,this.onResultOver);
            this.resultTF.removeEventListener(MouseEvent.ROLL_OUT,this.onControlOut);
            this.icon.dispose();
            this.icon = null;
            this.backImage.dispose();
            this.backImage = null;
            this.headerTF = null;
            this.timeTF = null;
            this.directionTF = null;
            this.resultTF = null;
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(this.model)
                {
                    this.headerTF.htmlText = this.model.title;
                    this.timeTF.htmlText = this.model.timeInfo;
                    this.directionTF.htmlText = this.model.direction;
                    this.resultTF.htmlText = this.model.result;
                    this.icon.source = this.model.icon;
                    this.icon.visible = Boolean(this.model.icon);
                    this.backImage.source = this.model.background;
                    this.backImage.visible = Boolean(this.model.background);
                    visible = true;
                }
                else
                {
                    visible = false;
                }
            }
            mouseChildren = true;
        }
        
        private function onResultOver(param1:MouseEvent) : void
        {
            var _loc2_:String = null;
            if(this.model)
            {
                _loc2_ = new ComplexTooltipHelper().addHeader(this.model.resultTTHeader).addBody(this.model.resultTTBody).make();
                if(_loc2_.length > 0)
                {
                    App.toolTipMgr.showComplex(_loc2_);
                }
            }
        }
        
        private function onControlOut(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private function onClanOver(param1:MouseEvent) : void
        {
            if((this.model) && (this.model.clanID))
            {
            }
        }
    }
}
