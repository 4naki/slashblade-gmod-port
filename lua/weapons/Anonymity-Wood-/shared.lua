if SERVER then

elseif CLIENT then

SWEP.PrintName = "Anonymity-Wood-"

end

SWEP.ViewModelFOV = 77
SWEP.UseHands = false
SWEP.Category = "Slashblade"
SWEP.Instructions = "Combine your movement and timing of your attacks to create combos!"
SWEP.Purpose = "Whack and slash enemies in style!"
SWEP.Contact = ""
SWEP.WorldModel = "models/slashblade/wood.mdl"
SWEP.Author = "YongLi & Naki"
SWEP.ViewModel = ""
SWEP.AdminSpawnable = false
SWEP.Spawnable = true
SWEP.Primary.NeverRaised = true
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.Damage = 14
SWEP.Primary.Delay = 1
SWEP.Primary.Ammo = ""
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.Delay = 0
SWEP.Secondary.Ammo = ""
SWEP.NoIronSightFovChange = true
SWEP.NoIronSightAttack = true
SWEP.LoweredAngles = Angle(60, 60, 60)

local ymt_swing1 = Sound( "yamatomod/ymt_swing_1.wav" )
local ymt_swing2 = Sound( "yamatomod/ymt_swing_2.wav" )
local ymt_swing3 = Sound( "yamatomod/ymt_swing_3.wav" )
local ymt_swing4 = Sound( "yamatomod/ymt_swing_3_2.wav" )
local ymt_swing5 = Sound( "yamatomod/ymt_swing_4.wav" )
local ymt_swing7 = Sound( "yamatomod/ymt_swing_4_2finalslash.wav" )
local ymt_swing6 = Sound( "yamatomod/ymt_swing_4_2inslash.wav" )
local ymt_swing8 = Sound( "yamatomod/ymt_swing_4_2ready.wav" )
local ymt_aswing1 = Sound( "yamatomod/ymt_swing_acombo1.wav" )
local ymt_aswing2 = Sound( "yamatomod/ymt_swing_acombo2.wav" )
local ymt_aswing3 = Sound( "yamatomod/ymt_swing_acombo3.wav" )
local ymt_aswing31 = Sound( "yamatomod/ymt_swing_acombo3.2.wav" )
local ymt_aswing32 = Sound( "yamatomod/ymt_swing_acombo3.2.1.wav" )
local ymt_rapidcut = Sound( "yamatomod/ymt_swing_rapidcut.wav" )
local ymt_teleport = Sound( "yamatomod/ymt_swing_teleport.wav" )
local ymt_dodge = Sound( "yamatomod/ymt_dodge.wav" )
local ymt_bulletblock1 = Sound( "physics/metal/metal_solid_impact_bullet1.wav" )
local ymt_bulletblock2 = Sound( "physics/metal/metal_solid_impact_bullet2.wav" )
local ymt_bulletblock3 = Sound( "physics/metal/metal_solid_impact_bullet3.wav" )
local ymt_upperslash = Sound( "yamatomod/ymt_swing_upperslash.wav" )
local ymt_judgementcut = Sound( "yamatomod/ymt_swing_judgementcut.wav" )
local ymt_judgementcutready = Sound( "yamatomod/ymt_swing_judgementcut_ready.wav" )
local ymt_downslash = Sound( "yamatomod/ymt_downslash.wav" )
local ymt_jc_ready = Sound( "yamatomod/ymt_ready.wav" )
local ymt_jc_during = Sound( "yamatomod/ymt_during.wav" )
local ymt_jc_during2 = Sound( "yamatomod/ymt_during2.wav" )
local ymt_jcend1
local ymt_jcend2
local ymt_vo_l1
local ymt_vo_l2
local ymt_vo_l3
local ymt_vo_l4
local ymt_vo_m1
local ymt_vo_m2
local ymt_vo_h1


function SWEP:Initialize()
	self.combo = 1
	self:SetHoldType("ymt_g_combo1")	
	self.duringattack = false
	self.bullet = false
	self.plyindirction = false
	self.duringattacktime = 0
	self.dodgecd = 0
	self.battlecrycd = 0
	self.bulletblockcd = 0
	self.trailtime = 0
	self.trailcd = 0
	self.dojc = false
	self.dojctimer = 0
	self.timer1 = 0
	self.doJCut = false
	self.plylanded = true
	self.landtimer = 0
	self.weaponmodel = 1
	self.swithweapontimer = 0
	self.dodgetime = 0
	self.dodgetime1 = 0
	self.canlockon = false
	self.downslash = false
	self.canlockon2 = false
	self.lockdowntimer = 0
	self.returnanimcd = 0
	self.back = true
end

function SWEP:PrimaryAttack( doanim, anim )
if !IsValid(self.Owner) then return end
local ply = self.Owner
if doanim == true then 
self:SetHoldType(anim)
if CLIENT then
timer.Simple(0.05, function()
if !IsValid(self) or !IsValid(ply) then return end
ply:SetAnimation(PLAYER_ATTACK1)
end)
else
ply:SetAnimation(PLAYER_ATTACK1)
end
else
self.back = false
if CLIENT then
timer.Simple(0.05, function()
if !IsValid(self) or !IsValid(ply) then return end
ply:SetAnimation(PLAYER_ATTACK1)
end)
end
if SERVER then
--DoCombo( playanim, anim, damage, delay, ranage, sphere, nextprifire, stuntimem, soundtype, sounddelay, hasleap, leaprange, leapdelay )
--ComboCounter( combo1, recovertime1, hastwoperiod, combo2, recovertime2 )
--DoAirCombo( playanim, anim, damage, delay, ranage, sphere, nextprifire, stuntimem, soundtype, sounddelay, flypower, flydelay )
if self.combo == 0 then
self:ComboCounter( 0.1, 0.6, false, combo2, recovertime2 )
util.ScreenShake( ply:GetPos(),1, 15, 0.45, 5000 ) 
if ply:IsOnGround() then
self:JudgementCut( 1 )
else
self:JudgementCut( 2 )
end
elseif self.combo == 0.1 then
util.ScreenShake( ply:GetPos(),1, 15, 0.45, 5000 ) 
self:ComboCounter( 0.2, 0.6, false, combo2, recovertime2 )
if ply:IsOnGround() then
self:JudgementCut( 1 )
else
self:JudgementCut( 2 )
end
elseif self.combo == 0.2 then
util.ScreenShake( ply:GetPos(),1, 15, 0.45, 5000 ) 
if ply:IsOnGround() then
self:JudgementCut( 1 )
else
self:JudgementCut( 2 )
end 
else
if not ply:IsOnGround() then
if ply:KeyDown( IN_FORWARD ) and ply:KeyDown( IN_SPEED ) then
if self.timer1 < CurTime() then 
self:DoBattleCry( true, 0.1, 1 )
self:DoAirCombo( true, "ymt_a_judgementcut", 19, 0.15, 55, 70, 0.3, 0.6, -1, 0.1, 10, 0.1 )
self:DoAirCombo( true, "ymt_a_judgementcut", 19, 0.15, 55, 70, 0.3, 0.6, -2, 0.1, 10, 0.1 )
self:ymttrail( 2,0.1, 0.2, "models/yamatomod/yamatotrail_airsp1.mdl", 2 )
self:ymttrail( 2,0.16, 0.2, "models/yamatomod/yamatotrail_airsp2.mdl", 2 )
self:ComboCounter( 1, 0.6, false, combo2, recovertime2 )
self.timer1 = CurTime() + 0.6
else	
self:ComboCounter( 1, 0, false, combo2, recovertime2 )
self:ymttrail( 3,0.07, 0.2, "models/yamatomod/yamatotrail_a3.mdl", 2 )
self:DoAirCombo( true, "ymt_a_combo3", 34, 0.15, 55, 70, 0.6, 0.6, -3, 0.1, 50, 0.1 )
end
elseif ply:KeyDown( IN_BACK ) and ply:KeyDown( IN_SPEED ) then
ply:EmitSound(ymt_judgementcutready)
self:DoBattleCry( true, 0.1, 1 )
self:DoAirCombo( false, "ymt_a_combo3_2_2", 40, 0.34, 60, 70, 0.8, 0.6, -3.8, 0, 50, 0.1 )
self:DownSlash()
elseif self.combo == 1 or self.combo == 11 then
self:DoBattleCry( true, 0.1, 1 )
self:ComboCounter( 2, 0.6, false, combo2, recovertime2 )
self:ymttrail( 2,0.07, 0.2, "models/yamatomod/yamatotrail_a1.mdl", 2 )
self:DoAirCombo( true, "ymt_a_combo1", 19, 0.15, 55, 70, 0.2, 0.6, -1, 0.1, 50, 0.1 )
elseif self.combo == 2 then
self:ComboCounter( 3, 0.4, true, 3.1, 0.2 )
self:DoBattleCry( true, 0.1, 1 )
self:ymttrail( 2,0.07, 0.2, "models/yamatomod/yamatotrail_a2.mdl", 2 )
self:DoAirCombo( true, "ymt_a_combo2", 21, 0.15, 55, 70, 0.2, 0.6, -2, 0.1, 50, 0.1 )
elseif self.combo == 3 or self.combo == 11.1 then
self:ComboCounter( 1, 0, false, combo2, recovertime2 )
self:DoBattleCry( true, 0.1, 2 )
self:ymttrail( 3,0.07, 0.2, "models/yamatomod/yamatotrail_a3.mdl", 2 )
self:DoAirCombo( true, "ymt_a_combo3", 34, 0.15, 55, 70, 0.6, 0.6, -3, 0.1, 50, 0.1 )
elseif self.combo == 3.1 then
self:ComboCounter( 3.2, 0.75, false, combo2, recovertime2 )
self:ymttrail( 1,0, 0.2, "models/yamatomod/yamatotrail_a3_1_1.mdl", 2 )
self:ymttrail( 2,0.13, 0.2, "models/yamatomod/yamatotrail_a3_1_2.mdl", 2 )
self:ymttrail( 2,0.24, 0.2, "models/yamatomod/yamatotrail_a3_1_3.mdl", 2 )
self:ymttrail( 3,0.35, 0.3, "models/yamatomod/yamatotrail_a3_1_4.mdl", 2 )
self:DoAirCombo( true, "ymt_a_combo3_2", 7, 0.05, 30, 90, 0.35, 0.6, -3.1, 0.1, 50, 0.1 )
self:DoAirCombo( false, "ymt_a_combo3_2", 6, 0.13, 35, 90, 0.35, 0.6, 0, 0.1, 50, 0.1 )
self:DoAirCombo( false, "ymt_a_combo3_2", 7, 0.25, 35, 90, 0.35, 0.6, 0, 0.1, 50, 0.1 )
self:DoAirCombo( false, "ymt_a_combo3_2", 17, 0.35, 35, 125, 0.4, 0.6, -9, 0.1, 50, 0.1 )
elseif self.combo == 3.2 then
self:DoBattleCry( true, 0.1, 3 )
self:DoAirCombo( true, "ymt_a_combo3_2_2", 32, 0.15, 30, 120, 0.8, 0.6, -3.2, 0.1, 50, 0.1 )
self:ymttrail( 3,0.12, 0.3, "models/yamatomod/yamatotrail_a3_2.mdl", 2 )
self:ComboCounter( 1, 0, false, combo2, recovertime2 )
end
else
if ply:KeyDown( IN_FORWARD ) and ply:KeyDown( IN_SPEED ) then
self:RapidCut()
ply:EmitSound(ymt_rapidcut)
elseif ply:KeyDown( IN_BACK ) and ply:KeyDown( IN_SPEED ) then
self:UpperSlash()
self:ComboCounter( 11, 0.6, false  )
self:ymttrail( 2,0.07, 0.5, "models/yamatomod/yamatotrail_us_1.mdl", 2 )
else
if self.combo == 1 then
self:DoBattleCry( true, 0.1, 1 )
self:ComboCounter( 2, 0.6, false, combo2, recovertime2 )
self:DoCombo( true, "ymt_g_combo1", 17, 0.16, 60, 55, 0.3, 0.6, 1, 0.1, true, 350,0.15 )
self:ymttrail( 1,0.1, 0.2, "models/yamatomod/yamatotrail_c1.mdl", 2 )
elseif self.combo == 2 then
self:DoBattleCry( true, 0.1, 1 )
self:ComboCounter( 3, 0.6, true, 3.1, 0.15 )
self:ymttrail( 1, 0.1, 0.2, "models/yamatomod/yamatotrail_c2.mdl", 2 )
self:DoCombo( true, "ymt_g_combo2", 19, 0.15, 55, 70, 0.34, 0.7, 2, 0.1, true, 530, 0.08 )
elseif self.combo == 3.1 then
self:DoBattleCry( true, 0.3, 2 )
self:ComboCounter( 1, 0, false, 3.1, 0.5 )
self:ymttrail( 3, 0.3, 0.4, "models/yamatomod/yamatotrail_c3_3.mdl", 30 )
self:DoCombo( true, "ymt_g_combo3_2", 43, 0.3, 60, 100, 1.1, 1.1, 3.1, 0.2, true, 380, 0 )
elseif self.combo == 3 then
self:DoBattleCry( true, 0.1, 1 )
self:ComboCounter( 4, 0.6, true, 4.1, 0.2 )
self:ymttrail( 2, 0.05, 0.2, "models/yamatomod/yamatotrail_c3_1.mdl", 27 )
self:ymttrail( 2, 0.16, 0.2, "models/yamatomod/yamatotrail_c3_2.mdl", 27 )
self:DoCombo( true, "ymt_g_combo3", 15, 0.17, 55, 65, 0.3, 0.6, 3, 0, true, 460, 0.05 )
self:DoCombo( false, "ymt_g_combo3", 17, 0.2, 55, 65, 0.3, 0.7, 0, 0.1, true, 560, 0.05 )
elseif self.combo == 4.1 then
self:DoBattleCry( true, 0.1, 1 )
self:ComboCounter( 4.2, 1, false, 4.1, 0.5 )
self:EmitSound(ymt_judgementcutready)
self:SetHoldType("ymt_g_combo4_1ready")
ply:SetAnimation( PLAYER_ATTACK1 )
self.combo = 1
timer.Simple(0.2, function()
if !IsValid(self) or !IsValid(ply) then return end
self:ymttrail( 2, 0.05, 0.2, "models/yamatomod/yamatotrail_c4_i1.mdl", 7 )
self:ymttrail( 2, 0.1, 0.2, "models/yamatomod/yamatotrail_c4_i2.mdl", 7 )
self:ymttrail( 2, 0.15, 0.2, "models/yamatomod/yamatotrail_c4_i3.mdl", 7 )
self:ymttrail( 2, 0.2, 0.2, "models/yamatomod/yamatotrail_c4_i4.mdl", 7 )
self:DoCombo( true, "ymt_g_combo4_1inslash", 7, 0.17, 55, 60, 0.3, 1, 4.2, 0.1, true, 465 ,0 )
self:DoCombo( false, "ymt_g_combo4_1inslash", 6, 0.22, 55, 60, 0.3, 0.6, 0, 0.1, false, 0 )
self:DoCombo( false, "ymt_g_combo4_1inslash", 7, 0.27, 55, 60, 0.3, 0.6, 0, 0.1, false, 0 )
self:DoCombo( false, "ymt_g_combo4_1inslash", 6, 0.32, 55, 60, 0.3, 0.6, 0, 0.1, false, 0 )
self:DoCombo( false, "ymt_g_combo4_1inslash", 7, 0.37, 55, 60, 0.3, 0.6, 0, 0.1, false, 0 )
end)
timer.Simple(0.55, function()
if !IsValid(self) or !IsValid(ply) then return end
if ply:KeyDown(IN_ATTACK) then
self:ymttrail( 2, 0.05, 0.2, "models/yamatomod/yamatotrail_c4_i1.mdl", 7 )
self:ymttrail( 2, 0.1, 0.2, "models/yamatomod/yamatotrail_c4_i2.mdl", 7 )
self:ymttrail( 2, 0.15, 0.2, "models/yamatomod/yamatotrail_c4_i3.mdl", 7 )
self:ymttrail( 2, 0.2, 0.2, "models/yamatomod/yamatotrail_c4_i4.mdl", 7 )
self:DoCombo( true, "ymt_g_combo4_1inslash", 7, 0.17, 55, 60, 0.3, 0.6, 4.2, 0.1, false, 0 )
self:DoCombo( false, "ymt_g_combo4_1inslash", 6, 0.22, 55, 60, 0.3, 0.6, 0, 0.1, false, 0 )
self:DoCombo( false, "ymt_g_combo4_1inslash", 7, 0.27, 55, 60, 0.3, 0.6, 0, 0.1, false, 0 )
self:DoCombo( false, "ymt_g_combo4_1inslash", 6, 0.32, 55, 60, 0.3, 0.6, 0, 0.1, false, 0 )
self:DoCombo( false, "ymt_g_combo4_1inslash", 7, 0.37, 55, 60, 0.3, 0.6, 0, 0.1, false, 0 )
timer.Simple(0.25, function()
if !IsValid(self) or !IsValid(ply) then return end
if ply:KeyDown(IN_ATTACK) then
self:ymttrail( 2, 0.05, 0.2, "models/yamatomod/yamatotrail_c4_i1.mdl", 7 )
self:ymttrail( 2, 0.1, 0.2, "models/yamatomod/yamatotrail_c4_i2.mdl", 7 )
self:ymttrail( 2, 0.15, 0.2, "models/yamatomod/yamatotrail_c4_i3.mdl", 7 )
self:ymttrail( 2, 0.2, 0.2, "models/yamatomod/yamatotrail_c4_i4.mdl", 7 )
self:DoCombo( true, "ymt_g_combo4_1inslash", 7, 0.17, 55, 60, 0.3, 0.6, 4.2, 0.1, false, 0 )
self:DoCombo( false, "ymt_g_combo4_1inslash", 6, 0.22, 55, 60, 0.3, 0.6, 0, 0.1, false, 0 )
self:DoCombo( false, "ymt_g_combo4_1inslash", 7, 0.27, 55, 60, 0.3, 0.6, 0, 0.1, false, 0 )
self:DoCombo( false, "ymt_g_combo4_1inslash", 6, 0.32, 55, 60, 0.3, 0.6, 0, 0.1, false, 0 )
self:DoCombo( false, "ymt_g_combo4_1inslash", 7, 0.37, 55, 60, 0.3, 0.6, 0, 0.1, false, 0 )
timer.Simple(0.3, function()
if !IsValid(self) or !IsValid(ply) then return end
self:ymttrail( 3, 0.05, 0.4, "models/yamatomod/yamatotrail_c4_1f.mdl", 60 )
	self.combo = 1
self:DoCombo( true, "ymt_g_combo4_1finalslash", 24, 0.17, 55, 120, 0.3, 0.8, 4.3, 0.3, true, 850, 0.05 )
self:DoBattleCry( true, 0.1, 2 )
	self.combo = 1
end)
else
self:ymttrail( 3, 0.05, 0.4, "models/yamatomod/yamatotrail_c4_1f.mdl", 60 )
	self.combo = 1
self:DoCombo( true, "ymt_g_combo4_1finalslash", 24, 0.17, 55, 120, 0.3, 0.8, 4.3, 0.3, true, 850, 0.05 )
self:DoBattleCry( true, 0.1, 2 )
	self.combo = 1
end
end)
else
self:ymttrail( 3, 0.05, 0.4, "models/yamatomod/yamatotrail_c4_1f.mdl", 60 )
self:DoCombo( true, "ymt_g_combo4_1finalslash", 24, 0.17, 55, 120, 0.3, 0.8, 4.3, 0.3, true, 850, 0.05 )
self:DoBattleCry( true, 0.1, 2 )
	self.combo = 1
end
end)
elseif self.combo == 4 then
self:ComboCounter( 1, 0, false, 4.5, 0.5 )
self:ymttrail( 3, 0.3, 0.4, "models/yamatomod/yamatotrail_c4.mdl", 60 )
self:DoBattleCry( true, 0.3, 3 )
self:DoCombo( true, "ymt_g_combo4", 43, 0.4, 70, 130, 0.7, 1, 4, 0.3, true, 870, 0.3 )
elseif self.combo == 11 then
self:DoBattleCry( true, 0.1, 2 )
self:ComboCounter( 1, 0, false, combo2, recovertime2 )
self:DoCombo( true, "ymt_upperslash_1_finish", 38, 0.16, 60, 180, 0.7, 0.8, 11, 0.1, true, 350,0.15 )
self:ymttrail( 3,0.1, 0.5, "models/yamatomod/yamatotrail_us_1_finish.mdl", 3 )
end
end
end
end
end
end
end

function SWEP:ComboCounter( combo1, recovertime1, hastwoperiod, combo2, recovertime2 )
if !IsValid(self.Owner) then return end
local ply = self.Owner
if SERVER then
self.combo = combo1
local a = self.combo
timer.Simple(recovertime1, function()
if !IsValid(self) or !IsValid(ply) then return end
if a == self.combo then
if hastwoperiod == false then
self.combo = 1
else
self.combo = combo2
local b = self.combo
timer.Simple(recovertime2, function()
if !IsValid(self) or !IsValid(ply) then return end
if b == self.combo then
self.combo = 1
end
end)
end
end
end)
end
end

function SWEP:DoCombo( playanim, anim, damage, delay, ranage, sphere, nextprifire, stuntime, soundtype, sounddelay, hasleap, leaprange, leapdelay )
if !IsValid(self.Owner) then return end
if SERVER then
local ply = self.Owner
	if IsValid(ply) then
	self.duringattacktime = CurTime() + stuntime
	self.Weapon:SetNextPrimaryFire(CurTime() + nextprifire )
	self.dodgecd = CurTime() + (nextprifire)
	timer.Simple(sounddelay, function()
	if !IsValid(self) or !IsValid(ply) then return end
	if soundtype == 1 then
	ply:EmitSound(ymt_swing1)
	elseif soundtype == 2 then
	ply:EmitSound(ymt_swing2)
	elseif soundtype == 3 then
	ply:EmitSound(ymt_swing3)
	elseif soundtype == 3.1 then
	ply:EmitSound(ymt_swing4)
	elseif soundtype == 4 then
	ply:EmitSound(ymt_swing5)
	elseif soundtype == 4.2 then
	ply:EmitSound(ymt_swing6)
	elseif soundtype == 4.3 then
	ply:EmitSound(ymt_rapidcut)
	elseif soundtype == 11 then
	ply:EmitSound(ymt_aswing32)
	else
	end
	end)
	if hasleap == true then
	timer.Simple(leapdelay, function()
	if !IsValid(self) or !IsValid(ply) then return end
	ply:SetVelocity((ply:GetForward() * 1) * leaprange + Vector(0,0,150) )	
	end)
	end
	if playanim == true then 
	self:SetHoldType(anim)
	ply:SetAnimation(PLAYER_ATTACK1)
	end
	timer.Simple(delay, function()
	if !IsValid(self) or !IsValid(ply) then return end
	if IsValid(ply) then
		local k, v
		local dmg = DamageInfo()
			dmg:SetDamage((damage)*(GetConVarNumber("yamato_damage")))
			dmg:SetDamageType(DMG_SLASH)
			dmg:SetAttacker(ply)
			dmg:SetInflictor(ply)
		for k, v in pairs ( ents.FindInSphere( (ply:GetPos()  + (ply:GetForward())* ranage) + Vector(0,0,35) , sphere ) ) do
		if !IsValid(v) or !IsValid(ply) then return end
			if v:IsValid() and v != self.Owner then
				if v:IsNPC() or v:IsPlayer() then
								ParticleEffect("blood_advisor_puncture",v:GetPos() + v:GetForward() * 0 + Vector( 0, 0, 40 ),Angle(0,45,0),nil)
				util.ScreenShake( ply:GetPos(),damage*0.07, 55, 0.45, 5000 ) 
				end
			if soundtype == 3.1 or soundtype == 4 or soundtype == 4.3 then
			if v:IsOnGround() then v:SetVelocity((ply:GetForward() * 10) * 200 + Vector(0,0,150) )
			else v:SetVelocity((ply:GetForward() * 10) * 80 + Vector(0,0,150) )
			end
			elseif soundtype == 4.2 then
			v:SetVelocity((ply:GetForward() * 1) * 1 + Vector(0,0,-350) )
			elseif soundtype == 11 then
			v:SetVelocity((ply:GetForward() * 450) * 1 + Vector(0,0,-1050) )
			else
			if v:IsOnGround() then
			v:SetVelocity((ply:GetForward() * 16) * 70 + Vector(0,0,-70) )
			else
			v:SetVelocity((ply:GetForward() * 15) * 1 + Vector(0,0,30) )
			end
			end
			v:TakeDamageInfo( dmg )			
			end	
		end
	end
	end)
	end
end
end

function SWEP:DoAirCombo( playanim, anim, damage, delay, ranage, sphere, nextprifire, stuntimem, soundtype, sounddelay, flypower, flydelay )
if !IsValid(self.Owner) then return end
if SERVER then
local ply = self.Owner
local pl = self.Owner
	if IsValid(ply) then
	self.Weapon:SetNextPrimaryFire(CurTime() + nextprifire )
	self.dodgecd = CurTime() + (nextprifire)
	timer.Simple(sounddelay, function()
	if !IsValid(self) or !IsValid(ply) then return end
	if soundtype == -1 then
	ply:EmitSound(ymt_aswing1)
	elseif soundtype == -2 then
	ply:EmitSound(ymt_aswing2)
	elseif soundtype == -3 then
	ply:EmitSound(ymt_aswing3)
	elseif soundtype == -3.1 then
	ply:EmitSound(ymt_aswing31)
	elseif soundtype == -3.2 then
	ply:EmitSound(ymt_aswing32)
	end
	end)
	timer.Simple(flydelay, function()
	if !IsValid(self) or !IsValid(ply) then return end
		local pl = self.Owner
		local ang = pl:GetAngles()
		local forward, right = ang:Forward(), ang:Right()
		
		local vel = -1 * pl:GetVelocity() -- Nullify current velocity
		vel = vel + Vector(0, 0, (200 + flypower)) -- Add vertical force
		
		local spd = (pl:GetMaxSpeed())*0.3
		
		if pl:KeyDown(IN_FORWARD) then
			vel = vel + forward * spd
		elseif pl:KeyDown(IN_BACK) then
			vel = vel - forward * spd
		end
		
		if pl:KeyDown(IN_MOVERIGHT) then
			vel = vel + right * spd
		elseif pl:KeyDown(IN_MOVELEFT) then
			vel = vel - right * spd
		end
	
		pl:SetVelocity(vel) 
		end)
	if playanim == true then 
	self:SetHoldType(anim)
	ply:SetAnimation(PLAYER_ATTACK1)
	end
	timer.Simple(delay, function()
	if !IsValid(self) or !IsValid(ply) then return end
	if IsValid(ply) then
		local k, v
		local dmg = DamageInfo()
			dmg:SetDamage((damage)*(GetConVarNumber("yamato_damage")))
			dmg:SetDamageType(DMG_SLASH)
			dmg:SetAttacker(ply)
			dmg:SetInflictor(ply)
		for k, v in pairs ( ents.FindInSphere( ply:GetPos() + (self.Owner:GetForward())* ranage, sphere ) ) do
		if !IsValid(v) or !IsValid(ply) then return end
			if v:IsValid() and v != self.Owner then
				if v:IsNPC() or v:IsPlayer() then
								ParticleEffect("blood_advisor_puncture",v:GetPos() + v:GetForward() * 0 + Vector( 0, 0, 40 ),Angle(0,45,0),nil)
				util.ScreenShake( ply:GetPos(),damage*0.12, 55, 0.45, 5000 ) 
				end
				dmg:SetDamageForce( ( v:GetPos() - self.Owner:GetPos() ):GetNormalized() * 100 )
				
				if soundtype == -1 or soundtype == -2 or soundtype == -3.1 then
		local pl = self.Owner
		local ang = pl:GetAngles()
		local forward, right = ang:Forward(), ang:Right()
		
		local vel = -1 * v:GetVelocity() -- Nullify current velocity
		vel = vel + Vector(0, 0, (200 + flypower) ) -- Add vertical force
		
		local spd = (pl:GetMaxSpeed())*0.3

		v:SetVelocity(vel) 
		elseif soundtype == -3 then
		v:SetVelocity((ply:GetForward() * 150) * 4 + Vector(0,0,30) )
		elseif soundtype == -3.2 then
		v:SetVelocity((ply:GetForward() * 50) * 4 + Vector(0,0,-830) )
		elseif soundtype == -3.8 then
		v:SetVelocity((ply:GetForward() * 50) * 4 + Vector(0,0,-1230) )
		elseif soundtype == -9 then
		v:SetVelocity((ply:GetForward() * 10) * 4 + Vector(0,0,160) )
		
	end
	v:TakeDamageInfo( dmg )
			end	
		end
	end
	end)
	end
end
end

function SWEP:JudgementCut( jctype )
if !IsValid(self.Owner) then return end
local ply = self.Owner
local jctraileffect
local enemypos
if SERVER then
self.duringattacktime = CurTime() + 0.4
self:ymttrail( 3,0.07, 0.1, "models/yamatomod/yamatotrail_c1.mdl", 0 )
self.Weapon:SetNextPrimaryFire(CurTime() + 0.3 )
self.dodgecd = CurTime() + 0.4
if jctype == 1 then
self:SetHoldType("ymt_g_judgementcut")
else
		local pl = self.Owner
		local ang = pl:GetAngles()
		local forward, right = ang:Forward(), ang:Right()
		
		local vel = -1 * pl:GetVelocity() -- Nullify current velocity
		vel = vel + Vector(0, 0, (150)) -- Add vertical force
		
		local spd = (pl:GetMaxSpeed())*0.3
		
		if pl:KeyDown(IN_FORWARD) then
			vel = vel + forward * spd
		elseif pl:KeyDown(IN_BACK) then
			vel = vel - forward * spd
		end
		
		if pl:KeyDown(IN_MOVERIGHT) then
			vel = vel + right * spd
		elseif pl:KeyDown(IN_MOVELEFT) then
			vel = vel - right * spd
		end
	
		pl:SetVelocity(vel) 
self:SetHoldType("ymt_a_judgementcut")
end
ply:SetAnimation( PLAYER_ATTACK1 )
---===========testeffect===========--
	local	ent05 = ents.Create("prop_dynamic")
		ent05:SetModel("models/maxofs2d/hover_rings.mdl")
		ent05:SetColor( Color( 120, 110, 255, 250 ) )
		ent05:SetMaterial( "models/effects/comball_sphere" )
		ent05:SetModelScale( 0,0,1 )		
		ent05:SetRenderMode( RENDERMODE_TRANSALPHA )
	local	ent06 = ents.Create("prop_dynamic")
		ent06:SetModel("models/maxofs2d/hover_rings.mdl")
		ent06:SetColor( Color( 29, 0, 255, 150 ) )
		ent06:SetMaterial( "models/shiny" )
		ent06:SetModelScale( 0,0,1 )	
		ent06:SetRenderMode( RENDERMODE_TRANSALPHA )
--=======================--
local jctraileffectp = ents.Create("prop_dynamic")
	jctraileffectp:SetModel("models/hunter/plates/plate.mdl")
	jctraileffectp:SetColor( Color( 255, 255, 255, 0 ) )
	jctraileffectp:SetRenderMode( RENDERMODE_TRANSALPHA )
	jctraileffectp:SetPos(ply:GetPos())
	jctraileffectp:Spawn()	
local jctraileffect1 = util.SpriteTrail( jctraileffectp, 0, Color( 255, 255, 255 ), false, 50, 10, 0.2, 0.02, "trails/tube" )
local jctraileffect2 = util.SpriteTrail( jctraileffectp, 0, Color( 0, 63, 255 ), false, 380, 350, 0.2, 0.02, "trails/laser" )
timer.Simple(0.1, function() if !IsValid(self) or !IsValid(ply) then return end
enemypos = ply:GetEyeTrace().HitPos
jctraileffectp:SetPos(enemypos)
jctraileffectp:EmitSound(ymt_judgementcut)
ent06:SetModelScale( 20,0.1,1 )
ent05:SetModelScale( 20,0.1,1 )
		ent06:SetPos(enemypos)
		ent06:Spawn()		
		ent05:SetPos(enemypos)	
		ent05:Spawn()	
end)

timer.Simple(0.2, function() if !IsValid(self) or !IsValid(ply) then return end
jctraileffect1:Remove() jctraileffect2:Remove() jctraileffectp:Remove() 
ent06:SetModelScale( 0,0.25,1 )
ent05:SetModelScale( 0,0.25,1 )
ParticleEffect("blood_spurt_synth_01",enemypos,Angle(0,0,0),nil)

		local k, v
		local dmg = DamageInfo()
			dmg:SetDamage((23)*(GetConVarNumber("yamato_damage")))
			dmg:SetDamageType(DMG_SLASH)
			dmg:SetAttacker(ply)
			dmg:SetInflictor(ply)
		for k, v in pairs ( ents.FindInSphere( enemypos, 100 ) ) do
			if v:IsValid() and v != ply then
				
				if v:IsNPC() or v:IsPlayer() then
				ParticleEffect("blood_advisor_puncture",v:GetPos() + v:GetForward() * 0 + Vector( 0, 0, 40 ),Angle(0,45,0),nil)
				end
				v:TakeDamageInfo( dmg )
		end 
	end
end)
timer.Simple(0.6, function() if !IsValid(self) or !IsValid(ply) then return end
ent05:Remove() ent06:Remove()
end)
end
end

--================================--
function SWEP:UpperSlash()
if !IsValid(self.Owner) then return end
if SERVER then
self.duringattacktime = CurTime() + 0.8
self.Weapon:SetNextPrimaryFire(CurTime() + 0.4 )
local ply = self.Owner
self:SetHoldType("ymt_upperslash_ready")
ply:EmitSound(ymt_judgementcutready)
ply:SetAnimation( PLAYER_ATTACK1 )
timer.Simple(0.17, function()
	if !IsValid(self) or !IsValid(ply) then return end
	ply:EmitSound(ymt_upperslash)
if ply:KeyDown( IN_ATTACK ) then
		local pl = self.Owner
		local ang = pl:GetAngles()
		local forward, right = ang:Forward(), ang:Right()
		
		local vel = -1 * pl:GetVelocity() -- Nullify current velocity
		vel = vel + Vector(0, 0, 450) -- Add vertical force
		
		local spd = pl:GetMaxSpeed()
		
		if pl:KeyDown(IN_FORWARD) then
			vel = vel + forward * spd
		elseif pl:KeyDown(IN_BACK) then
			vel = vel - forward * spd
		end
		
		if pl:KeyDown(IN_MOVERIGHT) then
			vel = vel + right * spd
		elseif pl:KeyDown(IN_MOVELEFT) then
			vel = vel - right * spd
		end
		
		pl:SetVelocity(vel) 
		
self:SetHoldType("wos_ymt_upperslash_2")
ply:SetAnimation( PLAYER_ATTACK1 )
	if IsValid(ply) then
		local k, v
		local dmg = DamageInfo()
			dmg:SetDamage((20)*(GetConVarNumber("yamato_damage")))
			dmg:SetDamageType(DMG_SLASH)
			dmg:SetAttacker(ply)
			dmg:SetInflictor(ply)
		for k, v in pairs ( ents.FindInSphere( (ply:GetPos()  + (ply:GetForward())* 90) + Vector(0,0,35) , 80 ) ) do
		if !IsValid(v) or !IsValid(ply) then return end
			if v:IsValid() and v != self.Owner then
			if v:IsNPC() or v:IsPlayer() then
				ParticleEffect("blood_advisor_puncture",v:GetPos() + v:GetForward() * 0 + Vector( 0, 0, 40 ),Angle(0,45,0),nil)
				util.ScreenShake( ply:GetPos(),4, 55, 0.45, 5000 ) 
				end
				v:TakeDamageInfo( dmg )
				v:SetVelocity((self.Owner:GetForward() * 1) * 1 + Vector(0,0,400) )	
			end	
		end
	end
else
self:SetHoldType("ymt_upperslash_1")
ply:SetAnimation( PLAYER_ATTACK1 )
	if IsValid(ply) then
		local k, v
		local dmg = DamageInfo()
			dmg:SetDamage((20)*(GetConVarNumber("yamato_damage")))
			dmg:SetDamageType(DMG_SLASH)
			dmg:SetAttacker(ply)
			dmg:SetInflictor(ply)
		for k, v in pairs ( ents.FindInSphere( (ply:GetPos()  + (ply:GetForward())* 90) + Vector(0,0,35) , 80 ) ) do
		if !IsValid(v) or !IsValid(ply) then return end
			if v:IsValid() and v != self.Owner then
				v:TakeDamageInfo( dmg )
				v:SetVelocity((self.Owner:GetForward() * 1) * 1 + Vector(0,0,400) )	
			end	
		end
	end
end
end)
end
end
--================================--

function SWEP:DownSlash()
local ply = self.Owner
self:SetHoldType("ymt_downslash_ready")
ply:SetAnimation(PLAYER_ATTACK1)
self.duringattacktime = CurTime() + 1000
self.Weapon:SetNextPrimaryFire(CurTime() + 1000 )
		local pl = self.Owner
		local ang = pl:GetAngles()
		local forward, right = ang:Forward(), ang:Right()
		
		local vel = -1 * pl:GetVelocity() -- Nullify current velocity
		vel = vel + Vector(0, 0, (200 + 50)) -- Add vertical force
		
		local spd = (pl:GetMaxSpeed())*0.3
		
		if pl:KeyDown(IN_FORWARD) then
			vel = vel + forward * spd
		elseif pl:KeyDown(IN_BACK) then
			vel = vel - forward * spd
		end
		
		if pl:KeyDown(IN_MOVERIGHT) then
			vel = vel + right * spd
		elseif pl:KeyDown(IN_MOVELEFT) then
			vel = vel - right * spd
		end
	
		pl:SetVelocity(vel)
timer.Simple(0.3, function()
self.downslash = true
	if !IsValid(self) or !IsValid(ply) then return end
	ply:SetVelocity(Vector(0, 0, -1000))
	self:SetHoldType("ymt_downslash_during")
	end)
end

function SWEP:DoAnimation( anim1 )
if !IsValid(self.Owner) then return end
local ply = self.Owner
if SERVER then
self:SetHoldType(anim1)
end
self:PrimaryAttack( true, anim1 )
end

function SWEP:Think()
if !IsValid(self.Owner) then return end
local ply = self.Owner
if SERVER then
--============adjustbattlecty===============--
if GetConVarNumber("ymt_custombattlecry") == 1 then
ymt_vo_l1 = Sound(GetConVarString("ymt_v_1"))
ymt_vo_l2 = Sound(GetConVarString("ymt_v_2"))
ymt_vo_l3 = Sound(GetConVarString("ymt_v_3"))
ymt_vo_l4 = Sound(GetConVarString("ymt_v_4"))
ymt_vo_m1 = Sound(GetConVarString("ymt_vm_1"))
ymt_vo_m2 = Sound(GetConVarString("ymt_vm_2"))
ymt_vo_h1 = Sound(GetConVarString("ymt_vh_1"))
ymt_jcend1 = Sound(GetConVarString("JudgementCutEndvoice1"))
ymt_jcend2 = Sound(GetConVarString("JudgementCutEndvoice2"))
else
ymt_jcend1 = Sound( "yamatomod/jcend1.wav" )
ymt_jcend2 = Sound( "yamatomod/jcend2.wav" )
ymt_vo_l1 = Sound("yamatomod/ymt_vergil_vl_1.wav")
ymt_vo_l2 = Sound("yamatomod/ymt_vergil_vl_2.wav")
ymt_vo_l3 = Sound("yamatomod/ymt_vergil_vl_3.wav")
ymt_vo_l4 = Sound("yamatomod/ymt_vergil_vl_4.wav")
ymt_vo_m1 = Sound("yamatomod/ymt_vergil_vm_1.wav")
ymt_vo_m2 = Sound("yamatomod/ymt_vergil_vm_2.wav")
ymt_vo_h1 = Sound("yamatomod/ymt_vergil_vh_1.wav")
end
--============dodgenbulletblock==============--
		hook.Add("EntityTakeDamage", "YamatoDodge"..self.Owner:GetName(), function(target, dmginfo)
			if IsValid(target) and IsValid(self.Owner) and target == ply and dmginfo:GetAttacker() != ply then
					if self.dodgetime > CurTime() then
						return true					
					elseif self.bullet == true then
if (dmginfo:GetDamageType() != DMG_SLASH and dmginfo:GetDamageType() != DMG_ALWAYSGIB and dmginfo:GetDamageType() != DMG_ENERGYBEAM
and dmginfo:GetDamageType() != DMG_BLAST and dmginfo:GetDamageType() != DMG_CLUB and dmginfo:GetDamageType() != DMG_BURN and dmginfo:GetDamageType() != DMG_VEHICLE and dmginfo:GetDamageType() != DMG_CRUSH and dmginfo:GetDamageType() != DMG_DIRECT and dmginfo:GetDamageType() != DMG_DISSOLVE and dmginfo:GetDamageType() != DMG_AIRBOAT and dmginfo:GetDamageType() != DMG_SLOWBURN and dmginfo:GetDamageType() != DMG_PHYSGUN and dmginfo:GetDamageType() != DMG_PLASMA and dmginfo:GetDamageType() != DMG_SONIC) or dmginfo:GetDamageType() == DMG_BULLET then
					local randbattlecry = math.random(1,3)
					if randbattlecry == 1 then
					ply:EmitSound(ymt_bulletblock1)
					elseif randbattlecry == 2 then
					ply:EmitSound(ymt_bulletblock2)
					elseif randbattlecry == 3 then
					ply:EmitSound(ymt_bulletblock3)
					end
					if self.bulletblockcd < CurTime() then
					self:DoAnimation("ymt_bulletblock")
					ParticleEffect("blood_spurt_synth_01b",ply:GetPos() + ply:GetForward()*30 + Vector( 0, 0, 60 ),Angle(((ply:GetPos() - ply:GetForward()*10):Angle())),nil)
					self.bulletblockcd = CurTime() + 0.45
					end
					return true
					end
			end
			end
		end)
--=======blockbullet===========--
if self.duringattacktime < CurTime() and self.Owner:KeyDown( IN_SPEED ) and ply:IsOnGround() then
self.bullet = true
else 
self.bullet = false
end
--=======return anim===========--
if self.Owner:KeyDown( IN_JUMP ) or self.Owner:KeyDown( IN_FORWARD ) or self.Owner:KeyDown( IN_BACK ) or
 self.Owner:KeyDown( IN_MOVELEFT ) or self.Owner:KeyDown( IN_MOVERIGHT ) then
 self.plyindirction = true
 else
 self.plyindirction = false
end
if self.duringattacktime < CurTime() and self.back == false and self.Owner:IsOnGround() and self.plyindirction == true then
self.back = true
self:SetHoldType("ymt_return")
ply:SetAnimation( PLAYER_ATTACK1 )
end
--========downslash===========--
if self.downslash == true and ply:IsOnGround() then
self.downslash = false
ply:EmitSound(ymt_downslash)
self:DoCombo( true, "ymt_downslash_finish", 70, 0, 80, 100, 0.7, 0.7, 3.1, 0.2, true, 380, 0 )
self:ymttrail( 3,0, 0.5, "models/yamatomod/yamatotrail_us_1.mdl", 2 )
end
--=====landanim=======----
if not ply:IsOnGround() and self.plylanded == true then
 self.plylanded = false
self.landtimer = CurTime() + 0.3
end
if ply:IsOnGround() and self.plylanded == false then
self.plylanded = true
if self.landtimer < CurTime() and self.duringattacktime  < CurTime() then
self:DoAnimation("ymt_land") --=================================landanim
end
end
--============lockdown=============----
if ply:KeyDown(IN_SPEED) then
local enemyangel
	for k, v in pairs ( ents.FindInSphere( ply:GetPos(), 750 ) ) do
	if v:IsValid() and v != ply and (v:IsNPC() or v:IsPlayer()) then	
	enemyangel = v:GetPos() + Vector(0,0,40)
	self.canlockon = true
	else 
	self.canlockon = false
	end
	end
	if self.canlockon == true and self.canlockon2 == false then
	if enemyangel != ply:GetPos() then
	ply:SetEyeAngles((enemyangel - ply:GetShootPos()):Angle())
	end
	end
end
--======judgementcut=======-- 
if ply:KeyPressed(IN_ATTACK) then
self.dojc = true
self.doJCut = true
self.dojctimer = CurTime() + 0.5
timer.Simple(0.5, function() if !IsValid(self) then return end
if self.dojc == true then
self.doJCut = true
end
end)
end
if self.dojctimer > CurTime() and ply:KeyReleased(IN_ATTACK) then
self.dojc = false
self.doJCut = false
end
if self.doJCut == true and ply:KeyReleased(IN_ATTACK) then
if self.duringattacktime < CurTime() then
self.Weapon:SetNextPrimaryFire(CurTime() + 0.3 )
self:ComboCounter( 0, 0.65, false, combo2, recovertime2 )
if ply:IsOnGround() then
if SERVER then
ply:EmitSound(ymt_judgementcutready)
end
self:DoAnimation("ymt_g_judgementcut_ready")
ply:SetVelocity((ply:GetForward() * 1) * -600 )
timer.Simple(0.2, function() if !IsValid(self) then return end 
self:JudgementCut( 1 )
end)
else
self:JudgementCut( 2 )
end
self.doJCut = false
elseif self.duringattacktime -0.1  < CurTime() then
self.Weapon:SetNextPrimaryFire(CurTime() + 0.2 )
self:ComboCounter( 0, 0.65, false, combo2, recovertime2 )
if ply:IsOnGround() then
if SERVER then
ply:EmitSound(ymt_judgementcutready)
self:JudgementCut( 1 )
else
self:JudgementCut( 2 )
end
end
end
end
--===============dodge=================--
if (not ply:IsOnGround()) and ply:KeyDown(IN_ZOOM) and ply:KeyDown(IN_BACK) and CurTime() > self.dodgecd then
		ply:SetVelocity(Vector(0, 0, -1450)) 
		ply:StopZooming()
		self.dodgetime = CurTime() + 0.4
		self.dodgecd = CurTime() + 1
		local dgtraileffect1
		local dgtraileffect2
		dgtraileffect1 = util.SpriteTrail( ply, 0, Color( 255, 255, 255 ), false, 50, 10, 0.2, 0.02, "trails/tube" )
		dgtraileffect2 = util.SpriteTrail( ply, 0, Color( 0, 63, 255 ), false, 380, 350, 0.2, 0.02, "trails/laser" )
				timer.Simple(0.2, function()
		if IsValid(dgtraileffect1) then 
		dgtraileffect1:Remove()
		end
		if IsValid(dgtraileffect2) then 
		dgtraileffect2:Remove()
		end
		end)
		ply:EmitSound(ymt_dodge)
		
end
		if ply:KeyDown(IN_ZOOM) and CurTime() > self.dodgecd and self.duringattacktime -0.2< CurTime()  then
		local dgtraileffect1
		local dgtraileffect2
		if ply:KeyDown(IN_ZOOM) then
		ply:EmitSound(ymt_dodge)
		end
		ply:StopZooming()
		self.dodgetime = CurTime() + 0.4
		self.Weapon:SetNextPrimaryFire(CurTime() + 0.3)
		local aimvec = self.Owner:GetAimVector()
		if ply:KeyDown(IN_ZOOM) then
		dgtraileffect1 = util.SpriteTrail( ply, 0, Color( 255, 255, 255 ), false, 50, 10, 0.2, 0.02, "trails/tube" )
		dgtraileffect2 = util.SpriteTrail( ply, 0, Color( 0, 63, 255 ), false, 380, 350, 0.2, 0.02, "trails/laser" )
		end
		self.dodgecd = CurTime() + 0.6
		if ply:IsOnGround() and self.Owner:KeyDown(IN_FORWARD) then 
		self:DoAnimation("ymt_land")
		ply:SetVelocity(Vector(aimvec.x*100,aimvec.y*100,aimvec.z*0.5)*24)
		ply:ViewPunch(Angle(5, 0, 0))
		elseif ply:IsOnGround() and self.Owner:KeyDown(IN_BACK) then
		self:DoAnimation("ymt_land")
		ply:SetVelocity(Vector(aimvec.x*100,aimvec.y*100,aimvec.z*0.5)*-24)
		ply:ViewPunch(Angle(-5, 0, 0))
		end
		if ply:IsOnGround() then 
		if self.Owner:KeyDown(IN_MOVELEFT) then
		self:DoAnimation("wos_yamato_trick_l")
		ply:SetLocalVelocity((ply:GetRight() * -1) * 1700)
		ply:ViewPunch(Angle(0, -10, 0))
		elseif self.Owner:KeyDown(IN_MOVERIGHT) then
		self:DoAnimation("wos_yamato_trick_r")
		ply:SetLocalVelocity((ply:GetRight() * 1) * 1700)
		ply:ViewPunch(Angle(0, 10, 0))
		end 
		end 
		if (not (ply:KeyDown(IN_MOVERIGHT) or ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK))) and ply:KeyDown(IN_ZOOM) then
		if ply:KeyDown(IN_SPEED) then
		self:Teleport()
		self:DoAnimation("wos_yamato_trick_up")
		ply:EmitSound(ymt_teleport)
ply:StopZooming()
self.dodgecd = CurTime() + 0.6
timer.Simple(0.1, function() 
if !IsValid(self) then return end
				self.Owner:SetPos(self.teleport_gotopos)
end)
				ply = self.Owner
				local pos = ply:GetPos()
				local tracedata = {}
				tracedata.start = pos
				tracedata.endpos = pos
				tracedata.filter = ply
				tracedata.mins = ply:OBBMins()
				tracedata.maxs = ply:OBBMaxs()
				timer.Simple(0.1, function() 
				if self.Owner:IsInWorld() == true then
				local tr = self.Owner:GetEyeTrace()
					self.Owner:SetPos(self.Owner:GetPos() - (tr.Normal*(self.Owner:BoundingRadius()*1.5)))
				end
				end)
				else
		local pl = self.Owner
		local ang = pl:GetAngles()
		local forward, right = ang:Forward(), ang:Right()
		
		local vel = -1 * pl:GetVelocity() -- Nullify current velocity
		vel = vel + Vector(0, 0, 2450) -- Add vertical force
		ply:EmitSound(ymt_teleport)
		self:DoAnimation("wos_yamato_trick_up")
		timer.Simple(0.063, function()
		if !IsValid(self) then return end
		vel = -1 * pl:GetVelocity()
		vel = vel + Vector(0, 0, 250)
		pl:SetVelocity(vel) 
		end)
		local spd = pl:GetMaxSpeed()	
		pl:SetVelocity(vel) 
				end
		end
		self.dodgetime1 = CurTime() + 0.6
		timer.Simple(0.2, function()
		if IsValid(dgtraileffect1) then 
		dgtraileffect1:Remove()
		end
		if IsValid(dgtraileffect2) then 
		dgtraileffect2:Remove()
		end
		end)
		end
--=============================-
 if self.trailtime > CurTime() then
	if self.trailcd < CurTime() then
 	local trail = util.SpriteTrail( ply, 0, Color( 0, 63, 255 ), false, 180, 1, 0.2, 0.02, "trails/physbeam" )
	local trail2 = util.SpriteTrail( ply, 0, Color( 255, 255, 255 ), false, 30, 1, 0.15, 0.02, "trails/tube" )
	timer.Simple(0.2, function()
		if IsValid(trail) then 
		trail:Remove()
		end
		if IsValid(trail2) then 
		trail2:Remove()
		end
	end)
	end
	self.trailcd = CurTime() + 0.5
 end
	if self.duringattacktime < CurTime() then
		self.duringattack = true
		self.Owner:SetWalkSpeed( 350 )
		self.Owner:SetRunSpeed( 100 )
		self.Owner:SetJumpPower(300)
		self.Owner:SetSlowWalkSpeed( 120 )
	elseif self.duringattacktime > CurTime() then
		self.duringattack = false
		self.Owner:SetWalkSpeed( 7 )
		self.Owner:SetSlowWalkSpeed( 10 )
		self.Owner:SetJumpPower(50)
		self.Owner:SetRunSpeed( 10 )
	end
end
end

function SWEP:Deploy()
if !IsValid(self.Owner) then return end
local ply = self.Owner
if SERVER then
if GetConVarNumber("ymt_3rdperson_on") == 1 then
	ply:ConCommand( "thirdperson_etp 1" )
		hook.Add("GetFallDamage", "RemoveFallDamage"..self.Owner:GetName(), function(ply, speed)
			if( GetConVarNumber( "mp_falldamage" ) > 0 ) then
				return ( speed - 826.5 ) * ( 100 / 896 )
			end
			return 0
		end)
end
end
end

function SWEP:ymttrail( trailtype, delay, fadetime, model, forward )
if !IsValid(self.Owner) then return end
local trailcolor_r
local trailcolor_g
local trailcolor_b
local ply = self.Owner
if SERVER then
if GetConVarNumber("ymt_trail") == 0 then 
local a
timer.Simple(delay,function()
if !IsValid(self) then return end
if trailtype == 1 then
trailcolor_r = GetConVarNumber("ymt_trail_r1")
trailcolor_g = GetConVarNumber("ymt_trail_g1")
trailcolor_b = GetConVarNumber("ymt_trail_b1")
elseif trailtype == 2 then
trailcolor_r = GetConVarNumber("ymt_trail_r2")
trailcolor_g = GetConVarNumber("ymt_trail_g2")
trailcolor_b = GetConVarNumber("ymt_trail_b2")
else
trailcolor_r = GetConVarNumber("ymt_trail_r3")
trailcolor_g = GetConVarNumber("ymt_trail_g3")
trailcolor_b = GetConVarNumber("ymt_trail_b3")
end

			a = ents.Create("prop_dynamic")
				a:SetModel(model)
				a:SetColor( Color( trailcolor_r, trailcolor_g, trailcolor_b, 0 ) )
				a:SetRenderMode( RENDERMODE_TRANSALPHA )
				a:SetModelScale( 0.7,0,1 )
				a:SetLocalAngles(ply:GetAngles())
				a:SetPos(ply:GetPos()+(ply:GetForward() * 1) * forward)
				a:Spawn()	
			timer.Simple(fadetime*0.1, function()
			if !IsValid(self) then if IsValid(a) then a:Remove() end return end
				a:SetModelScale( 1.3,fadetime*0.2,1 )
			end)
			timer.Simple(fadetime*0.4, function()
				if !IsValid(self) then if IsValid(a) then a:Remove() end return end
				a:SetModelScale( 1.6,fadetime,1 )
			end)
			timer.Simple(fadetime*0.1, function()
			if !IsValid(self) then if IsValid(a) then a:Remove() end return end
			a:SetColor( Color( trailcolor_r, trailcolor_g, trailcolor_b, 100 ) )
			end)
			timer.Simple(fadetime*0.2, function()
			if !IsValid(self) then if IsValid(a) then a:Remove() end return end
			a:SetColor( Color( trailcolor_r, trailcolor_g, trailcolor_b, 170 ) )	
			end)
			timer.Simple(fadetime*0.3, function()
			if !IsValid(self) then if IsValid(a) then a:Remove() end return end
			a:SetColor( Color( trailcolor_r, trailcolor_g, trailcolor_b, 255 ) )		
			end)
			timer.Simple(fadetime*0.4, function()
			if !IsValid(self) then if IsValid(a) then a:Remove() end return end
			a:SetColor( Color( trailcolor_r, trailcolor_g, trailcolor_b, 230 ) )		
			end)
			timer.Simple(fadetime*0.5, function()
			if !IsValid(self) then if IsValid(a) then a:Remove() end return end
			a:SetColor( Color( trailcolor_r, trailcolor_g, trailcolor_b, 170 ) )		
			end)
			timer.Simple(fadetime*0.6, function()
			if !IsValid(self) then if IsValid(a) then a:Remove() end return end
			a:SetColor( Color( trailcolor_r, trailcolor_g, trailcolor_b, 140 ) )		
			end)
			timer.Simple(fadetime*0.7, function()
			if !IsValid(self) then if IsValid(a) then a:Remove() end return end
			a:SetColor( Color( trailcolor_r, trailcolor_g, trailcolor_b, 80 ) )		
			end)
			timer.Simple(fadetime*0.8, function()
			if !IsValid(self) then if IsValid(a) then a:Remove() end return end
			a:SetColor( Color( trailcolor_r, trailcolor_g, trailcolor_b, 30 ) )		
			end)
			timer.Simple(fadetime*0.9, function()
			if !IsValid(self) then if IsValid(a) then a:Remove() end return end
			a:SetColor( Color( trailcolor_r, trailcolor_g, trailcolor_b, 0 ) )			
			end)
			timer.Simple(fadetime, function()
			if !IsValid(self) then if IsValid(a) then a:Remove() end return end
			a:Remove()		
			end)
	end)
end
end
end

function SWEP:RapidCut()
if !IsValid(self.Owner) then return end
local ply = self.Owner
self:ymttrail( 2, 0.03, 0.2, "models/yamatomod/yamatotrail_c4_i1.mdl", 3 )
self:ymttrail( 2, 0.06, 0.2, "models/yamatomod/yamatotrail_c4_i2.mdl", 3 )
self:ymttrail( 2, 0.09, 0.2, "models/yamatomod/yamatotrail_c4_i4.mdl", 3 )
self:ymttrail( 2, 0.12, 0.2, "models/yamatomod/yamatotrail_c4_i3.mdl", 3 )
self:ymttrail( 2, 0.15, 0.2, "models/yamatomod/yamatotrail_c4_i1.mdl", 3 )
self:ymttrail( 2, 0.17, 0.2, "models/yamatomod/yamatotrail_c4_i2.mdl", 8 )
self:ymttrail( 2, 0.18, 0.2, "models/yamatomod/yamatotrail_c4_i4.mdl", 8 )
self:ymttrail( 3, 0.2, 0.4, "models/yamatomod/yamatotrail_c4_1f.mdl", 7 )
self:DoCombo( false, "ymt_g_combo4_1inslash", 6, 0.03, 20, 85, 0.3, 0.6, 0, 0.1, false, 0 )
self:DoCombo( false, "ymt_g_combo4_1inslash", 6, 0.06, 20, 85, 0.3, 0.6, 0, 0.1, false, 0 )
self:DoCombo( false, "ymt_g_combo4_1inslash", 6, 0.09, 20, 85, 0.3, 0.6, 0, 0.1, false, 0 )
self:DoCombo( false, "ymt_g_combo4_1inslash", 6, 0.12, 20, 85, 0.3, 0.6, 0, 0.1, false, 0 )
self:DoCombo( false, "ymt_g_combo4_1inslash", 6, 0.15, 20, 85, 0.3, 0.6, 0, 0.1, false, 0 )
self:DoCombo( false, "ymt_g_combo4_1inslash", 6, 0.17, 20, 85, 0.3, 0.6, 0, 0.1, false, 0 )
self:DoCombo( false, "ymt_g_combo4_1inslash", 6, 0.18, 20, 85, 0.3, 0.6, 0, 0.1, false, 0 )
self:DoCombo( false, "ymt_g_combo4_1inslash", 17, 0.2, 30, 105, 0.3, 0.8, 0, 0.1, false, 0 )
if SERVER then
self.lockdowntimer = CurTime() + 0.7
self.Weapon:SetNextPrimaryFire(CurTime() + 0.7 )
		self.Weapon:SendWeaponAnim(ACT_VM_RECOIL1)
			local aimvec = self.Owner:GetAimVector()
			ply:SetVelocity(Vector(aimvec.x*4,aimvec.y*4,aimvec.z*0.3)*2000)
			self.dogetime = CurTime() + 1.4
			self.Owner:DoAnimationEvent( ACT_JUMP )
			self.Weapon:EmitSound("katana_doge")
		ply:ViewPunch(Angle(-6, 0, 0))
self:SetHoldType("ymt_rapidcut")
ply:SetAnimation(PLAYER_ATTACK1)
timer.Simple(0.1, function()
if !IsValid(self) then return end
self:SetHoldType("ymt_g_combo4_1finalslash")
ply:SetAnimation(PLAYER_ATTACK1)
end)
else
end
end

function SWEP:PrePlayerDraw(staff)
	staff:SetAnimTime(CurTime()+1)
end

function SWEP:JudgementCutEnd()
if SERVER then
local ply = self.Owner
local randbattlewords = math.random(1,2)
if SERVER then
if randbattlewords == 1 then
self:EmitSound(ymt_jcend1)
else
self:EmitSound(ymt_jcend2)
end
self:EmitSound(ymt_jc_ready)
end
self.dodgetime = CurTime() + 7
self:DoAnimation("wos_yamato_jcend_ready")
timer.Simple(3, function()if !IsValid(self)then return end
self:DoAnimation("wos_yamato_jcend_during")
self:Proptransform(ply,0.4,true,255,255,255,255,255,255,255,0,true,1,false)
self:SetNoDraw(true)
end)
if SERVER then
timer.Simple(3.5, function()if !IsValid(self)then return end
self:EmitSound(ymt_jc_during)
end)
timer.Simple(5.5, function()if !IsValid(self)then return end
self:EmitSound(ymt_jc_during2)
end)
end
timer.Simple(5.7, function()if !IsValid(self)then return end
self:Proptransform(ply,0.1,true,255,255,255,0,255,255,255,255,true,1,false)
self:Proptransform(self,0.1,true,255,255,255,0,255,255,255,255,true,1,false)
self:DoAnimation("wos_yamato_jcend_finish")
end)
ply:Freeze(true)
util.ScreenShake( ply:GetPos(),1, 250, 0.45, 5000 ) 
util.ScreenShake( ply:GetPos(),1, 250, 4, 5000 ) 
local main = ents.Create("prop_dynamic")
				main:SetModel("models/3dsky/r_skyfog.mdl")
				main:SetColor( Color( 255, 255, 255, 255 ) )
				main:SetRenderMode( RENDERMODE_TRANSALPHA )
				main:SetModelScale( 0,0,1 )
				main:SetPos(ply:GetPos())
				main:Spawn()
				main:SetParent(ply)
				local a1 = ents.Create("prop_dynamic")
				a1:SetModel("models/3dsky/r_skyfog.mdl")
				a1:SetColor( Color( 255, 255, 255, 255 ) )
				a1:SetMaterial( "models/props_combine/portalball001_sheet" )
				a1:SetRenderMode( RENDERMODE_TRANSALPHA )
				a1:SetModelScale( 0,0,1 )
				a1:SetPos(ply:GetPos())
				a1:Spawn()
				a1:SetParent(ply)
local b = ents.Create("prop_dynamic")
				b:SetModel("models/hunter/tubes/circle4x4.mdl")
				b:SetColor( Color( 255, 255, 255, 255 ) )
				b:SetRenderMode( RENDERMODE_TRANSALPHA )
				b:SetModelScale( 0,0,1 )
				b:SetMaterial( "models/props_combine/portalball001_sheet" )
				b:SetPos(ply:GetPos())
				b:Spawn()
				b:SetParent(ply)
local c1 = ents.Create("prop_dynamic")
				c1:SetModel("models/yamatomod/icut1.mdl")
				c1:SetColor( Color( 255, 255, 255, 0 ) )
				c1:SetRenderMode( RENDERMODE_TRANSALPHA )
				c1:SetModelScale( 0.7,0,1 )
				c1:SetMaterial( "debug/env_cubemap_model" )
				c1:SetPos(ply:GetPos())
				c1:Spawn()
				c1:SetParent(ply)
local c2 = ents.Create("prop_dynamic")
				c2:SetModel("models/yamatomod/icut2.mdl")
				c2:SetColor( Color( 255, 255, 255, 0 ) )
				c2:SetRenderMode( RENDERMODE_TRANSALPHA )
				c2:SetModelScale( 0.7,0,1 )
				c2:SetMaterial( "debug/env_cubemap_model" )
				c2:SetPos(ply:GetPos())
				c2:Spawn()
				c2:SetParent(ply)
local c3 = ents.Create("prop_dynamic")
				c3:SetModel("models/yamatomod/icut3.mdl")
				c3:SetColor( Color( 255, 255, 255, 0 ) )
				c3:SetRenderMode( RENDERMODE_TRANSALPHA )
				c3:SetModelScale( 0.7,0,1 )
				c3:SetMaterial( "debug/env_cubemap_model" )
				c3:SetPos(ply:GetPos())
				c3:Spawn()
				c3:SetParent(ply)
local c4 = ents.Create("prop_dynamic")
				c4:SetModel("models/yamatomod/icut4.mdl")
				c4:SetColor( Color( 255, 255, 255, 0 ) )
				c4:SetRenderMode( RENDERMODE_TRANSALPHA )
				c4:SetModelScale( 0.7,0,1 )
				c4:SetMaterial( "debug/env_cubemap_model" )
				c4:SetPos(ply:GetPos())
				c4:Spawn()
				c4:SetParent(ply)
local c5 = ents.Create("prop_dynamic")
				c5:SetModel("models/yamatomod/icut5.mdl")
				c5:SetColor( Color( 255, 255, 255, 0 ) )
				c5:SetRenderMode( RENDERMODE_TRANSALPHA )
				c5:SetModelScale( 0.7,0,1 )
				c5:SetMaterial( "debug/env_cubemap_model" )
				c5:SetPos(ply:GetPos())
				c5:Spawn()
				c5:SetParent(ply)
local c6 = ents.Create("prop_dynamic")
				c6:SetModel("models/yamatomod/icut6.mdl")
				c6:SetColor( Color( 255, 255, 255, 0 ) )
				c6:SetRenderMode( RENDERMODE_TRANSALPHA )
				c6:SetModelScale( 0.7,0,1 )
				c6:SetMaterial( "debug/env_cubemap_model" )
				c6:SetPos(ply:GetPos())
				c6:Spawn()
				c6:SetParent(ply)
local c7 = ents.Create("prop_dynamic")
				c7:SetModel("models/yamatomod/icut7.mdl")
				c7:SetColor( Color( 255, 255, 255, 0 ) )
				c7:SetRenderMode( RENDERMODE_TRANSALPHA )
				c7:SetModelScale( 0.7,0,1 )
				c7:SetMaterial( "debug/env_cubemap_model" )
				c7:SetPos(ply:GetPos())
				c7:Spawn()	
				c7:SetParent(ply)				
local c8 = ents.Create("prop_dynamic")
				c8:SetModel("models/yamatomod/icut8.mdl")
				c8:SetColor( Color( 255, 255, 255, 0 ) )
				c8:SetRenderMode( RENDERMODE_TRANSALPHA )
				c8:SetModelScale( 0.7,0,1 )
				c8:SetMaterial( "debug/env_cubemap_model" )
				c8:SetPos(ply:GetPos())
				c8:Spawn()	
				c8:SetParent(ply)
local p = ents.Create("prop_dynamic")
				p:SetModel("models/3dsky/r_skyfog.mdl")
				p:SetColor( Color( 255, 255, 255, 50 ) )
				p:SetRenderMode( RENDERMODE_TRANSALPHA )
				p:SetModelScale( 0,0,1 )
				p:SetPos(ply:GetPos())
				p:Spawn()	
				p:SetParent(ply)
self:Proptransform(a1,0.4,true,0,130,255,0,0,130,255,255,true,1,false) 
self:Proptransform(main,0.3,true,255,255,255,0,255,255,255,120,true,0.8,false) 
self:Proptransform(b,0.4,true,0,130,255,0,0,130,255,120,true,14.5,false) 
timer.Simple(7, function()ply:Freeze(false) end)
timer.Simple(0.3, function()if !IsValid(self) or !IsValid(ply) then return end self:Proptransform(main,0.2,true,255,255,255,120,255,255,255,50,true,1,false) end)
timer.Simple(1.7, function()if !IsValid(self) or !IsValid(ply) then return end
self:Proptransform(main,1.7,true,255,255,255,50,255,255,255,140,true,1.02,false)
self:Proptransform(b,1.7,true,0,130,255,120,0,130,255,120,true,14.8,false)  
end)
timer.Simple(3.4, function()if !IsValid(self) or !IsValid(ply) then return end
self:Proptransform(main,0.05,true,255,255,255,140,255,255,255,250,true,1,false) 
self:Proptransform(b,0.05,true,0,130,255,120,0,130,255,120,true,14.5,false)  
end)
timer.Simple(3.5, function()if !IsValid(self) or !IsValid(ply) then return end
a1:Remove() 
b:Remove()
--==================--
		local k, v
		local dmg = DamageInfo()
			dmg:SetDamage(75*(GetConVarNumber("yamato_damage")))
			dmg:SetDamageType(DMG_SLASH)
			dmg:SetAttacker(self.Owner)
			dmg:SetInflictor(self.Owner)
		for k, v in pairs ( ents.FindInSphere( self.Owner:GetPos(), 1400 ) ) do
			if v:IsValid() and v != self.Owner then
				dmg:SetDamageForce( ( v:GetPos() - self.Owner:GetPos() ):GetNormalized() * 100 )
				if v:IsNPC() then
				end
				v:TakeDamageInfo( dmg ) v:TakeDamageInfo( dmg ) v:TakeDamageInfo( dmg ) v:TakeDamageInfo( dmg ) v:TakeDamageInfo( dmg ) v:TakeDamageInfo( dmg ) v:TakeDamageInfo( dmg )
			end	
		end
--=================
self:Proptransform(c1,0.01,true,255,255,255,0,255,255,255,90,true,1,false)
util.ScreenShake( ply:GetPos(),1, 250, 0.45, 5000 ) 
timer.Simple(0.04, function()if !IsValid(self)then return end
util.ScreenShake( ply:GetPos(),1, 250, 0.45, 5000 ) 
self:Proptransform(c2,0.01,true,255,255,255,0,255,255,255,90,true,1,false)
end)
timer.Simple(0.08, function()if !IsValid(self)then return end
util.ScreenShake( ply:GetPos(),1, 250, 0.45, 5000 ) 
self:Proptransform(c3,0.01,true,255,255,255,0,255,255,255,90,true,1,false)
end)
timer.Simple(0.12, function()if !IsValid(self)then return end
util.ScreenShake( ply:GetPos(),1, 250, 0.45, 5000 ) 
self:Proptransform(c4,0.01,true,255,255,255,0,255,255,255,90,true,1,false)
end)
timer.Simple(0.16, function()if !IsValid(self)then return end
util.ScreenShake( ply:GetPos(),1, 250, 0.45, 5000 ) 
self:Proptransform(c5,0.01,true,255,255,255,0,255,255,255,90,true,1,false)
end)
timer.Simple(0.2, function()if !IsValid(self)then return end
util.ScreenShake( ply:GetPos(),1, 250, 0.45, 5000 ) 
self:Proptransform(c6,0.01,true,255,255,255,0,255,255,255,90,true,1,false)
end)
timer.Simple(0.24, function()if !IsValid(self)then return end
util.ScreenShake( ply:GetPos(),1, 250, 0.45, 5000 ) 
self:Proptransform(c7,0.01,true,255,255,255,0,255,255,255,90,true,1,false)
end)
timer.Simple(0.28, function()if !IsValid(self)then return end
util.ScreenShake( ply:GetPos(),1, 250, 0.45, 5000 ) 
self:Proptransform(c8,0.01,true,255,255,255,0,255,255,255,90,true,1,false)
end)
self:Proptransform(main,0.1,true,255,255,255,250,255,255,255,120,true,1,false) 
end)
timer.Simple(5, function()if !IsValid(self)then return end
self:Proptransform(main,2,true,255,255,255,120,255,255,255,150,true,0.92,false)
self:Proptransform(c1,2,true,255,255,255,90,255,255,255,140,true,0.95,false)
self:Proptransform(c2,2,true,255,255,255,90,255,255,255,140,true,0.95,false)
self:Proptransform(c3,2,true,255,255,255,90,255,255,255,140,true,0.95,false)
self:Proptransform(c4,2,true,255,255,255,90,255,255,255,140,true,0.95,false)
self:Proptransform(c5,2,true,255,255,255,90,255,255,255,140,true,0.95,false)
self:Proptransform(c6,2,true,255,255,255,90,255,255,255,140,true,0.95,false)
self:Proptransform(c7,2,true,255,255,255,90,255,255,255,140,true,0.95,false)
self:Proptransform(c8,2,true,255,255,255,90,255,255,255,140,true,0.95,false)
end)
timer.Simple(5.7, function()if !IsValid(self)then return end self:SetNoDraw(false) end)
timer.Simple(7, function()if !IsValid(self)then return end
util.ScreenShake( ply:GetPos(),1, 250, 0.45, 5000 ) 
self:Proptransform(main,0.1,true,255,255,255,150,255,255,235,0,true,1.3,true)
self:Proptransform(c1,0.1,true,255,255,255,140,255,255,255,0,true,1.3,true)
self:Proptransform(c2,0.1,true,255,255,255,140,255,255,255,0,true,1.3,true)
self:Proptransform(c3,0.1,true,255,255,255,140,255,255,255,0,true,1.3,true)
self:Proptransform(c4,0.1,true,255,255,255,140,255,255,255,0,true,1.3,true)
self:Proptransform(c5,0.1,true,255,255,255,140,255,255,255,0,true,1.3,true)
self:Proptransform(c6,0.1,true,255,255,255,140,255,255,255,0,true,1.3,true)
self:Proptransform(c7,0.1,true,255,255,255,140,255,255,255,0,true,1.3,true)
self:Proptransform(c8,0.1,true,255,255,255,140,255,255,255,0,true,1.3,true)
self:Proptransform(p,0.2,true,255,255,255,0,255,255,255,60,true,1.5,true) 
end)
end
end

function SWEP:SecondaryAttack()
local ply = self.Owner
timer.Simple(0.1, function()if !IsValid(self)then return end self:DoAnimation("wos_yamato_jcend_ready") end)
if self.duringattacktime < CurTime() and ply:IsOnGround() then
self:JudgementCutEnd()
end
end

function SWEP:Proptransform( obj, finishtime, changecolor, oldcolorr, oldcolorg, oldcolorb, oldcolors, colorr, colorg, colorb, colors, changesize, size, removeobj )
if SERVER then
local cvr = colorr - oldcolorr
local cvg = colorg - oldcolorg
local cvb = colorb - oldcolorb
local cvs = colors - oldcolors
if obj:IsPlayer() then
obj:SetRenderMode( RENDERMODE_TRANSALPHA )
end
if changesize == true then obj:SetModelScale( size,finishtime,1 )end
timer.Simple(finishtime*0.1, function()
	if !IsValid(self) then if IsValid(obj) then obj:Remove() end return end
	if changecolor == true then obj:SetColor( Color((oldcolorr+cvr*0.1), (oldcolorg+cvg*0.1), (oldcolorb+cvb*0.1), (oldcolors+cvs*0.1)) ) end	
end)
timer.Simple(finishtime*0.2, function()
	if !IsValid(self) then if IsValid(obj) then obj:Remove() end return end
	if changecolor == true then obj:SetColor( Color((oldcolorr+cvr*0.2), (oldcolorg+cvg*0.2), (oldcolorb+cvb*0.2), (oldcolors+cvs*0.2)) ) end	
end)
timer.Simple(finishtime*0.3, function()
	if !IsValid(self) then if IsValid(obj) then obj:Remove() end return end
	if changecolor == true then obj:SetColor( Color((oldcolorr+cvr*0.3), (oldcolorg+cvg*0.3), (oldcolorb+cvb*0.3), (oldcolors+cvs*0.3)) ) end	
end)
timer.Simple(finishtime*0.4, function()
	if !IsValid(self) then if IsValid(obj) then obj:Remove() end return end
	if changecolor == true then obj:SetColor( Color((oldcolorr+cvr*0.4), (oldcolorg+cvg*0.4), (oldcolorb+cvb*0.4), (oldcolors+cvs*0.4)) ) end	
end)
timer.Simple(finishtime*0.5, function()
	if !IsValid(self) then if IsValid(obj) then obj:Remove() end return end
	if changecolor == true then obj:SetColor( Color((oldcolorr+cvr*0.5), (oldcolorg+cvg*0.5), (oldcolorb+cvb*0.5), (oldcolors+cvs*0.5)) ) end	
end)
timer.Simple(finishtime*0.6, function()
	if !IsValid(self) then if IsValid(obj) then obj:Remove() end return end
	if changecolor == true then obj:SetColor( Color((oldcolorr+cvr*0.6), (oldcolorg+cvg*0.6), (oldcolorb+cvb*0.6), (oldcolors+cvs*0.6)) ) end	
end)
timer.Simple(finishtime*0.7, function()
	if !IsValid(self) then if IsValid(obj) then obj:Remove() end return end
	if changecolor == true then obj:SetColor( Color((oldcolorr+cvr*0.7), (oldcolorg+cvg*0.7), (oldcolorb+cvb*0.7), (oldcolors+cvs*0.7)) ) end	
end)
timer.Simple(finishtime*0.8, function()
	if !IsValid(self) then if IsValid(obj) then obj:Remove() end return end
	if changecolor == true then obj:SetColor( Color((oldcolorr+cvr*0.8), (oldcolorg+cvg*0.8), (oldcolorb+cvb*0.8), (oldcolors+cvs*0.8)) ) end	
end)
timer.Simple(finishtime*0.9, function()
	if !IsValid(self) then if IsValid(obj) then obj:Remove() end return end
	if changecolor == true then obj:SetColor( Color((oldcolorr+cvr*0.9), (oldcolorg+cvg*0.9), (oldcolorb+cvb*0.9), (oldcolors+cvs*0.9)) ) end	
end)
timer.Simple(finishtime, function()
	if !IsValid(self) then if IsValid(obj) then obj:Remove() end return end
	if changecolor == true then obj:SetColor( Color((oldcolorr+cvr*1), (oldcolorg+cvg*1), (oldcolorb+cvb*1), (oldcolors+cvs*1)) ) end	
end)
timer.Simple(finishtime, function()
	if !IsValid(self) then if IsValid(obj) then obj:Remove() end return end
	if removeobj == true then obj:Remove() end	
end)

end
end

function SWEP:Holster()
local ply = self.Owner
if SERVER then
ply:Freeze(false)
hook.Remove("EntityTakeDamage", "YamatoDodge"..ply:GetName())
hook.Remove("GetFallDamage", "RemoveFallDamage"..ply:GetName())
if GetConVarNumber("ymt_3rdperson_off") == 1 then
ply:ConCommand( "thirdperson_etp 0" )
end
ply:SetWalkSpeed( 250 )
ply:SetRunSpeed( 400 )
ply:SetJumpPower(200)
ply:SetSlowWalkSpeed( 120 )
end
return true
end

function SWEP:Teleport()
	if !IsValid(self.Owner) then return end
	local vm = self.Owner:GetViewModel()
	local effectdata = EffectData()
	local ply = self.Owner
	if SERVER then
	self.trailtime = CurTime() + 0.2
	ply:EmitSound(GetConVarString("ymt_dodgelsound"))
	end
	self.teleport_gotopos = (self.Owner:GetEyeTrace().HitPos)
		ply = self.Owner
		pos = ply:GetPos()
		tracedata = {}
		tracedata.start = pos
		tracedata.endpos = pos
		tracedata.filter = ply
		tracedata.mins = ply:OBBMins()
		tracedata.maxs = ply:OBBMaxs()
		trace = util.TraceHull( tracedata )
		if (trace.Entity:IsWorld() or trace.Entity:IsValid()) then return end
end

function SWEP:DoBattleCry( hascd, delay, voicelevel )
if !IsValid(self.Owner) then return end
if SERVER then
timer.Simple(delay, function()
if !IsValid(self) then return end
if hascd == true then
if self.battlecrycd < CurTime()  then
if voicelevel == 1 then
local randbattlecry = math.random(1,4)
if randbattlecry == 1 then
self:EmitSound(ymt_vo_l1)
elseif randbattlecry == 2 then
self:EmitSound(ymt_vo_l2)
elseif randbattlecry == 3 then
self:EmitSound(ymt_vo_l3)
elseif randbattlecry == 4 then
self:EmitSound(ymt_vo_l4)
end
elseif voicelevel == 2 then
local randbattlecry = math.random(1,3)
if randbattlecry == 1 then
self:EmitSound(ymt_vo_l4)
elseif randbattlecry == 2 then
self:EmitSound(ymt_vo_m1)
elseif randbattlecry == 3 then
self:EmitSound(ymt_vo_m2)
end
elseif voicelevel == 3 then
local randbattlecry = math.random(1,4)
if randbattlecry == 1 then
self:EmitSound(ymt_vo_h1)
elseif randbattlecry == 2 then
self:EmitSound(ymt_vo_m1)
elseif randbattlecry == 3 then
self:EmitSound(ymt_vo_m2)
elseif randbattlecry == 4 then
self:EmitSound(ymt_vo_h1)
end
end
self.battlecrycd = CurTime() + 0.6
end
else
end
end)
end
end

function SWEP:OnDrop()
if !IsValid(self.Owner) then return end
local ply = self.Owner
	if SERVER then
	ply:Freeze(false)
		hook.Remove("EntityTakeDamage", "YamatoDodge"..self.Owner:GetName())
		hook.Remove("GetFallDamage", "RemoveFallDamage"..self.Owner:GetName())
	end
	return true
end

function SWEP:Reload()

end

function SWEP:OnRemove()
if !IsValid(self.Owner) then return end
local ply = self.Owner
	if SERVER then
	ply:Freeze(false)
		hook.Remove("EntityTakeDamage", "YamatoDodge"..self.Owner:GetName())
		hook.Remove("GetFallDamage", "RemoveFallDamage"..self.Owner:GetName())
	end
	return true
end
