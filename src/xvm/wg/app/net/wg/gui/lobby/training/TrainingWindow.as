package net.wg.gui.lobby.training
{
    import net.wg.infrastructure.base.meta.impl.TrainingWindowMeta;
    import net.wg.infrastructure.base.meta.ITrainingWindowMeta;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.ScrollingListEx;
    import net.wg.gui.components.controls.NumericStepper;
    import net.wg.gui.components.controls.CheckBox;
    import net.wg.gui.components.advanced.TextAreaSimple;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.data.VO.TrainingWindowVO;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.events.ListEvent;
    import scaleform.clik.constants.WrappingMode;
    import flash.display.InteractiveObject;
    import net.wg.data.Aliases;
    import scaleform.clik.constants.InvalidationType;
    
    public class TrainingWindow extends TrainingWindowMeta implements ITrainingWindowMeta
    {
        
        public function TrainingWindow() {
            super();
        }
        
        private static function showTooltip(param1:MouseEvent) : void {
            App.toolTipMgr.showComplex(TOOLTIPS.TRAINING_CREATE_INVITES_CHECKBOX);
        }
        
        private static function hideTooltip(param1:MouseEvent) : void {
            App.toolTipMgr.hide();
        }
        
        public var mapName:TextField;
        
        public var battleType:TextField;
        
        public var maxPlayers:TextField;
        
        public var maps:ScrollingListEx;
        
        public var battleTime:NumericStepper;
        
        public var isPrivate:CheckBox;
        
        public var description:TextAreaSimple;
        
        public var createButon:SoundButtonEx;
        
        public var closeButon:SoundButtonEx;
        
        public var minimap:MinimapLobby;
        
        private var mapsData:Array;
        
        private var paramsVO:TrainingWindowVO;
        
        private var _dataWasSetted:Boolean = false;
        
        public function populateMaps(param1:Array) : void {
            this.mapsData = param1;
            this.maps.dataProvider = new DataProvider(param1);
        }
        
        public function setInfo(param1:Object) : void {
            var _loc2_:* = NaN;
            this.paramsVO = new TrainingWindowVO(param1);
            if(this.paramsVO.create)
            {
                window.title = MENU.TRAINING_CREATE_TITLE;
                this.maps.selectedIndex = Math.floor(Math.random() * this.mapsData.length);
                this.isPrivate.selected = false;
            }
            else
            {
                window.title = MENU.TRAINING_INFO_SETTINGS_TITLE;
                this.createButon.label = MENU.TRAINING_INFO_SETTINGS_OKBUTTON;
                _loc2_ = 0;
                while(_loc2_ < this.mapsData.length)
                {
                    if(this.paramsVO.arena == this.mapsData[_loc2_].key)
                    {
                        this.maps.selectedIndex = _loc2_;
                        this._dataWasSetted = true;
                        break;
                    }
                    _loc2_++;
                }
                invalidateData();
            }
        }
        
        override protected function configUI() : void {
            super.configUI();
            this.createButon.addEventListener(ButtonEvent.CLICK,this.createTraining);
            this.closeButon.addEventListener(ButtonEvent.CLICK,this.onClose);
            this.isPrivate.addEventListener(MouseEvent.ROLL_OVER,showTooltip);
            this.isPrivate.addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            this.isPrivate.addEventListener(MouseEvent.CLICK,hideTooltip);
            this.maps.addEventListener(ListEvent.INDEX_CHANGE,this.onMapChange);
            this.maps.wrapping = WrappingMode.STICK;
            this.description.text = "";
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void {
            super.onInitModalFocus(param1);
            setFocus(this.createButon);
        }
        
        override protected function onPopulate() : void {
            super.onPopulate();
            this.battleTime.maximum = App.globalVarsMgr.isDevelopmentS()?9999:30;
            this.battleTime.validateNow();
            window.useBottomBtns = true;
            registerComponent(this.minimap,Aliases.LOBBY_MINIMAP);
            this.populateMaps(getMapsDataS());
            this.setInfo(getInfoS());
        }
        
        override protected function onDispose() : void {
            this.createButon.removeEventListener(ButtonEvent.CLICK,this.createTraining);
            this.closeButon.removeEventListener(ButtonEvent.CLICK,this.onClose);
            this.isPrivate.removeEventListener(MouseEvent.ROLL_OVER,showTooltip);
            this.isPrivate.removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            this.isPrivate.removeEventListener(MouseEvent.CLICK,hideTooltip);
            this.maps.removeEventListener(ListEvent.INDEX_CHANGE,this.onMapChange);
            this.mapName = null;
            this.battleType = null;
            this.maxPlayers = null;
            this.maps.dispose();
            this.maps = null;
            this.battleTime.dispose();
            this.battleTime = null;
            this.isPrivate.dispose();
            this.isPrivate = null;
            this.description.dispose();
            this.description = null;
            this.createButon.dispose();
            this.createButon = null;
            this.closeButon.dispose();
            this.closeButon = null;
            if(this.mapsData)
            {
                this.mapsData.splice(0,this.mapsData.length);
                this.mapsData = null;
            }
            this.paramsVO.dispose();
            this.paramsVO = null;
            super.onDispose();
        }
        
        override protected function draw() : void {
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (this.paramsVO))
            {
                this.isPrivate.selected = this.paramsVO.privacy;
                this.description.text = this.paramsVO.description;
                this.description.validateNow();
                this.battleTime.enabled = this.maps.mouseEnabled = this.maps.mouseChildren = this.paramsVO.canChangeArena;
                this.maps.alpha = this.paramsVO.canChangeArena?1:0.6;
                this.isPrivate.enabled = this.paramsVO.canMakeOpenedClosed;
                this.description.enabled = this.paramsVO.canChangeComment;
            }
        }
        
        private function onClose(param1:ButtonEvent) : void {
            onWindowCloseS();
        }
        
        private function createTraining(param1:ButtonEvent) : void {
            var _loc2_:Number = this.mapsData[this.maps.selectedIndex].key;
            var _loc3_:Number = this.battleTime.value;
            var _loc4_:int = this.isPrivate.selected?1:0;
            var _loc5_:String = this.description.text?this.description.text:"";
            updateTrainingRoomS(_loc2_,_loc3_,_loc4_,_loc5_);
            this.onClose(null);
        }
        
        private function onMapChange(param1:ListEvent) : void {
            if(param1.index < this.mapsData.length)
            {
                this.mapName.text = param1.itemData.name;
                this.battleType.text = param1.itemData.arenaType;
                this.maxPlayers.text = param1.itemData.size + "/" + param1.itemData.size;
                this.battleTime.value = param1.itemData.time;
                this.minimap.setMapS(param1.itemData.key);
            }
            if((this._dataWasSetted) && (this.paramsVO))
            {
                this.battleTime.value = this.paramsVO.timeout;
                this._dataWasSetted = false;
            }
        }
    }
}
