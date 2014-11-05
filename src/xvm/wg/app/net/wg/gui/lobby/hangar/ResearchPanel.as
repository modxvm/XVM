package net.wg.gui.lobby.hangar
{
    import net.wg.infrastructure.base.meta.impl.ResearchPanelMeta;
    import net.wg.infrastructure.base.meta.IResearchPanelMeta;
    import net.wg.gui.interfaces.IHelpLayoutComponent;
    import net.wg.gui.components.tooltips.helpers.TankTypeIco;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.controls.IconText;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import net.wg.utils.IHelpLayout;
    import flash.geom.Rectangle;
    import net.wg.data.constants.Directions;
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
        
        public var premIGRBg:Sprite = null;
        
        public var bg:MovieClip = null;
        
        private var _vehicleName:String = "";
        
        private var _vehicleType:String = "";
        
        private var _vDescription:String = "";
        
        private var _earnedXP:Number = 0;
        
        private var _isElite:Boolean = false;
        
        private var _isPremIGR:Boolean;
        
        private var _helpLayout:DisplayObject = null;
        
        private var _helpLayoutX:Number = 0;
        
        private var _helpLayoutW:Number = 0;
        
        public function as_updateCurrentVehicle(param1:String, param2:String, param3:String, param4:Number, param5:Boolean, param6:Boolean) : void
        {
            this._vehicleName = param1;
            this._vehicleType = param2;
            this._vDescription = param3;
            this._earnedXP = param4;
            this._isElite = param5;
            this._isPremIGR = param6;
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
            this.premIGRBg.mouseEnabled = this.premIGRBg.mouseChildren = false;
        }
        
        public function getHelpLayoutWidth() : Number
        {
            return this.bg.width + this.bg.x - (this.tankTypeIco.x - this.tankTypeIco.width);
        }
        
        public function showHelpLayoutEx(param1:Number, param2:Number) : void
        {
            this._helpLayoutX = param1;
            this._helpLayoutW = param2;
            this.showHelpLayout();
        }
        
        public function showHelpLayout() : void
        {
            var _loc1_:IHelpLayout = App.utils.helpLayout;
            var _loc2_:Rectangle = new Rectangle(this.bg.x + this.bg.width - this._helpLayoutW,0,this._helpLayoutW,this.bg.height);
            var _loc3_:Object = _loc1_.getProps(_loc2_,LOBBY_HELP.HANGAR_VEHRESEARCHPANEL,Directions.RIGHT);
            this._helpLayout = _loc1_.create(root,_loc3_,this);
        }
        
        public function closeHelpLayout() : void
        {
            var _loc1_:IHelpLayout = App.utils.helpLayout;
            _loc1_.destroy(this._helpLayout);
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
            this._helpLayout = null;
            this.premIGRBg = null;
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
                this.premIGRBg.visible = this._isPremIGR;
            }
        }
        
        private function handleButtonClick(param1:ButtonEvent) : void
        {
            goToResearchS();
        }
    }
}
