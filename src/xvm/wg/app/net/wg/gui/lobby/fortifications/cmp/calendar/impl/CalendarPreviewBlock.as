package net.wg.gui.lobby.fortifications.cmp.calendar.impl
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.ScrollingListEx;
    import net.wg.gui.components.controls.ScrollBar;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.fortifications.data.FortCalendarPreviewBlockVO;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.data.DataProvider;
    
    public class CalendarPreviewBlock extends UIComponent
    {
        
        public function CalendarPreviewBlock()
        {
            super();
        }
        
        public var dateTF:TextField;
        
        public var dateInfoTF:TextField;
        
        public var noEventsTF:TextField;
        
        public var list:ScrollingListEx;
        
        public var scrollBar:ScrollBar;
        
        public var shadowSeparator:MovieClip;
        
        private var _model:FortCalendarPreviewBlockVO;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.list.buttonModeEnabled = false;
            this.shadowSeparator.mouseChildren = this.shadowSeparator.mouseEnabled = false;
        }
        
        override protected function onDispose() : void
        {
            this.dateTF = null;
            this.dateInfoTF = null;
            this.shadowSeparator = null;
            this.list.dispose();
            this.list = null;
            this.scrollBar.dispose();
            this.scrollBar = null;
            if(this._model)
            {
                this._model.dispose();
                this._model = null;
            }
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(this._model)
                {
                    this.dateTF.htmlText = this._model.dateString;
                    this.dateInfoTF.htmlText = this._model.dateInfo;
                    if(this._model.hasEvents)
                    {
                        this.list.dataProvider = new DataProvider(this._model.events);
                        this.list.visible = true;
                        this.noEventsTF.visible = false;
                    }
                    else
                    {
                        this.list.dataProvider = new DataProvider([]);
                        this.noEventsTF.htmlText = this._model.noEventsText;
                        this.noEventsTF.visible = true;
                        this.list.visible = false;
                    }
                }
            }
        }
        
        public function get model() : FortCalendarPreviewBlockVO
        {
            return this._model;
        }
        
        public function set model(param1:FortCalendarPreviewBlockVO) : void
        {
            this._model = param1;
            invalidateData();
        }
    }
}
