package net.wg.gui.lobby.training 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import net.wg.infrastructure.helpers.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public class TrainingDragController extends net.wg.infrastructure.helpers.DragDropListDelegateCtrlr
    {
        public function TrainingDragController(arg1:__AS3__.vec.Vector.<flash.display.InteractiveObject>, arg2:Class, arg3:String)
        {
            super(arg1, arg2, arg3);
            return;
        }

        protected override function onHighlightHitAreas(arg1:Boolean, arg2:flash.display.InteractiveObject):void
        {
            var loc1:*=null;
            if (arg2 is net.wg.infrastructure.interfaces.entity.IDropItem) 
            {
                if (arg1) 
                {
                    arg2.alpha = 0.3;
                    var loc2:*=0;
                    var loc3:*=getDelegates();
                    for each (loc1 in loc3) 
                    {
                        net.wg.infrastructure.interfaces.IDropList(loc1.getHitArea()).highlightList();
                    }
                }
                else 
                {
                    if (arg2) 
                    {
                        arg2.alpha = 1;
                    }
                    loc2 = 0;
                    loc3 = getDelegates();
                    for each (loc1 in loc3) 
                    {
                        net.wg.infrastructure.interfaces.IDropList(loc1.getHitArea()).hideHighLight();
                    }
                }
            }
            return;
        }
    }
}
