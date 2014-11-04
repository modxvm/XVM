package net.wg.gui.lobby.fortifications.data
{
    import net.wg.gui.lobby.fortifications.data.base.BuildingBaseVO;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import net.wg.utils.IAssertable;
    
    public class BuildingVO extends BuildingBaseVO
    {
        
        public function BuildingVO(param1:Object)
        {
            super(param1);
        }
        
        private static var CTX_MENU_DATA:String = "ctxMenuData";
        
        public var isDefenceHour:Boolean = false;
        
        public var toolTipData:Array = null;
        
        public var transportTooltipData:Array = null;
        
        public var orderTime:String = "";
        
        public var direction:int = -1;
        
        public var position:int = 0;
        
        public var cooldown:String = "";
        
        public var progress:int = -1;
        
        public var isAvailable:Boolean = true;
        
        public var isExportAvailable:Boolean = false;
        
        public var isImportAvailable:Boolean = false;
        
        public var isLevelUp:Boolean = false;
        
        public var ctxMenuData:Array = null;
        
        public var isOpenCtxMenu:Boolean = false;
        
        public var productionInPause:Boolean = false;
        
        public var underAttack:Boolean = false;
        
        public var looted:Boolean = false;
        
        public var isBaseBuildingDamaged:Boolean = false;
        
        public var isFortFrozen:Boolean = false;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            var _loc5_:BuildingCtxMenuVO = null;
            if(param1 == CTX_MENU_DATA && !(param2 == null))
            {
                _loc3_ = param2 as Array;
                this.ctxMenuData = [];
                for each(_loc4_ in _loc3_)
                {
                    _loc5_ = new BuildingCtxMenuVO(_loc4_);
                    this.ctxMenuData.push(_loc5_);
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
        
        public function get isInFoundationState() : Boolean
        {
            return this.progress > FORTIFICATION_ALIASES.STATE_TROWEL && this.progress < FORTIFICATION_ALIASES.STATE_BUILDING;
        }
        
        public final function validate() : void
        {
            var _loc1_:IAssertable = App.utils.asserter;
            var _loc2_:* = this.progress == FORTIFICATION_ALIASES.STATE_BUILDING;
            var _loc3_:* = "non-completed building \'" + uid + "\' can not be available to ";
            if(this.isExportAvailable)
            {
                _loc1_.assert(_loc2_,_loc3_ + "exporting");
            }
        }
    }
}
