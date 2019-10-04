package net.wg.gui.battle.views.battleMessenger.VO
{
    public class BattleMessengerToxicVO extends Object
    {

        public var messageID:Number = -1;

        public var vehicleID:Number = -1;

        public var blackList:ButtonToxicStatusVO = null;

        public function BattleMessengerToxicVO()
        {
            super();
            this.blackList = new ButtonToxicStatusVO();
        }

        public function parseData(param1:Object) : void
        {
            if(param1 == null)
            {
                return;
            }
            this.vehicleID = param1.vehicleID;
            this.messageID = param1.messageID;
            this.blackList.parseData(param1.blackList);
        }

        public function reset() : void
        {
            this.messageID = -1;
            this.vehicleID = -1;
            this.blackList.reset();
        }
    }
}
