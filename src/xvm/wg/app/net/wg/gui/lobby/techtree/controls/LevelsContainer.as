package net.wg.gui.lobby.techtree.controls
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.lobby.techtree.helpers.Distance;
    import flash.geom.Rectangle;
    
    public class LevelsContainer extends Sprite implements IDisposable
    {
        
        public function LevelsContainer() {
            super();
            scale9Grid = new Rectangle(0,0,1,1);
            tabEnabled = mouseChildren = mouseEnabled = false;
            this.delimiters = new Vector.<LevelDelimiter>();
        }
        
        private static function updateLevelDelimiter(param1:LevelDelimiter, param2:Number, param3:Number, param4:Number, param5:Number) : void {
            param1.x = param2;
            param1.y = param3;
            param1.setSize(param4,param5);
        }
        
        private var delimiters:Vector.<LevelDelimiter>;
        
        public var oddLevelRenderer:String = "OddLevelDelimiter";
        
        public var evenLevelRenderer:String = "EvenLevelDelimiter";
        
        public function updateLevels(param1:Vector.<Distance>, param2:Number, param3:Number) : Number {
            /*
             * Decompilation error
             * Code may be obfuscated
             * Error type: TranslateException
             */
            throw new Error("Not decompiled due to error");
        }
        
        public function dispose() : void {
            var _loc1_:LevelDelimiter = null;
            while(this.delimiters.length)
            {
                _loc1_ = this.delimiters.pop();
                if(_loc1_)
                {
                    _loc1_.dispose();
                }
            }
            while(numChildren > 0)
            {
                removeChildAt(0);
            }
        }
        
        private function createLevelDelimiter(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : LevelDelimiter {
            return App.utils.classFactory.getComponent(param1 % 2?this.oddLevelRenderer:this.evenLevelRenderer,LevelDelimiter,{
                "x":param2,
                "y":param3,
                "width":param4,
                "height":param5,
                "levelNumber":param1
            });
    }
    
    private function removeLevelDelimiter(param1:LevelDelimiter) : Boolean {
        var _loc2_:* = false;
        if(contains(param1))
        {
            removeChild(param1);
            _loc2_ = true;
        }
        return _loc2_;
    }
}
}
