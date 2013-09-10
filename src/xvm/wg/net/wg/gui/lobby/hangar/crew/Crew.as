package net.wg.gui.lobby.hangar.crew 
{
    import flash.display.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.data.*;
    import scaleform.clik.interfaces.*;
    
    public class Crew extends net.wg.infrastructure.base.meta.impl.CrewMeta implements net.wg.infrastructure.interfaces.IHelpLayoutComponent, net.wg.infrastructure.base.meta.ICrewMeta, net.wg.infrastructure.interfaces.IDAAPIModule
    {
        public function Crew()
        {
            super();
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            invalidate(INVALIDATE_LIST);
            return;
        }

        protected override function onDispose():void
        {
            this.list.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_ROLL_OVER, showTooltip);
            this.list.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_ROLL_OUT, hideTooltip);
            this.list.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_PRESS, hideTooltip);
            App.stage.removeEventListener(net.wg.gui.events.CrewEvent.SHOW_RECRUIT_WINDOW, this.onShowRecruitWindow);
            App.stage.removeEventListener(net.wg.gui.events.CrewEvent.EQUIP_TANKMAN, this.onEquipTankman);
            removeEventListener(net.wg.gui.events.CrewEvent.UNLOAD_TANKMAN, this.onUnloadTankman);
            removeEventListener(net.wg.gui.events.CrewEvent.UNLOAD_ALL_TANKMAN, this.onUnloadAllTankman);
            removeEventListener(net.wg.gui.events.CrewEvent.OPEN_PERSONAL_CASE, this.openPersonalCaseHandler);
            this.list.dispose();
            this.list = null;
            this.bg = null;
            if (this._helpLayout) 
            {
                this.closeHelpLayout();
            }
            this._helpLayout = null;
            super.dispose();
            super.onDispose();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            mouseEnabled = false;
            addEventListener(net.wg.gui.events.CrewEvent.UNLOAD_TANKMAN, this.onUnloadTankman);
            addEventListener(net.wg.gui.events.CrewEvent.UNLOAD_ALL_TANKMAN, this.onUnloadAllTankman);
            addEventListener(net.wg.gui.events.CrewEvent.OPEN_PERSONAL_CASE, this.openPersonalCaseHandler);
            App.stage.addEventListener(net.wg.gui.events.CrewEvent.EQUIP_TANKMAN, this.onEquipTankman);
            App.stage.addEventListener(net.wg.gui.events.CrewEvent.SHOW_RECRUIT_WINDOW, this.onShowRecruitWindow);
            this.list.addEventListener(net.wg.gui.events.ListEventEx.ITEM_ROLL_OVER, showTooltip);
            this.list.addEventListener(net.wg.gui.events.ListEventEx.ITEM_ROLL_OUT, hideTooltip);
            this.list.addEventListener(net.wg.gui.events.ListEventEx.ITEM_PRESS, hideTooltip);
            this.list.mouseEnabled = false;
            this.list.validateNow();
            return;
        }

        internal function onEquipTankman(arg1:net.wg.gui.events.CrewEvent):void
        {
            equipTankmanS(arg1.initProp.tankmanID, arg1.initProp.slot);
            return;
        }

        internal function onUnloadTankman(arg1:net.wg.gui.events.CrewEvent):void
        {
            unloadTankmanS(arg1.initProp.tankmanID);
            return;
        }

        internal function onUnloadAllTankman(arg1:net.wg.gui.events.CrewEvent):void
        {
            unloadAllTankmanS();
            return;
        }

        internal function onShowRecruitWindow(arg1:net.wg.gui.events.CrewEvent):void
        {
            onShowRecruitWindowClickS(arg1.initProp, arg1.menuEnabled);
            return;
        }

        public function as_tankmenResponse(arg1:Array, arg2:Array):void
        {
            var loc5:*=null;
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=null;
            var loc1:*=[];
            var loc2:*=arg1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                if (arg1[loc3].tankmanID) 
                {
                    var loc9:*=0;
                    var loc10:*=arg2;
                    for each (loc8 in loc10) 
                    {
                        if (loc8.tankmanID != arg1[loc3].tankmanID) 
                        {
                            continue;
                        }
                        loc5 = loc8;
                        break;
                    }
                }
                else 
                {
                    loc5 = {"iconFile":arg1[loc3].nationID != 0 ? "germany-empty.png" : "ussr-empty.png", "role":arg1[loc3].role, "roleIconFile":arg1[loc3].roleIcon, "firstname":arg1[loc3].firstname ? arg1[loc3].firstname : "", "lastname":arg1[loc3].lastname ? arg1[loc3].lastname : "", "rank":arg1[loc3].rank ? arg1[loc3].rank : "", "specializationLevel":-1, "vehicleType":arg1[loc3].vehicleType, "tankType":arg1[loc3].tankType, "tankmanID":NaN};
                }
                loc5.slot = arg1[loc3].slot;
                loc5.curVehicleType = arg1[loc3].tankType;
                loc5.curVehicleName = arg1[loc3].vehicleType;
                loc5.roles = arg1[loc3].roles;
                loc5.vehicleElite = arg1[loc3].vehicleElite;
                loc5.recruitList = [];
                loc5.recruitList.push({"specializationLevel":101, "recruit":true, "roleType":arg1[loc3].roleType, "role":arg1[loc3].role, "roleIconFile":arg1[loc3].roleIcon, "vehicleType":arg1[loc3].vehicleType, "typeID":arg1[loc3].typeID, "nationID":arg1[loc3].nationID, "iconFile":arg1[loc3].nationID != 0 ? "germany-empty.png" : "ussr-empty.png", "tankType":arg1[loc3].tankType});
                loc6 = arg2.length;
                loc7 = 0;
                while (loc7 < loc6) 
                {
                    if (arg2[loc7].roleType == arg1[loc3].roleType && arg2[loc7].nationID == arg1[loc3].nationID) 
                    {
                        if (arg2[loc7].tankmanID == arg1[loc3].tankmanID) 
                        {
                            arg2[loc7].selected = true;
                        }
                        if (!arg2[loc7].inTank || arg2[loc7].tankmanID == arg1[loc3].tankmanID) 
                        {
                            loc5.recruitList.push(arg2[loc7]);
                        }
                    }
                    ++loc7;
                }
                loc1.push(new net.wg.gui.lobby.hangar.crew.RecruitRendererVO(loc5));
                ++loc3;
            }
            var loc4:*=61;
            this.bg.height = loc9 = loc1.length * loc4;
            this.maskMC.height = loc9;
            this.list.mask = this.maskMC;
            this.list.dataProvider.cleanUp();
            this.list.dataProvider = new scaleform.clik.data.DataProvider(loc1);
            invalidate(INVALIDATE_ENABLE);
            return;
        }

        public override function get enabled():Boolean
        {
            return super.enabled;
        }

        public override function set enabled(arg1:Boolean):void
        {
            super.enabled = arg1;
            invalidate(INVALIDATE_ENABLE);
            return;
        }

        public function showHelpLayout():void
        {
            var loc1:*={"borderWidth":204, "borderHeight":height, "direction":this.helpDirection, "text":LOBBY_HELP.HANGAR_CREW, "x":0, "y":0, "connectorLength":this.helpConnectorLength};
            this.setHelpLayout(App.utils.helpLayout.create(this.root, loc1, this));
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(INVALIDATE_LIST)) 
            {
                updateTankmenS();
            }
            if (isInvalid(INVALIDATE_ENABLE)) 
            {
                this.list.validateNow();
                this.list.enabled = this.enabled;
                this.list.mouseEnabled = this.enabled;
            }
            return;
        }

        public function closeHelpLayout():void
        {
            if (this.getHelpLayout() != null) 
            {
                App.utils.helpLayout.destroy(this.getHelpLayout());
            }
            return;
        }

        protected function setHelpLayout(arg1:flash.display.DisplayObject):void
        {
            this._helpLayout = arg1;
            return;
        }

        protected function getHelpLayout():flash.display.DisplayObject
        {
            return this._helpLayout;
        }

        internal function openPersonalCaseHandler(arg1:net.wg.gui.events.CrewEvent):void
        {
            openPersonalCaseS(arg1.initProp.tankmanID.toString(), arg1.selectedTab);
            return;
        }

        internal static function setupDataProvider(arg1:Array):scaleform.clik.interfaces.IDataProvider
        {
            var loc2:*=null;
            var loc1:*=new scaleform.clik.data.DataProvider();
            var loc3:*=0;
            var loc4:*=arg1;
            for each (loc2 in loc4) 
            {
                loc1.push(new net.wg.gui.lobby.hangar.crew.RecruitRendererVO(loc2));
            }
            return loc1;
        }

        internal static function showTooltip(arg1:net.wg.gui.events.ListEventEx):void
        {
            App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.TANKMAN, null, arg1.itemData.tankmanID, true);
            return;
        }

        internal static function hideTooltip(arg1:net.wg.gui.events.ListEventEx):void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal static const INVALIDATE_LIST:String="invalidateList";

        internal static const INVALIDATE_ENABLE:String="invalidateEnable";

        public var list:net.wg.gui.components.controls.ScrollingListEx;

        public var maskMC:flash.display.MovieClip;

        public var bg:flash.display.MovieClip;

        public var helpDirection:String="R";

        public var helpText:String="";

        public var helpConnectorLength:Number=12;

        internal var _helpLayout:flash.display.DisplayObject=null;
    }
}
