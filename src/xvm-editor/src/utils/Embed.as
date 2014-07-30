package utils
{
    public final class Embed
    {
        // fonts
        [Embed(source="../../assets/HeliosCondC.otf", fontFamily="$FieldFont",
            fontStyle="normal", fontWeight="normal", embedAsCFF="false")]
        private static var $FieldFontClassRegular:Class;
        [Embed(source="../../assets/HeliosCondC-Bold.otf", fontFamily="$FieldFont",
            fontStyle="normal", fontWeight="bold", embedAsCFF="false")]
        private static var $FieldFontClassBold:Class;
        [Embed(source="../../assets/HeliosCondC-Italic.otf", fontFamily="$FieldFont",
            fontStyle="italic", fontWeight="normal", embedAsCFF="false")]
        private static var $FieldFontClassItalic2:Class;
        [Embed(source="../../assets/HeliosCondC-BoldItalic.otf", fontFamily="$FieldFont",
            fontStyle="italic", fontWeight="bold", embedAsCFF="false")]
        private static var $FieldFontClassBoldItalic:Class;

        [Embed(source="../../assets/HeliosCondC.otf", fontFamily="$FieldFont",
            fontStyle="normal", fontWeight="normal", embedAsCFF="true")]
        private static var $FieldFontClassCFF:Class;

        [Embed(source="../../assets/Cuprum.ttf", fontFamily="Cuprum",
            fontStyle="normal", fontWeight="normal", embedAsCFF="false")]
        private static var CuprumClassCFF:Class;
        
        // images
        [Embed(source="../images/add.png")]
        public static const add:Class;
        [Embed(source="../images/delete.png")]
        public static const del:Class;
        [Embed("../images/syscolors.png")]
        public static const syscolors:Class;
        [Embed("../images/macros.png")]
        public static const macros:Class;
    }
}
