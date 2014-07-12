package net.wg.gui.crewOperations
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import scaleform.clik.events.ButtonEvent;
    import flash.display.Graphics;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.Event;
    
    public class CrewOperationsIRenderer extends UIComponent
    {
        
        public function CrewOperationsIRenderer() {
            this.myHitArea = new MovieClip();
            super();
        }
        
        private var _data:CrewOperationInfoVO;
        
        public var iconLoader:UILoaderAlt;
        
        public var title:TextField;
        
        public var description:TextField;
        
        public var footer:CrewOperationsIRFooter;
        
        private var OFFSET_BETWEEN_TEXT_AND_BUTTON:uint = 16;
        
        private var myHitArea:MovieClip;
        
        override protected function configUI() : void {
            super.configUI();
            this.description.mouseEnabled = false;
            this.footer.button.addEventListener(ButtonEvent.CLICK,this.btnClickHandler,false,0,true);
            addChildAt(this.myHitArea,0);
            hitArea = this.myHitArea;
        }
        
        private function btnClickHandler(param1:ButtonEvent) : void {
            dispatchEvent(new CrewOperationEvent(CrewOperationEvent.OPERATION_CHANGED,this._data.id,true));
        }
        
        override protected function draw() : void {
            var _loc1_:Graphics = null;
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (this._data))
            {
                this.title.text = this._data.title;
                this.description.text = this._data.description;
                this.iconLoader.source = this._data.iconPath;
                this.footer.data = this._data;
                this.footer.validateNow();
                this.footer.y = Math.round(this.description.y + this.description.textHeight + this.OFFSET_BETWEEN_TEXT_AND_BUTTON - this.footer.button.y);
                _height = Math.round(this.footer.y + this.footer.height);
                this.myHitArea.mouseEnabled = false;
                _loc1_ = this.myHitArea.graphics;
                _loc1_.clear();
                _loc1_.beginFill(0,0);
                _loc1_.drawRect(0,0,_width,_height);
                _loc1_.endFill();
                dispatchEvent(new Event(Event.RESIZE,true));
            }
        }
        
        public function get data() : CrewOperationInfoVO {
            return this._data;
        }
        
        public function set data(param1:CrewOperationInfoVO) : void {
            this._data = param1;
            invalidateData();
        }
        
        override protected function onDispose() : void {
            this._data = null;
            if(this.footer)
            {
                this.footer.dispose();
            }
            this.footer = null;
            super.onDispose();
        }
    }
}
