package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class TrainingRoomInfoVO extends DAAPIDataClass
   {
          
      public function TrainingRoomInfoVO(param1:Object) {
         super(param1);
      }

      public var comment:String = "";

      public var arenaName:String = "";

      public var roundLenString:String = "";

      public var maxPlayersCount:Number = 0;

      public var arenaSubType:String = "";

      public var creator:String = "";

      public var arenaTypeID:Number = 0;

      public var description:String = "";

      public var title:String = "";

      public var canChangeArenaVOIP:Boolean;

      public var arenaVoipChannels:Number = -1;

      public var isCreator:Boolean;

      public var creatorFullName:String = "";

      public var creatorClan:String = "";

      public var creatorRegion:String = "";

      public var creatorIgrType:int = 0;
   }

}