package net.wg.gui.lobby.hangar.crew
{
    import net.wg.infrastructure.base.meta.impl.CrewMeta;
    import net.wg.infrastructure.interfaces.IHelpLayoutComponent;
    import net.wg.infrastructure.base.meta.ICrewMeta;
    import net.wg.infrastructure.interfaces.IDAAPIModule;
    import scaleform.clik.interfaces.IDataProvider;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.events.ListEventEx;
    import net.wg.data.constants.Tooltips;
    import net.wg.gui.components.controls.ScrollingListEx;
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import net.wg.gui.events.CrewEvent;
    
    public class Crew extends CrewMeta implements IHelpLayoutComponent, ICrewMeta, IDAAPIModule
    {
        
        public function Crew()
        {
            super();
        }
        
        private static var INVALIDATE_LIST:String = "invalidateList";
        
        private static var INVALIDATE_ENABLE:String = "invalidateEnable";
        
        private static function setupDataProvider(param1:Array) : IDataProvider
        {
            var _loc3_:Object = null;
            var _loc2_:DataProvider = new DataProvider();
            for each(_loc3_ in param1)
            {
                _loc2_.push(new RecruitRendererVO(_loc3_));
            }
            return _loc2_;
        }
        
        private static function showTooltip(param1:ListEventEx) : void
        {
            if(param1.itemData.tankmanID)
            {
                App.toolTipMgr.showSpecial(Tooltips.TANKMAN,null,param1.itemData.tankmanID,true);
            }
        }
        
        private static function hideTooltip(param1:ListEventEx) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var list:ScrollingListEx;
        
        public var maskMC:MovieClip;
        
        public var bg:MovieClip;
        
        public var helpDirection:String = "R";
        
        public var helpText:String = "";
        
        public var helpConnectorLength:Number = 12;
        
        private var _helpLayout:DisplayObject = null;
        
        public function as_tankmenResponse(param1:Array, param2:Array) : void
        {
            /*
             * Decompilation error
             * Code may be obfuscated
             * Error type: TranslateException
             */
            throw new Error("Not decompiled due to error");
        }
        
        public function showHelpLayout() : void
        {
            var _loc1_:Object = {"borderWidth":204,
            "borderHeight":height,
            "direction":this.helpDirection,
            "text":LOBBY_HELP.HANGAR_CREW,
            "x":0,
            "y":0,
            "connectorLength":this.helpConnectorLength
        };
        this.setHelpLayout(App.utils.helpLayout.create(this.root,_loc1_,this));
    }
    
    public function closeHelpLayout() : void
    {
        if(this.getHelpLayout() != null)
        {
            App.utils.helpLayout.destroy(this.getHelpLayout());
        }
    }
    
    override public function get enabled() : Boolean
    {
        return super.enabled;
    }
    
    override public function set enabled(param1:Boolean) : void
    {
        super.enabled = param1;
        invalidate(INVALIDATE_ENABLE);
    }
    
    override protected function onPopulate() : void
    {
        super.onPopulate();
        invalidate(INVALIDATE_LIST);
    }
    
    override protected function onDispose() : void
    {
        this.list.removeEventListener(ListEventEx.ITEM_ROLL_OVER,showTooltip);
        this.list.removeEventListener(ListEventEx.ITEM_ROLL_OUT,hideTooltip);
        this.list.removeEventListener(ListEventEx.ITEM_PRESS,hideTooltip);
        App.stage.removeEventListener(CrewEvent.SHOW_RECRUIT_WINDOW,this.onShowRecruitWindow);
        App.stage.removeEventListener(CrewEvent.EQUIP_TANKMAN,this.onEquipTankman);
        removeEventListener(CrewEvent.UNLOAD_TANKMAN,this.onUnloadTankman);
        removeEventListener(CrewEvent.OPEN_PERSONAL_CASE,this.openPersonalCaseHandler);
        this.list.dispose();
        this.list = null;
        this.bg = null;
        if(this._helpLayout)
        {
            this.closeHelpLayout();
        }
        this.maskMC = null;
        this._helpLayout = null;
        super.onDispose();
    }
    
    override protected function configUI() : void
    {
        super.configUI();
        mouseEnabled = false;
        addEventListener(CrewEvent.UNLOAD_TANKMAN,this.onUnloadTankman);
        addEventListener(CrewEvent.OPEN_PERSONAL_CASE,this.openPersonalCaseHandler);
        App.stage.addEventListener(CrewEvent.EQUIP_TANKMAN,this.onEquipTankman);
        App.stage.addEventListener(CrewEvent.SHOW_RECRUIT_WINDOW,this.onShowRecruitWindow);
        this.list.addEventListener(ListEventEx.ITEM_ROLL_OVER,showTooltip);
        this.list.addEventListener(ListEventEx.ITEM_ROLL_OUT,hideTooltip);
        this.list.addEventListener(ListEventEx.ITEM_PRESS,hideTooltip);
        this.list.mouseEnabled = false;
        this.list.validateNow();
    }
    
    override protected function draw() : void
    {
        if(isInvalid(INVALIDATE_LIST))
        {
            updateTankmenS();
        }
        if(isInvalid(INVALIDATE_ENABLE))
        {
            this.list.validateNow();
            this.list.enabled = this.enabled;
            this.list.mouseEnabled = this.enabled;
        }
    }
    
    protected function setHelpLayout(param1:DisplayObject) : void
    {
        this._helpLayout = param1;
    }
    
    protected function getHelpLayout() : DisplayObject
    {
        return this._helpLayout;
    }
    
    private function onEquipTankman(param1:CrewEvent) : void
    {
        equipTankmanS(param1.initProp.tankmanID,param1.initProp.slot);
    }
    
    private function onUnloadTankman(param1:CrewEvent) : void
    {
        unloadTankmanS(param1.initProp.tankmanID);
    }
    
    private function onShowRecruitWindow(param1:CrewEvent) : void
    {
        onShowRecruitWindowClickS(param1.initProp,param1.menuEnabled);
    }
    
    private function openPersonalCaseHandler(param1:CrewEvent) : void
    {
        openPersonalCaseS(param1.initProp.tankmanID.toString(),param1.selectedTab);
    }
}
}
