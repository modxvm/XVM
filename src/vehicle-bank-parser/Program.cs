/**
 * Based on Tank Icon Maker by Roman Starkov https://bitbucket.org/rstarkov/tankdataconverter GPLv3
 */
using System;
using System.IO;
using System.Linq;
using RT.Util;
using RT.Util.ExtensionMethods;
using RT.Util.Json;
using System.Collections.Generic;

namespace VehicleBankParser
{
    class Program
    {
        private const String VEHICLE_DIR_PATH = @"res\scripts\item_defs\vehicles\{0}\list.xml";
        private const String GAME_PATH = @"D:\Program Files\World_of_Tanks";
        private const String GAME_CLUSTER = "Ru";
        private const String GAME_VER = "0.7.5";
        private const String OUTPUT_PATH = @"D:\";
        static readonly String [] COUNTRIES = new String[]{ "ussr", "germany", "usa", "france", "china", "uk" };

        static void Main(string[] args)
        {
            generateFiles(GAME_PATH, GAME_CLUSTER, GAME_VER, COUNTRIES, OUTPUT_PATH, VEHICLE_DIR_PATH);
        }

        private static void generateFiles(string gamePath, string lang, string builtInVersion, string[] countries, string outputPath, string vehicleListPath)
        {
            // Read the tank data from game files

            var splitStringRef = Ut.Lambda((string str) =>
            {
                var split = str.Split(':');
                if (split.Length != 2) throw new Exception();
                if (!split[0].StartsWith("#")) throw new Exception();
                return new { file = split[0].Substring(1), key = split[1] };
            });

            var tanks = countries.SelectMany(country =>
                BxmlReader.ReadFile(Path.Combine(gamePath, vehicleListPath.Fmt(country)))
                .AsDict
                .Select(kvp => new { country, id = kvp.Key, raw = kvp.Value })
            ).ToDictionary(tank => tank.country + "-" + tank.id, tank =>
            {
                var tags1 = tank.raw["tags"].AsString.Split("\r\n").Select(s => s.Trim()).ToHashSet();
                var tags2 = tank.raw["tags"].AsString.Split(' ').Select(s => s.Trim()).ToHashSet();
                var tags = tags1.Count > tags2.Count ? tags1 : tags2;
                bool notInShop = tank.raw.ContainsKey("notInShop") && tank.raw["notInShop"].AsBool;
                bool gold = tank.raw["price"] is JsonDict && tank.raw["price"].ContainsKey("gold");
                return new
                {
                    tank.id,
                    tank.country,
                    tank.raw,
                    nameFull = splitStringRef(tank.raw["userString"].AsString),
                    nameShort = splitStringRef(tank.raw.ContainsKey("shortUserString") ? tank.raw["shortUserString"].AsString : tank.raw["userString"].AsString),
                    tier = tank.raw["level"].AsInt,
                    secret = tags.Contains("secret"),
                    tags, notInShop, gold,
                    kind = notInShop ? "special" : gold ? "premium" : "normal",
                    class_ = tags.Contains("lightTank") ? "light" : tags.Contains("mediumTank") ? "medium" : tags.Contains("heavyTank") ? "heavy" : tags.Contains("SPG") ? "artillery" : tags.Contains("AT-SPG") ? "destroyer" : Ut.Throw<string>(new Exception("Unknown tank class")),
                };
            });

        
            // Built-in
            using (var csv = OpenWriteCsv(Path.Combine(outputPath, "Data-BuiltIn-{0}-001.csv".Fmt(builtInVersion))))
            {
                csv.WriteLine("WOT-BUILTIN-DATA,1,,,");
                foreach (var tank in tanks.OrderBy(tank => tank.Key))
                    csv.WriteLine(ToCsv(new[] { tank.Key, tank.Value.country, tank.Value.tier.ToString(), tank.Value.class_, tank.Value.kind }));
            }
        }

        private static StreamWriter OpenWriteCsv(string filename)
        {
            return new StreamWriter(File.Open(filename, FileMode.Create, FileAccess.Write, FileShare.Read));
        }

        private static string ToCsv(string[] row)
        {
            return string.Join(",", row.Select(f => f.Contains('"') || f.Contains(',') ? ("\"" + f.Replace("\"", "\"\"") + "\"") : f));
        }
    }
}
