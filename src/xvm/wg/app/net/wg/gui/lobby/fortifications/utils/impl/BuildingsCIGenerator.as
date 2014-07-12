package net.wg.gui.lobby.fortifications.utils.impl
{
    import net.wg.gui.lobby.fortifications.utils.IBuildingsCIGenerator;
    import net.wg.infrastructure.interfaces.IContextItem;
    import net.wg.gui.lobby.fortifications.data.BuildingCtxMenuVO;
    import net.wg.data.components.ContextItem;
    
    public class BuildingsCIGenerator extends Object implements IBuildingsCIGenerator
    {
        
        public function BuildingsCIGenerator() {
            super();
        }
        
        public function generateGeneralCtxItems(param1:Array) : Vector.<IContextItem> {
            return this.generateContextItems(param1);
        }
        
        private function generateContextItems(param1:Array) : Vector.<IContextItem> {
            var _loc5_:BuildingCtxMenuVO = null;
            var _loc6_:ContextItem = null;
            var _loc2_:int = param1.length;
            var _loc3_:Vector.<IContextItem> = new Vector.<IContextItem>();
            var _loc4_:* = 0;
            while(_loc4_ < _loc2_)
            {
                _loc5_ = BuildingCtxMenuVO(param1[_loc4_]);
                _loc6_ = new ContextItem(_loc5_.actionID,_loc5_.menuItem,{"enabled":_loc5_.isEnabled});
                _loc3_.push(_loc6_);
                _loc4_++;
            }
            return _loc3_;
        }
    }
}
