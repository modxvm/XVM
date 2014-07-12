package net.wg.gui.lobby.battleloading
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import scaleform.clik.controls.StatusIndicator;
    import net.wg.gui.components.icons.BattleTypeIcon;
    import net.wg.gui.components.controls.ReadOnlyScrollingList;
    import net.wg.gui.lobby.battleloading.data.TeamVehiclesDataProvider;
    import net.wg.gui.lobby.battleloading.data.EnemyVehiclesDataProvider;
    import net.wg.gui.lobby.battleloading.interfaces.IVehiclesDataProvider;
    
    public class BattleLoadingForm extends UIComponent
    {
        
        public function BattleLoadingForm() {
            super();
            this.teamDP = new TeamVehiclesDataProvider();
            this.enemyDP = new EnemyVehiclesDataProvider();
        }
        
        public var mapText:TextField;
        
        public var battleText:TextField;
        
        public var winText:TextField;
        
        public var team1Text:TextField;
        
        public var team2Text:TextField;
        
        public var helpTip:TextField;
        
        public var tipText:TextField;
        
        public var loadingBar:StatusIndicator;
        
        public var battleIcon:BattleTypeIcon;
        
        public var team1List:ReadOnlyScrollingList;
        
        public var team2List:ReadOnlyScrollingList;
        
        private var teamDP:TeamVehiclesDataProvider;
        
        private var enemyDP:EnemyVehiclesDataProvider;
        
        override protected function configUI() : void {
            this.battleIcon.visible = false;
            if(this.team1List != null)
            {
                this.team1List.dataProvider = this.teamDP;
            }
            if(this.team2List != null)
            {
                this.team2List.dataProvider = this.enemyDP;
            }
            super.configUI();
        }
        
        public function updateProgress(param1:Number) : void {
            this.loadingBar.position = param1;
        }
        
        public function updateMapName(param1:String) : void {
            this.mapText.text = param1;
            this.mapText.text = App.utils.toUpperOrLowerCase(this.mapText.text,true);
        }
        
        public function setBattleTypeName(param1:String) : void {
            this.battleText.text = param1;
        }
        
        public function setBattleTypeFrameNum(param1:Number) : void {
            this.battleIcon.visible = true;
            this.battleIcon.typeByNumber = param1;
        }
        
        public function setBattleTypeFrameName(param1:String) : void {
            this.battleIcon.visible = true;
            this.battleIcon.type = param1;
        }
        
        public function updateWinText(param1:String) : void {
            this.winText.htmlText = param1;
            this.winText.y = 128 + (40 - this.winText.textHeight >> 1) ^ 0;
        }
        
        public function updateTeamsHeaders(param1:String, param2:String) : void {
            this.team1Text.text = param1;
            this.team2Text.text = param2;
        }
        
        public function updateTip(param1:String) : void {
            this.helpTip.text = MENU.LOADING_HELPTIP;
            this.tipText.htmlText = param1;
        }
        
        public function updateTipTitle(param1:String) : void {
            this.helpTip.text = param1;
        }
        
        public function setPlayerInfo(param1:Number, param2:Number) : void {
            this.teamDP.setPlayerVehicleID(param1);
            this.teamDP.setPrebattleID(param2);
        }
        
        public function setVehiclesData(param1:Boolean, param2:Array) : void {
            var _loc3_:IVehiclesDataProvider = param1?this.enemyDP:this.teamDP;
            _loc3_.setSource(param2);
            _loc3_.invalidate(_loc3_.length);
        }
        
        public function addVehicleInfo(param1:Boolean, param2:Object, param3:Array) : void {
            var _loc4_:IVehiclesDataProvider = param1?this.enemyDP:this.teamDP;
            if(_loc4_.addVehicleInfo(param2,param3))
            {
                _loc4_.invalidate(_loc4_.length);
            }
        }
        
        public function updateVehicleInfo(param1:Boolean, param2:Object, param3:Array) : void {
            var _loc4_:IVehiclesDataProvider = param1?this.enemyDP:this.teamDP;
            var _loc5_:Boolean = _loc4_.updateVehicleInfo(param2);
            _loc5_ = (_loc4_.setSorting(param3)) || (_loc5_);
            if(_loc5_)
            {
                _loc4_.invalidate(_loc4_.length);
            }
        }
        
        public function setVehicleStatus(param1:Boolean, param2:Number, param3:uint, param4:Array) : void {
            var _loc5_:IVehiclesDataProvider = param1?this.enemyDP:this.teamDP;
            var _loc6_:Boolean = _loc5_.setVehicleStatus(param2,param3);
            _loc6_ = (_loc5_.setSorting(param4)) || (_loc6_);
            if(_loc6_)
            {
                _loc5_.invalidate(_loc5_.length);
            }
        }
        
        public function setPlayerStatus(param1:Boolean, param2:Number, param3:uint) : void {
            var _loc4_:IVehiclesDataProvider = param1?this.enemyDP:this.teamDP;
            if(_loc4_.setPlayerStatus(param2,param3))
            {
                _loc4_.invalidate(_loc4_.length);
            }
        }
        
        override protected function onDispose() : void {
            this.team1List.disposeRenderers();
            this.team1List.dispose();
            this.team1List = null;
            this.team2List.disposeRenderers();
            this.team2List.dispose();
            this.team2List = null;
            this.teamDP.cleanUp();
            this.teamDP = null;
            this.enemyDP.cleanUp();
            this.enemyDP = null;
            this.loadingBar.dispose();
            this.loadingBar = null;
            this.battleIcon.dispose();
            this.battleIcon = null;
            super.onDispose();
        }
        
        override public function toString() : String {
            return "[WG BattleLoadingForm " + name + "]";
        }
    }
}
