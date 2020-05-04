package net.wg.infrastructure.base.meta.impl
{
    import net.wg.data.constants.Errors;

    public class EventBattleQueueMeta extends BaseBattleQueueMeta
    {

        public var moveSpace:Function;

        public var notifyCursorOver3dScene:Function;

        public var notifyCursorDragging:Function;

        public function EventBattleQueueMeta()
        {
            super();
        }

        public function moveSpaceS(param1:Number, param2:Number, param3:Number) : void
        {
            App.utils.asserter.assertNotNull(this.moveSpace,"moveSpace" + Errors.CANT_NULL);
            this.moveSpace(param1,param2,param3);
        }

        public function notifyCursorOver3dSceneS(param1:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.notifyCursorOver3dScene,"notifyCursorOver3dScene" + Errors.CANT_NULL);
            this.notifyCursorOver3dScene(param1);
        }

        public function notifyCursorDraggingS(param1:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.notifyCursorDragging,"notifyCursorDragging" + Errors.CANT_NULL);
            this.notifyCursorDragging(param1);
        }
    }
}
