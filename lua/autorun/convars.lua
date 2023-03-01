if SERVER then AddCSLuaFile() end

if !ConVarExists("yamato_damage") then
    CreateConVar("yamato_damage", '1', FCVAR_ARCHIVE)
end

hook.Add("PopulateToolMenu", "YamatoOptionsMenu", function()
    spawnmenu.AddToolMenuOption("Utilities", "DevilMayCry", "basic_options", "Options", "", "", function(panel)

            panel:AddControl("toggle", {
                label = "Disable Yamato Trail",
                command = "ymt_trail"
            })
			
			 panel:AddControl("toggle", {
                label = "Auto Enable 3rdperson",
                command = "ymt_3rdperson_on"
            })
			
			panel:AddControl("toggle", {
                label = "Auto Disable 3rdperson",
                command = "ymt_3rdperson_off"
            })
			
			panel:AddControl("slider", {
                type = "float",
                label = "YamatoDamageMultiply",
                command = "yamato_damage",
                min = 0,
                max = 20,
            })
			panel:AddControl("color", {
                label = "Trail Color1",
				red = "ymt_trail_r1",
				green = "ymt_trail_g1",
				blue = "ymt_trail_b1",
				alpha = "ymt_trail_a1",
            })
			panel:AddControl("color", {
                label = "Trail Color2",
				red = "ymt_trail_r2",
				green = "ymt_trail_g2",
				blue = "ymt_trail_b2",
				alpha = "ymt_trail_a2",
            })
			panel:AddControl("color", {
                label = "Trail Color3",
				red = "ymt_trail_r3",
				green = "ymt_trail_g3",
				blue = "ymt_trail_b3",
				alpha = "ymt_trail_a3",
            })
			panel:AddControl("textbox", {
                label = "soundfiles",
				command = "ymt_dodgelsound",
            })
			
			panel:AddControl("toggle", {
                label = "Enable Custom Battle Cry",
                command = "ymt_custombattlecry"
            })
			
			panel:AddControl("textbox", {
                label = "yamato_battlecrylight1",
				command = "ymt_v_1",
            })
			
			panel:AddControl("textbox", {
                label = "yamato_battlecrylight2",
				command = "ymt_v_2",
            })
			
			panel:AddControl("textbox", {
                label = "yamato_battlecrylight3",
				command = "ymt_v_3",
            })
			
			panel:AddControl("textbox", {
                label = "yamato_battlecrylight4",
				command = "ymt_v_4",
            })
			
			panel:AddControl("textbox", {
                label = "yamato_battlecrymiddal1",
				command = "ymt_vm_1",
            })
			
			panel:AddControl("textbox", {
                label = "yamato_battlecrymiddal2",
				command = "ymt_vm_2",
            })
			
			panel:AddControl("textbox", {
                label = "yamato_battlecryheavy1",
				command = "ymt_vh_1",
            })
			
			panel:AddControl("textbox", {
                label = "JudgementCutEndvoice1",
				command = "ymt_jcendv_1",
            })
			
			panel:AddControl("textbox", {
                label = "JudgementCutEndvoice2",
				command = "ymt_jcendv_2",
            })

    end)
end)
	
	
if !ConVarExists("ymt_custombattlecry") then
 CreateConVar("ymt_custombattlecry", '0', FCVAR_ARCHIVE)
end
	
if !ConVarExists("ymt_3rdperson_on") then
 CreateConVar("ymt_3rdperson_on", '1', FCVAR_ARCHIVE)
end	
	
if !ConVarExists("ymt_3rdperson_off") then
 CreateConVar("ymt_3rdperson_off", '1', FCVAR_ARCHIVE)
end
		
if !ConVarExists("JudgementCutEndvoice1") then
    CreateConVar("JudgementCutEndvoice1", "yamatomod/jcend1.wav", FCVAR_ARCHIVE)
end	

if !ConVarExists("JudgementCutEndvoice2") then
    CreateConVar("JudgementCutEndvoice2", "yamatomod/jcend2.wav", FCVAR_ARCHIVE)
end	

if !ConVarExists("ymt_dodgelsound") then
    CreateConVar("ymt_dodgelsound", "yamatomod/yamato_tele.wav", FCVAR_ARCHIVE)
end	
	
if !ConVarExists("ymt_v_1") then
    CreateConVar("ymt_v_1", "yamatomod/ymt_vergil_vl_1.wav", FCVAR_ARCHIVE)
end	

if !ConVarExists("ymt_v_2") then
    CreateConVar("ymt_v_2", "yamatomod/ymt_vergil_vl_2.wav", FCVAR_ARCHIVE)
end
	
if !ConVarExists("ymt_v_3") then
    CreateConVar("ymt_v_3", "yamatomod/ymt_vergil_vl_3.wav", FCVAR_ARCHIVE)
end

if !ConVarExists("ymt_v_4") then
    CreateConVar("ymt_v_4", "yamatomod/ymt_vergil_vl_4.wav", FCVAR_ARCHIVE)
end
	
if !ConVarExists("ymt_vm_1") then
    CreateConVar("ymt_vm_1", "yamatomod/ymt_vergil_vm_1.wav", FCVAR_ARCHIVE)
end	

if !ConVarExists("ymt_vm_2") then
    CreateConVar("ymt_vm_2", "yamatomod/ymt_vergil_vm_2.wav", FCVAR_ARCHIVE)
end	

if !ConVarExists("ymt_vh_1") then
    CreateConVar("ymt_vh_1", "yamatomod/ymt_vergil_vh_1.wav", FCVAR_ARCHIVE)
end

if !ConVarExists("ymt_trail") then
    CreateConVar("ymt_trail", '0', FCVAR_ARCHIVE)
end

if !ConVarExists("ymt_trail_r1") then
    CreateConVar("ymt_trail_r1", '72', FCVAR_ARCHIVE)
end

if !ConVarExists("ymt_trail_g1") then
    CreateConVar("ymt_trail_g1", '72', FCVAR_ARCHIVE)
end

if !ConVarExists("ymt_trail_b1") then
    CreateConVar("ymt_trail_b1", '72', FCVAR_ARCHIVE)
end

if !ConVarExists("ymt_trail_a1") then
    CreateConVar("ymt_trail_a1", '255', FCVAR_ARCHIVE)
end

if !ConVarExists("ymt_trail_r2") then
    CreateConVar("ymt_trail_r2", '127', FCVAR_ARCHIVE)
end

if !ConVarExists("ymt_trail_g2") then
    CreateConVar("ymt_trail_g2", '255', FCVAR_ARCHIVE)
end

if !ConVarExists("ymt_trail_b2") then
    CreateConVar("ymt_trail_b2", '255', FCVAR_ARCHIVE)
end

if !ConVarExists("ymt_trail_a2") then
    CreateConVar("ymt_trail_a2", '255', FCVAR_ARCHIVE)
end
if !ConVarExists("ymt_trail_r3") then
    CreateConVar("ymt_trail_r3", '127', FCVAR_ARCHIVE)
end

if !ConVarExists("ymt_trail_g3") then
    CreateConVar("ymt_trail_g3", '159', FCVAR_ARCHIVE)
end

if !ConVarExists("ymt_trail_b3") then
    CreateConVar("ymt_trail_b3", '255', FCVAR_ARCHIVE)
end

if !ConVarExists("ymt_trail_a3") then
    CreateConVar("ymt_trail_a3", '255', FCVAR_ARCHIVE)
end