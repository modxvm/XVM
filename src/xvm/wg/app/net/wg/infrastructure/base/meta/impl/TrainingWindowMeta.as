package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class TrainingWindowMeta extends AbstractWindowView
    {
        
        public function TrainingWindowMeta() {
            super();
        }
        
        public var getInfo:Function = null;
        
        public var getMapsData:Function = null;
        
        public var updateTrainingRoom:Function = null;
        
        public function getInfoS() : Object {
            App.utils.asserter.assertNotNull(this.getInfo,"getInfo" + Errors.CANT_NULL);
            return this.getInfo();
        }
        
        public function getMapsDataS() : Array {
            App.utils.asserter.assertNotNull(this.getMapsData,"getMapsData" + Errors.CANT_NULL);
            return this.getMapsData();
        }
        
        public function updateTrainingRoomS(param1:Number, param2:Number, param3:int, param4:String) : void {
            App.utils.asserter.assertNotNull(this.updateTrainingRoom,"updateTrainingRoom" + Errors.CANT_NULL);
            this.updateTrainingRoom(param1,param2,param3,param4);
        }
    }
}
