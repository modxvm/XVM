package net.wg.gui.lobby.training 
{
    import flash.display.*;
    import flash.filters.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.core.*;
    
    public class MinimapEntry extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.IMinimapEntry
    {
        public function MinimapEntry()
        {
            super();
            return;
        }

        public function init(arg1:String, arg2:String, arg3:String, arg4:String):void
        {
            this.m_type = arg1;
            this.entryName = arg2;
            this.vehicleClass = arg3;
            this.markLabel = arg4;
            this.validateNow();
            return;
        }

        public function showAction(arg1:String):void
        {
            if (this.markMC != null) 
            {
                this.markMC.gotoAndStop(1);
            }
            this.markLabel = arg1;
            validateNow();
            return;
        }

        public function lightPlayer(arg1:Boolean):void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            if (this.player != null) 
            {
                loc1 = 1;
                loc2 = 4;
                if (!(ms_lastLitEntry == null) && arg1) 
                {
                    if (ms_lastLitEntry == this) 
                    {
                        ms_lastLitEntry = null;
                    }
                    else 
                    {
                        ms_lastLitEntry.player.litIcon.gotoAndStop(loc1);
                    }
                }
                if (this.player.litIcon.currentFrame == (arg1 ? loc1 : loc2)) 
                {
                    if (arg1) 
                    {
                        ms_lastLitEntry = this;
                    }
                    else 
                    {
                        ms_lastLitEntry = null;
                    }
                    if (this.getMinimap().visible) 
                    {
                        App.utils.scheduler.envokeInNextFrame(this.playPlayer);
                    }
                    else 
                    {
                        this.player.litIcon.gotoAndStop(arg1 ? loc2 : loc1);
                    }
                }
            }
            return;
        }

        internal function playPlayer():void
        {
            this.player.litIcon.play();
            App.utils.scheduler.cancelTask(this.playPlayer);
            return;
        }

        public function get colorSchemeName():String
        {
            return "vm_" + (this.entryName == null ? this.m_type : this.entryName);
        }

        public function setEntryName(arg1:String):void
        {
            if (arg1 != this.entryName) 
            {
                this.entryName = arg1;
                invalidate();
            }
            return;
        }

        public function setDead(arg1:Boolean):void
        {
            this.isDead = true;
            this.isDeadPermanent = arg1;
            invalidate();
            return;
        }

        public function setPostmortem(arg1:Boolean):void
        {
            this.isPostmortem = arg1;
            invalidate();
            return;
        }

        public function isTeamPoint():Boolean
        {
            return this.m_type == "points" && !(this.teamPoint == null);
        }

        internal function isBackMarker():Boolean
        {
            return this.m_type == "backgroundMarker" && !(this.backMarker == null);
        }

        internal function updateType():void
        {
            if (this.m_type != null) 
            {
                gotoAndStop(this.m_type);
            }
            return;
        }

        internal function updateIfEntryIsPlayer():void
        {
            var loc1:*=null;
            if (this.player != null) 
            {
                loc1 = App.colorSchemeMgr.getAliasColor(this.colorSchemeName);
                if (this.isDead) 
                {
                    loc1 = loc1 == null ? "green" : loc1;
                    this.player.gotoAndStop("dead");
                    this.player.icon.marker.gotoAndStop(this.vehicleClass + "-" + loc1);
                    this.player.icon.gotoAndPlay("show");
                    this.player.icon.isDeadPermanent = this.isDeadPermanent;
                }
                else if (this.isPostmortem) 
                {
                    this.player.gotoAndStop("postmortem");
                }
                else 
                {
                    if (loc1 != null) 
                    {
                        this.player.gotoAndStop(loc1);
                    }
                    this.player.litIcon.icon.gotoAndStop(this.vehicleClass);
                }
            }
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            this.updateType();
            this.updateIfEntryIsPlayer();
            if (this.selfIcon != null) 
            {
                this.selfIcon.gotoAndStop(this.entryName);
                if (this.rotation != 0) 
                {
                    this.markMC.rotation = -this.rotation;
                }
            }
            if (this.isTeamPoint()) 
            {
                this.teamPoint.gotoAndStop(this.entryName);
                loc1 = "teamPoint";
                loc2 = loc1 + this.entryName + this.vehicleClass;
                loc3 = App.colorSchemeMgr.getAliasColor(loc2);
                loc4 = App.colorSchemeMgr.getScheme(loc2).adjustOffset;
                this.teamPoint.pointType.gotoAndStop(loc3);
                this.teamPoint.pointType.teamColor.gotoAndStop(this.markLabel);
                if (loc4 == null) 
                {
                    this.teamPoint.pointType.teamColor.filters = [];
                }
                else 
                {
                    this.teamPoint.pointType.teamColor.filters = [loc4];
                }
            }
            else if (this.isBackMarker()) 
            {
                this.backMarker.gotoAndStop(this.entryName);
                loc5 = "backMarker";
                loc6 = App.colorSchemeMgr.getAliasColor(loc5 + this.entryName + this.markLabel);
                this.backMarker.marker.gotoAndStop(loc6);
            }
            else if (this.markMC != null) 
            {
                if (this.markLabel != null) 
                {
                    this.markMC.gotoAndStop(this.markLabel);
                }
            }
            super.draw();
            return;
        }

        internal function getMinimap():flash.display.MovieClip
        {
            return flash.display.MovieClip(this.parent);
        }

        public static function unhighlightLastEntry():void
        {
            if (ms_lastLitEntry) 
            {
                ms_lastLitEntry.lightPlayer(false);
            }
            return;
        }

        
        {
            ms_lastLitEntry = null;
        }

        public function update(arg1:Object):void
        {
            invalidate();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        public var player:flash.display.MovieClip;

        public var selfIcon:flash.display.MovieClip;

        public var markMC:flash.display.MovieClip;

        public var teamPoint:flash.display.MovieClip;

        public var hover:flash.display.MovieClip;

        public var backMarker:flash.display.MovieClip;

        public var m_type:String="";

        internal var entryName:String="";

        internal var vehicleClass:String="";

        internal var markLabel:String="";

        internal var isTeamKiller:Boolean=false;

        internal var isDead:Boolean=false;

        internal var isDeadPermanent:Boolean=false;

        internal var isPostmortem:Boolean=false;

        internal var isMarketLit:Boolean=false;

        internal var playingTimeoutId:Number=NaN;

        internal static var ms_lastLitEntry:net.wg.gui.lobby.training.MinimapEntry=null;
    }
}
