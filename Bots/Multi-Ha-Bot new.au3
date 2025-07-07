; blue fetid -1899, 109
;~ -6617, 2345 burial Red
;~ -3245, 6028 burial blue
;~ -3704, 1643 ANTECHAMBER BLUE


#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GuiEdit.au3>
#include "GWA2.au3"

Opt("GUIOnEventMode", 1)

#Region *Declarations*
; ---------------------
Global $Iam = 0
Global $Iamblue = 1
Global $Iamred = 2
;---------------------
Global $HA = 330
Global $uw = 84
Global $fetid = 593
Global $BurialMounds = 80
Global $UnholyTemples = 79
Global $ForgottenShrines = 596
Global $GoldenGates = 126
Global $Courtyard = 78
Global $Antechamber = 598
Global $Vault = 83
Global $HoH = 75
; ---------------------
Global $IamwonUW
Global $Iamwonfetid
Global $IamwonBurialMounds
Global $IamwonUnholyTemples
Global $IamwonForgottenShrines
Global $IamwonGoldenGates
Global $IamwonCourtyard
; ---------------------
Global $Fameup
Global $SaveFame
;----------------------
Global $LastBag = 3
Global $OffSet = 900
Global $gwpid
; ---------------------
Global $mZaishen
Global $mUnderworld
Global $mFetidRiver
Global $mBurialMounds
Global $mUnholyTemples
Global $mForgottenShrines
Global $mGoldenGates
Global $mCourtyard
Global $mAntechamber
Global $mHallofHero

;-----------------------
Global $intStarted = -1
Global $Runs = 0
Global $lblWins = 0
Global $Zk = 0
Global $iTotalBalthazar = 0
Global $iMaxTotalBalthazar = 0
Global $MID_Zkey = 28517
Global $MID_Hero_Boxes = 36666
Global $BalthazarForVal = "Zaishen Keys"
Global $distance = GetDistance(GetNearestEnemyToAgent(-2))
Global $oStats_Fame = GetHeroTitle()
Global $i = 1
Global $Positionwindow = False
Global $BoolRun = False
Global $BoolInit = False
Global $LogFile = FileOpen("ChestLog.txt", 2)
Global $Rendering = True

Global $ChatStuckTimer = TimerInit()
Global $permasf = 0
Global $usealchol = 0
Global $WeAreDead = 0
Global $Error = 0
Global Enum $INSTANCETYPE_OUTPOST, $INSTANCETYPE_EXPLORABLE, $INSTANCETYPE_LOADING
Global Enum $BAG_Backpack = 1, $BAG_BeltPouch, $BAG_Bag1, $BAG_Bag2, $BAG_EquipmentPack, $BAG_UnclaimedItems = 7, $BAG_Storage1, $BAG_Storage2, _
		$BAG_Storage3, $BAG_Storage4, $BAG_Storage5, $BAG_Storage6, $BAG_Storage7, $BAG_Storage8, $BAG_StorageAnniversary
;----------------------------------------------------
#EndRegion Declarations

#Region GUI
GUICreate("Multi-Ha-Bot by Teqatle", 354, 234)
GUISetFont(-1, 9, 400, 0, "Arial")
GUICtrlCreateGroup("", 8, 0, 121, 170)

GUICtrlCreateLabel("Runs:", 16, 60, 55, 18)
GUICtrlSetFont(-1, 9, 500, 0)
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlCreateLabel("Fame:", 16, 76, 55, 18)
GUICtrlSetFont(-1, 9, 500, 0)
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlCreateLabel("Up:", 16, 92, 55, 18)
GUICtrlSetFont(-1, 9, 500, 0)
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlCreateLabel("Zk uped:", 16, 108, 55, 18)
GUICtrlSetFont(-1, 9, 500, 0)
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlCreateLabel("Zkeys:", 16, 124, 55, 18)
GUICtrlSetFont(-1, 9, 500, 0)
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlCreateLabel("Boxes:", 16, 140, 55, 18)
GUICtrlSetFont(-1, 9, 500, 0)
GUICtrlSetColor(-1, 0x0000FF)
Global $Nowinmap = GUICtrlCreateLabel("now in map", 10, 176, 120, 18, BitOR($SS_CENTER, $SS_CENTERIMAGE))
 GUICtrlSetFont(-1, 10, 700, 0)
  Global $Myboxesinbag = GUICtrlCreateLabel("0", 72, 140, 51, 18, BitOR($SS_CENTER, $SS_CENTERIMAGE))
 GUICtrlSetFont(-1, 9, 500, 0)
  GUICtrlSetColor(-1, 0x0000FF)
Global $MyZKeysinbag = GUICtrlCreateLabel("0", 72, 124, 51, 18, BitOR($SS_CENTER, $SS_CENTERIMAGE))
 GUICtrlSetFont(-1, 9, 500, 0)
  GUICtrlSetColor(-1, 0x0000FF)
Global $lblZk = GUICtrlCreateLabel("0", 72, 108, 51, 18, BitOR($SS_CENTER, $SS_CENTERIMAGE))
 GUICtrlSetFont(-1, 9, 500, 0)
  GUICtrlSetColor(-1, 0x0000FF)
Global $lblWins = GUICtrlCreateLabel("0", 62, 92, 51, 18, BitOR($SS_CENTER, $SS_CENTERIMAGE))
 GUICtrlSetFont(-1, 9, 500, 0)
  GUICtrlSetColor(-1, 0x0000FF)
    GUICtrlCreateLabel("/300", 102, 92, 25, 18)
    GUICtrlSetFont(-1, 9, 500, 0)
    GUICtrlSetColor(-1, 0x0000FF)
Global $lblfame = GUICtrlCreateLabel("0", 72, 76, 51, 18, BitOR($SS_CENTER, $SS_CENTERIMAGE))
 GUICtrlSetFont(-1, 9, 500, 0)
  GUICtrlSetColor(-1, 0x0000FF)
Global $lblruns = GUICtrlCreateLabel("0", 72, 60, 51, 18, BitOR($SS_CENTER, $SS_CENTERIMAGE))
 GUICtrlSetFont(-1, 9, 500, 0)
  GUICtrlSetColor(-1, 0x0000FF)

GUICtrlCreateGroup("", -99, -99, 1, 1)

Global $Console = GUICtrlCreateEdit("", 136, 0, 209, 120, BitOR(0x0040, 0x00200000, 0x00800000, 0x0800))
GUICtrlSetFont(-1, 9, 400, 0, "Arial")
GUICtrlSetColor(-1, 0x00FFFF)
GUICtrlSetBkColor(-1, 0x000000)
GUICtrlSetCursor(-1, 5)

GUICtrlCreateGroup("", 8, 190, 121, 33)
GUICtrlSetState(-1, $GUI_CHECKED)
Global $cbxHideGW = GUICtrlCreateCheckbox("Disable Graphics", 24, 200, 98, 17)
GUICtrlSetOnEvent($cbxHideGW, "Init")
Global $pause = GUICtrlCreateCheckbox("Pause", 70, 32, 50, 25)
GUICtrlSetOnEvent($pause, "Pause")
GUICtrlCreateGroup("", -99, -99, 1, 1)

GUICtrlCreateGroup("Was on maps", 136, 130, 209, 93, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
GUICtrlCreateLabel("Underworld:", 140, 145, 70, 18)
GUICtrlCreateLabel("Fetid River:", 140, 160, 70, 18)
GUICtrlCreateLabel("Burial Mounds:", 140, 175, 70, 18)
GUICtrlCreateLabel("Unholy Temples:", 140, 190, 100, 18)
GUICtrlCreateLabel("Forgotten Shrines:", 140, 205, 100, 18)
GUICtrlCreateLabel("Golden Gates:", 255, 150, 70, 18)
GUICtrlCreateLabel("Courtyard:", 255, 165, 70, 18)
GUICtrlCreateLabel("Antechamber:", 255, 180, 70, 18)
GUICtrlCreateLabel("Hall of Hero:", 255, 195, 70, 18)
Global $mUnderworld = GUICtrlCreateLabel("0", 225, 145, 30, 18, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetColor(-1, 0x00FF00)
Global $mFetidRiver = GUICtrlCreateLabel("0", 225, 160, 30, 18, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetColor(-1, 0x00FF00)
Global $mBurialMounds = GUICtrlCreateLabel("0", 225, 175, 30, 18, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetColor(-1, 0x00FF00)
Global $mUnholyTemples = GUICtrlCreateLabel("0", 225, 190, 30, 18, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetColor(-1, 0xFF0000)
Global $mForgottenShrines = GUICtrlCreateLabel("0", 225, 205, 30, 18, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetColor(-1, 0xFF0000)
Global $mGoldenGates = GUICtrlCreateLabel("0", 330, 150, 10, 18, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetColor(-1, 0xFF0000)
Global $mCourtyard = GUICtrlCreateLabel("0", 330, 165, 10, 18, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetColor(-1, 0xFF0000)
Global $mAntechamber = GUICtrlCreateLabel("0", 330, 180, 10, 18, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetColor(-1, 0xFF0000)
Global $mHallofHero = GUICtrlCreateLabel("0", 330, 195, 10, 18, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetColor(-1, 0xFF0000)

Global $GUIStart = GUICtrlCreateButton("START", 8, 32, 60, 25)
GUICtrlSetFont(-1, 9, 700, 0, "Arial")
Global $GUIName = GUICtrlCreateCombo("", 8, 8, 121, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, GetLoggedCharNames())

GUISetState(@SW_SHOW)
GUISetOnEvent($GUI_EVENT_CLOSE, "CloseHandler")
GUICtrlSetOnEvent($GUIStart, "Init")

#EndRegion GUI

SetEvent("SkillActivate", "", "", "", "")

While 1
	Sleep(100)
	If $BoolRun Then
		Mainloop()
	EndIf
WEnd

While 1
	Sleep(100)
	If $boolRun Then
		$WeAreDead = 0
		Start()
		If $WeAreDead = 0 Then Zaishen()
		If $WeAreDead = 0 Then UW()
		If Not $boolRun Then
			Out("Bot was paused")
		EndIf
	EndIf
WEnd

Func Init()
	Switch (@GUI_CtrlId)
		Case $GUIStart
			If $BoolRun = False Then
				GUICtrlSetData($GUIStart, "...")
				GUICtrlSetState($GUIStart, $GUI_Enable)
				GUICtrlSetState($GUIName, $GUI_Disable)
				Initialize(GUICtrlRead($GUIName), True, True)
				GUICtrlSetData($GUIStart, "Don't bother, not working")
				$BoolRun = True
				Famesave()
				Out("Bot started!")
			Else
				GUICtrlSetData($GUIStart, "You had to click it -_-")
				GUICtrlSetState($GUIStart, $GUI_DISABLE)
				$BoolRun = False
			EndIf
		Case $cbxHideGW
			If GUICtrlRead($cbxHideGW) = 1 Then
				DisableRendering()
				WinSetState(GetWindowHandle(), "", @SW_HIDE)
			Else
				EnableRendering()
				WinSetState(GetWindowHandle(), "", @SW_SHOW)
			EndIf
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
EndFunc   ;==>Init

Func Mainloop()
	If GetMapLoading() == 2 Then Disconnected()
	If GetMapLoading() == $INSTANCETYPE_OUTPOST Then Start()
	If GetMapLoading() == $INSTANCETYPE_EXPLORABLE And GetMapID() == $HA Then Zaishen()
	If GetMapID() == $uw Then UW()
	If GetMapID() == $fetid Then Fetid()
	If GetMapID() == $BurialMounds Then BurialMounds()
	If GetMapID() == $UnholyTemples Then UnholyTemples()
	If GetMapID() == $ForgottenShrines Then ForgottenShrines()
	If GetMapID() == $GoldenGates Then GoldenGates()
	If GetMapID() == $Courtyard Then Courtyard()
	If GetMapID() == $Antechamber Then  Antechamber()
	If GetMapID() == $Vault Then Vault()
	If GetMapID() == $HoH Then HoH()
EndFunc   ;==>Mainloop

;~ #Region MainLoop
Func Start()
	If GetMapLoading() == 2 Then Disconnected()
	If GetMapLoading() == $INSTANCETYPE_OUTPOST And GetMapID() == $HA  Then
	If GUICtrlRead($pause) = 1 Then
		out("Bot paused")
		sleep(2000)
	Else
	GUICtrlSetData($Nowinmap, "Out post HA")
	GUICtrlSetColor($Nowinmap, 0x26FF00)
	titlecheck()
	Zkeys()
	GUICtrlSetData($Myboxesinbag, CountItemInBagsByModelID($MID_Hero_Boxes))
	GUICtrlSetData($MyZKeysinbag, CountItemInBagsByModelID($MID_Zkey))
	If GetEffectTimeRemaining(2546) > 0 Then
		Out("Wait for Dishonorable.")
		Sleep(GetEffectTimeRemaining(2546) + 2000) ; Dishonorable
	EndIf
	Do
		If GetMapID() <> $HA Then
			Out("Travel To outpost")
;~ 			TravelTo($HA)
			WaitMapLoading()
		EndIf
	Until GetMapID() = $HA
	GUICtrlSetData($lblruns, GUICtrlRead($lblruns) + 1)
    $Runs += 1
	Out("Starting Run # " & $Runs)
	Out("Add henchs")
		AddNpc(11)
        AddNpc(12)
		AddNpc(13)
		AddNpc(14)
		AddNpc(6)
		AddNpc(7)
		AddNpc(8)
        EnterChallenge()
		WaitMapLoading()
		EndIf
	EndIf
EndFunc   ;==>Start


Func Zaishen()
	GUICtrlSetData($Nowinmap, "Zaishen Map")
	GUICtrlSetColor($Nowinmap, 0x00F3FF)
	While GetMapLoading() == $INSTANCETYPE_EXPLORABLE And GetMapID() == $HA
		If GetMapLoading() == 2 Then Disconnected()
		If GUICtrlRead($pause) = 1 Then
		    out("Bot paused")
		    sleep(2000)
		Else
		    CheckIsTeamWiped()
		    $agent = GetNearestEnemyToAgent()
            $distance = getdistance($agent, -2)
            $besttarget = GetBestTarget()
		    $Elementalist = GetAgentByName("Zaishen Elementalist")
		    If $distance > 1300 And $distance < 8000  Then
			    If GetMapLoading() == $INSTANCETYPE_EXPLORABLE And GetMapID() == $HA Then
				    MoveTo(9012, 1211)
				    Attack($agent)
			        Out("Looking enemy")
			        CallTarget($agent)
			        ChangeTarget($agent)
			        sleep(1000)
			    EndIf
		    EndIf
		    If $distance < 2000 Then
			    If GetMapLoading() == $INSTANCETYPE_EXPLORABLE And GetMapID() == $HA Then
				    killenemy()
		        EndIf
		    EndIf
            If getnearestenemytoagent() = 0 Then
			    If GetMapLoading() == $INSTANCETYPE_EXPLORABLE And GetMapID() == $HA Then
			        Out("Waiting uw loading:")
				    WaitMapLoading()
			    EndIf
            EndIf
		    If GetMapLoading() == $INSTANCETYPE_OUTPOST And GetMapID() == $HA  Then
		        Return MainLoop()
		    EndIf
		EndIf
    WEnd
EndFunc  ;==>Zaishen


Func UW()
	GUICtrlSetData($Nowinmap, "Underworld")
	GUICtrlSetColor($Nowinmap, 0xFFE200)
	$IamwonUW = getherotitle()
	SkipCinematic()
 While GetMapLoading() == $INSTANCETYPE_EXPLORABLE And GetMapID() == $uw
	If GetMapLoading() == 2 Then Disconnected()
	$agent = GetNearestEnemyToAgent()
	$distance = getdistance($agent, -2)
	$besttarget = GetBestTarget()
	CheckIsTeamWiped()
    if $IamwonUW == getherotitle() Then
	    If getnearestenemytoagent() = 0 Then
		    If GetIsLiving(GetMyID()) Then
		        If GetMapID() == $uw Then
			        Out("fight in UW")
		            sleep(1000)
					Move (67, -3341)
		        EndIf
		    EndIf
	    EndIf
	EndIf
	if $IamwonUW == getherotitle() Then
	    if $distance > 1250 And $distance < 8000  Then
		    If GetIsLiving(GetMyID()) Then
			    If GetMapID() == $uw Then
				    Attack($agent)
		            sleep(1500)
			    EndIf
		    EndIf
	    EndIf
	EndIf
	if $IamwonUW == getherotitle() Then
	    If $distance < 1250 Then
		    If GetIsLiving(GetMyID()) Then
		        If GetMapID() == $uw Then
					killenemy()
				EndIf
		    EndIf
	    EndIf
	EndIf
	if $IamwonUW < getherotitle() Then
		If GetMapID() == $uw Then
		    Out("won in UW")
			Fameup()
;~ 		    TravelTo($HA)
			Sleep(5000)
		    WaitMapLoading()
		EndIf
	EndIf
 WEnd
 GUICtrlSetData($mUnderworld, GUICtrlRead($mUnderworld) + 1)
EndFunc

Func Fetid()
	GUICtrlSetData($Nowinmap, "Fetid River")
	GUICtrlSetColor($Nowinmap, 0xFFC400)
	SkipCinematic()
	titlecheck()
	$Iamwonfetid = getherotitle()
	While GetMapLoading() == $INSTANCETYPE_EXPLORABLE And GetMapID() == $fetid
		If GetMapLoading() == 2 Then Disconnected()
		$agent = GetNearestEnemyToAgent()
        $distance = getdistance($agent, -2)
        $besttarget = GetBestTarget()
		CheckIsTeamWiped()
		If $Iamwonfetid == getherotitle() Then
		    if $distance > 1250 And $distance < 8000  Then
			    If GetIsLiving(GetMyID()) Then
		            If GetMapID() == $fetid Then
			            Out("fight in Fetid")
			            Attack($agent)
			            sleep(1500)
	                EndIf
		        EndIf
	        EndIf
		EndIf
		If $Iamwonfetid == getherotitle() Then
		    If $distance < 1250 Then
			    If GetIsLiving(GetMyID()) Then
				    If GetMapID() == $fetid Then
					    Out("killing in Fetid")
				        killenemy()
		            EndIf
		        EndIf
	        EndIf
		EndIf
		If $Iamwonfetid < getherotitle() Then
			If GetIsLiving(GetMyID()) Then
				If GetMapID() == $fetid Then
		            Out("won in Fetid")
					Fameup()
;~ 		            TravelTo($HA)
                    Sleep(5000)
		            WaitMapLoading()
			    EndIf
		    EndIf
	    EndIf
	WEnd
	GUICtrlSetData($mFetidRiver, GUICtrlRead($mFetidRiver) + 1)
EndFunc

Func BurialMounds()
	GUICtrlSetData($Nowinmap, "Burial Mounds")
	GUICtrlSetColor($Nowinmap, 0xFFAB00)
	SkipCinematic()
	titlecheck()
	$IamwonBurialMounds = getherotitle()
	While GetMapLoading() == $INSTANCETYPE_EXPLORABLE And GetMapID() == $BurialMounds
		If GetMapLoading() == 2 Then Disconnected()
			$agent = GetNearestEnemyToAgent()
            $distance = getdistance($agent, -2)
            $besttarget = GetBestTarget()
		    CheckIsTeamWiped()
		If $IamwonBurialMounds == getherotitle() Then
			If getnearestenemytoagent() = 0 Then
				If GetIsLiving(GetMyID()) Then
					If GetMapID() == $BurialMounds Then
				        Out("lf enemes")
						sleep(1000)
		                Move (-4214, 3251)
					EndIf
				EndIf
	        EndIf
		EndIf
		If $IamwonBurialMounds == getherotitle() Then
			if $distance > 1250 And $distance < 10000  Then
			    If GetIsLiving(GetMyID()) Then
		            If GetMapID() == $BurialMounds Then
			            Out("fight in Byrial")
			            Attack($agent)
			            sleep(1500)
	                EndIf
		        EndIf
			EndIf
		EndIf
		If $IamwonBurialMounds == getherotitle() Then
		    If $distance < 1250 Then
			    If GetIsLiving(GetMyID()) Then
				    If GetMapID() == $BurialMounds Then
					    Out("Killing in Byrial")
				        killenemy()
		            EndIf
		        EndIf
	        EndIf
		EndIf
		If $IamwonBurialMounds < getherotitle() Then
			If GetIsLiving(GetMyID()) Then
				If GetMapID() == $BurialMounds Then
		            Out("won in Burial")
					Fameup()
                    Sleep(5000)
		            WaitMapLoading()
			    EndIf
		    EndIf
	    EndIf
	WEnd
	GUICtrlSetData($mBurialMounds, GUICtrlRead($mBurialMounds) + 1)
EndFunc

Func UnholyTemples()
	GUICtrlSetData($Nowinmap, "Unholy Temples")
	GUICtrlSetColor($Nowinmap, 0xFF9E00)
	SkipCinematic()
	titlecheck()
	$IamwonUnholyTemples = getherotitle()
	Checkcolor()
	While GetMapLoading() == $INSTANCETYPE_EXPLORABLE And GetMapID() == $UnholyTemples
		If GetMapLoading() == 2 Then Disconnected()
		If $Iam = $Iamblue Then
			UnholyBlue()
			if $IamwonUnholyTemples < getherotitle() Then
				If GetIsLiving(GetMyID()) Then
					If GetMapID() == $UnholyTemples Then
		                Out("won in Unholy")
                        Sleep(5000)
		                WaitMapLoading()
				    EndIf
		        EndIf
	        EndIf
		EndIf
        If $Iam = $Iamred Then
			UnholyRed()
			if $IamwonUnholyTemples < getherotitle() Then
				If GetIsLiving(GetMyID()) Then
					If GetMapID() == $UnholyTemples Then
		                Out("won in Unholy")
						Fameup()
						Sleep(5000)
		                WaitMapLoading()
				    EndIf
		        EndIf
	        EndIf
		EndIf
	WEnd
	GUICtrlSetData($mUnholyTemples, GUICtrlRead($mUnholyTemples) + 1)
EndFunc

Func UnholyBlue()
	If GetMapLoading() == 2 Then Disconnected()
	$Ghostly1 = GetNearestNPCToCoords(1883, 2328)
	$IamwonUnholyTemples = getherotitle()
			CheckIsTeamWiped()
			$NearestNPS = GetNearestAgentToAgent()
			if $IamwonUnholyTemples == getherotitle()  Then
		        If GetIsLiving(GetMyID()) Then
					If GetMapID() == $UnholyTemples Then
						Out("run blue relicks")
					    MoveTo (-667, -331)
					EndIf
				EndIf
			EndIf
			if $IamwonUnholyTemples == getherotitle() And CheckArea(-667, -331) Then
				If GetIsLiving(GetMyID()) Then
					If GetMapID() == $UnholyTemples Then
						MoveTo (-2233, -2047)
					EndIf
				EndIf
			EndIf
			if $IamwonUnholyTemples == getherotitle() And CheckArea(-2233, -2047) Then
				If GetIsLiving(GetMyID()) Then
					If GetMapID() == $UnholyTemples Then
						PickUpLoot()
					    Sleep(1000)
						MoveTo (-667, -331)
					EndIf
				EndIf
			EndIf
			if $IamwonUnholyTemples == getherotitle() And CheckArea(-667, -331) Then
				If GetIsLiving(GetMyID()) Then
					If GetMapID() == $UnholyTemples Then
						MoveTo (1549, 1519)
						Sleep(2000)
						GoToNPC($Ghostly1)
						Sleep(500)
						GoToNPC($Ghostly1)
						CommandAll(-3107, -2996)
					EndIf
				EndIf
			EndIf

EndFunc

Func UnholyRed()
	If GetMapLoading() == 2 Then Disconnected()
	$Ghostly2 = GetNearestNPCToCoords(-3052, -3041)
	$IamwonUnholyTemples = getherotitle()
			CheckIsTeamWiped()
			$NearestNPS = GetNearestAgentToAgent()
			if $IamwonUnholyTemples == getherotitle()  Then
		        If GetIsLiving(GetMyID()) Then
					If GetMapID() == $UnholyTemples Then
						Out("run red relicks")
					    MoveTo (-667, -331)
					EndIf
				EndIf
			EndIf
			if $IamwonUnholyTemples == getherotitle() And CheckArea(-667, -331) Then
				If GetIsLiving(GetMyID()) Then
					If GetMapID() == $UnholyTemples Then
						MoveTo (868, 1666)
					EndIf
				EndIf
			EndIf
			if $IamwonUnholyTemples == getherotitle() And CheckArea(868, 1666) Then
				If GetIsLiving(GetMyID()) Then
					If GetMapID() == $UnholyTemples Then
						PickUpLoot()
					    Sleep(1000)
						MoveTo (-667, -331)
					EndIf
				EndIf
			EndIf
			if $IamwonUnholyTemples == getherotitle() And CheckArea(-667, -331) Then
				If GetIsLiving(GetMyID()) Then
					If GetMapID() == $UnholyTemples Then
						MoveTo (-2855, -1646)
						MoveTo (-3107, -2996)
						Sleep(2000)
						GoToNPC($Ghostly2)
						Sleep(500)
						GoToNPC($Ghostly2)
						CommandAll(1549, 1519)
					EndIf
				EndIf
			EndIf
EndFunc

Func ForgottenShrines()
	GUICtrlSetData($Nowinmap, "Forgotten Shrines")
	SkipCinematic()
	titlecheck()
	$IamwonForgottenShrines = getherotitle()
	$GhostlyBlue = GetNearestNPCToCoords(-1910, -3490)
	$GhostlyRed = GetNearestNPCToCoords(1950, -3435)
	Checkcolor()
	If GetMapLoading() == $INSTANCETYPE_EXPLORABLE And GetMapID() == $ForgottenShrines Then
	    If $Iam == $Iamblue Then
	        GoToNPC($GhostlyBlue)
	        sleep(1000)
		EndIf
	EndIf
	If GetMapLoading() == $INSTANCETYPE_EXPLORABLE And GetMapID() == $ForgottenShrines Then
	    If $Iam == $Iamred Then
	        GoToNPC($GhostlyRed)
	        sleep(1000)
		EndIf
	EndIf
	Global $Startblue = 0
	Global $Startred = 0
	While GetMapLoading() == $INSTANCETYPE_EXPLORABLE And GetMapID() == $ForgottenShrines
		If $Iam == $Iamblue Then
			Out("I am blue")
		    CheckIsTeamWiped()
		    $agent = GetNearestEnemyToAgent()
			$distance = getdistance($agent, -2)
			$besttarget = GetBestTarget()
		    If $Startblue = 0 Then
			    If $IamwonForgottenShrines == getherotitle()  Then
				    If GetIsLiving(GetMyID()) Then
					    If GetMapID() == $ForgottenShrines Then
							CommandAll(-949, 946)
						    Do
							    If GetIsDead(GetMyID()) Then ExitLoop
							    if $IamwonForgottenShrines < getherotitle()  Then ExitLoop
							        Move (-2227, -1405)
							        Sleep(2000)
						    Until CheckArea(-2227, -1405)
					    EndIf
				    EndIf
			    EndIf
		    EndIf
			if $IamwonForgottenShrines == getherotitle() And CheckArea(-2227, -1405) And GetMapID() == $ForgottenShrines Then
				If GetIsLiving(GetMyID()) Then
					sleep(15000)
				    MoveTo (-949, 946)
					$Startblue = 1
				EndIf
			EndIf
			if $IamwonForgottenShrines == getherotitle() And CheckArea(-949, 946) And GetMapID() == $ForgottenShrines Then
				If GetIsLiving(GetMyID()) Then
					sleep(15000)
                    CommandAll(11, 3664)
				    MoveTo (11, 3664)
			    EndIf
			EndIf
			if $IamwonForgottenShrines == getherotitle()  And CheckArea(11, 3664) And GetMapID() == $ForgottenShrines Then
				If GetIsLiving(GetMyID()) Then
					sleep(15000)
				    CommandAll(606, 928)
					MoveTo (606, 928)
			    EndIf
			EndIf
			if $IamwonForgottenShrines == getherotitle()  And CheckArea(606, 928) And GetMapID() == $ForgottenShrines Then
				If GetIsLiving(GetMyID()) Then
				    sleep(15000)
				    CommandAll(2063, -1375)
				    MoveTo (2063, -1375)
				EndIf
			EndIf
			If $Startblue = 1 Then
					If $IamwonForgottenShrines == getherotitle() And GetMapID() == $ForgottenShrines Then sleep(20000)
				    If $IamwonForgottenShrines == getherotitle() And GetMapID() == $ForgottenShrines Then CommandAll(606, 928)
                    If $IamwonForgottenShrines == getherotitle() And GetMapID() == $ForgottenShrines Then sleep(20000)
				    If $IamwonForgottenShrines == getherotitle() And GetMapID() == $ForgottenShrines Then CommandAll(11, 3664)
                    If $IamwonForgottenShrines == getherotitle() And GetMapID() == $ForgottenShrines Then sleep(20000)
				    If $IamwonForgottenShrines == getherotitle() And GetMapID() == $ForgottenShrines Then CommandAll(-949, 946)
                    If $IamwonForgottenShrines == getherotitle() And GetMapID() == $ForgottenShrines Then sleep(20000)
				    If $IamwonForgottenShrines == getherotitle() And GetMapID() == $ForgottenShrines Then CommandAll(2063, -1375)
			EndIf
			if $IamwonForgottenShrines < getherotitle() And GetMapID() == $ForgottenShrines Then
		        If GetIsLiving(GetMyID()) Then
				    If GetMapID() == $ForgottenShrines Then
                        Out("won in FS")
						Sleep(5000)
				        WaitMapLoading()
				    EndIf
				EndIf
			EndIf
		EndIf

		If $Iam == $Iamred Then
			Out("I am red")
		    CheckIsTeamWiped()
		    $agent = GetNearestEnemyToAgent()
			$distance = getdistance($agent, -2)
			$besttarget = GetBestTarget()
            If $Startred = 0 Then
			    If $IamwonForgottenShrines == getherotitle() And GetMapID() == $ForgottenShrines Then
                    If GetIsLiving(GetMyID()) Then
				        CommandAll(606, 928)
				        Do
					        If GetMapID() <> $ForgottenShrines Then ExitLoop
					        If GetIsDead(GetMyID()) Then ExitLoop
					        If $IamwonForgottenShrines < getherotitle()  Then ExitLoop
					            Move (2063, -1375)
					            Sleep(2000)
				        Until CheckArea(2063, -1375)
				    EndIf
			    EndIf
			EndIf
			if $IamwonForgottenShrines == getherotitle() And CheckArea(2063, -1375) And GetMapID() == $ForgottenShrines Then
				If GetIsLiving(GetMyID()) Then
					sleep(15000)
				    MoveTo (606, 928)
                    $Startred = 1
				EndIf
			EndIf
			if $IamwonForgottenShrines == getherotitle() And CheckArea(606, 928) And GetMapID() == $ForgottenShrines Then
				If GetIsLiving(GetMyID()) Then
					sleep(15000)
					CommandAll(11, 3664)
					MoveTo (11, 3664)
				EndIf
			EndIf
			if $IamwonForgottenShrines == getherotitle() And CheckArea(11, 3664) And GetMapID() == $ForgottenShrines Then
				If GetIsLiving(GetMyID()) Then
					sleep(15000)
					CommandAll(-949, 946)
					MoveTo (-949, 946)
			        sleep(15000)
				EndIf
			EndIf
			if $IamwonForgottenShrines == getherotitle() And CheckArea(-949, 946) And GetMapID() == $ForgottenShrines Then
				If GetIsLiving(GetMyID()) Then
					sleep(15000)
				    CommandAll(-2227, -1405)
					MoveTo (-2227, -1405)
				EndIf
			EndIf
			If $Startred = 1 Then
					If $IamwonForgottenShrines == getherotitle() And GetMapID() == $ForgottenShrines Then sleep(20000)
					If $IamwonForgottenShrines == getherotitle() And GetMapID() == $ForgottenShrines Then CommandAll(-949, 946)
					If $IamwonForgottenShrines == getherotitle() And GetMapID() == $ForgottenShrines Then sleep(20000)
					If $IamwonForgottenShrines == getherotitle() And GetMapID() == $ForgottenShrines Then CommandAll(11, 3664)
					If $IamwonForgottenShrines == getherotitle() And GetMapID() == $ForgottenShrines Then sleep(20000)
					If $IamwonForgottenShrines == getherotitle() And GetMapID() == $ForgottenShrines Then CommandAll(606, 928)
					If $IamwonForgottenShrines == getherotitle() And GetMapID() == $ForgottenShrines Then sleep(20000)
					If $IamwonForgottenShrines == getherotitle() And GetMapID() == $ForgottenShrines Then CommandAll(-2227, -1405)
			EndIf
			if $IamwonForgottenShrines < getherotitle() And GetMapID() == $ForgottenShrines Then
				If GetIsDead(GetMyID()) Then ExitLoop
		        If GetIsLiving(GetMyID()) Then
				    If GetMapID() == $ForgottenShrines Then
                        Out("won in FS")
						Fameup()
						Sleep(5000)
				        WaitMapLoading()
				    EndIf
				EndIf
			EndIf
		EndIf
	WEnd
	GUICtrlSetData($mForgottenShrines, GUICtrlRead($mForgottenShrines) + 1)
EndFunc

Func GoldenGates()
	If GetMapLoading() == 2 Then Disconnected()
	GUICtrlSetData($Nowinmap, "Golden Gates")
	GUICtrlSetColor($Nowinmap, 0xFF6600)
	SkipCinematic()
	CancelAll()
	titlecheck()
	$IamwonGoldenGates = getherotitle()
	While GetMapLoading() == $INSTANCETYPE_EXPLORABLE And GetMapID() == $GoldenGates
		If GetMapLoading() == 2 Then Disconnected()
		If GetMapID() <> $GoldenGates Then ExitLoop
		CheckIsTeamWiped()
		    $agent = GetNearestEnemyToAgent()
			$distance = getdistance($agent, -2)
			$besttarget = GetBestTarget()
		If $IamwonGoldenGates == getherotitle() Then
			If getnearestenemytoagent() = 0 Then
                If GetIsDead(GetMyID()) Then ExitLoop
				If GetIsLiving(GetMyID()) Then
					If GetMapID() == $GoldenGates Then
					    Out("lf enemes")
						MoveTo (-308, -950)
						sleep(1000)
					EndIf
				EndIf
	        EndIf
		EndIf
		If $IamwonGoldenGates == getherotitle() Then
			if $distance > 1300 And $distance < 5000  Then
				If GetIsDead(GetMyID()) Then ExitLoop
				If GetIsLiving(GetMyID()) Then
					If GetMapID() == $GoldenGates Then
					    Out("fight in GG")
						GoNPC($agent)
						sleep(500)
						Attack($agent)
						sleep(1500)
					EndIf
				EndIf
	        EndIf
		EndIf
		If $IamwonGoldenGates == getherotitle() Then
		    If $distance < 1300 Then
		        If GetIsDead(GetMyID()) Then ExitLoop
				If GetIsLiving(GetMyID()) Then
					If GetMapID() == $GoldenGates Then
					    killenemy()
					EndIf
				EndIf
			EndIf
		EndIf
		If $IamwonGoldenGates < getherotitle() Then
			If GetIsDead(GetMyID()) Then ExitLoop
			If GetIsLiving(GetMyID()) Then
				If GetMapID() == $GoldenGates Then
					Out("won in GG")
					Fameup()
					Sleep(5000)
					WaitMapLoading()
				EndIf
			EndIf
		EndIf
	WEnd
	GUICtrlSetData($mGoldenGates, GUICtrlRead($mGoldenGates) + 1)
EndFunc

Func Courtyard()
	If GetMapLoading() == 2 Then Disconnected()
	GUICtrlSetData($Nowinmap, "Courtyard")
	GUICtrlSetColor($Nowinmap, 0x3700FF)
	SkipCinematic()
	CommandAll(-75, 325)
	Sleep(2000)
	GoToNPC(GetAgentByName("Ghostly Hero"))
	CancelAll()
	titlecheck()
	$IamwonCourtyard = getherotitle()
	While GetMapLoading() == $INSTANCETYPE_EXPLORABLE And GetMapID() == $Courtyard
		If GetMapLoading() == 2 Then Disconnected()
		If GetMapID() <> $Courtyard Then ExitLoop
		Out("Courtyard")
		CheckIsTeamWiped()
		if $IamwonCourtyard == getherotitle() Then
		    If Not CheckArea(-75, 325) Then
			    If GetIsDead(GetMyID()) Then ExitLoop
			    If GetIsLiving(GetMyID()) Then
				    If GetMapID() == $Courtyard Then
						Out("lf enemes")
					    sleep(1000)
						MoveTo (-75, 325)
				     EndIf
			    EndIf
		    EndIf
	    EndIf
	    if $IamwonCourtyard == getherotitle() Then
		    If $distance < 1300 Then
			    If GetIsDead(GetMyID()) Then ExitLoop
			    If GetIsLiving(GetMyID()) Then
				    If GetMapID() == $Courtyard Then
						killenemy()
					EndIf
			    EndIf
		    EndIf
		EndIf
		if $IamwonCourtyard < getherotitle() Then
			If GetIsDead(GetMyID()) Then ExitLoop
			If GetIsLiving(GetMyID()) Then
				If GetMapID() == $Courtyard Then
			        Out("won in Courtyard")
					Fameup()
					Sleep(5000)
			        WaitMapLoading()
				EndIf
			EndIf
		EndIf
	WEnd
	GUICtrlSetData($mCourtyard, GUICtrlRead($mCourtyard) + 1)
EndFunc

Func Antechamber()
	If GetMapLoading() == 2 Then Disconnected()
	GUICtrlSetData($Nowinmap, "Antechamber")
	GUICtrlSetColor($Nowinmap, 0x3700FF)
	SkipCinematic()
	CancelAll()
	titlecheck()
	$IamwonAntechamber = getherotitle()
	Checkcolor()
While GetMapLoading() == $INSTANCETYPE_EXPLORABLE And GetMapID() == $Antechamber
	If GetMapLoading() == 2 Then Disconnected()
	If $Iam == $Iamblue Then
		If GetMapLoading() == 2 Then Disconnected()
		Out("Antechamber")
		CheckIsTeamWiped()
			if $IamwonAntechamber == getherotitle() Then
				If GetIsLiving(GetMyID()) Then
					If GetMapID() == $Antechamber Then
						CommandAll(-494, 4389)
						Sleep(2000)
						GoToNPC(GetNearestAgentToAgent())
						Do
							If GetMapID() <> $Antechamber Then ExitLoop
						    If GetIsDead(GetMyID()) Then ExitLoop
						    If $IamwonAntechamber < getherotitle()  Then ExitLoop
							Move (-485, 2039)
							Sleep(2000)
						Until CheckArea(-485, 2039)
					EndIf
				EndIf
			EndIf
			If CheckArea(-485, 2039) Then
				if $IamwonAntechamber == getherotitle() Then
				    If GetIsLiving(GetMyID()) Then
					    If GetMapID() == $Antechamber Then
						    sleep(15000)
						    CommandAll(-495, -18)
						    MoveTo (28, 1144)
						    sleep(1000)
						EndIf
					EndIf
				EndIf
			EndIf
			If CheckArea(28, 1144) Then
				If $IamwonAntechamber == getherotitle() Then
				    If GetIsLiving(GetMyID()) Then
						If GetMapID() == $Antechamber Then
						    MoveTo (-495, -18)
			                sleep(5000)
				            CancelAll()
						EndIf
					EndIf
				EndIf
			EndIf
			If CheckArea(-495, -18) Then
				If $IamwonAntechamber == getherotitle() Then
				    If GetIsLiving(GetMyID()) Then
						If GetMapID() == $Antechamber Then
						    MoveTo (237, -9)
				            sleep(1000)
						EndIf
					EndIf
				EndIf
			EndIf
			If CheckArea(237, -9) Then
				If $IamwonAntechamber == getherotitle() Then
				    If GetIsLiving(GetMyID()) Then
						If GetMapID() == $Antechamber Then
						    MoveTo (-494, -2239)
						EndIf
					EndIf
				EndIf
			EndIf
			If CheckArea(-494, -2239) Then
				If $IamwonAntechamber == getherotitle() Then
				    If GetIsLiving(GetMyID()) Then
						If GetMapID() == $Antechamber Then
						    sleep(15000)
				            CommandAll(-467, -4608)
				            sleep(15000)
				            CancelAll()
						EndIf
					EndIf
				EndIf
			EndIf
	    if $IamwonAntechamber < getherotitle() Then
			If GetMapLoading() == 2 Then Disconnected()
			If GetIsDead(GetMyID()) Then ExitLoop
			If GetIsLiving(GetMyID()) Then
				If GetMapID() == $Antechamber Then
                    Out("won in Ante")
					Sleep(5000)
			        WaitMapLoading()
				EndIf
			EndIf
		EndIf
	EndIf
	If $Iam == $Iamred Then
		If GetMapLoading() == 2 Then Disconnected()
		Out("Antechamber")
		CheckIsTeamWiped()
			If $IamwonAntechamber == getherotitle() Then
				If GetIsLiving(GetMyID()) Then
					If GetMapID() == $Antechamber Then
						CommandAll(-467, -4608)
						Sleep(2000)
						GoToNPC(GetNearestAgentToAgent())
						Do
							If GetMapID() <> $Antechamber Then ExitLoop
						    If GetIsDead(GetMyID()) Then ExitLoop
						    If $IamwonAntechamber < getherotitle()  Then ExitLoop
						    Move (-475, -2253)
							Sleep(2000)
						Until CheckArea(-494, -2239)
					EndIf
				EndIf
			EndIf
			If CheckArea(-494, -2239) Then
				If $IamwonAntechamber == getherotitle() Then
				    If GetIsLiving(GetMyID()) Then
					    If GetMapID() == $Antechamber Then
							sleep(15000)
						    MoveTo (-494, -2239)
					    EndIf
				    EndIf
			    EndIf
			EndIf
			If CheckArea(-494, -2239) Then
				If $IamwonAntechamber == getherotitle() Then
				    If GetIsLiving(GetMyID()) Then
					    If GetMapID() == $Antechamber Then
							sleep(15000)
				            CommandAll(-495, -18)
				            MoveTo (-1030, -1250)
				            sleep(1000)
					    EndIf
				    EndIf
			    EndIf
			EndIf
			If CheckArea(-1030, -1250) Then
				If $IamwonAntechamber == getherotitle() Then
				    If GetIsLiving(GetMyID()) Then
					    If GetMapID() == $Antechamber Then
							MoveTo (-495, -18)
				            sleep(5000)
				            CancelAll()
					    EndIf
				    EndIf
			    EndIf
			EndIf
			If CheckArea(-495, -18) Then
				If $IamwonAntechamber == getherotitle() Then
				    If GetIsLiving(GetMyID()) Then
					    If GetMapID() == $Antechamber Then
							MoveTo (237, -9)
				            sleep(1000)
					    EndIf
				    EndIf
			    EndIf
			EndIf
			If CheckArea(237, -9) Then
				If $IamwonAntechamber == getherotitle() Then
				    If GetIsLiving(GetMyID()) Then
					    If GetMapID() == $Antechamber Then
							MoveTo (-485, 2039)
				            sleep(15000)
					    EndIf
				    EndIf
			    EndIf
			EndIf
			If CheckArea(-485, 2039) Then
				If $IamwonAntechamber == getherotitle() Then
				    If GetIsLiving(GetMyID()) Then
					    If GetMapID() == $Antechamber Then
							CommandAll(-494, 4389)
				            sleep(15000)
					    EndIf
				    EndIf
			    EndIf
			EndIf
	    if $IamwonAntechamber < getherotitle() Then
			If GetMapLoading() == 2 Then Disconnected()
			If GetIsDead(GetMyID()) Then ExitLoop
			If GetIsLiving(GetMyID()) Then
				If GetMapID() == $Antechamber Then
                    Out("won in Ante")
					Fameup()
					Sleep(5000)
			        WaitMapLoading()
				EndIf
			EndIf
		EndIf
	EndIf
WEnd
GUICtrlSetData($mAntechamber, GUICtrlRead($mAntechamber) + 1)
EndFunc

Func Vault()
	If GetMapLoading() == 2 Then Disconnected()
	GUICtrlSetData($Nowinmap, "Vault")
	SkipCinematic()
    if GetMapID() == $Vault Then
        Sleep (5000)
		Out("Vault")
		TravelTo($HA)
		WaitMapLoading()
	EndIf
EndFunc

Func HoH()
	If GetMapLoading() == 2 Then Disconnected()
	GUICtrlSetData($Nowinmap, "Hall of Hero")
	GUICtrlSetColor($Nowinmap, 0xFF00FF)
	SkipCinematic()
    While GetMapID() == $HoH
		If GetMapLoading() == 2 Then Disconnected()
		If GUICtrlRead($pause) = 1 Then
		    out("Bot paused")
		    sleep(2000)
		Else
		    Out("HoH")
		    Sleep (10000)
		    resign()
			WaitMapLoading()
		EndIf
	WEnd
	GUICtrlSetData($mHallofHero, GUICtrlRead($mHallofHero) + 1)
EndFunc

Func killenemy()
	If $distance < 1250 Then
		For $i = 1 to 7
			If GetMapLoading() == 2 Then Disconnected()
			If GetIsDead(GetMyID()) Then ExitLoop
			If GetMapLoading() == $INSTANCETYPE_OUTPOST Then ExitLoop
			GetBestTarget()
			$besttarget = GetBestTarget()
			Out("Kill best Enemes")
			Attack($besttarget)
			CallTarget($besttarget)
			Sleep(300)
			skilluserange($i, $besttarget)
			Sleep(300)
			ChangeTarget($besttarget)
		Next
	EndIf
EndFunc


Func skilluserange($skillnumber, $agent)
	$distance = getdistance($agent, -2)
	If $distance < 1250 Then
		While True
			If GetMapLoading() == 2 Then Disconnected()
;~ 			$skillrechargetime = getskillbarskillrecharge($skillnumber, 0)
;~ 			If $skillrechargetime == 0 Then
				$skillslotid = getskillbarskillid($skillnumber)
				$skillidstruct = getskillbyid($skillslotid)
				useskill($skillnumber, -1)
				$activationzeitausgabe = DllStructGetData($skillidstruct, "Activation")
				$aftercastzeitausgabe = DllStructGetData($skillidstruct, "Aftercast")
;~ 				Sleep($activationzeitausgabe + $aftercastzeitausgabe)
				Sleep(1500)
				ExitLoop
;~ 			EndIf
		WEnd
	EndIf
EndFunc
#EndRegion


#Region Divers
Func CloseHandler()
	If Not $Rendering Then AdlibUnRegister("_ReduceMemory")
	Exit
EndFunc   ;==>CloseHandler

Func Out($aString)
	Local $temp = "[" & @HOUR & ":" & @MIN & "] " & $aString
	FileWriteLine($LogFile, $temp)
	GUICtrlSetData($Console, GUICtrlRead($Console) & $temp & @CRLF)
	_GUICtrlEdit_Scroll($Console, 4)
EndFunc   ;==>Out


Func _ReduceMemory()
	If $gwpid <> -1 Then
		Local $ai_Handle = DllCall("kernel32.dll", 'int', 'OpenProcess', 'int', 0x1f0fff, 'int', False, 'int', $gwpid)
		Local $ai_Return = DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', $ai_Handle[0])
		DllCall('kernel32.dll', 'int', 'CloseHandle', 'int', $ai_Handle[0])
	Else
		Local $ai_Return = DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', -1)
	EndIf

	Return $ai_Return[0]
EndFunc   ;==>_ReduceMemory

Func _CanPickUp($aItem)
	Local $lModelID = DllStructGetData(($aItem), 'ModelID')
	Local $lRarity = GetRarity($aItem)
	Local $t = DllStructGetData($aItem, 'Type')
	If $lModelID == 0 Then Return False
	If $lModelID == 146 Then
		Switch DllStructGetData($aItem, "ExtraID")
			Case 10, 12
				Return True
			Case Else
				Return False
		EndSwitch
	EndIf
	If $lRarity == 2624 Then Return True
	Return False
EndFunc   ;==>_CanPickUp

#EndRegion

func titlecheck()
   If $WeAreDead = 0 Then
         $nStats_Fame = GetHeroTitle() - $oStats_Fame
   GUICtrlSetData($lblfame, $nStats_Fame)
   EndIf
   EndFunc

Func Disconnected2() ;-rename to "Disconnected()" if not using the function in gwa2
   Out("Disconnected!")
   Out("Attempting to reconnect.")
   ControlSend(getwindowhandle(), "", "", "{Enter}")
   Local $lcheck = False
   Local $ldeadlock = TimerInit()
   Do
	  Sleep(20)
	  $lcheck = getmaploading() <> 2 AND getagentexists(-2)
   Until $lcheck OR TimerDiff($ldeadlock) > 60000
   If $lcheck = False Then
	  Out("Failed to Reconnect!")
	  Out("Retrying...")
	  ControlSend(getwindowhandle(), "", "", "{Enter}")
	  $ldeadlock = TimerInit()
	  Do
		 Sleep(20)
		 $lcheck = getmaploading() <> 2 AND getagentexists(-2)
	  Until $lcheck OR TimerDiff($ldeadlock) > 60000
	  If $lcheck = False Then
		 Out("Could not reconnect!")
		 Out("Exiting.")
	  EndIf
   EndIf
   Out("Reconnected!")
EndFunc

Func Zkeys()
If $BalthazarForVal = "Zaishen Keys" Then
						$iTotalBalthazar = GetBalthazarFaction()
						RndSleep(250)
						If ($iTotalBalthazar >= 10001) Then
							TradeBalthazarX($BalthazarForVal)
						EndIf
EndIf
EndFunc

Func TradeBalthazarX($Balthazar)
	Out("Trading Balthazar")
	$MyName = GetCharname()
	If GetMapID() == $HA Then
		Sleep(Random(750, 3000, 1))
		$npc = GetAgentByName("Tolkano [Tournament]") ; GetNearestNPCToCoords(-2706, -6802)
		RndSleep(500)
		If $Balthazar == "Zaishen Keys" Then
            GoToNPC($npc)
			If GetBalthazarFaction() >= 10000 Then
				RndSleep(500)
				Dialog(0x87) ;; Purchase Zkeys using faction
				RndSleep(1500)
				Dialog(0x88) ;; Purchase 1 Zkey
				RndSleep(1500)
				$Zk += 1
	            GUICtrlSetData($lblZk, GUICtrlRead($lblZk) + 1)
;~ 				$aRet = _Toast_Show(0, $MyName, "Has " & $MyTotalZkeys & " Zkeys!     " & @CRLF & "Completed " & $iTotalRuns & " runs." , 3, False)
;~ 				TraySetToolTip($MyName & @CRLF & "Has " & $MyTotalZkeys & " Zkeys!")
			EndIf
			Sleep(Random(500, 2500, 1))
;~ 			Switch Random(1, 5, 1)
;~ 				Case 1, 2
;~ 					Move(-3141, -6809, 300)
;~ 				Case 3
;~ 					MoveTo(-3141, -6809, 300)
;~ 					Move(-3141, -6809, 300)
;~ 				Case 4
;~ 					GoToNPCNearestCoords(-2805, -6366)
;~ 				Case 5
;~ 					GoToNPCNearestCoords(-3699, -7362)
;~ 			EndSwitch
		EndIf
	EndIf
EndFunc   ;==>TradeBalthazarX


;~ Func GetBestTarget($aRange = 1250)
;~ 	Local $lBestTarget, $lDistance, $lLowestSum = 100000000
;~ 	Local $lAgentArray = GetAgentArray(0xDB)
;~ 	For $i = 1 to $lAgentArray[0]
;~ 		Local $lSumDistances = 0
;~ 		If DllStructGetData($lAgentArray[$i], 'Allegiance') = 3 Then ContinueLoop
;~ 		If DllStructGetData($lAgentArray[$i], 'HP') = 0 Then ContinueLoop
;~ 		If DllStructGetData($lAgentArray[$i], 'ID') = GetMyID() Then ContinueLoop
;~ 		If GetDistance($lAgentArray[$i]) < $aRange Then ContinueLoop
;~ 		For $j = 1 to $lAgentArray[0]
;~ 			If DllStructGetData($lAgentArray[$j], 'Allegiance') =  3 Then ContinueLoop
;~ 			If DllStructGetData($lAgentArray[$j], 'HP') = 0 Then ContinueLoop
;~ 			If DllStructGetData($lAgentArray[$j], 'ID') = GetMyID() Then ContinueLoop
;~ 			If GetDistance($lAgentArray[$j]) < $aRange Then ContinueLoop
;~ 			$lDistance = GetDistance($lAgentArray[$i], $lAgentArray[$j])
;~ 			$lSumDistances += $lDistance
;~ 		Next
;~ 		If $lSumDistances And $lLowestSum Then
;~ 			$lLowestSum = $lSumDistances
;~ 			$lBestTarget = $lAgentArray[$i]
;~ 		EndIf
;~ 	Next
;~ 	Return $lBestTarget
;~ EndFunc

Func GetBestTarget($aRange = 1220)
	Local $lBestTarget, $lDistance, $lLowestSum = 100000000
	Local $lAgentArray = GetAgentArray(0xDB)
	For $i = 1 to $lAgentArray[0]
		Local $lSumDistances = 0
		If DllStructGetData($lAgentArray[$i], 'Allegiance') <> 3 Then ContinueLoop
		If DllStructGetData($lAgentArray[$i], 'HP') <= 0 Then ContinueLoop
		If DllStructGetData($lAgentArray[$i], 'ID') = GetMyID() Then ContinueLoop
		If GetDistance($lAgentArray[$i]) > $aRange Then ContinueLoop
		For $j = 1 to $lAgentArray[0]
			If DllStructGetData($lAgentArray[$j], 'Allegiance') <> 3 Then ContinueLoop
			If DllStructGetData($lAgentArray[$j], 'HP') <= 0 Then ContinueLoop
			If DllStructGetData($lAgentArray[$j], 'ID') = GetMyID() Then ContinueLoop
			If GetDistance($lAgentArray[$j]) > $aRange Then ContinueLoop
			$lDistance = GetDistance($lAgentArray[$i], $lAgentArray[$j])
			$lSumDistances += $lDistance
		Next
		If $lSumDistances < $lLowestSum Then
			$lLowestSum = $lSumDistances
			$lBestTarget = $lAgentArray[$i]
		EndIf
	Next
	Return $lBestTarget
EndFunc    ;==>GetBestTarget

Func CheckIsTeamWiped() ; Start over on Party Wipes
 	Local $TeamMembersAlive = 0
 	Local $lAgentArray = GetParty()
 	For $i = 1 To $lAgentArray[0]
 		$lAgent = $lAgentArray[$i]
 		If DllStructGetData($lAgent, 'Allegiance') = 1 Then
 			If Not BitAND(DllStructGetData($lAgent, 'Typemap'), 131072) Then ContinueLoop ; summoned
 			If GetIsDead($lAgent) = False Then ; if not dead
 			   $TeamMembersAlive += 1
 			EndIf
 		EndIf
 	 Next
	If $TeamMembersAlive > 1 Then
 		Return False
	Else
		out("Party is dead, Return.")
		Sleep(15000)
		If GetMapID() == $UnholyTemples Or GetMapID() == $Antechamber Or GetMapID() == $ForgottenShrines Then
			out("wait res")
			Do
				Sleep(5000)
			Until GetIsLiving(GetMyID())
		EndIf
		If GetMapID() == $Courtyard Then
			Do
				Sleep(2000)
			Until GetIsLiving(GetMyID())
			CommandAll(-75, 325)
			Sleep(2000)
			GoToNPC(GetNearestAgentToAgent())
			CancelAll()
			out("take ghostly")
			$Error += 1
            If $Error = 50 Then
				TravelTo($HA)
				WaitMapLoading()
			EndIf
		EndIf
		If Not GetMapID() == $UnholyTemples Or GetMapID() == $Antechamber Or GetMapID() == $ForgottenShrines Then
			out("Any map")
			Return Mainloop()
        EndIf
	EndIf
EndFunc   ;==>CheckTeamWiped

Func PickUpLoot()
   If GetMapLoading() == 2 Then Disconnected()
   Local $lMe, $lAgent, $lItem
   Local $lBlockedTimer
   Local $lBlockedCount = 0
   Local $lItemExists = True
   For $i = 1 To GetMaxAgents()
	  If GetMapLoading() == 2 Then Disconnected()
	  $lMe = GetAgentByID(-2)
	  If DllStructGetData($lMe, 'HP') <= 0.0 Then Return
	  $lAgent = GetAgentByID($i)
	  If Not GetIsMovable($lAgent) Then ContinueLoop
	  If Not GetCanPickUp($lAgent) Then ContinueLoop
	  $lItem = GetItemByAgentID($i)
	  If CanPickUp($lItem) Then
		 Do
			If GetMapLoading() == 2 Then Disconnected()
			;If $lBlockedCount > 2 Then UseSkillEx(6,-2)
			PickUpItem($lItem)
			Sleep(GetPing())
			Do
			   Sleep(100)
			   $lMe = GetAgentByID(-2)
			Until DllStructGetData($lMe, 'MoveX') == 0 And DllStructGetData($lMe, 'MoveY') == 0
			$lBlockedTimer = TimerInit()
			Do
			   Sleep(3)
			   $lItemExists = IsDllStruct(GetAgentByID($i))
			Until Not $lItemExists Or TimerDiff($lBlockedTimer) > Random(5000, 7500, 1)
			If $lItemExists Then $lBlockedCount += 1
		 Until Not $lItemExists Or $lBlockedCount > 5
	  EndIf
   Next
EndFunc

Func CanPickUp($lItem)
   If GetMapLoading() == 2 Then Disconnected()
   Local $RepairKit = GetAgentByName("Repair Kit")
   Local $Flag = GetAgentByName("Flag")
   Local $Quantity
   Local $ModelID = DllStructGetData($lItem, 'ModelID')
   Local $ExtraID = DllStructGetData($lItem, 'ExtraID')
   Local $lType = DllStructGetData($lItem, 'Type')
   Local $lRarity = GetRarity($lItem)
   For $i = 1 To GetMaxAgents()
;~    If $ModelID == 146 And ($ExtraID == 10 Or $ExtraID == 12) Then Return True	; Black and White Dye
;~    If $ModelID == 921 Then	; Bones
;~ 	  $Drops += DllStructGetData($lItem, 'Quantity')
;~ 	  GUICtrlSetData($DropsCount,$Drops)
	  Return True
;~    EndIf
;~    If $ModelID == GetAgentByName("Repair Kit") Then Return True ; 929 = Dust
;~    If $ModelID == GetAgentByName("Flag") Then Return True
   If $ModelID == $i Then Return True
;~    If $ModelID == 24353 Then Return True ; Diessa
;~    If $ModelID == 24354 Then Return True ; Rin
;~    If $ModelID == 22751 Then Return True ; Lockpick
;~    If $ModelID == 22191 Then Return True ; Clover
;~    If $ModelID == 2511 And GetGoldCharacter() < 99000 Then Return True	;2511 = Gold Coins
   ;If $lType == 24 Then Return True ;Shields
   Next
   Return False
EndFunc


Func Checkcolor()
	$Iam = 0
	If GetMapID() == $UnholyTemples Then
		If GetIsLiving(GetMyID()) Then
			Move(3247, 2429)
	        Sleep(1000)
            If CheckArea(3247, 2429) Then
				Out("I am blue in Unholy Temples")
				$Iam = $Iamblue
			Else
		        Out("I am red in Unholy Temples")
				$Iam = $Iamred
	        EndIf
			Sleep(1000)
		EndIf
	EndIf
	If GetMapID() == $ForgottenShrines Then
		If GetIsLiving(GetMyID()) Then
	        Move(-1990, -3415)
	        Sleep(1000)
            If CheckArea(-1990, -3415) Then
		        $Iam = $Iamblue
				Out("I am blue in Forgotten Shrines")
			Else
		        $Iam = $Iamred
		        Out("I am red in Forgotten Shrines")
	        EndIf
		EndIf
	EndIf
	If GetMapID() == $Antechamber Then
		If GetIsLiving(GetMyID()) Then
	        Move(-3704, 1643)
	        Sleep(1000)
            If CheckArea(-3704, 1643) Then
		        $Iam = $Iamblue
				Out("I am blue in Antechamber")
			Else
		        $Iam = $Iamred
		        Out("I am red in Antechamber")
	        EndIf
		EndIf
	EndIf
EndFunc ;Checkcolor()


Func Fameup()
    $Fameup = getherotitle() - $SaveFame
    GUICtrlSetData($lblWins, $Fameup)
    Out($Fameup & " fame uped")
EndFunc ; Fameup()

Func Famesave()
	titlecheck()
	$SaveFame = getherotitle()
	Out("fame now:" & $SaveFame)
	Return False
EndFunc ; Famesave()

Func PositionWindows()
	$Windowbot = WinGetTitle('Multi-Ha-Bot by Teqatle')
    WinSetTitle($Windowbot, '', 'Multi-Ha-Bot by Teqatle #')
   If $Positionwindow = False Then
	    If WinExists('Multi-Ha-Bot by Teqatle 9') Then
			If WinExists('Multi-Ha-Bot by Teqatle 8') And WinExists('Multi-Ha-Bot by Teqatle 7') And WinExists('Multi-Ha-Bot by Teqatle 6') And WinExists('Multi-Ha-Bot by Teqatle 5') And WinExists('Multi-Ha-Bot by Teqatle 4') And WinExists('Multi-Ha-Bot by Teqatle 3') And WinExists('Multi-Ha-Bot by Teqatle 2') And WinExists('Multi-Ha-Bot by Teqatle 1') Then
		        WinSetTitle($Windowbot, '', 'Multi-Ha-Bot by Teqatle 10')
		        WinMove($Windowbot, "", 145, 532, 356, 254)
                $Positionwindow = True
			EndIf
	    EndIf
	EndIf
   If $Positionwindow = False Then
	    If WinExists('Multi-Ha-Bot by Teqatle 8') Then
			If WinExists('Multi-Ha-Bot by Teqatle 7') And WinExists('Multi-Ha-Bot by Teqatle 6') And WinExists('Multi-Ha-Bot by Teqatle 5') And WinExists('Multi-Ha-Bot by Teqatle 4') And WinExists('Multi-Ha-Bot by Teqatle 3') And WinExists('Multi-Ha-Bot by Teqatle 2') And WinExists('Multi-Ha-Bot by Teqatle 1') Then
		        WinSetTitle($Windowbot, '', 'Multi-Ha-Bot by Teqatle 9')
		        WinMove($Windowbot, "", 145, 786, 356, 254)
                $Positionwindow = True
			EndIf
	    EndIf
	EndIf
   If $Positionwindow = False Then
	    If WinExists('Multi-Ha-Bot by Teqatle 7') Then
			If WinExists('Multi-Ha-Bot by Teqatle 6') And WinExists('Multi-Ha-Bot by Teqatle 5') And WinExists('Multi-Ha-Bot by Teqatle 4') And WinExists('Multi-Ha-Bot by Teqatle 3') And WinExists('Multi-Ha-Bot by Teqatle 2') And WinExists('Multi-Ha-Bot by Teqatle 1') Then
		        WinSetTitle($Windowbot, '', 'Multi-Ha-Bot by Teqatle 8')
		        WinMove($Windowbot, "", 500, 786, 356, 254)
                $Positionwindow = True
			EndIf
	    EndIf
	EndIf
	If $Positionwindow = False Then
	    If WinExists('Multi-Ha-Bot by Teqatle 6') Then
			If WinExists('Multi-Ha-Bot by Teqatle 5') And WinExists('Multi-Ha-Bot by Teqatle 4') And WinExists('Multi-Ha-Bot by Teqatle 3') And WinExists('Multi-Ha-Bot by Teqatle 2') And WinExists('Multi-Ha-Bot by Teqatle 1') Then
		        WinSetTitle($Windowbot, '', 'Multi-Ha-Bot by Teqatle 7')
		        WinMove($Windowbot, "", 500, 532, 356, 254)
                $Positionwindow = True
			EndIf
	    EndIf
	EndIf
	If $Positionwindow = False Then
	    If WinExists('Multi-Ha-Bot by Teqatle 5') Then
			If WinExists('Multi-Ha-Bot by Teqatle 4') And WinExists('Multi-Ha-Bot by Teqatle 3') And WinExists('Multi-Ha-Bot by Teqatle 2') And WinExists('Multi-Ha-Bot by Teqatle 1') Then
		        WinSetTitle($Windowbot, '', 'Multi-Ha-Bot by Teqatle 6')
		        WinMove($Windowbot, "", 856, 532, 356, 254)
                $Positionwindow = True
			EndIf
	    EndIf
	EndIf
	If $Positionwindow = False Then
	    If WinExists('Multi-Ha-Bot by Teqatle 4') Then
			If WinExists('Multi-Ha-Bot by Teqatle 3') And WinExists('Multi-Ha-Bot by Teqatle 2') And WinExists('Multi-Ha-Bot by Teqatle 1') Then
		        WinSetTitle($Windowbot, '', 'Multi-Ha-Bot by Teqatle 5')
		        WinMove($Windowbot, "", 856, 786, 356, 254)
                $Positionwindow = True
			EndIf
	    EndIf
	EndIf
	If $Positionwindow = False Then
	    If WinExists('Multi-Ha-Bot by Teqatle 3') Then
			If WinExists('Multi-Ha-Bot by Teqatle 2') And WinExists('Multi-Ha-Bot by Teqatle 1') Then
		        WinSetTitle($Windowbot, '', 'Multi-Ha-Bot by Teqatle 4')
		        WinMove($Windowbot, "", 1212, 786, 356, 254)
                $Positionwindow = True
			EndIf
	    EndIf
	EndIf
    If $Positionwindow = False Then
	    If WinExists('Multi-Ha-Bot by Teqatle 2') Then
			If WinExists('Multi-Ha-Bot by Teqatle 1') Then
		        WinSetTitle($Windowbot, '', 'Multi-Ha-Bot by Teqatle 3')
		        WinMove($Windowbot, "", 1212, 532, 356, 254)
                $Positionwindow = True
			EndIf
	    EndIf
	EndIf
	If $Positionwindow = False Then
	    If WinExists('Multi-Ha-Bot by Teqatle 1') Then
		    WinSetTitle($Windowbot, '', 'Multi-Ha-Bot by Teqatle 2')
		    WinMove($Windowbot, "", 1566, 532, 356, 254)
			$Positionwindow = True
	    EndIf
	EndIf
	If $Positionwindow = False Then
	    If WinExists('Multi-Ha-Bot by Teqatle #') Then
		    WinSetTitle($Windowbot, '', 'Multi-Ha-Bot by Teqatle 1')
		    WinMove($Windowbot, "", 1566, 786, 356, 254)
            $Positionwindow = True
	    EndIf
	EndIf
EndFunc