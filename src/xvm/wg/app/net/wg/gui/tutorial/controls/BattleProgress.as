package net.wg.gui.tutorial.controls 
{
    import flash.display.*;
    import scaleform.clik.core.*;
    
    public class BattleProgress extends scaleform.clik.core.UIComponent
    {
        public function BattleProgress()
        {
            this.separatorItems = [];
            this.taskItems = [];
            this.phaseItems = [];
            super();
            this._bodyWidth = this.background.width - BODY_WIDTH_CORRECTION;
            return;
        }

        internal function getLineStatus(arg1:Number):String
        {
            var loc1:*=PHASE_NONE;
            var loc2:*=arg1;
            switch (loc2) 
            {
                case 0:
                {
                    loc1 = PHASE_NONE;
                    break;
                }
                case 1:
                {
                    loc1 = PHASE_FAIL;
                    break;
                }
                case 2:
                {
                    loc1 = PHASE_NONE;
                    break;
                }
                case 3:
                {
                    loc1 = PHASE_DONE;
                    break;
                }
            }
            return loc1;
        }

        public function createInstance(arg1:flash.display.DisplayObjectContainer, arg2:String):flash.display.MovieClip
        {
            var loc1:*=null;
            loc1 = App.utils.classFactory.getObject(arg2) as flash.display.MovieClip;
            if (loc1) 
            {
                arg1.addChild(loc1);
            }
            return loc1;
        }

        internal function clearItems(arg1:flash.display.Sprite, arg2:Array):void
        {
            while (arg1.numChildren) 
            {
                arg1.removeChildAt(0);
            }
            arg2.splice(0, arg2.legth);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            this.setupPhases();
            this.setupTasks();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.clearItems(this.separatorsContainer, this.separatorItems);
            this.clearItems(this.phasesContainer, this.phaseItems);
            this.clearItems(this.tasksContainer, this.taskItems);
            return;
        }

        public function populateUI(arg1:Number, arg2:Number):void
        {
            if (this._allPhases != arg2) 
            {
                this._allPhases = arg2;
                this.rebuildPhases();
                this.rebuildTasks();
                invalidate();
            }
            if (this._curPhase != arg1) 
            {
                this._curPhase = arg1;
                this.rebuildTasks();
                invalidate();
            }
            return;
        }

        public function setPhases(arg1:Number):void
        {
            this._phaseStatusMask = arg1;
            invalidate();
            return;
        }

        public function setTasks(arg1:Number, arg2:Number):void
        {
            if (this._allTasks != arg1) 
            {
                this._allTasks = arg1;
                this.rebuildTasks();
            }
            if (this._tasksStatusMask != arg2) 
            {
                this._tasksStatusMask = arg2;
                invalidate();
            }
            return;
        }

        internal function rebuildPhases():void
        {
            var loc2:*=NaN;
            var loc3:*=null;
            var loc4:*=null;
            this.clearItems(this.separatorsContainer, this.separatorItems);
            this.clearItems(this.phasesContainer, this.phaseItems);
            this._phaseWidth = this._bodyWidth / this._allPhases;
            var loc1:*=0;
            while (loc1 < this._allPhases) 
            {
                loc2 = this._phaseWidth * loc1 ^ 0;
                loc3 = this.createInstance(this.separatorsContainer, this.separatorRenderer) as net.wg.gui.tutorial.controls.ProgressSeparator;
                loc3.x = loc2;
                loc3.setup(loc1, this._phaseWidth);
                this.separatorItems.push(loc3);
                (loc4 = this.createInstance(this.phasesContainer, this.progressItemRenderer) as net.wg.gui.tutorial.controls.ProgressItem).x = loc2;
                loc4.width = this._phaseWidth;
                this.phaseItems.push(loc4);
                ++loc1;
            }
            return;
        }

        internal function setupPhases():void
        {
            var loc1:*=NaN;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            if (!isNaN(this._phaseStatusMask) && !(this.phaseItems == null)) 
            {
                loc1 = MASK;
                loc2 = 0;
                while (loc2 < this.phaseItems.length) 
                {
                    loc3 = this.phaseItems[loc2];
                    loc4 = this.separatorItems[loc2];
                    loc5 = this.getLineStatus((loc1 & this._phaseStatusMask) >> 2 * loc2);
                    loc3.setPhase(loc5);
                    loc4.gotoAndStop(this._curPhase != loc2 ? loc3.phaseFrame : "current");
                    loc4.setup(loc2, this._phaseWidth);
                    loc1 = loc1 << 2;
                    ++loc2;
                }
            }
            return;
        }

        internal function setupTasks():void
        {
            var loc1:*=NaN;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            if (this._curPhase > -1 && !isNaN(this._tasksStatusMask)) 
            {
                loc1 = MASK;
                loc2 = 0;
                while (loc2 < this.taskItems.length) 
                {
                    loc3 = this.taskItems[loc2];
                    loc4 = this.getLineStatus((loc1 & this._tasksStatusMask) >> 2 * loc2);
                    loc3.setPhase(loc4);
                    loc3.highlight();
                    loc1 = loc1 << 2;
                    ++loc2;
                }
            }
            return;
        }

        internal function rebuildTasks():void
        {
            var loc4:*=null;
            this.clearItems(this.tasksContainer, this.taskItems);
            var loc1:*=this._phaseWidth * this._curPhase ^ 0;
            var loc2:*=this._phaseWidth / this._allTasks ^ 0;
            var loc3:*=0;
            while (loc3 < this._allTasks) 
            {
                (loc4 = this.createInstance(this.tasksContainer, this.progressItemRenderer) as net.wg.gui.tutorial.controls.ProgressItem).x = loc1 + loc3 * loc2;
                loc4.width = loc3 != (this._allTasks - 1) ? loc2 : (this._phaseWidth % this._allTasks ^ 0) + loc2;
                this.taskItems.push(loc4);
                ++loc3;
            }
            return;
        }

        internal static const PHASE_DONE:String="done";

        internal static const PHASE_FAIL:String="fail";

        internal static const PHASE_NONE:String="none";

        internal static const MASK:uint=3;

        internal static const BODY_WIDTH_CORRECTION:Number=8;

        public var progressItemRenderer:String="BattleProgressItem";

        public var separatorRenderer:String="BattleSeparator";

        internal var _curPhase:Number=-1;

        internal var _allPhases:Number=0;

        internal var _phaseStatusMask:Number=NaN;

        internal var _allTasks:Number=0;

        internal var _tasksStatusMask:Number=NaN;

        public var background:flash.display.MovieClip;

        public var phasesContainer:flash.display.Sprite;

        public var tasksContainer:flash.display.Sprite;

        public var separatorsContainer:flash.display.Sprite;

        internal var separatorItems:Array;

        internal var taskItems:Array;

        internal var phaseItems:Array;

        internal var _phaseWidth:Number;

        internal var _bodyWidth:Number;
    }
}
