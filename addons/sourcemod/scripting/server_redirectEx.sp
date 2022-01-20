#include "sdktools"
#include "dhooks"
#include "glib/memutils"

#include "server_redirect/net.sp"
#include "server_redirect/redirect.sp"

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	CreateNative("RedirectClient", RedirectClient_Native);
	RegPluginLibrary("server_redirect");
}

public Plugin myinfo = 
{
	name = "Server redirect",
	author = "GAMMA CASE, Rostu",
	description = "Allows to connect to other servers.",
	version = "1.1",
	url = "https://steamcommunity.com/id/_GAMMACASE_/ | Rostu#7917"
};
public void OnPluginStart()
{
	gShouldReconnect = new StringMap();

	GameData gd = new GameData("server_redirect.games");
	ASSERT_MSG(gd, "Can't open \"server_redirect.games.txt\" gamedata file.");

	InitNet(gd);
	SetupSDKCalls(gd);
	SetupDhooks(gd);

	delete gd;
}