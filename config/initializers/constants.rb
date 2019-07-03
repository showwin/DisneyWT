# 各パークの文字列
TDL_STRING = 'tdl'
TDS_STRING = 'tds'
SDL_STRING = 'sdl'
HDL_STRING = 'hdl'

# 表示するアトラクション
TDL_ATTRACTIONS = %w(4 2 3 10 8 9 12 24 21 23 22 20 18 14 17 15 19 28 25 31 32 33 34 37)
TDS_ATTRACTIONS = %w(46 49 62 39 65 51 47 52 43 44 53 50 42 61 48 41 58 57 56 59 60 45 55 54 40)
SDL_ATTRACTIONS = %w(attRoaringRapids attSoaringOverHorizon attAliceWonderlandMaze attHunnyPotSpin attAdventuresWinniePooh attOnceUponTimeAdventure attPeterPansFlight attSevenDwarfsMineTrain attVoyageToCrystalGrotto attDumboFlyingElephant attFantasiaCarousel attBuzzLightyearPlanetRescue attJetPacks attStitchEncounter attTronLightcyclePowerRun attExplorerCanoes attPiratesOfCaribbean attShipwreckShore attSirensRevenge)
HDL_ATTRACTIONS = %w(attJungleRiverCruise attTarzansTreehouse attRafttoTarzansTreehouse attBigGrizzlyMountainRunawayMineCars attRCRacer attSlinkyDogSpin attToySoldierParachuteDrop attOrbitron attStarWarsCommandPost attHyperspaceMountain attBuzzLightyearAstroBlasters attitsasmallworld attTheManyAdventuresofWinniethePooh attCinderellaCarousel attFantasyGardens attFairyTaleForest attMadHatterTeaCups attMickeysPhilharMagic attDumbotheFlyingElephant attMysticManor attAnimationAcademy attArtofAnimation attMainStreetVehicles attHongKongDisneylandRailroadMainStreetStation)

# カレンダーの混雑指数に使うアトラクション
TDL_MAIN_ATTRACTIONS = %w(4 2 3 10 12 24 21 18 14 17 15 19 31 32 33 34 37)
TDS_MAIN_ATTRACTIONS = %w(62 39 65 43 44 53 42 61 58 57 56 59 60 45 55 54 40)
SDL_MAIN_ATTRACTIONS = %w(attTronLightcyclePowerRun attRoaringRapids attPeterPansFlight attSevenDwarfsMineTrain attAdventuresWinniePooh attVoyageToCrystalGrotto attPiratesOfCaribbean attBuzzLightyearPlanetRescue attJetPacks attStitchEncounter attSoaringOverHorizon)
HDL_MAIN_ATTRACTIONS = %w(attHongKongDisneylandRailroadMainStreetStation attTheManyAdventuresofWinniethePooh attDumbotheFlyingElephant attitsasmallworld attMickeysPhilharMagic attHyperspaceMountain attBuzzLightyearAstroBlasters attJungleRiverCruise attRCRacer attSlinkyDogSpin attToySoldierParachuteDrop attBigGrizzlyMountainRunawayMineCars attMysticManor)

# カレンダーの混雑指数
CALENDAR_BUSY0 = 0
CALENDAR_BUSY1 = 15
CALENDAR_BUSY2 = 25
CALENDAR_BUSY3 = 35
CALENDAR_BUSY4 = 40
CALENDAR_BUSY5 = 50
CALENDAR_BUSY6 = 60
CALENDAR_BUSY7 = 70

# 待ち時間の混雑状況
WAITTIME_BUSY0 = 0
WAITTIME_BUSY1 = 10
WAITTIME_BUSY2 = 20
WAITTIME_BUSY3 = 30
WAITTIME_BUSY4 = 60
WAITTIME_BUSY5 = 90
WAITTIME_BUSY6 = 120
WAITTIME_BUSY7 = 170

# Redis のキャッシュ保存時間
SHORT_EXPIRE_SECONDS = 60 * 60 # 1 hour
LONG_EXPIRE_SECONDS = 60 * 60 * 24 * 30 # 1 month
