/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg 
{
	import com.xfw.*;
	import com.xvm.*;
	
	public dynamic class CMarkersVehicleDist implements ICloneable 
	{
		public var alpha:*;
        public var enabled:*;
        public var shadow:CShadow;
        public var textFormat:CTextFormat;
        public var x:*;
        public var y:*;
		
		public function clone():*
		{
			throw new Error("clone() method is not implemented");
		}
		internal function applyGlobalMacros():void
		{	
			enabled = Macros.FormatBooleanGlobal(enabled, true);
		}	
	}
}