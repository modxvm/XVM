package net.wg.gui.lobby.header
{
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.events.HeaderEvent;


   public class MainMenu extends UIComponent
   {
          
      public function MainMenu() {
         this.buttonsArr = new DataProvider([
            {
               "label":MENU.HEADERBUTTONS_HANGAR,
               "value":"hangar",
               "textColor":16563563,
               "textColorOver":16765319,
               "tooltip":TOOLTIPS.HEADER_HEADER_BUTTONS_HANGAR
            }
         ,
            {
               "label":MENU.HEADERBUTTONS_INVENTORY,
               "value":"inventory",
               "tooltip":TOOLTIPS.HEADER_HEADER_BUTTONS_INVENTORY,
               "helpText":LOBBY_HELP.HEADER_MENU_INVENTORY,
               "helpDirection":"B",
               "helpConnectorLength":12
            }
         ,
            {
               "label":MENU.HEADERBUTTONS_SHOP,
               "value":"shop",
               "tooltip":TOOLTIPS.HEADER_HEADER_BUTTONS_SHOP,
               "helpText":LOBBY_HELP.HEADER_MENU_SHOP,
               "helpDirection":"B",
               "helpConnectorLength":62
            }
         ,
            {
               "label":MENU.HEADERBUTTONS_PROFILE,
               "value":"profile",
               "tooltip":TOOLTIPS.HEADER_HEADER_BUTTONS_PROFILE,
               "helpText":LOBBY_HELP.HEADER_MENU_PROFILE,
               "helpDirection":"B",
               "helpConnectorLength":12
            }
         ,
            {
               "label":MENU.HEADERBUTTONS_TECHTREE,
               "value":"techtree",
               "tooltip":TOOLTIPS.HEADER_HEADER_BUTTONS_TECHTREE,
               "helpText":LOBBY_HELP.HEADER_MENU_TECHTREE,
               "helpDirection":"B",
               "helpConnectorLength":12
            }
         ,
            {
               "label":MENU.HEADERBUTTONS_BARRACKS,
               "value":"barracks",
               "tooltip":TOOLTIPS.HEADER_HEADER_BUTTONS_BARRACKS
            }
         ]);
         super();
      }

      public var bar:HeaderButtonBar;

      protected var current:String = "hangar";

      protected var buttonsArr:DataProvider;

      public function setCurrent(param1:String) : void {
         this.current = param1;
         this.bar.selectedIndex = -1;
         this.bar.enabled = !(this.current == "prebattle");
         var _loc2_:Number = 0;
         while(_loc2_ < this.buttonsArr.length)
         {
            if(this.current == this.buttonsArr[_loc2_].value)
            {
               this.bar.selectedIndex = _loc2_;
            }
            _loc2_++;
         }
      }

      override protected function onDispose() : void {
         super.onDispose();
         this.bar.removeEventListener(IndexEvent.INDEX_CHANGE,this.buttonClickHandler);
         this.buttonsArr = null;
      }

      override protected function configUI() : void {
         super.configUI();
         this.bar.selectedIndex = -1;
         if(App.globalVarsMgr.isChinaS())
         {
            this.buttonsArr.push(
               {
                  "label":MENU.HEADERBUTTONS_BROWSER,
                  "value":"browser",
                  "tooltip":TOOLTIPS.HEADER_HEADER_BUTTONS_BROWSER
               }
            );
         }
         this.bar.validateNow();
         this.bar.dataProvider = this.buttonsArr;
         this.bar.addEventListener(ButtonEvent.CLICK,this.buttonClickHandler,false,0,true);
      }

      override protected function draw() : void {
         super.draw();
      }

      protected function buttonClickHandler(param1:ButtonEvent) : void {
         if(param1.target.data != null)
         {
            dispatchEvent(new HeaderEvent(HeaderEvent.LOAD_VIEW,param1.target.data.value));
         }
      }
   }

}