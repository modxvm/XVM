package net.wg.gui.lobby.vehicleInfo
{
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class PropBlock extends Sprite
   {
      
      public function PropBlock() {
         super();
      }
      
      public var propValue:TextField;
      
      public var propName:TextField;
      
      public function setData(param1:Object) : void {
         this.propValue.text = param1.value;
         this.propName.text = MENU.vehicleinfo_params(param1.name);
      }
   }
}
