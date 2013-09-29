package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class TrainingWindowMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function TrainingWindowMeta()
        {
            super();
            return;
        }

        public function getInfoS():Object
        {
            App.utils.asserter.assertNotNull(this.getInfo, "getInfo" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getInfo();
        }

        public function getMapsDataS():Array
        {
            App.utils.asserter.assertNotNull(this.getMapsData, "getMapsData" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getMapsData();
        }

        public function updateTrainingRoomS(arg1:Number, arg2:Number, arg3:int, arg4:String):void
        {
            App.utils.asserter.assertNotNull(this.updateTrainingRoom, "updateTrainingRoom" + net.wg.data.constants.Errors.CANT_NULL);
            this.updateTrainingRoom(arg1, arg2, arg3, arg4);
            return;
        }

        public var getInfo:Function=null;

        public var getMapsData:Function=null;

        public var updateTrainingRoom:Function=null;
    }
}
