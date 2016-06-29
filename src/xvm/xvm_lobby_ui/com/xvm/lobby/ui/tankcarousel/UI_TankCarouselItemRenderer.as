/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.ui.tankcarousel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.extraFields.*;
    import com.xvm.lobby.vo.*;
    import com.xvm.types.cfg.*;
    import com.xvm.types.dossier.*;
    import flash.display.*;
    import flash.utils.*;
    import net.wg.gui.lobby.hangar.tcarousel.data.*;

    public /*dynamic*/ class UI_TankCarouselItemRenderer extends TankCarouselItemRendererUI
    {
        public static const ITEM_WIDTH:int = 160;
        public static const ITEM_HEIGHT:int = 100;

        private static const COMMAND_XVM_CAROUSEL_GET_USED_SLOTS_COUNT:String = 'xvm_carousel.get_used_slots_count';
        private static const COMMAND_XVM_CAROUSEL_GET_TOTAL_SLOTS_COUNT:String = 'xvm_carousel.get_total_slots_count';

        private var cfg:CCarousel;
        private var _lastSelectedState:Boolean;
        private var _extraFieldsHolder:MovieClip = null;
        private var _extraFields:ExtraFields = null;
        private var _dataVO:VehicleCarouselVO = null;

        public function UI_TankCarouselItemRenderer()
        {
            //Logger.add(getQualifiedClassName(this));
            super();
            cfg = Config.config.hangar.carousel;
            try
            {
                createExtraFields();
                setupStandardFields();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override protected function onDispose():void
        {
            if (_extraFields != null)
            {
                _extraFields.dispose();
                _extraFields = null;
            }
            _extraFieldsHolder = null;
            this._dataVO = null;
            super.onDispose();
        }

        override public function set data(value:Object):void
        {
            try
            {
                if (_dataVO != null)
                {
                    _dataVO = null;
                }
                if (value != null)
                {
                    _dataVO = VehicleCarouselVO(value);
                }
                else
                {
                    _extraFieldsHolder.visible = false;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            super.data = value;
        }

        override public function set selected(value:Boolean):void
        {
            if (selected != value)
            {
                super.selected = value;
                updateDataXvm();
            }
        }

        override protected function updateData():void
        {
            super.updateData();
            updateDataXvm();
        }

        // PRIVATE

        private function createExtraFields():void
        {
            try
            {
                var zoom:Number = cfg.zoom;
                var w:int = int(ITEM_WIDTH * zoom);
                var h:int = int(ITEM_HEIGHT * zoom);

                _extraFieldsHolder = new MovieClip();
                _extraFieldsHolder.x = this.slot.x + 1;
                _extraFieldsHolder.y = this.slot.y + 1;
                _extraFieldsHolder.mouseEnabled = false;
                _extraFieldsHolder.mouseChildren = false;
                addChildAt(_extraFieldsHolder, this.getChildIndex(this.slot) + 1);

                _extraFields = new ExtraFields(cfg.extraFields);
                _extraFields.scaleX = _extraFields.scaleY = 1 / zoom;
                _extraFieldsHolder.addChild(_extraFields);
                _extraFieldsHolder.mask = _extraFieldsHolder.addChild(createMask(-2, -2, ITEM_WIDTH + 3, ITEM_HEIGHT + 3));
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function setupStandardFields():void
        {
                //setupStandardField(vehicleIcon.tankTypeMc, cfg.fields.tankType);

                //vehicleIcon.levelMc.visible = false;
                //App.utils.scheduler.scheduleOnNextFrame(function():void {
                    //if (vehicleIcon == null)
                        //return;
                    //setupStandardField(vehicleIcon.levelMc, cfg.fields.level);
                    //vehicleIcon.levelMc.visible = true;
                //});

                //setupStandardField(vehicleIcon.xp, cfg.fields.xp);
                //vehicleIcon.xp.x = w - vehicleIcon.xp.width + cfg.fields.xp.dx;

                //setupStandardField(vehicleIcon.multyXp, cfg.fields.multiXp);
                //vehicleIcon.multyXp.x = w - vehicleIcon.multyXp.width + cfg.fields.multiXp.dx;

                //setupTankNameField(cfg.fields.tankName);

                //setupStatusTextField(cfg.fields.statusText);
                //setupClanLockField(cfg.fields.clanLock);
        }

        private function createMask(x:Number, y:Number, width:Number, height:Number):Shape
        {
            var mask:Shape = new Shape();
            mask.graphics.beginFill(0xFFFFFF, 1);
            mask.graphics.drawRect(x, y, width, height);
            mask.graphics.endFill();
            mask.visible = false;
            return mask;
        }

        private function updateDataXvm():void
        {
            try
            {
                var isExtraFieldsVisible:Boolean = false;
                if (_dataVO != null)
                {
                    if (!(_dataVO.buySlot || _dataVO.buyTank))
                    {
                        var tankIconVO:TankIconVO = _dataVO.getTankIconVO();
                        if (tankIconVO != null)
                        {
                            var options:VOLobbyMacrosOptions = new VOLobbyMacrosOptions();
                            options.vehicleData = VehicleInfo.getByIcon(tankIconVO.image);
                            var dossier:AccountDossier = Dossier.getAccountDossier();
                            if (dossier != null)
                            {
                                var vdata:VehicleDossierCut = dossier.getVehicleDossierCut(options.vehCD);
                                vdata.elite = tankIconVO.elite ? "elite" : null;
                                vdata.selected = this.selected ? "sel" : null;
                                options.vehicleData.__vehicleDossierCut = vdata;
                                _extraFields.update(options);
                                isExtraFieldsVisible = true;
                            }
                        }
                    }
                }
                if (_extraFieldsHolder.visible != isExtraFieldsVisible)
                {
                    _extraFieldsHolder.visible = isExtraFieldsVisible;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
