package net.wg.infrastructure.managers.impl
{
    import net.wg.gui.components.containers.ManagedContainer;

    public class ContainerManagerBattle extends ContainerManagerBase
    {

        public function ContainerManagerBattle()
        {
            super();
        }

        override public function as_isContainerShown(param1:String) : Boolean
        {
            assert(containersMap.hasOwnProperty(param1),"ContainerManagerBattle does not have container with type " + param1);
            var _loc2_:ManagedContainer = containersMap[param1] as ManagedContainer;
            return _loc2_?_loc2_.visible:false;
        }

        override protected function showContainers(param1:Vector.<String>) : void
        {
            this.setVisibility(param1,true);
        }

        override protected function hideContainers(param1:Vector.<String>) : void
        {
            this.setVisibility(param1,false);
        }

        private function setVisibility(param1:Vector.<String>, param2:Boolean) : void
        {
            var _loc3_:String = null;
            var _loc4_:ManagedContainer = null;
            for each(_loc3_ in param1)
            {
                assert(containersMap.hasOwnProperty(_loc3_),"ContainerManagerBattle does not have container with type " + _loc3_);
                _loc4_ = containersMap[_loc3_] as ManagedContainer;
                if(_loc4_)
                {
                    _loc4_.visible = param2;
                }
            }
        }
    }
}
