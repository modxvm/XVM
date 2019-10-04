package net.wg.gui.battle.views.battleMessenger
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.BitmapData;

    public class BattleImageSubstitution extends Object implements IDisposable
    {

        public var subString:String;

        public var image:BitmapData;

        public var baseLineY:int = 11;

        public function BattleImageSubstitution(param1:String, param2:BitmapData)
        {
            super();
            this.subString = param1;
            this.image = param2;
        }

        public function dispose() : void
        {
            if(this.image.width != 0 && this.image.height != 0)
            {
                this.image.dispose();
            }
            this.image = null;
        }
    }
}
