import wot.Minimap.model.MapConfig;
import wot.Minimap.MinimapEntry;

/**
 * LostEnemyMarkerFactory creates lost enemy icon MovieClip based on its vehicle class.
 * Icons are picked up by html at res_mods/minimapicons/*
 * 
 * Preventing removeMovieClip() on MinimapEntry when Python wants it provokes minimap icons display errors.
 * Cant copy MinimapEntry. Actionscript 2 restriction.
 * Cant make a bitmap screenshot of MinimapEntry. Simply does not work. BitmapData.draw(markMC) -> null. No idea why.
 * No link name of internal enemy icons inside minimap flash library.
 * 
 * This is why new MovieClip creation with external images is the only way.
 * 
 * This leads to configuration mismatch for alive and dead units.
 * Lost icons are external picked by html. Normal are internal from library.
 */

class wot.Minimap.staticUtils.LostEnemyIconFactory
{
    public static function createIcon(container:MovieClip, vehClass:String, x:Number, y:Number):MovieClip
    {
        var lost:MovieClip = container.createEmptyMovieClip("lost" + x, container.getNextHighestDepth());
        lost._x = x;
        lost._y = y;
        
        var textField:TextField = lost.createTextField("textField", 1, 0, 0, 100, 30);
        textField.antiAliasType = "advanced";
        textField.html = true;

        if (MapConfig.lostEnemyEnabled)
        {
            lost._alpha = MapConfig.lostEnemyAlpha;
            
            var width:Number = MapConfig.lostEnemyIconWidth;
            var height:Number = MapConfig.lostEnemyIconHeight;
            
            textField.htmlText = "<span class='xvm_mm'>";
            switch (vehClass)
            {
                case MinimapEntry.MINIMAP_ENTRY_VEH_CLASS_LIGHT:
                    textField.htmlText += "<img src='img://../minimapicons/light.png' width='" + width + "' height='" + height + "' align='left'>";
                    break;
                case MinimapEntry.MINIMAP_ENTRY_VEH_CLASS_MEDIUM:
                    textField.htmlText += "<img src='img://../minimapicons/medium.png' width='" + width + "' height='" + height + "' align='left'>";
                    break;
                case MinimapEntry.MINIMAP_ENTRY_VEH_CLASS_HEAVY:
                    textField.htmlText += "<img src='img://../minimapicons/heavy.png' width='" + width + "' height='" + height + "' align='left'>";
                    break;
                case MinimapEntry.MINIMAP_ENTRY_VEH_CLASS_TD:
                    textField.htmlText += "<img src='img://../minimapicons/td.png' width='" + width + "' height='" + height + "' align='left'>";
                    break;
                case MinimapEntry.MINIMAP_ENTRY_VEH_CLASS_SPG:
                    textField.htmlText += "<img src='img://../minimapicons/spg.png' width='" + width + "' height='" + height + "' align='left'>";
            }
            textField.htmlText += "</span>";
        }
        
        return lost;
    }
}