package net.wg.gui.lobby.header 
{
    import net.wg.gui.events.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class MainMenu extends scaleform.clik.core.UIComponent
    {
        public function MainMenu()
        {
            this.buttonsArr = new scaleform.clik.data.DataProvider([{"label":MENU.HEADERBUTTONS_HANGAR, "value":"hangar", "textColor":16563563, "tooltip":TOOLTIPS.HEADER_HEADER_BUTTONS_HANGAR}, {"label":MENU.HEADERBUTTONS_INVENTORY, "value":"inventory", "tooltip":TOOLTIPS.HEADER_HEADER_BUTTONS_INVENTORY, "helpText":LOBBY_HELP.HEADER_MENU_INVENTORY, "helpDirection":"B", "helpConnectorLength":12}, {"label":MENU.HEADERBUTTONS_SHOP, "value":"shop", "tooltip":TOOLTIPS.HEADER_HEADER_BUTTONS_SHOP, "helpText":LOBBY_HELP.HEADER_MENU_SHOP, "helpDirection":"B", "helpConnectorLength":62}, {"label":MENU.HEADERBUTTONS_PROFILE, "value":"profile", "tooltip":TOOLTIPS.HEADER_HEADER_BUTTONS_PROFILE, "helpText":LOBBY_HELP.HEADER_MENU_PROFILE, "helpDirection":"B", "helpConnectorLength":12}, {"label":MENU.HEADERBUTTONS_TECHTREE, "value":"techtree", "tooltip":TOOLTIPS.HEADER_HEADER_BUTTONS_TECHTREE, "helpText":LOBBY_HELP.HEADER_MENU_TECHTREE, "helpDirection":"B", "helpConnectorLength":12}, {"label":MENU.HEADERBUTTONS_BARRACKS, "value":"barracks", "tooltip":TOOLTIPS.HEADER_HEADER_BUTTONS_BARRACKS}]);
            super();
            this.originalWidth = this.width;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.bar.selectedIndex = -1;
            if (App.globalVarsMgr.isChinaS()) 
            {
                this.buttonsArr.push({"label":MENU.HEADERBUTTONS_BROWSER, "value":"browser", "tooltip":TOOLTIPS.HEADER_HEADER_BUTTONS_BROWSER});
            }
            this.bar.validateNow();
            this.bar.dataProvider = this.buttonsArr;
            this.bar.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.buttonClickHandler, false, 0, true);
            App.utils.focusHandler.setFocus(this.bar);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        public function setCurrent(arg1:String):void
        {
            this.current = arg1;
            this.bar.selectedIndex = -1;
            this.bar.enabled = !(this.current == "prebattle");
            var loc1:*=0;
            while (loc1 < this.buttonsArr.length) 
            {
                if (this.current == this.buttonsArr[loc1].value) 
                {
                    this.bar.selectedIndex = loc1;
                }
                ++loc1;
            }
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.bar.removeEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.buttonClickHandler);
            this.buttonsArr = null;
            return;
        }

        protected function buttonClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            if (arg1.target.data != null) 
            {
                dispatchEvent(new net.wg.gui.events.HeaderEvent(net.wg.gui.events.HeaderEvent.LOAD_VIEW, arg1.target.data.value));
            }
            return;
        }

        internal var originalWidth:Number;

        public var bar:net.wg.gui.lobby.header.HeaderButtonBar;

        protected var current:String="hangar";

        protected var buttonsArr:scaleform.clik.data.DataProvider;
    }
}
