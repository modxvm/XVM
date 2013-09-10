package net.wg.gui.lobby.training 
{
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.*;
    import net.wg.data.VO.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class TrainingWindow extends net.wg.infrastructure.base.meta.impl.TrainingWindowMeta implements net.wg.infrastructure.base.meta.ITrainingWindowMeta
    {
        public function TrainingWindow()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.createButon.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.createTraining);
            this.closeButon.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onClose);
            this.isPrivate.addEventListener(flash.events.MouseEvent.ROLL_OVER, showTooltip);
            this.isPrivate.addEventListener(flash.events.MouseEvent.ROLL_OUT, hideTooltip);
            this.isPrivate.addEventListener(flash.events.MouseEvent.CLICK, hideTooltip);
            this.maps.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onMapChange);
            App.utils.focusHandler.setFocus(this.createButon);
            this.description.text = "";
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            this.battleTime.maximum = App.globalVarsMgr.isDevelopmentS() ? 9999 : 30;
            this.battleTime.validateNow();
            window.useBottomBtns = true;
            registerComponent(this.minimap, net.wg.data.Aliases.LOBBY_MINIMAP);
            this.populateMaps(getMapsDataS());
            this.setInfo(getInfoS());
            return;
        }

        protected override function onDispose():void
        {
            this.createButon.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.createTraining);
            this.closeButon.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onClose);
            this.isPrivate.removeEventListener(flash.events.MouseEvent.ROLL_OVER, showTooltip);
            this.isPrivate.removeEventListener(flash.events.MouseEvent.ROLL_OUT, hideTooltip);
            this.isPrivate.removeEventListener(flash.events.MouseEvent.CLICK, hideTooltip);
            this.maps.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onMapChange);
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
            if (this.mapsData) 
            {
                this.mapsData.splice(0, this.mapsData.length);
                this.mapsData = null;
            }
            this.paramsVO.dispose();
            this.paramsVO = null;
            super.onDispose();
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && this.paramsVO) 
            {
                this.isPrivate.selected = this.paramsVO.privacy;
                this.description.text = this.paramsVO.description;
                this.description.validateNow();
            }
            return;
        }

        public function populateMaps(arg1:Array):void
        {
            this.mapsData = arg1;
            this.maps.dataProvider = new scaleform.clik.data.DataProvider(arg1);
            return;
        }

        public function setInfo(arg1:Object):void
        {
            var loc1:*=NaN;
            this.paramsVO = new net.wg.data.VO.TrainingWindowVO(arg1);
            if (this.paramsVO.create) 
            {
                window.title = MENU.TRAINING_CREATE_TITLE;
                this.maps.selectedIndex = Math.floor(Math.random() * this.mapsData.length);
                this.isPrivate.selected = false;
            }
            else 
            {
                window.title = MENU.TRAINING_INFO_SETTINGS_TITLE;
                this.createButon.label = MENU.TRAINING_INFO_SETTINGS_OKBUTTON;
                loc1 = 0;
                while (loc1 < this.mapsData.length) 
                {
                    if (this.paramsVO.arena == this.mapsData[loc1].key) 
                    {
                        this.maps.selectedIndex = loc1;
                        this._dataWasSetted = true;
                        break;
                    }
                    ++loc1;
                }
                invalidateData();
            }
            return;
        }

        internal function onClose(arg1:scaleform.clik.events.ButtonEvent):void
        {
            onWindowCloseS();
            return;
        }

        internal function createTraining(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc1:*=this.mapsData[this.maps.selectedIndex].key;
            var loc2:*=this.battleTime.value;
            var loc3:*=this.isPrivate.selected ? 1 : 0;
            var loc4:*=this.description.text ? this.description.text : "";
            updateTrainingRoomS(loc1, loc2, loc3, loc4);
            this.onClose(null);
            return;
        }

        internal function onMapChange(arg1:scaleform.clik.events.ListEvent):void
        {
            if (arg1.index < this.mapsData.length) 
            {
                this.mapName.text = arg1.itemData.name;
                this.battleType.text = arg1.itemData.arenaType;
                this.maxPlayers.text = arg1.itemData.size + "/" + arg1.itemData.size;
                this.battleTime.value = arg1.itemData.time;
                this.minimap.setMapS(arg1.itemData.key);
            }
            if (this._dataWasSetted && this.paramsVO) 
            {
                this.battleTime.value = this.paramsVO.timeout;
                this._dataWasSetted = false;
            }
            return;
        }

        internal static function showTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.showComplex(TOOLTIPS.TRAINING_CREATE_INVITES_CHECKBOX);
            return;
        }

        internal static function hideTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        public var mapName:flash.text.TextField;

        public var battleType:flash.text.TextField;

        public var maxPlayers:flash.text.TextField;

        public var maps:net.wg.gui.components.controls.ScrollingListEx;

        public var battleTime:net.wg.gui.components.controls.NumericStepper;

        public var isPrivate:net.wg.gui.components.controls.CheckBox;

        public var description:net.wg.gui.components.advanced.TextAreaSimple;

        public var createButon:net.wg.gui.components.controls.SoundButtonEx;

        public var closeButon:net.wg.gui.components.controls.SoundButtonEx;

        public var minimap:net.wg.gui.lobby.training.MinimapLobby;

        internal var mapsData:Array;

        internal var paramsVO:net.wg.data.VO.TrainingWindowVO;

        internal var _dataWasSetted:Boolean=false;
    }
}
