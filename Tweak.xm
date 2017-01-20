#import <substrate.h>
#import <Foundation/Foundation.h>

#define Hook(x, y, z) MSHookFunction(MSFindSymbol(NULL, x), (void*)y, (void**)&z)

#define PLIST_PATH @"/var/mobile/Library/Preferences/JellySagaCheats.plist"

inline bool GetPrefBool(NSString *key) {
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] boolValue];
}

inline int GetPrefInt(NSString *key) {
	return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] intValue];
}

int (*old_getLives)(void *self);
int (*old_AddScore)(void*, int, bool);
bool (*old_LevelsUnlocked)(void *self);
bool (*old_AnglerBossIsComplete)(void *self);
bool (*old_AnglerIsComplete)(void *self);
bool (*old_ChocolateNemesIsComplete)(void *self);
bool (*old_JamBossIsComplete)(void *self);
bool (*old_JamIsComplete)(void *self);
bool (*old_PluckNBossIsComplete)(void *self);
bool (*old_PluckNDropIsComplete)(void *self);
bool (*old_StompIsComplete)(void *self);
bool (*old_FPFIsComplete)(void *self);
bool (*old_UnlockBoosters)(void *self);
int (*old_getStars)(void *self);
void (*old_CreateLevel)(void*, void*, int, void*);
int (*old_BoostersModifier)(void *self);
int (*old_MovesModifier)(void *self);

bool isNewGame = true;

static int getLives(void *self) {
	if(GetPrefBool(@"kLives")) {
		return 5;
	} else {
		return old_getLives(self);
	}
}

int AddScore(void *self, int scoreVal, bool unk) {
    bool score = GetPrefBool(@"kscore");
    if (score) {
        int mult = GetPrefInt(@"kscoreval");
        scoreVal *= mult;
    }
    return old_AddScore(self, scoreVal, unk);
}

static bool LevelsUnlocked(void *self) {
	if(GetPrefBool(@"kLevel")) {
		return true;
	} else {
		return old_LevelsUnlocked(self);
	}
}

static bool AnglerBossIsComplete(void *self) {
	if(GetPrefBool(@"kComplete")) {
		return true;
	} else {
		return old_AnglerBossIsComplete(self);
	}
}

static bool AnglerIsComplete(void *self) {
	if(GetPrefBool(@"kComplete")) {
		return true;
	} else {
		return old_AnglerIsComplete(self);
	}
}

static bool ChocolateNemesIsComplete(void *self) {
	if(GetPrefBool(@"kComplete")) {
		return true;
	} else {
		return old_ChocolateNemesIsComplete(self);
	}
}

static bool JamBossIsComplete(void *self) {
	if(GetPrefBool(@"kComplete")) {
		return true;
	} else {
		return old_JamBossIsComplete(self);
	}
}

static bool JamIsComplete(void *self) {
	if(GetPrefBool(@"kComplete")) {
		return true;
	} else {
		return old_JamIsComplete(self);
	}
}

static bool PluckNBossIsComplete(void *self) {
	if(GetPrefBool(@"kComplete")) {
		return true;
	} else {
		return old_PluckNBossIsComplete(self);
	}
}

static bool PluckNDropIsComplete(void *self) {
	if(GetPrefBool(@"kComplete")) {
		return true;
	} else {
		return old_PluckNDropIsComplete(self);
	}
}

static bool StompIsComplete(void *self) {
	if(GetPrefBool(@"kComplete")) {
		return true;
	} else {
		return old_StompIsComplete(self);
	}
}

static bool FPFIsComplete(void *self) {
	if(GetPrefBool(@"kComplete")) {
		return true;
	} else {
		return old_FPFIsComplete(self);
	}
}

static bool UnlockBoosters(void *self) {
	if(GetPrefBool(@"kUnlockBoosters")) {
		return true;
	} else {
		return old_UnlockBoosters(self);
	}
}

static int getStars(void *self) {
	if(GetPrefBool(@"kStars")) {
		return 3;
	} else {
		return old_getStars(self);
	}
}

extern "C" inline int GetColors() {
    int num = GetPrefBool(@"kcolors");
    if(num > 0 && num <= 6) {
        return num;
    }
    return -1;
}

void CreateLevel(void *self, void *unk1, int colors, void *unk2) {
    int num = GetColors();
    if (num != -1) {
        colors = num;
    }
    return old_CreateLevel(self, unk1, colors, unk2);
}

static int BoostersModifier(void *self) {
	if(GetPrefBool(@"Boosters")) {
		int newValue = GetPrefInt(@"Boostersslider");
			return newValue;
	} else {
		return old_BoostersModifier(self);
	}
}

int MovesModifier(void *self) {
    static int defecit = -1;
    static int placeholder = 0x7FFFFFFF;
    if (isNewGame) {
        defecit = -1;
        placeholder = 0x7FFFFFFF;
        isNewGame = false;
    }
    int val = GetPrefInt(@"kMovesslider");
    int valCopy = val;
    val += old_MovesModifier(self);
    if (val < placeholder) {
        defecit++;
        placeholder = val;
    }
    bool moves = GetPrefBool(@"kMoves");
    if (moves) {
        return valCopy - defecit;
    }
    return old_MovesModifier(self);
}

__attribute__((constructor)) void DylibMain() {
	MSHookFunction(MSFindSymbol(NULL, "____ZN18CStritzLifeManager11GetNumLivesEv"),(void*)getLives, (void**)&old_getLives);
	MSHookFunction(MSFindSymbol(NULL, "____ZN13CProgressUtil15IsLevelUnlockedEiPK19CStritzLevelManagerPK15CEpisodeManager"),(void*)LevelsUnlocked, (void**)&old_LevelsUnlocked);
	MSHookFunction(MSFindSymbol(NULL, "____ZNK18AnglerBossGameMode11IsCompletedEv"),(void*)AnglerBossIsComplete, (void**)&old_AnglerBossIsComplete);
	MSHookFunction(MSFindSymbol(NULL, "____ZNK14AnglerGameMode11IsCompletedEv"),(void*)AnglerIsComplete, (void**)&old_AnglerIsComplete);
	MSHookFunction(MSFindSymbol(NULL, "____ZNK25CChocolateNemesisGameMode11IsCompletedEv"),(void*)ChocolateNemesIsComplete, (void**)&old_ChocolateNemesIsComplete);
	MSHookFunction(MSFindSymbol(NULL, "____ZNK11JamBossMode11IsCompletedEv"),(void*)JamBossIsComplete, (void**)&old_JamBossIsComplete);
	MSHookFunction(MSFindSymbol(NULL, "____ZNK11JamGameMode11IsCompletedEv"),(void*)JamIsComplete, (void**)&old_JamIsComplete);
	MSHookFunction(MSFindSymbol(NULL, "____ZNK10PluckNBoss11IsCompletedEv"),(void*)PluckNBossIsComplete, (void**)&old_PluckNBossIsComplete);
	MSHookFunction(MSFindSymbol(NULL, "____ZNK10PluckNDrop11IsCompletedEv"),(void*)PluckNDropIsComplete, (void**)&old_PluckNDropIsComplete);
	MSHookFunction(MSFindSymbol(NULL, "____ZNK9StompMode11IsCompletedEv"),(void*)StompIsComplete, (void**)&old_StompIsComplete);
	MSHookFunction(MSFindSymbol(NULL, "____ZNK7FPFMode11IsCompletedEv"),(void*)FPFIsComplete, (void**)&old_FPFIsComplete);
        MSHookFunction(MSFindSymbol(NULL, "____ZN13CJuegoManager17OnBoosterUnlockedERKN5Juego13AppBoosterDtoE"),(void*)UnlockBoosters, (void**)&old_UnlockBoosters);
        MSHookFunction(MSFindSymbol(NULL, "____ZNK5Juego15AppStarLevelDto8GetStarsEv"),(void*)getStars, (void**)&old_getStars);
	MSHookFunction(MSFindSymbol(NULL, "____ZN14JamGridBuilder8GetColorEv"),(void*)CreateLevel, (void**)&old_CreateLevel);
        MSHookFunction(MSFindSymbol(NULL, "____ZNK5Juego19AppBoosterAmountDto9GetAmountEv"),(void*)BoostersModifier, (void**)&old_BoostersModifier);
	MSHookFunction(MSFindSymbol(NULL, "____ZNK19GameRoundStatistics15GetNumMovesLeftEv"),(void*)MovesModifier, (void**)&old_MovesModifier);
	MSHookFunction(MSFindSymbol(NULL, "____ZN15CScoreMergeArea8AddScoreEi7CColorf"),(void*)AddScore, (void**)&old_AddScore);

}
