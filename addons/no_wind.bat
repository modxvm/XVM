@echo off

rem Disable wind
rem Run from res_mods\0.7.x

rem Отключить ветер
rem Запускать из res_mods\0.7.x

if not exist system\data mkdir system\data

echo NumWindMatricesAndLeafAngles 0 0 > system\data\speedwind.ini
echo WindResponseAndLimit 0 0 >> system\data\speedwind.ini
echo MaxBendAngle 0 >> system\data\speedwind.ini
echo BranchExponent 0 >> system\data\speedwind.ini
echo LeafExponent 0 >> system\data\speedwind.ini
echo GustStrengthMinMax 0 0 >> system\data\speedwind.ini
echo GustDurationMinMax 0 0 >> system\data\speedwind.ini
echo GustFrequency 0 >> system\data\speedwind.ini
echo BranchOscillationX_LaLsHaHs 0 0 0 0 >> system\data\speedwind.ini
echo BranchOscillationY_LaLsHaHs 0 0 0 0 >> system\data\speedwind.ini
echo LeafRocking_LaLsHaHs 0 0 0 0 >> system\data\speedwind.ini
echo LeafRustling_LaLsHaHs 0 0 0 0 >> system\data\speedwind.ini
