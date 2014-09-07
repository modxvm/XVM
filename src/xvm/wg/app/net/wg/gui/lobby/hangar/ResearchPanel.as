package net.wg.gui.lobby.hangar
{
    import net.wg.infrastructure.base.meta.impl.ResearchPanelMeta;
    import net.wg.infrastructure.base.meta.IResearchPanelMeta;
    import net.wg.gui.interfaces.IHelpLayoutComponent;
    import net.wg.gui.components.tooltips.helpers.TankTypeIco;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.controls.IconText;
    import flash.display.MovieClip;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.IconsTypes;
    
    public class ResearchPanel extends ResearchPanelMeta implements IResearchPanelMeta, IHelpLayoutComponent
    {
        
        public function ResearchPanel()
        {
            super();
        }
        
        public var tankTypeIco:TankTypeIco = null;
        
        public var tankName:TextField = null;
        
        public var tankDescr:TextField = null;
        
        public var button:SoundButtonEx = null;
        
        public var xpText:IconText = null;
        
        public var bg:MovieClip = null;
        
        private var _vehicleName:String = "";
        
        private var _vehicleType:String = "";
        
        private var _vDescription:String = "";
        
        private var _earnedXP:Number = 0;
        
        private var _isElite:Boolean = false;
        
        public function as_updateCurrentVehicle(param1:String, param2:String, param3:String, param4:Number, param5:Boolean) : void
        {
            this._vehicleName = param1;
            this._vehicleType = param2;
            this._vDescription = param3;
            this._earnedXP = param4;
            this._isElite = param5;
            invalidateData();
        }
        
        public function as_setEarnedXP(param1:Number) : void
        {
            if(this._earnedXP == param1)
            {
                return;
            }
            this._earnedXP = param1;
            invalidateData();
        }
        
        public function as_setElite(param1:Boolean) : void
        {
            if(this._isElite == param1)
            {
                return;
            }
            this._isElite = param1;
            invalidateData();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.mouseEnabled = false;
            this.bg.mouseEnabled = false;
            this.bg.mouseChildren = false;
        }
        
        public function showHelpLayout() : void
        {
            this.button.showHelpLayout();
        }
        
        public function closeHelpLayout() : void
        {
            this.button.closeHelpLayout();
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            this.xpText.focusable = false;
            this.xpText.mouseChildren = false;
            if(this.button != null)
            {
                this.button.addEventListener(ButtonEvent.CLICK,this.handleButtonClick,false,0,true);
                this.button.label = MENU.UNLOCKS_UNLOCKBUTTON;
                this.button.tooltip = TOOLTIPS.HANGAR_UNLOCKBUTTON;
                this.button.helpText = LOBBY_HELP.HANGAR_MODULES_POWER_LEVEL;
            }
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
            if(this.button != null)
            {
                this.button.removeEventListener(ButtonEvent.CLICK,this.handleButtonClick);
            }
            this.xpText.dispose();
            this.xpText = null;
            this.button.dispose();
            this.button = null;
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.tankTypeIco.type = this._isElite?this._vehicleType + "_elite":this._vehicleType;
                this.tankTypeIco.x = this._isElite?-32:-22;
                this.tankName.text = this._vehicleName;
                this.tankDescr.htmlText = this._vDescription;
                this.xpText.text = App.utils != null?App.utils.locale.integer(this._earnedXP):this._earnedXP.toString();
                this.xpText.icon = this._isElite?IconsTypes.ELITE_XP:IconsTypes.XP;
            }
        }
        
        private function handleButtonClick(param1:ButtonEvent) : void
        {
            goToResearchS();
        }
    }
}
