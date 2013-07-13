using System;
using System.Collections.Generic;

static class Defines
{
    // List of all counties (don't change the order)
    public static readonly string[] COUNTRIES = new string[] { "ussr", "germany", "usa", "china", "france", "uk"/*, "japan"*/ };

    // List of vehicle types (don't change the order)
    public static readonly string[] TYPES = new string[] { "", "SPG", "LT", "MT", "TD", "HT" };
    public static readonly string[] TYPES_FOR_SORT = new string[] { "LT", "MT", "HT", "TD", "SPG" };
}
