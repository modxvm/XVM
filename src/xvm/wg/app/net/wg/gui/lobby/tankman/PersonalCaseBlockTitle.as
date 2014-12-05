package net.wg.gui.lobby.tankman
{
    import flash.display.Sprite;
    import net.wg.gui.interfaces.IPersonalCaseBlockTitle;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.events.UILoaderEvent;
    import net.wg.data.constants.Values;
    import flash.text.TextFieldAutoSize;
    import scaleform.gfx.TextFieldEx;
    
    public class PersonalCaseBlockTitle extends Sprite implements IPersonalCaseBlockTitle
    {
        
        public function PersonalCaseBlockTitle()
        {
            super();
            this.premIcon.visible = false;
            this.rightText.autoSize = TextFieldAutoSize.RIGHT;
            TextFieldEx.setVerticalAlign(this.rightText,TextFieldEx.VALIGN_CENTER);
        }
        
        private static var ICON_PADDING:int = -1;
        
        public var blockName:TextField = null;
        
        public var rightText:TextField = null;
        
        public var premIcon:UILoaderAlt = null;
        
        public function premiumVehicle(param1:Boolean) : void
        {
            this.rightText.alpha = param1?1:0.3;
        }
        
        public function dispose() : void
        {
            this.blockName = null;
            this.rightText = null;
            this.premIcon.removeEventListener(UILoaderEvent.COMPLETE,this.onLoadHandler);
            this.premIcon.dispose();
            this.premIcon = null;
        }
        
        public function setLeftText(param1:String) : void
        {
            this.blockName.text = param1;
        }
        
        public function setRightText(param1:String) : void
        {
            this.rightText.text = param1;
            this.rightText.x = this.rightText.x ^ 0;
            if(!(param1 == Values.EMPTY_STR) && !(param1 == null))
            {
                this.premIcon.visible = true;
                this.premIcon.addEventListener(UILoaderEvent.COMPLETE,this.onLoadHandler);
                this.premIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_PREM_SMALL_ICON;
            }
        }
        
        private function onLoadHandler(param1:UILoaderEvent) : void
        {
            this.premIcon.x = this.rightText.x - this.premIcon.width + ICON_PADDING ^ 0;
            this.premIcon.y = this.premIcon.y ^ 0;
            this.premIcon.alpha = this.rightText.alpha;
        }
    }
}
