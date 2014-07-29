package net.wg.gui.lobby.training
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.geom.ColorTransform;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.Event;
    
    public class ObserverButtonComponent extends UIComponent
    {
        
        public function ObserverButtonComponent()
        {
            super();
        }
        
        public static var SELECTED:String = "selChanged";
        
        public var icon:UILoaderAlt;
        
        public var button:SoundButtonEx;
        
        private var _selected:Boolean;
        
        private var defColorTrans:ColorTransform;
        
        private var tooltipViewer:TooltipViewer;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.defColorTrans = this.icon.transform.colorTransform;
            this.icon.source = RES_ICONS.MAPS_ICONS_VEHICLE_CONTOUR_USSR_OBSERVER;
            this.button.addEventListener(ButtonEvent.CLICK,this.btnClickHandler,false,0,true);
            this.button.label = App.utils.locale.makeString(MENU.TRAINING_INFO_OBSERVER);
            if(this.tooltipViewer == null)
            {
                this.tooltipViewer = new TooltipViewer(this.icon);
            }
            this.updateTooltip();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.updateData();
            }
        }
        
        private function updateData() : void
        {
            this.button.selected = this._selected;
            if(this._selected)
            {
                this.icon.transform.colorTransform = App.colorSchemeMgr.getTransform(TrainingConstants.VEHICLE_YELLOW_COLOR_SCHEME_ALIAS);
            }
            else
            {
                this.icon.transform.colorTransform = this.defColorTrans;
            }
            this.updateTooltip();
        }
        
        private function updateTooltip() : void
        {
            if(enabled)
            {
                this.tooltipViewer.setTooltip(this._selected?TOOLTIPS.TRAINING_OBSERVER_SELECTEDICON:TOOLTIPS.TRAINING_OBSERVER_ICON);
                this.button.tooltip = TOOLTIPS.TRAINING_OBSERVER_BTN;
            }
            else
            {
                this.tooltipViewer.setTooltip(null);
                this.button.tooltip = null;
            }
        }
        
        private function btnClickHandler(param1:ButtonEvent) : void
        {
            this._selected = this.button.selected;
            this.updateData();
            dispatchEvent(new Event(SELECTED));
        }
        
        public function get selected() : Boolean
        {
            return this._selected;
        }
        
        public function set selected(param1:Boolean) : void
        {
            if(this._selected != param1)
            {
                this._selected = param1;
                invalidateData();
            }
        }
        
        override protected function onDispose() : void
        {
            this.tooltipViewer.dispose();
            this.tooltipViewer = null;
            this.button.removeEventListener(ButtonEvent.CLICK,this.btnClickHandler);
            super.onDispose();
        }
        
        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            this.icon.alpha = param1?1:0.5;
            this.button.enabled = param1;
            this.updateTooltip();
        }
    }
}
