package net.wg.gui.lobby.clans.utils
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.infrastructure.interfaces.IDisplayObject;

    public class ClanHelper extends Object implements IDisposable
    {

        public function ClanHelper()
        {
            super();
        }

        public function dispose() : void
        {
        }

        public function getPositionOfCenter(param1:IDisplayObject, param2:int) : int
        {
            return param1.width - param2 >> 1;
        }

        public function getPositionOfRightPart(param1:IDisplayObject, param2:int, param3:int) : int
        {
            return param1.width - (param2 + param3 >> 1) ^ 0;
        }
    }
}
