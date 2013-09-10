package net.wg.gui.lobby.training 
{
    import flash.display.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.helpers.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public class TrainingDragDelegate extends net.wg.infrastructure.helpers.DropListDelegate
    {
        public function TrainingDragDelegate(arg1:flash.display.InteractiveObject, arg2:String)
        {
            super(arg1, arg2);
            return;
        }

        public override function onStartDrop(arg1:flash.display.InteractiveObject, arg2:flash.display.InteractiveObject, arg3:Number, arg4:Number):void
        {
            var loc1:*=null;
            super.onStartDrop(arg1, arg2, arg3, arg4);
            if (App.instance) 
                if (loc1 = App.cursor.getAttachedSprite() as net.wg.infrastructure.interfaces.entity.IUpdatable) 
                {
                    App.utils.asserter.assertNotNull(loc1, "cursor.attachedSprite" + net.wg.data.constants.Errors.CANT_NULL);
                    net.wg.infrastructure.interfaces.entity.IUpdatable(loc1).update(net.wg.infrastructure.interfaces.entity.IDropItem(arg2).data);
                }
                else 
                    DebugUtils.LOG_ERROR("attached sprite must implements IUpdatable interface.");
            return;
        }
    }
}
