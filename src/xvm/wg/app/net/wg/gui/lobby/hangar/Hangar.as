package net.wg.gui.lobby.hangar
{
   import net.wg.infrastructure.base.meta.impl.HangarMeta;
   import net.wg.infrastructure.base.meta.IHangarMeta;
   import net.wg.gui.lobby.hangar.crew.Crew;
   import net.wg.gui.lobby.hangar.tcarousel.TankCarousel;
   import net.wg.gui.lobby.hangar.ammunitionPanel.AmmunitionPanel;
   import flash.display.Sprite;
   import scaleform.gfx.TextFieldEx;
   import flashx.textLayout.formats.TextAlign;
   import net.wg.data.Aliases;
   import flash.ui.Keyboard;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import net.wg.gui.events.LobbyEvent;
   import scaleform.clik.events.InputEvent;
   import flash.geom.Point;
   import net.wg.utils.IEventCollector;
   import net.wg.data.constants.Tooltips;


   public class Hangar extends HangarMeta implements IHangarMeta
   {
          
      public function Hangar() {
         super();
      }

      private static const CAROUSEL_AMMUNITION_PADDING:int = 10;

      private static const PARAMS_RIGHT_MARGIN:int = 5;

      private static const RESEARCH_PANEL_RIGHT_MARGIN:int = 172;

      private static const MESSENGER_BAR_PADDING:int = 38;

      private static const INVALIDATE_ENABLED_CREW:String = "InvalidateEnabledCrew";

      private static const IGR_LOGO:String = "../maps/icons/library/igrLogo.png";

      public var vehResearchPanel:ResearchPanel;

      public var tmenXpPanel:TmenXpPanel;

      public var crew:Crew;

      public var params:Params;

      public var carousel:TankCarousel;

      public var ammunitionPanel:AmmunitionPanel;

      public var bottomBg:Sprite;

      public var igrLabel:IgrLabel;

      private var _isShowHelpLayout:Boolean = false;

      private var crewEnabled:Boolean = true;

      private function updateIgrPosition() : void {
         if(this.igrLabel)
         {
            this.igrLabel.x = width - this.igrLabel.width >> 1;
         }
      }

      override public function updateStage(param1:Number, param2:Number) : void {
         var _loc3_:* = NaN;
         _originalWidth = param1;
         _originalHeight = param2;
         setSize(param1,param2);
         if(this.carousel)
         {
            this.carousel.updateSize(param1,this.carousel.height);
            this.carousel.y = param2 - this.carousel.height;
         }
         if(this.bottomBg)
         {
            this.bottomBg.x = 0;
            this.bottomBg.y = _originalHeight - this.bottomBg.height + MESSENGER_BAR_PADDING;
            this.bottomBg.width = _originalWidth;
         }
         this.updateIgrPosition();
         if(this.params)
         {
            this.params.x = param1 - this.params.width - PARAMS_RIGHT_MARGIN;
         }
         if(this.ammunitionPanel)
         {
            this.ammunitionPanel.x = param1 - this.ammunitionPanel.width >> 1;
            _loc3_ = this.carousel.height + CAROUSEL_AMMUNITION_PADDING;
            this.ammunitionPanel.y = param2 - this.ammunitionPanel.height - _loc3_;
            this.ammunitionPanel.updateStage(param1,param2 - _loc3_);
         }
         if(this.vehResearchPanel != null)
         {
            this.vehResearchPanel.x = param1 - RESEARCH_PANEL_RIGHT_MARGIN;
         }
         if(this._isShowHelpLayout)
         {
            this.as_closeHelpLayout();
         }
      }

      public function as_readyToFight(param1:Boolean, param2:String, param3:String, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean, param9:Boolean) : void {
         this.carousel.enabled = !param5;
         this.crewEnabled = !param5 && (param7);
         invalidate(INVALIDATE_ENABLED_CREW);
         this.ammunitionPanel.setVehicleStatus(param2,param3);
         this.ammunitionPanel.disableAmmunitionPanel(param9?false:!param1 && (param6) && !param8);
         this.ammunitionPanel.disableTuningButton(param7?!param1 && (param6) && (param8):true);
         this.params.visible = param4;
         this.crew.visible = param4;
         this.ammunitionPanel.visible = param4;
         this.carousel.visible = param4;
         this.bottomBg.visible = param4;
         this.vehResearchPanel.visible = param4;
      }

      public function as_showHelpLayout() : void {
         if(!this._isShowHelpLayout)
         {
            this._isShowHelpLayout = true;
            if(this.crew.visible)
            {
               this.crew.showHelpLayout();
            }
            if(this.params.visible)
            {
               this.params.showHelpLayout();
            }
            if(this.ammunitionPanel.visible)
            {
               this.ammunitionPanel.showHelpLayout();
            }
            if(this.carousel.visible)
            {
               this.carousel.showHelpLayout();
            }
            if(this.vehResearchPanel.visible)
            {
               this.vehResearchPanel.showHelpLayout();
            }
         }
      }

      public function as_closeHelpLayout() : void {
         if(this._isShowHelpLayout)
         {
            this._isShowHelpLayout = false;
            App.instance.utils.helpLayout.destroyBackground();
            this.crew.closeHelpLayout();
            this.params.closeHelpLayout();
            this.ammunitionPanel.closeHelpLayout();
            this.carousel.closeHelpLayout();
            this.vehResearchPanel.closeHelpLayout();
         }
      }

      public function as_setIsIGR(param1:Boolean, param2:String) : void {
         if(param1)
         {
            this.igrLabel.visible = true;
            this.igrLabel.mouseChildren = false;
            this.igrLabel.useHandCursor = this.igrLabel.buttonMode = true;
            this.igrLabel.igrText.htmlText = param2;
            TextFieldEx.setVerticalAlign(this.igrLabel.igrText,TextAlign.CENTER);
         }
         else
         {
            this.igrLabel.visible = false;
         }
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         registerComponent(this.crew,Aliases.CREW);
         registerComponent(this.tmenXpPanel,Aliases.TMEN_XP_PANEL);
         registerComponent(this.params,Aliases.PARAMS);
         registerComponent(this.carousel,Aliases.TANK_CAROUSEL);
         registerComponent(this.ammunitionPanel,Aliases.AMMUNITION_PANEL);
         addEventListener(CrewDropDownEvent.SHOW_DROP_DOWN,this.onShowCrewDropwDownHandler);
         if(this.vehResearchPanel != null)
         {
            registerComponent(this.vehResearchPanel,Aliases.RESEARCH_PANEL);
         }
      }

      override protected function onDispose() : void {
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN);
         this.igrLabel.removeEventListener(MouseEvent.ROLL_OVER,this.onIgrRollOver);
         this.igrLabel.removeEventListener(MouseEvent.ROLL_OUT,this.onIgrRollOut);
         App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.UNREGISTER_DRAGGING));
         removeEventListener(CrewDropDownEvent.SHOW_DROP_DOWN,this.onShowCrewDropwDownHandler);
         App.gameInputMgr.clearKeyHandler(Keyboard.F1,KeyboardEvent.KEY_DOWN);
         App.gameInputMgr.clearKeyHandler(Keyboard.F1,KeyboardEvent.KEY_UP);
         super.onDispose();
         this.vehResearchPanel.dispose();
         this.vehResearchPanel = null;
         this.tmenXpPanel = null;
         this.crew = null;
         this.params = null;
         this.ammunitionPanel = null;
         this.carousel = null;
         this.bottomBg = null;
         this.igrLabel.dispose();
         this.igrLabel = null;
      }

      override protected function configUI() : void {
         super.configUI();
         App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.REGISTER_DRAGGING));
         this.updateStage(parent.width,parent.height);
         this.params.mouseEnabled = false;
         this.params.mouseChildren = false;
         mouseEnabled = false;
         this.bottomBg.mouseEnabled = false;
         this.igrLabel.addEventListener(MouseEvent.ROLL_OVER,this.onIgrRollOver);
         this.igrLabel.addEventListener(MouseEvent.ROLL_OUT,this.onIgrRollOut);
         App.gameInputMgr.setKeyHandler(Keyboard.F1,KeyboardEvent.KEY_DOWN,this.showLayoutHandler,true);
         App.gameInputMgr.setKeyHandler(Keyboard.F1,KeyboardEvent.KEY_UP,this.closeLayoutHandler,true);
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(INVALIDATE_ENABLED_CREW))
         {
            this.crew.enabled = this.crewEnabled;
         }
      }

      private function handleEscape(param1:InputEvent) : void {
         App.contextMenuMgr.hide();
         if(App.helpLayout.isShowed())
         {
            onEscapeS();
         }
      }

      private function closeLayoutHandler() : void {
         closeHelpLayoutS();
      }

      private function onShowCrewDropwDownHandler(param1:CrewDropDownEvent) : void {
         var _loc2_:Point = globalToLocal(new Point(param1.dropDownref.x,param1.dropDownref.y));
         var _loc3_:IEventCollector = App.utils.events;
         _loc3_.disableDisposingForObj(param1.dropDownref);
         addChild(param1.dropDownref);
         _loc3_.enableDisposingForObj(param1.dropDownref);
         param1.dropDownref.x = _loc2_.x;
         param1.dropDownref.y = _loc2_.y;
      }

      private function showLayoutHandler(param1:InputEvent) : void {
         showHelpLayoutS();
      }

      private function onIgrRollOver(param1:MouseEvent) : void {
         App.toolTipMgr.showSpecial(Tooltips.IGR_INFO,null);
      }

      private function onIgrRollOut(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }
   }

}