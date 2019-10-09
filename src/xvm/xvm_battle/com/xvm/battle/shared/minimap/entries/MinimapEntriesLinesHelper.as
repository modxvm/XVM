/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.shared.minimap.entries
{
    import com.xfw.*;
    import com.xvm.battle.*;
    import com.xvm.types.cfg.*;
    import flash.display.*;
    import net.wg.gui.battle.views.minimap.constants.*;

    public class MinimapEntriesLinesHelper
    {
        public static function createLines(linesCfg:Vector.<CMinimapLine>):Sprite
        {
            var scaleFactor:Number = MinimapSizeConst.MAP_SIZE[0].width / BattleGlobalData.mapSize;
            var sprite:Sprite = new Sprite();
            if (linesCfg)
            {
                var len:int = linesCfg.length;
                for (var i:int = 0; i < len; ++i)
                {
                    var lineCfg:CMinimapLine = linesCfg[i];
                    if (lineCfg.enabled)
                    {
                        var from:Number = lineCfg.from;
                        var to:Number = lineCfg.to;

                        // Translate absolute minimap distance in points to game meters
                        if (lineCfg.inmeters)
                        {
                            from *= scaleFactor;
                            to   *= scaleFactor;
                        }
                        sprite.graphics.lineStyle(lineCfg.thickness, lineCfg.color, lineCfg.alpha / 100.0);
                        sprite.graphics.moveTo(0, -from);
                        sprite.graphics.lineTo(0, -to);
                    }
                }
            }
            return sprite;
        }
    }
}
