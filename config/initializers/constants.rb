# 各パークの文字列
TDL_STRING = 'tdl'
TDS_STRING = 'tds'
SDL_STRING = 'sdl'
HDL_STRING = 'hdl'

# 表示するアトラクション
TDL_ATTRACTIONS = %w(al_western al_carib al_jungle wl_mountain wl_gallery wl_country wl_mark cc_splash fl_pooh fl_haunted fl_alice fl_small fl_castle fl_cinderella fl_pinocchio fl_peter fl_philhar fl_snow fl_dumbo tt_gadget tt_goofy tt_rabbit tl_tours tl_mountain tl_buzz tl_monster tl_grand tl_jets stitch)
TDS_ATTRACTIONS = %w(mh_transit mh_fortress mh_gondolas aw_tot aw_toy aw_turtle aw_railway aw_transit aw_big mi_center mi_20000 pd_aqua pd_railway ld_indiana ld_raging ld_transit ml_theater ml_jelly ml_scuttle ml_flounder ml_balloon ml_pool ac_magic ac_caravan ac_sindbad ac_jasmine)
SDL_ATTRACTIONS = %w(attRoaringRapids attSoaringOverHorizon attAliceWonderlandMaze attHunnyPotSpin attAdventuresWinniePooh attOnceUponTimeAdventure attPeterPansFlight attSevenDwarfsMineTrain attVoyageToCrystalGrotto attDumboFlyingElephant attFantasiaCarousel attBuzzLightyearPlanetRescue attJetPacks attStitchEncounter attTronLightcyclePowerRun attExplorerCanoes attPiratesOfCaribbean attShipwreckShore attSirensRevenge)
HDL_ATTRACTIONS = %w(attJungleRiverCruise attTarzansTreehouse attRafttoTarzansTreehouse attBigGrizzlyMountainRunawayMineCars attRCRacer attSlinkyDogSpin attToySoldierParachuteDrop attOrbitron attStarWarsCommandPost attHyperspaceMountain attBuzzLightyearAstroBlasters attitsasmallworld attTheManyAdventuresofWinniethePooh attCinderellaCarousel attFantasyGardens attFairyTaleForest attMadHatterTeaCups attMickeysPhilharMagic attDumbotheFlyingElephant attMysticManor attAnimationAcademy attArtofAnimation attMainStreetVehicles attHongKongDisneylandRailroadMainStreetStation)

# カレンダーの混雑指数に使うアトラクション
TDL_MAIN_ATTRACTIONS = %w(al_western al_carib al_jungle wl_mountain cc_splash fl_pooh fl_haunted fl_pinocchio fl_peter fl_philhar fl_snow fl_dumbo tl_tours tl_mountain tl_buzz tl_monster tl_grand tl_jets stitch)
TDS_MAIN_ATTRACTIONS = %w(aw_tot aw_toy aw_turtle mi_center mi_20000 pd_aqua d_indiana ld_raging ml_jelly ml_scuttle ml_flounder ml_balloon ml_pool ac_magic ac_caravan ac_sindbad ac_jasmine)
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
