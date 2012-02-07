package utils
{
	public class ElementKind
	{
		public static const vehicleIcon:uint = 1;
		public static const playerName:uint = 2;
		public static const vehicleName:uint = 4;
		public static const healthBar:uint = 8;
		public static const currentHealth:uint = 16;
		public static const healthRatio:uint = 32;
		public static const combatScrollText:uint = 64;
		public static const contourIcon:uint = 128;
		public static const levelIcon:uint = 256;
		public static const actionMarker:uint = 512;

		public static const none:uint = 0;
		public static const all:uint = 0xFFFFFFFF;
		// All text input elements
		public static const text:uint = playerName | vehicleName | currentHealth | healthRatio | combatScrollText;
		// All elements with shadow
		public static const shadow:uint = all & ~(levelIcon | actionMarker | healthBar);
		// All elements with color
		public static const color:uint = all & ~(levelIcon | actionMarker);

		public static function getElementsNames(elements:uint):Array
		{
			var result:Array = [];
			if ((elements & vehicleIcon) != 0)
				result.push("vehicleIcon");
			if ((elements & playerName) != 0)
				result.push("playerName");
			if ((elements & vehicleName) != 0)
				result.push("vehicleName");
			if ((elements & healthBar) != 0)
				result.push("healthBar");
			if ((elements & currentHealth) != 0)
				result.push("currentHealth");
			if ((elements & healthRatio) != 0)
				result.push("healthRatio");
			if ((elements & combatScrollText) != 0)
				result.push("combatScrollText");
			if ((elements & contourIcon) != 0)
				result.push("contourIcon");
			if ((elements & levelIcon) != 0)
				result.push("levelIcon");
			if ((elements & actionMarker) != 0)
				result.push("actionMarker");
			return result;
		}
	}
}