package net.wg.gui.lobby.techtree.data.state
{


   public class NodeStateItem extends Object
   {
          
      public function NodeStateItem(param1:uint, param2:StateProperties) {
         super();
         this.state = param1;
         this.props = param2;
      }

      private var state:uint;

      private var props:StateProperties;

      public function getState() : uint {
         return this.state;
      }

      public function getProps() : StateProperties {
         return this.props;
      }
   }

}