package net.wg.gui.lobby.customization 
{
    import flash.events.*;
    import flash.text.*;
    
    public class CamouflageGroupView extends net.wg.gui.lobby.customization.BaseTimedCustomizationGroupView
    {
        public function CamouflageGroupView()
        {
            super();
            return;
        }

        public function setDefaultLabel(arg1:String):void
        {
            this.defaultLbl = arg1;
            this.hintLabel.htmlText = this.defaultLbl;
            return;
        }

        protected override function handleItemDataChanged(arg1:flash.events.Event=null):void
        {
            var loc1:*=null;
            var loc2:*=null;
            this.hintLabel.htmlText = this.defaultLbl;
            if (selectedItemIdx > -1) 
            {
                loc1 = itemsDP.requestItemAt(selectedItemIdx);
                if (loc1 && loc1.id && selectedPriceIdx > -1) 
                {
                    loc2 = new net.wg.gui.lobby.customization.CustomizationEvent(net.wg.gui.lobby.customization.CustomizationEvent.SELECT_NEW);
                    loc2.data = loc1;
                    loc2.index = selectedItemIdx;
                    dispatchEvent(loc2);
                    this.hintLabel.htmlText = loc1.invisibilityLbl;
                }
            }
            return;
        }

        public var hintLabel:flash.text.TextField;

        internal var defaultLbl:String="";
    }
}
