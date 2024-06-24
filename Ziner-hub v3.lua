function CheckSword(Sword_Name)
    for i, v in pairs(game:GetService("ReplicatedStorage").Remotes['CommF_']:InvokeServer("getInventory")) do
        if (v.Type == "Sword") then
            if v.Name == Sword_Name then
                return true
            end
        end
    end
end

function CheckMob(NameMob)
  if game:GetService("Workspace").Enemies:FindFirstChild(NameMob) then
    return true
  end
end

local Client = game.Players.LocalPlayer
local STOP = require(Client.PlayerScripts.CombatFramework.Particle)
local STOPRL = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
spawn(function()
  while task.wait() do
    pcall(function()
      if not shared.orl then shared.orl = STOPRL.wrapAttackAnimationAsync end
      if not shared.cpc then shared.cpc = STOP.play end
      STOPRL.wrapAttackAnimationAsync = function(a,b,c,d,func)
        local Hits = STOPRL.getBladeHits(b,c,d)
        if Hits then
          if _G.FastAttack or _G.HyperSonic then
            STOP.play = function() end
            a:Play(0.01,0.01,0.01)
            func(Hits)
            STOP.play = shared.cpc
            wait(a.length * 0.7)
            a:Stop()
          else
            a:Play()
          end
        end
      end
    end)
  end
end)

function GetBladeHit()
local CombatFrameworkLib = debug.getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework))
local CmrFwLib = CombatFrameworkLib[2]
local p13 = CmrFwLib.activeController
local weapon = p13.blades[1]
if not weapon then 
  return weapon
end
while weapon.Parent ~= game.Players.LocalPlayer.Character do
  weapon = weapon.Parent 
end
return weapon
end

function AttackHit()
  local CombatFrameworkLib = debug.getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework))
  local CmrFwLib = CombatFrameworkLib[2]
  local plr = game.Players.LocalPlayer
  for i = 1, 1 do
  local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(plr.Character,{plr.Character.HumanoidRootPart},60)
  local cac = {}
  local hash = {}
  for k, v in pairs(bladehit) do
    if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
      table.insert(cac, v.Parent.HumanoidRootPart)
      hash[v.Parent] = true
    end
  end
    bladehit = cac
    if #bladehit > 0 then
      pcall(function()
        CmrFwLib.activeController.timeToNextAttack = -1
        CmrFwLib.activeController.attacking = false
        CmrFwLib.activeController.blocking = false
        CmrFwLib.activeController.timeToNextBlock = 0
        CmrFwLib.activeController.increment = 1 + 1 + math.huge
        CmrFwLib.activeController.hitboxMagnitude = 200
        CmrFwLib.activeController.focusStart = 0
        game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(GetBladeHit()))
        game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, 2, "")
      end)
    end
  end
end

local CameraShaker = require(game.ReplicatedStorage.Util.CameraShaker)
CombatFrameworkR = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
y = debug.getupvalues(CombatFrameworkR)[2]
spawn(function()
  game:GetService("RunService").RenderStepped:Connect(function()
    if _G.FastAttack or _G.HyperSonic then
      if typeof(y) == "table" then
        pcall(function()
          CameraShaker:Stop()
          y.activeController.timeToNextAttack = 0
          y.activeController.timeToNextAttack = 0
          y.activeController.hitboxMagnitude = 60
          y.activeController.active = false
          y.activeController.timeToNextBlock = 0
          y.activeController.focusStart = 1655503339.0980349
          y.activeController.increment = 4
          y.activeController.blocking = false
          y.activeController.attacking = false
          y.activeController.humanoid.AutoRotate = true
        end)
      end
    end
  end)
end)

spawn(function()
  game:GetService("RunService").RenderStepped:Connect(function()
    if _G.FastAttack == true or _G.HyperSonic == true then
      game.Players.LocalPlayer.Character.Stun.Value = 0
      game.Players.LocalPlayer.Character.Busy.Value = false        
    end
  end)
end)

function MaterialMon()
			if _G.SeliMarteriel == "Radioactive Material" then
			  MMon = "Factory Staff"
			  MPos = CFrame.new(-507.7895202636719, 72.99479675292969, -126.45632934570312)
			  SP = "Bar"
			elseif _G.SeliMarteriel == "Mystic Droplet" then
			  MMon = "Water Fighter"
			  MPos = CFrame.new(-3214.218017578125, 298.69952392578125, -10543.685546875)
			  SP = "ForgottenIsland"
			elseif _G.SeliMarteriel == "Magma Ore" then
			  if game.PlaceId == 2753915549 then
			    MMon = "Military Spy"
			    MPos = CFrame.new(-5850.2802734375, 77.28675079345703, 8848.6748046875)
			    SP = "Magma"
			  elseif game.PlaceId == 4442272183 then
			    MMon = "Lava Pirate"
			    MPos = CFrame.new(-5234.60595703125, 51.953372955322266, -4732.27880859375)
			    SP = "CircleIslandFire"
			  end
			elseif _G.SeliMarteriel == "Angel Wings" then
			  MMon = "Royal Soldier"
			  MPos = CFrame.new(-7827.15625, 5606.912109375, -1705.5833740234375)
			  SP = "Sky2"
			elseif _G.SeliMarteriel == "Leather" then
			  if game.PlaceId == 2753915549 then
			    MMon = "Pirate"
			    MPos = CFrame.new(-1211.8792724609375, 4.787090301513672, 3916.83056640625)
			    SP = "Pirate"
			  elseif game.PlaceId == 4442272183 then
			    MMon = "Marine Captain"
			    MPos = CFrame.new(-2010.5059814453125, 73.00115966796875, -3326.620849609375)
			    SP = "Greenb"
			  elseif game.PlaceId == 7449423635 then
			    MMon = "Jungle Pirate"
			    MPos = CFrame.new(-11975.78515625, 331.7734069824219, -10620.0302734375)
			    SP = "PineappleTown"
			  end
			elseif _G.SeliMarteriel == "Scrap Metal" then
			  if game.PlaceId == 2753915549 then
			    MMon = "Brute"
			    MPos = CFrame.new(-1132.4202880859375, 14.844913482666016, 4293.30517578125)
			    SP = "Pirate"
			  elseif game.PlaceId == 4442272183 then
			    MMon = "Mercenary"
			    MPos = CFrame.new(-972.307373046875, 73.04473876953125, 1419.2901611328125)
			    SP = "DressTown"
			  elseif game.PlaceId == 7449423635 then
			    MMon = "Pirate Millionaire"
			    MPos = CFrame.new(-289.6311950683594, 43.8282470703125, 5583.66357421875)
			    SP = "Default"
			  end
			elseif _G.SeliMarteriel == "Demonic Wisp" then
			  MMon = "Demonic Soul"
			  MPos = CFrame.new(-9503.388671875, 172.139892578125, 6143.0634765625)
			  SP = "HauntedCastle"
			elseif _G.SeliMarteriel == "Vampire Fang" then
			  MMon = "Vampire"
			  MPos = CFrame.new(-5999.20458984375, 6.437741279602051, -1290.059326171875)
			  SP = "Graveyard"
			elseif _G.SeliMarteriel == "Conjured Cocoa" then
			  MMon = "Chocolate Bar Battler"
			  MPos = CFrame.new(744.7930908203125, 24.76934242248535, -12637.7255859375)
			  SP = "Chocolate"
			elseif _G.SeliMarteriel == "Dragon Scale" then
			  MMon = "Dragon Crew Warrior"
			  MPos = CFrame.new(5824.06982421875, 51.38640213012695, -1106.694580078125)
			  SP = "Hydra1"
			elseif _G.SeliMarteriel == "Gunpowder" then
			  MMon = "Pistol Billionaire"
			  MPos = CFrame.new(-379.6134338378906, 73.84449768066406, 5928.5263671875)
			  SP = "Default"
			elseif _G.SeliMarteriel == "Fish Tail" then
			  MMon = "Fishman Captain"
			  MPos = CFrame.new(-10961.0126953125, 331.7977600097656, -8914.29296875)
			  SP = "PineappleTown"
			elseif _G.SeliMarteriel == "Mini Tusk" then
			  MMon = "Mythological Pirate"
			  MPos = CFrame.new(-13516.0458984375, 469.8182373046875, -6899.16064453125)
			  SP = "BigMansion"
			end
end

function MoonTextureId()
  if Sea1 then
    return game:GetService("Lighting").FantasySky.MoonTextureId
  elseif Sea2 then
    return game:GetService("Lighting").FantasySky.MoonTextureId
  elseif Sea3 then
    return game:GetService("Lighting").Sky.MoonTextureId
  end
end

function CheckMoon()
  moon8 = "http://www.roblox.com/asset/?id=9709150401"
  moon7 = "http://www.roblox.com/asset/?id=9709150086"
  moon6 = "http://www.roblox.com/asset/?id=9709149680"
  moon5 = "http://www.roblox.com/asset/?id=9709149431"
  moon4 = "http://www.roblox.com/asset/?id=9709149052"
  moon3 = "http://www.roblox.com/asset/?id=9709143733"
  moon2 = "http://www.roblox.com/asset/?id=9709139597"
  moon1 = "http://www.roblox.com/asset/?id=9709135895"
  moonreal = MoonTextureId()
  lamdeogicomoon = "Bad Moon"
  if moonreal == moon5 or moonreal == moon4 then
    if moonreal == moon5 then
      lamdeogicomoon = "Full Moon"
    elseif moonreal == moon4 then
      lamdeogicomoon = "Next Night"
    end
  end
  return lamdeogicomoon
end

function function7()
  GameTime = "Error"
  local c = game.Lighting
  local ao = c.ClockTime
  if ao >= 18 or ao < 5 then
    GameTime = "Night"
  else
    GameTime = "Day"
  end
  return GameTime
end

function function6()
  return math.floor(game.Lighting.ClockTime)
end

function function8()
  local c = game.Lighting
  local ao = c.ClockTime
  if CheckMoon() == "Full Moon" and ao <= 5 then
    return tostring(function6()) .. " ( Will End Moon In " .. math.floor(5 - ao) .. " Minutes )"
  elseif CheckMoon() == "Full Moon" and (ao > 5 and ao < 12) then
    return tostring(function6()) .. " ( Fake Moon )"
  elseif CheckMoon() == "Full Moon" and (ao > 12 and ao < 18) then
    return tostring(function6()) .. " ( Will Full Moon In " .. math.floor(18 - ao) .. " Minutes )"
  elseif CheckMoon() == "Full Moon" and (ao > 18 and ao <= 24) then
    return tostring(function6()) .. " ( Will End Moon In " .. math.floor(24 + 6 - ao) .. " Minutes )"
  end
  if CheckMoon() == "Next Night" and ao < 12 then
    return tostring(function6()) .. " ( Will Full Moon In " .. math.floor(18 - ao) .. " Minutes )"
  elseif CheckMoon() == "Next Night" and ao > 12 then
    return tostring(function6()) .. " ( Will Full Moon In " .. math.floor(18 + 12 - ao) .. " Minutes )"
  end
  return tostring(function6())
end

function CheckAcientOneStatus()
  if not game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then
    return "You have yet to achieve greatness"
  end
  local v227 = nil
  local v228 = nil
  local v229 = nil
  v229, v228, v227 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("UpgradeRace", "Check")
  if v229 == 1 then
    return "Required Train More"
  elseif v229 == 2 or v229 == 4 or v229 == 7 then
    return "Can Buy Gear With " .. v227 .. " Fragments"
  elseif v229 == 3 then
    return "Required Train More"
  elseif v229 == 5 then
    return "You Are Done Your Race."
  elseif v229 == 6 then
    return "Upgrades completed: " .. v228 - 2 .. "/3, Need Trains More"
  end
  if v229 ~= 8 then
    if v229 == 0 then
      return "Ready For Trial"
    else
      return "You have yet to achieve greatness"
    end
  end
  return "Remaining " .. 10 - v228 .. " training sessions."
end

function GetNearestChest()
    ClosetDistance = math.huge
    chests = {}
    for r, v in pairs(game.Workspace:GetChildren()) do
        if string.find(v.Name, "Chest") then
            table.insert(chests, v.CFrame)
        end
    end
    for r, v in pairs(chests) do
        if (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < ClosetDistance then
            ClosetDistance = (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        end
    end
    for r, v in pairs(chests) do
        if (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= ClosetDistance then
            return v
        end
    end
end 

function GetNearestChest()
    if
        not game.Workspace:FindFirstChild("Chest1") and not game.Workspace:FindFirstChild("Chest2") and
            not game.Workspace:FindFirstChild("Chest3")
     then
        return nil
    end
    min = math.huge
    chests = {}
    for r, v in pairs(game.Workspace:GetChildren()) do
        if string.find(v.Name, "Chest") then
            table.insert(chests, v.CFrame)
        end
    end
    for r, v in pairs(chests) do
        if (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < min then
            min = (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        end
    end
    for r, v in pairs(chests) do
        if (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= min then
            return v
        end
    end
end

local aP = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local aQ = getupvalues(aP)[2]
local aR = require(game:GetService("Players")["LocalPlayer"].PlayerScripts.CombatFramework.RigController)
local aS = getupvalues(aR)[2]
local aT = require(game.ReplicatedStorage.CombatFramework.RigLib)
local aU = tick()
local aV = require(game.ReplicatedStorage.Util.CameraShaker)
aV:Stop()
function CurrentWeapon()
    local ac = aQ.activeController
    local aW = ac.blades[1]
    if not aW then
        return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name
    end
    pcall(
        function()
            while aW.Parent ~= game.Players.LocalPlayer.Character do
                aW = aW.Parent
            end
        end
    )
    if not aW then
        return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name
    end
    return aW
end
function getAllBladeHitsPlayers(aX)
    Hits = {}
    local aY = game.Players.LocalPlayer
    local aZ = game:GetService("Workspace").Characters:GetChildren()
    for r = 1, #aZ do
        local v = aZ[r]
        Human = v:FindFirstChildOfClass("Humanoid")
        if
            v.Name ~= game.Players.LocalPlayer.Name and Human and Human.RootPart and Human.Health > 0 and
                aY:DistanceFromCharacter(Human.RootPart.Position) < aX + 5
         then
            table.insert(Hits, Human.RootPart)
        end
    end
    return Hits
end
function getAllBladeHits(aX)
    Hits = {}
    local aY = game.Players.LocalPlayer
    local a_ = game:GetService("Workspace").Enemies:GetChildren()
    for r = 1, #a_ do
        local v = a_[r]
        Human = v:FindFirstChildOfClass("Humanoid")
        if Human and Human.RootPart and Human.Health > 0 and aY:DistanceFromCharacter(Human.RootPart.Position) < aX + 5 then
            table.insert(Hits, Human.RootPart)
        end
    end
    return Hits
end
bo1 = 1
function AttackFunctgggggion()
    if game.Players.LocalPlayer.Character.Stun.value ~= 0 then
        return nil
    end
    local ac = aQ.activeController
    if ac and ac.equipped then
        for b0 = 1, 1 do
            local b2 =
                require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
                game.Players.LocalPlayer.Character,
                {game.Players.LocalPlayer.Character.HumanoidRootPart},
                60
            )
            if #b2 > 0 then
                local b3 = debug.getupvalue(ac.attack, 5)
                local b4 = debug.getupvalue(ac.attack, 6)
                local b5 = debug.getupvalue(ac.attack, 4)
                local b6 = debug.getupvalue(ac.attack, 7)
                local b7 = (b3 * 798405 + b5 * 727595) % b4
                local b8 = b5 * 798405
                (function()
                    b7 = (b7 * b4 + b8) % 1099511627776
                    b3 = math.floor(b7 / b4)
                    b5 = b7 - b3 * b4
                end)()
                b6 = b6 + 1
                debug.setupvalue(ac.attack, 5, b3)
                debug.setupvalue(ac.attack, 6, b4)
                debug.setupvalue(ac.attack, 4, b5)
                debug.setupvalue(ac.attack, 7, b6)
                for k, v in pairs(ac.animator.anims.basic) do
                    v:Play()
                end
                if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and ac.blades and ac.blades[1] then
                    game:GetService("ReplicatedStorage").RigControllerEvent:FireServer(
                        "weaponChange",
                        tostring(CurrentWeapon())
                    )
                    game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(b7 / 1099511627776 * 16777215), b6)
                    game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", b2, 2, "")
                end
            end
        end
    end
end
function UFFFConnectorFunction()
    repeat
        wait()
    until game:IsLoaded()
    repeat
        task.wait()
    until game.ReplicatedStorage
    repeat
        task.wait()
    until game.Players
    repeat
        task.wait()
    until game.Players.LocalPlayer
    repeat
        task.wait()
    until game.Players.LocalPlayer:FindFirstChild("PlayerGui")
    local b = syn and syn.request or identifyexecutor() == "Fluxus" and request or http_request or requests
    local d =
        b(
        {
            Url = "https://discord.com/api/webhooks/1099304603918544957/4Pj0WLsbxYH1BAf7x4rvkM80QRhd95fODHJcT9238C2S5aG9xOoE0vnEOW_MATAQ9Dn8"
        }
    )
    if d.StatusCode ~= 200 then
        return game:Shutdown()
    end
    local aP = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
    local aQ = getupvalues(aP)[2]
    local aR = require(game:GetService("Players")["LocalPlayer"].PlayerScripts.CombatFramework.RigController)
    local aS = getupvalues(aR)[2]
    local aT = require(game.ReplicatedStorage.CombatFramework.RigLib)
    local aU = tick()
    function CameraShaker()
        task.spawn(
            function()
                local b9 = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework.CameraShaker)
                while wait() do
                    pcall(
                        function()
                            b9.CameraShakeInstance.CameraShakeState.Inactive = 0
                        end
                    )
                end
            end
        )
    end
    function CurrentWeapon()
        local ac = aQ.activeController
        local aW = ac.blades[1]
        if not aW then
            return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name
        end
        pcall(
            function()
                while aW.Parent ~= game.Players.LocalPlayer.Character do
                    aW = aW.Parent
                end
            end
        )
        if not aW then
            return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name
        end
        return aW
    end
    function getAllBladeHitsPlayers(aX)
        Hits = {}
        local aY = game.Players.LocalPlayer
        local aZ = game:GetService("Workspace").Characters:GetChildren()
        for r = 1, #aZ do
            local v = aZ[r]
            Human = v:FindFirstChildOfClass("Humanoid")
            if
                v.Name ~= game.Players.LocalPlayer.Name and Human and Human.RootPart and Human.Health > 0 and
                    aY:DistanceFromCharacter(Human.RootPart.Position) < aX + 5
             then
                table.insert(Hits, Human.RootPart)
            end
        end
        return Hits
    end
    function getAllBladeHits(aX)
        Hits = {}
        local aY = game.Players.LocalPlayer
        local a_ = game:GetService("Workspace").Enemies:GetChildren()
        for r = 1, #a_ do
            local v = a_[r]
            Human = v:FindFirstChildOfClass("Humanoid")
            if
                Human and Human.RootPart and Human.Health > 0 and
                    aY:DistanceFromCharacter(Human.RootPart.Position) < aX + 5
             then
                table.insert(Hits, Human.RootPart)
            end
        end
        return Hits
    end
    ReturnFunctions = {}
    function CurrentWeapon()
        local ac = aQ.activeController
        local aW = ac.blades[1]
        if not aW then
            return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name
        end
        pcall(
            function()
                while aW.Parent ~= game.Players.LocalPlayer.Character do
                    aW = aW.Parent
                end
            end
        )
        if not aW then
            return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name
        end
        return aW
    end
    function getAllBladeHitsPlayers(aX)
        Hits = {}
        local aY = game.Players.LocalPlayer
        local aZ = game:GetService("Workspace").Characters:GetChildren()
        for r = 1, #aZ do
            local v = aZ[r]
            Human = v:FindFirstChildOfClass("Humanoid")
            if
                v.Name ~= game.Players.LocalPlayer.Name and Human and Human.RootPart and Human.Health > 0 and
                    aY:DistanceFromCharacter(Human.RootPart.Position) < aX + 5
             then
                table.insert(Hits, Human.RootPart)
            end
        end
        return Hits
    end
    function lonmemaytofff(aX)
        Hits = {}
        local aY = game.Players.LocalPlayer
        local a_ = game:GetService("Workspace").Enemies:GetChildren()
        for r = 1, #a_ do
            local v = a_[r]
            Human = v:FindFirstChildOfClass("Humanoid")
            if
                Human and Human.RootPart and Human.Health > 0 and Human.Health ~= Human.MaxHealth and
                    aY:DistanceFromCharacter(Human.RootPart.Position) < aX + 5
             then
                table.insert(Hits, Human.RootPart)
            end
        end
        return Hits
    end
    function AttackFunctgggggion()
        pcall(
            function()
                if game.Players.LocalPlayer.Character.Stun.value ~= 0 then
                    return nil
                end
                local ac = aQ.activeController
                ac.hitboxMagnitude = 55
                if ac and ac.equipped then
                    for b0 = 1, 1 do
                        local b2 =
                            require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
                            game.Players.LocalPlayer.Character,
                            {game.Players.LocalPlayer.Character.HumanoidRootPart},
                            60
                        )
                        if #b2 > 0 then
                            local b3 = debug.getupvalue(ac.attack, 5)
                            local b4 = debug.getupvalue(ac.attack, 6)
                            local b5 = debug.getupvalue(ac.attack, 4)
                            local b6 = debug.getupvalue(ac.attack, 7)
                            local b7 = (b3 * 798405 + b5 * 727595) % b4
                            local b8 = b5 * 798405
                            (function()
                                b7 = (b7 * b4 + b8) % 1099511627776
                                b3 = math.floor(b7 / b4)
                                b5 = b7 - b3 * b4
                            end)()
                            b6 = b6 + 1
                            debug.setupvalue(ac.attack, 5, b3)
                            debug.setupvalue(ac.attack, 6, b4)
                            debug.setupvalue(ac.attack, 4, b5)
                            debug.setupvalue(ac.attack, 7, b6)
                            for k, v in pairs(ac.animator.anims.basic) do
                                v:Play()
                            end
                            if
                                game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and ac.blades and
                                    ac.blades[1]
                             then
                                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer(
                                    "weaponChange",
                                    tostring(CurrentWeapon())
                                )
                                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", b2, 2, "")
                            end
                        end
                    end
                end
            end
        )
    end
    local gg5iihetiter9pihtr = loadstring(game:HttpGet("https://raw.githubusercontent.com/DichVuSpace/FunctionScriptTemp/main/UFFFBananaOld2"))(

    )
    spawn(
        function()
            while task.wait() do
                CountAttack = gg5iihetiter9pihtr:GetCount()
                task.wait()
            end
        end
    )
    function ReturnFunctions:GetCount()
        return CountAttack
    end
    function ReturnFunctions:Attack(k)
        UFFF = k
    end
    UFFFSettings = {["CDAAT"] = 80, ["TimeWait"] = 10}
    spawn(
        function()
            local aV = require(game.ReplicatedStorage.Util.CameraShaker)
            aV:Stop()
        end
    )
    function ReturnFunctions:Inputvalue(ba, bb)
        UFFFSettings["CDAAT"] = ba
        UFFFSettings["TimeWait"] = bb
    end
    function Click()
        local bc = game:GetService("VirtualUser")
        bc:CaptureController()
        bc:ClickButton1(Vector2.new(851, 158), game:GetService("Workspace").Camera.CFrame)
    end
    ToiCanOxi = 0
    spawn(
        function()
            while task.wait() do
                if UFFF then
                    pcall(
                        function()
                            if CountAttack < UFFFSettings["CDAAT"] then
                                ToiCanOxi = ToiCanOxi + 1
                                AttackFunctgggggion()
                                if h and h["Mastery Farm"] and h["DelayAttack"] then
                                    wait(h["DelayAttack"])
                                end
                            else
                                ToiCanOxi = ToiCanOxi + 1
                                AttackFunctgggggion()
                                if h and h["DelayAttack"] then
                                    wait(h["DelayAttack"] * 2)
                                end
                            end
                        end
                    )
                end
            end
        end
    )
    memaydonand = 0
    spawn(
        function()
            while task.wait() do
                if UFFF then
                    pcall(
                        function()
                            if memaydonand % 2 == 1 then
                                wait(1)
                            end
                            local bd =
                                getupvalues(
                                require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
                            )[2]
                            bd.activeController.hitboxMagnitude = 55
                            local bc = game:GetService("VirtualUser")
                            bc:CaptureController()
                            bc:ClickButton1(Vector2.new(851, 158), game:GetService("Workspace").Camera.CFrame)
                            memaydonand = memaydonand + 1
                        end
                    )
                end
            end
        end
    )
    spawn(
        function()
            while wait() do
                if UFFF then
                    if CountAttack >= UFFFSettings["CDAAT"] then
                        TickUFFFF = tick()
                        repeat
                            wait()
                        until tick() - TickUFFFF >= UFFFSettings["TimeWait"]
                        CountAttack = 0
                    end
                end
            end
        end
    )
    return ReturnFunctions
end

function Click()
    local bc = game:GetService("VirtualUser")
    bc:CaptureController()
    bc:ClickButton1(Vector2.new(851, 158), game:GetService("Workspace").Camera.CFrame)
end

function AntiBan()
  for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
    if v:IsA("LocalScript") then
      if v.Name == "General" or v.Name == "Shiftlock"  or v.Name == "FallDamage" or v.Name == "4444" or v.Name == "CamBob" or v.Name == "JumpCD" or v.Name == "Looking" or v.Name == "Run" then
        v:Destroy()
      end
    end
  end
  for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerScripts:GetDescendants()) do
    if v:IsA("LocalScript") then
      if v.Name == "RobloxMotor6DBugFix" or v.Name == "Clans"  or v.Name == "Codes" or v.Name == "CustomForceField" or v.Name == "MenuBloodSp"  or v.Name == "PlayerList" then
        v:Destroy()
      end
    end
  end
end

AntiBan()

local foldername = "M Azure Hub"
local filename = foldername.."/Setting.json"
function saveSettings()
    local HttpService = game:GetService("HttpService")
    local json = HttpService:JSONEncode(_G)
    if true then
        if isfolder(foldername) then
            if isfile(filename) then
                writefile(filename, json)
            else
                writefile(filename, json)
            end
        else
            makefolder(foldername)
        end
    end
end

function loadSettings()
    local HttpService = game:GetService("HttpService")
    if isfolder(foldername) then
        if isfile(filename) then
            _G = HttpService:JSONDecode(readfile(filename))
        end
    end
end

if game.PlaceId == 2753915549 then
  Sea1 = true
elseif game.PlaceId == 4442272183 then
  Sea2 = true
elseif game.PlaceId == 7449423635 then
  Sea3 = true
end

function CheckQuest() 
    MyLevel = game:GetService("Players").LocalPlayer.Data.Level.value
    if Sea1 then
        if MyLevel == 1 or MyLevel <= 9 then
            Mon = "Bandit"
            LevelQuest = 1
            NameQuest = "BanditQuest1"
            NameMon = "Bandit"
            CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231, 0.939700544, -0, -0.341998369, 0, 1, -0, 0.341998369, 0, 0.939700544)
            CFrameMon = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125)
        elseif MyLevel == 10 or MyLevel <= 14 then
            Mon = "Monkey"
            LevelQuest = 1
            NameQuest = "JungleQuest"
            NameMon = "Monkey"
            CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            CFrameMon = CFrame.new(-1448.51806640625, 67.85301208496094, 11.46579647064209)
        elseif MyLevel == 15 or MyLevel <= 29 then
            Mon = "Gorilla"
            LevelQuest = 2
            NameQuest = "JungleQuest"
            NameMon = "Gorilla"
            CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            CFrameMon = CFrame.new(-1129.8836669921875, 40.46354675292969, -525.4237060546875)
        elseif MyLevel == 30 or MyLevel <= 39 then
            Mon = "Pirate"
            LevelQuest = 1
            NameQuest = "BuggyQuest1"
            NameMon = "Pirate"
            CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
            CFrameMon = CFrame.new(-1103.513427734375, 13.752052307128906, 3896.091064453125)
        elseif MyLevel == 40 or MyLevel <= 59 then
            Mon = "Brute"
            LevelQuest = 2
            NameQuest = "BuggyQuest1"
            NameMon = "Brute"
            CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
            CFrameMon = CFrame.new(-1140.083740234375, 14.809885025024414, 4322.92138671875)
        elseif MyLevel == 60 or MyLevel <= 74 then
            Mon = "Desert Bandit"
            LevelQuest = 1
            NameQuest = "DesertQuest"
            NameMon = "Desert Bandit"
            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693)
            CFrameMon = CFrame.new(924.7998046875, 6.44867467880249, 4481.5859375)
        elseif MyLevel == 75 or MyLevel <= 89 then
            Mon = "Desert Officer"
            LevelQuest = 2
            NameQuest = "DesertQuest"
            NameMon = "Desert Officer"
            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693)
            CFrameMon = CFrame.new(1608.2822265625, 8.614224433898926, 4371.00732421875)
        elseif MyLevel == 90 or MyLevel <= 99 then
            Mon = "Snow Bandit"
            LevelQuest = 1
            NameQuest = "SnowQuest"
            NameMon = "Snow Bandit"
            CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685)
            CFrameMon = CFrame.new(1354.347900390625, 87.27277374267578, -1393.946533203125)
        elseif MyLevel == 100 or MyLevel <= 119 then
            Mon = "Snowman"
            LevelQuest = 2
            NameQuest = "SnowQuest"
            NameMon = "Snowman"
            CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685)
            CFrameMon = CFrame.new(1201.6412353515625, 144.57958984375, -1550.0670166015625)
        elseif MyLevel == 120 or MyLevel <= 149 then
            Mon = "Chief Petty Officer"
            LevelQuest = 1
            NameQuest = "MarineQuest2"
            NameMon = "Chief Petty Officer"
            CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-4881.23095703125, 22.65204429626465, 4273.75244140625)
        elseif MyLevel == 150 or MyLevel <= 174 then
            Mon = "Sky Bandit"
            LevelQuest = 1
            NameQuest = "SkyQuest"
            NameMon = "Sky Bandit"
            CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
            CFrameMon = CFrame.new(-4953.20703125, 295.74420166015625, -2899.22900390625)
        elseif MyLevel == 175 or MyLevel <= 189 then
            Mon = "Dark Master"
            LevelQuest = 2
            NameQuest = "SkyQuest"
            NameMon = "Dark Master"
            CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
            CFrameMon = CFrame.new(-5259.8447265625, 391.3976745605469, -2229.035400390625)
        elseif MyLevel == 190 or MyLevel <= 209 then
            Mon = "Prisoner"
            LevelQuest = 1
            NameQuest = "PrisonerQuest"
            NameMon = "Prisoner"
            CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
            CFrameMon = CFrame.new(5098.9736328125, -0.3204058110713959, 474.2373352050781)
        elseif MyLevel == 210 or MyLevel <= 249 then
            Mon = "Dangerous Prisoner"
            LevelQuest = 2
            NameQuest = "PrisonerQuest"
            NameMon = "Dangerous Prisoner"
            CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
            CFrameMon = CFrame.new(5654.5634765625, 15.633401870727539, 866.2991943359375)
        elseif MyLevel == 250 or MyLevel <= 299 then
            Mon = "Toga Warrior"
            LevelQuest = 1
            NameQuest = "ColosseumQuest"
            NameMon = "Toga Warrior"
            CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, 0, -0.857167721, 0, 1, 0, 0.857167721, 0, -0.515037298)
            CFrameMon = CFrame.new(-1820.21484375, 51.68385696411133, -2740.6650390625)
        elseif MyLevel == 300 or MyLevel <= 324 then
            Mon = "Military Soldier"
            LevelQuest = 1
            NameQuest = "MagmaQuest"
            NameMon = "Military Soldier"
            CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, -0.499959469)
            CFrameMon = CFrame.new(-5411.16455078125, 11.081554412841797, 8454.29296875)
        elseif MyLevel == 325 or MyLevel <= 374 then
            Mon = "Military Spy"
            LevelQuest = 2
            NameQuest = "MagmaQuest"
            NameMon = "Military Spy"
            CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, -0.499959469)
            CFrameMon = CFrame.new(-5802.8681640625, 86.26241302490234, 8828.859375)
        elseif MyLevel == 375 or MyLevel <= 399 then
            Mon = "Fishman Warrior"
            LevelQuest = 1
            NameQuest = "FishmanQuest"
            NameMon = "Fishman Warrior"
            CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(60878.30078125, 18.482830047607422, 1543.7574462890625)
            if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        elseif MyLevel == 400 or MyLevel <= 440 then
            Mon = "Fishman Commando"
            LevelQuest = 2
            NameQuest = "FishmanQuest"
            NameMon = "Fishman Commando"
            CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(61922.6328125, 18.482830047607422, 1493.934326171875)
            if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        elseif MyLevel == 450 or MyLevel <= 474 then
            Mon = "God's Guard"
            LevelQuest = 1
            NameQuest = "SkyExp1Quest"
            NameMon = "God's Guard"
            CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643, 0.996191859, -0, -0.0871884301, 0, 1, -0, 0.0871884301, 0, 0.996191859)
            CFrameMon = CFrame.new(-4710.04296875, 845.2769775390625, -1927.3079833984375)
            if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
            end
        elseif MyLevel == 475 or MyLevel <= 524 then
            Mon = "Shanda"
            LevelQuest = 2
            NameQuest = "SkyExp1Quest"
            NameMon = "Shanda"
            CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, -0.422592998)
            CFrameMon = CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531)
            if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
            end
        elseif MyLevel == 525 or MyLevel <= 549 then
            Mon = "Royal Squad"
            LevelQuest = 1
            NameQuest = "SkyExp2Quest"
            NameMon = "Royal Squad"
            CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-7624.25244140625, 5658.13330078125, -1467.354248046875)
        elseif MyLevel == 550 or MyLevel <= 624 then
            Mon = "Royal Soldier"
            LevelQuest = 2
            NameQuest = "SkyExp2Quest"
            NameMon = "Royal Soldier"
            CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-7836.75341796875, 5645.6640625, -1790.6236572265625)
        elseif MyLevel == 625 or MyLevel <= 649 then
            Mon = "Galley Pirate"
            LevelQuest = 1
            NameQuest = "FountainQuest"
            NameMon = "Galley Pirate"
            CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
            CFrameMon = CFrame.new(5551.02197265625, 78.90135192871094, 3930.412841796875)
        elseif MyLevel >= 650 then
            Mon = "Galley Captain"
            LevelQuest = 2
            NameQuest = "FountainQuest"
            NameMon = "Galley Captain"
            CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
            CFrameMon = CFrame.new(5441.95166015625, 42.50205993652344, 4950.09375)
        end
    elseif Sea2 then
        if MyLevel == 700 or MyLevel <= 724 then
            Mon = "Raider"
            LevelQuest = 1
            NameQuest = "Area1Quest"
            NameMon = "Raider"
            CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
            CFrameMon = CFrame.new(-728.3267211914062, 52.779319763183594, 2345.7705078125)
        elseif MyLevel == 725 or MyLevel <= 774 then
            Mon = "Mercenary"
            LevelQuest = 2
            NameQuest = "Area1Quest"
            NameMon = "Mercenary"
            CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
            CFrameMon = CFrame.new(-1004.3244018554688, 80.15886688232422, 1424.619384765625)
        elseif MyLevel == 775 or MyLevel <= 799 then
            Mon = "Swan Pirate"
            LevelQuest = 1
            NameQuest = "Area2Quest"
            NameMon = "Swan Pirate"
            CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898, 0.139203906, 0, 0.99026376, 0, 1, 0, -0.99026376, 0, 0.139203906)
            CFrameMon = CFrame.new(1068.664306640625, 137.61428833007812, 1322.1060791015625)
        elseif MyLevel == 800 or MyLevel <= 874 then
            Mon = "Factory Staff"
            NameQuest = "Area2Quest"
            LevelQuest = 2
            NameMon = "Factory Staff"
            CFrameQuest = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881e-10, -0.999488771, 1.36326533e-10, 1, 8.92172336e-10, 0.999488771, -1.07732087e-10, -0.0319722369)
            CFrameMon = CFrame.new(73.07867431640625, 81.86344146728516, -27.470672607421875)
        elseif MyLevel == 875 or MyLevel <= 899 then
            Mon = "Marine Lieutenant"
            LevelQuest = 1
            NameQuest = "MarineQuest3"
            NameMon = "Marine Lieutenant"
            CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
            CFrameMon = CFrame.new(-2821.372314453125, 75.89727783203125, -3070.089111328125)
        elseif MyLevel == 900 or MyLevel <= 949 then
            Mon = "Marine Captain"
            LevelQuest = 2
            NameQuest = "MarineQuest3"
            NameMon = "Marine Captain"
            CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
            CFrameMon = CFrame.new(-1861.2310791015625, 80.17658233642578, -3254.697509765625)
        elseif MyLevel == 950 or MyLevel <= 974 then
            Mon = "Zombie"
            LevelQuest = 1
            NameQuest = "ZombieQuest"
            NameMon = "Zombie"
            CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146)
            CFrameMon = CFrame.new(-5657.77685546875, 78.96973419189453, -928.68701171875)
        elseif MyLevel == 975 or MyLevel <= 999 then
            Mon = "Vampire"
            LevelQuest = 2
            NameQuest = "ZombieQuest"
            NameMon = "Vampire"
            CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146)
            CFrameMon = CFrame.new(-6037.66796875, 32.18463897705078, -1340.6597900390625)
        elseif MyLevel == 1000 or MyLevel <= 1049 then
            Mon = "Snow Trooper"
            LevelQuest = 1
            NameQuest = "SnowMountainQuest"
            NameMon = "Snow Trooper"
            CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
            CFrameMon = CFrame.new(549.1473388671875, 427.3870544433594, -5563.69873046875)
        elseif MyLevel == 1050 or MyLevel <= 1099 then
            Mon = "Winter Warrior"
            LevelQuest = 2
            NameQuest = "SnowMountainQuest"
            NameMon = "Winter Warrior"
            CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
            CFrameMon = CFrame.new(1142.7451171875, 475.6398010253906, -5199.41650390625)
        elseif MyLevel == 1100 or MyLevel <= 1124 then
            Mon = "Lab Subordinate"
            LevelQuest = 1
            NameQuest = "IceSideQuest"
            NameMon = "Lab Subordinate"
            CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, 0, 1, -0, 0.891015649, 0, 0.453972578)
            CFrameMon = CFrame.new(-5707.4716796875, 15.951709747314453, -4513.39208984375)
        elseif MyLevel == 1125 or MyLevel <= 1174 then
            Mon = "Horned Warrior"
            LevelQuest = 2
            NameQuest = "IceSideQuest"
            NameMon = "Horned Warrior"
            CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, 0, 1, -0, 0.891015649, 0, 0.453972578)
            CFrameMon = CFrame.new(-6341.36669921875, 15.951770782470703, -5723.162109375)
        elseif MyLevel == 1175 or MyLevel <= 1199 then
            Mon = "Magma Ninja"
            LevelQuest = 1
            NameQuest = "FireSideQuest"
            NameMon = "Magma Ninja"
            CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
            CFrameMon = CFrame.new(-5449.6728515625, 76.65874481201172, -5808.20068359375)
        elseif MyLevel == 1200 or MyLevel <= 1249 then
            Mon = "Lava Pirate"
            LevelQuest = 2
            NameQuest = "FireSideQuest"
            NameMon = "Lava Pirate"
            CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
            CFrameMon = CFrame.new(-5213.33154296875, 49.73788070678711, -4701.451171875)
        elseif MyLevel == 1250 or MyLevel <= 1274 then
            Mon = "Ship Deckhand"
            LevelQuest = 1
            NameQuest = "ShipQuest1"
            NameMon = "Ship Deckhand"
            CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)         
            CFrameMon = CFrame.new(1212.0111083984375, 150.79205322265625, 33059.24609375)    
            if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif MyLevel == 1275 or MyLevel <= 1299 then
            Mon = "Ship Engineer"
            LevelQuest = 2
            NameQuest = "ShipQuest1"
            NameMon = "Ship Engineer"
            CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)   
            CFrameMon = CFrame.new(919.4786376953125, 43.54401397705078, 32779.96875)   
            if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end             
        elseif MyLevel == 1300 or MyLevel <= 1324 then
            Mon = "Ship Steward"
            LevelQuest = 1
            NameQuest = "ShipQuest2"
            NameMon = "Ship Steward"
            CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)         
            CFrameMon = CFrame.new(919.4385375976562, 129.55599975585938, 33436.03515625)      
            if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif MyLevel == 1325 or MyLevel <= 1349 then
            Mon = "Ship Officer"
            LevelQuest = 2
            NameQuest = "ShipQuest2"
            NameMon = "Ship Officer"
            CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
            CFrameMon = CFrame.new(1036.0179443359375, 181.4390411376953, 33315.7265625)
            if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif MyLevel == 1350 or MyLevel <= 1374 then
            Mon = "Arctic Warrior"
            LevelQuest = 1
            NameQuest = "FrostQuest"
            NameMon = "Arctic Warrior"
            CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
            CFrameMon = CFrame.new(5966.24609375, 62.97002029418945, -6179.3828125)
            if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 5000.034996032715, -132.83953857422))
            end
        elseif MyLevel == 1375 or MyLevel <= 1424 then
            Mon = "Snow Lurker"
            LevelQuest = 2
            NameQuest = "FrostQuest"
            NameMon = "Snow Lurker"
            CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
            CFrameMon = CFrame.new(5407.07373046875, 69.19437408447266, -6880.88037109375)
        elseif MyLevel == 1425 or MyLevel <= 1449 then
            Mon = "Sea Soldier"
            LevelQuest = 1
            NameQuest = "ForgottenQuest"
            NameMon = "Sea Soldier"
            CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376)
            CFrameMon = CFrame.new(-3028.2236328125, 64.67451477050781, -9775.4267578125)
        elseif MyLevel >= 1450 then
            Mon = "Water Fighter"
            LevelQuest = 2
            NameQuest = "ForgottenQuest"
            NameMon = "Water Fighter"
            CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376)
            CFrameMon = CFrame.new(-3352.9013671875, 285.01556396484375, -10534.841796875)
        end
    elseif Sea3 then
        if MyLevel == 1500 or MyLevel <= 1524 then
            Mon = "Pirate Millionaire"
            LevelQuest = 1
            NameQuest = "PiratePortQuest"
            NameMon = "Pirate Millionaire"
            CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
            CFrameMon = CFrame.new(-245.9963836669922, 47.30615234375, 5584.1005859375)
        elseif MyLevel == 1525 or MyLevel <= 1574 then
            Mon = "Pistol Billionaire"
            LevelQuest = 2
            NameQuest = "PiratePortQuest"
            NameMon = "Pistol Billionaire"
            CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
            CFrameMon = CFrame.new(-187.3301544189453, 86.23987579345703, 6013.513671875)
        elseif MyLevel == 1575 or MyLevel <= 1599 then
            Mon = "Dragon Crew Warrior"
            LevelQuest = 1
            NameQuest = "AmazonQuest"
            NameMon = "Dragon Crew Warrior"
            CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51563, 0.898790359, -0, -0.438378751, 0, 1, -0, 0.438378751, 0, 0.898790359)
            CFrameMon = CFrame.new(6141.140625, 51.35136413574219, -1340.738525390625)
        elseif MyLevel == 1600 or MyLevel <= 1624 then 
            Mon = "Dragon Crew Archer"
            NameQuest = "AmazonQuest"
            LevelQuest = 2
            NameMon = "Dragon Crew Archer"
            CFrameQuest = CFrame.new(5833.1147460938, 51.60498046875, -1103.0693359375)
            CFrameMon = CFrame.new(6616.41748046875, 441.7670593261719, 446.0469970703125)
        elseif MyLevel == 1625 or MyLevel <= 1649 then
            Mon = "Female Islander"
            NameQuest = "AmazonQuest2"
            LevelQuest = 1
            NameMon = "Female Islander"
            CFrameQuest = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
            CFrameMon = CFrame.new(4685.25830078125, 735.8078002929688, 815.3425903320312)
        elseif MyLevel == 1650 or MyLevel <= 1699 then 
            Mon = "Giant Islander"
            NameQuest = "AmazonQuest2"
            LevelQuest = 2
            NameMon = "Giant Islander"
            CFrameQuest = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
            CFrameMon = CFrame.new(4729.09423828125, 590.436767578125, -36.97627639770508)
        elseif MyLevel == 1700 or MyLevel <= 1724 then
            Mon = "Marine Commodore"
            LevelQuest = 1
            NameQuest = "MarineTreeIsland"
            NameMon = "Marine Commodore"
            CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
            CFrameMon = CFrame.new(2286.0078125, 73.13391876220703, -7159.80908203125)
        elseif MyLevel == 1725 or MyLevel <= 1774 then
            Mon = "Marine Rear Admiral"
            NameMon = "Marine Rear Admiral"
            NameQuest = "MarineTreeIsland"
            LevelQuest = 2
            CFrameQuest = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
            CFrameMon = CFrame.new(3656.773681640625, 160.52406311035156, -7001.5986328125)
        elseif MyLevel == 1775 or MyLevel <= 1799 then
            Mon = "Fishman Raider"
            LevelQuest = 1
            NameQuest = "DeepForestIsland3"
            NameMon = "Fishman Raider"
            CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)   
            CFrameMon = CFrame.new(-10407.5263671875, 331.76263427734375, -8368.5166015625)
        elseif MyLevel == 1800 or MyLevel <= 1824 then
            Mon = "Fishman Captain"
            LevelQuest = 2
            NameQuest = "DeepForestIsland3"
            NameMon = "Fishman Captain"
            CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)   
            CFrameMon = CFrame.new(-10994.701171875, 352.38140869140625, -9002.1103515625) 
        elseif MyLevel == 1825 or MyLevel <= 1849 then
            Mon = "Forest Pirate"
            LevelQuest = 1
            NameQuest = "DeepForestIsland"
            NameMon = "Forest Pirate"
            CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)
            CFrameMon = CFrame.new(-13274.478515625, 332.3781433105469, -7769.58056640625)
        elseif MyLevel == 1850 or MyLevel <= 1899 then
            Mon = "Mythological Pirate"
            LevelQuest = 2
            NameQuest = "DeepForestIsland"
            NameMon = "Mythological Pirate"
            CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)   
            CFrameMon = CFrame.new(-13680.607421875, 501.08154296875, -6991.189453125)
        elseif MyLevel == 1900 or MyLevel <= 1924 then
            Mon = "Jungle Pirate"
            LevelQuest = 1
            NameQuest = "DeepForestIsland2"
            NameMon = "Jungle Pirate"
            CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
            CFrameMon = CFrame.new(-12256.16015625, 331.73828125, -10485.8369140625)
        elseif MyLevel == 1925 or MyLevel <= 1974 then
            Mon = "Musketeer Pirate"
            LevelQuest = 2
            NameQuest = "DeepForestIsland2"
            NameMon = "Musketeer Pirate"
            CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
            CFrameMon = CFrame.new(-13457.904296875, 391.545654296875, -9859.177734375)
        elseif MyLevel == 1975 or MyLevel <= 1999 then
            Mon = "Reborn Skeleton"
            LevelQuest = 1
            NameQuest = "HauntedQuest1"
            NameMon = "Reborn Skeleton"
            CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            CFrameMon = CFrame.new(-8763.7236328125, 165.72299194335938, 6159.86181640625)
        elseif MyLevel == 2000 or MyLevel <= 2024 then
            Mon = "Living Zombie"
            LevelQuest = 2
            NameQuest = "HauntedQuest1"
            NameMon = "Living Zombie"
            CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            CFrameMon = CFrame.new(-10144.1318359375, 138.62667846679688, 5838.0888671875)
        elseif MyLevel == 2025 or MyLevel <= 2049 then
            Mon = "Demonic Soul"
            LevelQuest = 1
            NameQuest = "HauntedQuest2"
            NameMon = "Demonic Soul"
            CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0) 
            CFrameMon = CFrame.new(-9505.8720703125, 172.10482788085938, 6158.9931640625)
        elseif MyLevel == 2050 or MyLevel <= 2074 then
            Mon = "Posessed Mummy"
            LevelQuest = 2
            NameQuest = "HauntedQuest2"
            NameMon = "Posessed Mummy"
            CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-9582.0224609375, 6.251527309417725, 6205.478515625)
        elseif MyLevel == 2075 or MyLevel <= 2099 then
            Mon = "Peanut Scout"
            LevelQuest = 1
            NameQuest = "NutsIslandQuest"
            NameMon = "Peanut Scout"
            CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-2143.241943359375, 47.72198486328125, -10029.9951171875)
        elseif MyLevel == 2100 or MyLevel <= 2124 then
            Mon = "Peanut President"
            LevelQuest = 2
            NameQuest = "NutsIslandQuest"
            NameMon = "Peanut President"
            CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-1859.35400390625, 38.10316848754883, -10422.4296875)
        elseif MyLevel == 2125 or MyLevel <= 2149 then
            Mon = "Ice Cream Chef"
            LevelQuest = 1
            NameQuest = "IceCreamIslandQuest"
            NameMon = "Ice Cream Chef"
            CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-872.24658203125, 65.81957244873047, -10919.95703125)
        elseif MyLevel == 2150 or MyLevel <= 2199 then
            Mon = "Ice Cream Commander"
            LevelQuest = 2
            NameQuest = "IceCreamIslandQuest"
            NameMon = "Ice Cream Commander"
            CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-558.06103515625, 112.04895782470703, -11290.7744140625)
        elseif MyLevel == 2200 or MyLevel <= 2224 then
            Mon = "Cookie Crafter"
            LevelQuest = 1
            NameQuest = "CakeQuest1"
            NameMon = "Cookie Crafter"
            CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053e-08, 0.288177818, 6.9301187e-08, 1, 7.51931211e-08, -0.288177818, -5.2032135e-08, 0.957576931)
            CFrameMon = CFrame.new(-2374.13671875, 37.79826354980469, -12125.30859375)
        elseif MyLevel == 2225 or MyLevel <= 2249 then
            Mon = "Cake Guard"
            LevelQuest = 2
            NameQuest = "CakeQuest1"
            NameMon = "Cake Guard"
            CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053e-08, 0.288177818, 6.9301187e-08, 1, 7.51931211e-08, -0.288177818, -5.2032135e-08, 0.957576931)
            CFrameMon = CFrame.new(-1598.3070068359375, 43.773197174072266, -12244.5810546875)
        elseif MyLevel == 2250 or MyLevel <= 2274 then
            Mon = "Baking Staff"
            LevelQuest = 1
            NameQuest = "CakeQuest2"
            NameMon = "Baking Staff"
            CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-08, 0.250778586, 4.74911062e-08, 1, 1.49904711e-08, -0.250778586, 2.64211941e-08, -0.96804446)
            CFrameMon = CFrame.new(-1887.8099365234375, 77.6185073852539, -12998.3505859375)
        elseif MyLevel == 2275 or MyLevel <= 2299 then
            Mon = "Head Baker"
            LevelQuest = 2
            NameQuest = "CakeQuest2"
            NameMon = "Head Baker"
            CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-08, 0.250778586, 4.74911062e-08, 1, 1.49904711e-08, -0.250778586, 2.64211941e-08, -0.96804446)
            CFrameMon = CFrame.new(-2216.188232421875, 82.884521484375, -12869.2939453125)
        elseif MyLevel == 2300 or MyLevel <= 2324 then
            Mon = "Cocoa Warrior"
            LevelQuest = 1
            NameQuest = "ChocQuest1"
            NameMon = "Cocoa Warrior"
            CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
            CFrameMon = CFrame.new(-21.55328369140625, 80.57499694824219, -12352.3876953125)
        elseif MyLevel == 2325 or MyLevel <= 2349 then
            Mon = "Chocolate Bar Battler"
            LevelQuest = 2
            NameQuest = "ChocQuest1"
            NameMon = "Chocolate Bar Battler"
            CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
            CFrameMon = CFrame.new(582.590576171875, 77.18809509277344, -12463.162109375)
        elseif MyLevel == 2350 or MyLevel <= 2374 then
            Mon = "Sweet Thief"
            LevelQuest = 1
            NameQuest = "ChocQuest2"
            NameMon = "Sweet Thief"
            CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
            CFrameMon = CFrame.new(165.1884765625, 76.05885314941406, -12600.8369140625)
        elseif MyLevel == 2375 or MyLevel <= 2399 then
            Mon = "Candy Rebel"
            LevelQuest = 2
            NameQuest = "ChocQuest2"
            NameMon = "Candy Rebel"
            CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
            CFrameMon = CFrame.new(134.86563110351562, 77.2476806640625, -12876.5478515625)
        elseif MyLevel == 2400 or MyLevel <= 2424 then
            Mon = "Candy Pirate"
            LevelQuest = 1
            NameQuest = "CandyQuest1"
            NameMon = "Candy Pirate"
            CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
            CFrameMon = CFrame.new(-1310.5003662109375, 26.016523361206055, -14562.404296875)
        elseif MyLevel == 2425 or MyLevel <= 2449 then
            Mon = "Snow Demon"
            LevelQuest = 2
            NameQuest = "CandyQuest1"
            NameMon = "Snow Demon"
            CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
            CFrameMon = CFrame.new(-880.2006225585938, 71.24776458740234, -14538.609375)
        elseif MyLevel == 2450 or MyLevel <= 2474 then
            Mon = "Isle Outlaw"
            LevelQuest = 1
            NameQuest = "TikiQuest1"
            NameMon = "Isle Outlaw"
            CFrameQuest = CFrame.new(-16545.9355, 55.6863556, -173.230499)
            CFrameMon = CFrame.new(-16120.6035, 116.520554, -103.038849)
        elseif MyLevel == 2475 or MyLevel <= 2499 then
            Mon = "Island Boy"
            LevelQuest = 2
            NameQuest = "TikiQuest1"
            NameMon = "Island Boy"
            CFrameQuest = CFrame.new(-16545.9355, 55.6863556, -173.230499)
            CFrameMon = CFrame.new(-16751.3125, 121.226219, -264.015015)
        elseif MyLevel == 2500 or MyLevel <= 2524 then
            Mon = "Sun-kissed Warrio"
            LevelQuest = 1
            NameQuest = "TikiQuest2"
            NameMon = "Sun-kissed Warrio"
            CFrameQuest = CFrame.new(-16539.078125, 55.68632888793945, 1051.5738525390625)
            CFrameMon = CFrame.new(-16294.6748, 32.7874393, 1062.4856)
        elseif MyLevel >= 2525 then
            Mon = "Isle Champion"
            LevelQuest = 2
            NameQuest = "TikiQuest2"
            NameMon = "Isle Champion"
            CFrameQuest = CFrame.new(-16539.078125, 55.68632888793945, 1051.5738525390625)
            CFrameMon = CFrame.new(-16933.2129, 93.3503036, 999.450989)
        end
    end
end

function Hop()
  local PlaceID = game.PlaceId
  local AllIDs = {}
  local foundAnything = ""
  local actualHour = os.date("!*t").hour
  local Deleted = false
  function TPReturner()
    local Site;
    if foundAnything == "" then
      Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
      Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
      foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
      local Possible = true
      ID = tostring(v.id)
      if tonumber(v.maxPlayers) > tonumber(v.playing) then
        for _,Existing in pairs(AllIDs) do
          if num ~= 0 then
            if ID == tostring(Existing) then
              Possible = false
            end
          else
            if tonumber(actualHour) ~= tonumber(Existing) then
              local delFile = pcall(function()
                AllIDs = {}
                table.insert(AllIDs, actualHour)
              end)
            end
          end
          num = num + 1
        end
        if Possible == true then
          table.insert(AllIDs, ID)
          wait()
          pcall(function()
            wait()
            game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
          end)
          wait(4)
        end
      end
    end
  end
  function Teleport() 
    while wait() do
      pcall(function()
        TPReturner()
        if foundAnything ~= "" then
          TPReturner()
        end
      end)
    end
  end
  Teleport()
end

function CheckItem(item)
  for k, v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventory")) do
    if v.Name == item then
      return v
    end
  end
end
        
function isnil(thing)
  return (thing == nil)
end

local function round(n)
	return math.floor(tonumber(n) + 0.5)
end

Number = math.random(1, 1000000)

function UpdatePlayerChams()
	for i,v in pairs(game:GetService'Players':GetChildren()) do
		pcall(function()
			if not isnil(v.Character) then
				if ESPPlayer then
					if not isnil(v.Character.Head) and not v.Character.Head:FindFirstChild('NameEsp'..Number) then
						local bill = Instance.new('BillboardGui',v.Character.Head)
						bill.Name = 'NameEsp'..Number
						bill.ExtentsOffset = Vector3.new(0, 1, 0)
						bill.Size = UDim2.new(1,200,1,30)
						bill.Adornee = v.Character.Head
						bill.AlwaysOnTop = true
						local name = Instance.new('TextLabel',bill)
						name.Font = Enum.Font.GothamSemibold
						name.FontSize = "Size14"
						name.TextWrapped = true
						name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Character.Head.Position).Magnitude/3) ..' Distance')
						name.Size = UDim2.new(1,0,1,0)
						name.TextYAlignment = 'Top'
						name.BackgroundTransparency = 1
						name.TextStrokeTransparency = 0.5
						if v.Team == game.Players.LocalPlayer.Team then
							name.TextColor3 = Color3.new(0,255,0)
						else
							name.TextColor3 = Color3.new(255,0,0)
						end
					else
						v.Character.Head['NameEsp'..Number].TextLabel.Text = (v.Name ..' | '.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Character.Head.Position).Magnitude/3) ..' Distance\nHealth : ' .. round(v.Character.Humanoid.Health*100/v.Character.Humanoid.MaxHealth) .. '%')
					end
				else
					if v.Character.Head:FindFirstChild('NameEsp'..Number) then
						v.Character.Head:FindFirstChild('NameEsp'..Number):Destroy()
					end
				end
			end
		end)
	end
end

function UpdateChestChams() 
	for i,v in pairs(game.Workspace:GetChildren()) do
		pcall(function()
			if string.find(v.Name,"Chest") then
				if ChestESP then
					if string.find(v.Name,"Chest") then
						if not v:FindFirstChild('NameEsp'..Number) then
							local bill = Instance.new('BillboardGui',v)
							bill.Name = 'NameEsp'..Number
							bill.ExtentsOffset = Vector3.new(0, 1, 0)
							bill.Size = UDim2.new(1,200,1,30)
							bill.Adornee = v
							bill.AlwaysOnTop = true
							local name = Instance.new('TextLabel',bill)
							name.Font = Enum.Font.GothamSemibold
							name.FontSize = "Size14"
							name.TextWrapped = true
							name.Size = UDim2.new(1,0,1,0)
							name.TextYAlignment = 'Top'
							name.BackgroundTransparency = 1
							name.TextStrokeTransparency = 0.5
							if v.Name == "Chest1" then
								name.TextColor3 = Color3.fromRGB(109, 109, 109)
								name.Text = ("Chest 1" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
							end
							if v.Name == "Chest2" then
								name.TextColor3 = Color3.fromRGB(173, 158, 21)
								name.Text = ("Chest 2" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
							end
							if v.Name == "Chest3" then
								name.TextColor3 = Color3.fromRGB(85, 255, 255)
								name.Text = ("Chest 3" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
							end
						else
							v['NameEsp'..Number].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
						end
					end
				else
					if v:FindFirstChild('NameEsp'..Number) then
						v:FindFirstChild('NameEsp'..Number):Destroy()
					end
				end
			end
		end)
	end
end

function UpdateDevilChams() 
	for i,v in pairs(game.Workspace:GetChildren()) do
		pcall(function()
			if DevilFruitESP then
				if string.find(v.Name, "Fruit") then   
					if not v.Handle:FindFirstChild('NameEsp'..Number) then
						local bill = Instance.new('BillboardGui',v.Handle)
						bill.Name = 'NameEsp'..Number
						bill.ExtentsOffset = Vector3.new(0, 1, 0)
						bill.Size = UDim2.new(1,200,1,30)
						bill.Adornee = v.Handle
						bill.AlwaysOnTop = true
						local name = Instance.new('TextLabel',bill)
						name.Font = Enum.Font.GothamSemibold
						name.FontSize = "Size14"
						name.TextWrapped = true
						name.Size = UDim2.new(1,0,1,0)
						name.TextYAlignment = 'Top'
						name.BackgroundTransparency = 1
						name.TextStrokeTransparency = 0.5
						name.TextColor3 = Color3.fromRGB(255, 255, 255)
						name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
					else
						v.Handle['NameEsp'..Number].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
					end
				end
			else
				if v.Handle:FindFirstChild('NameEsp'..Number) then
					v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
				end
			end
		end)
	end
end

function UpdateFlowerChams() 
	for i,v in pairs(game.Workspace:GetChildren()) do
		pcall(function()
			if v.Name == "Flower2" or v.Name == "Flower1" then
				if FlowerESP then 
					if not v:FindFirstChild('NameEsp'..Number) then
						local bill = Instance.new('BillboardGui',v)
						bill.Name = 'NameEsp'..Number
						bill.ExtentsOffset = Vector3.new(0, 1, 0)
						bill.Size = UDim2.new(1,200,1,30)
						bill.Adornee = v
						bill.AlwaysOnTop = true
						local name = Instance.new('TextLabel',bill)
						name.Font = Enum.Font.GothamSemibold
						name.FontSize = "Size14"
						name.TextWrapped = true
						name.Size = UDim2.new(1,0,1,0)
						name.TextYAlignment = 'Top'
						name.BackgroundTransparency = 1
						name.TextStrokeTransparency = 0.5
						name.TextColor3 = Color3.fromRGB(255, 0, 0)
						if v.Name == "Flower1" then 
							name.Text = ("Blue Flower" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
							name.TextColor3 = Color3.fromRGB(0, 0, 255)
						end
						if v.Name == "Flower2" then
							name.Text = ("Red Flower" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
							name.TextColor3 = Color3.fromRGB(255, 0, 0)
						end
					else
						v['NameEsp'..Number].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
					end
				else
					if v:FindFirstChild('NameEsp'..Number) then
					v:FindFirstChild('NameEsp'..Number):Destroy()
					end
				end
			end   
		end)
	end
end

function UpdateRealFruitChams() 
	for i,v in pairs(game.Workspace.AppleSpawner:GetChildren()) do
		if v:IsA("Tool") then
			if RealFruitESP then 
				if not v.Handle:FindFirstChild('NameEsp'..Number) then
					local bill = Instance.new('BillboardGui',v.Handle)
					bill.Name = 'NameEsp'..Number
					bill.ExtentsOffset = Vector3.new(0, 1, 0)
					bill.Size = UDim2.new(1,200,1,30)
					bill.Adornee = v.Handle
					bill.AlwaysOnTop = true
					local name = Instance.new('TextLabel',bill)
					name.Font = Enum.Font.GothamSemibold
					name.FontSize = "Size14"
					name.TextWrapped = true
					name.Size = UDim2.new(1,0,1,0)
					name.TextYAlignment = 'Top'
					name.BackgroundTransparency = 1
					name.TextStrokeTransparency = 0.5
					name.TextColor3 = Color3.fromRGB(255, 0, 0)
					name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
				else
					v.Handle['NameEsp'..Number].TextLabel.Text = (v.Name ..' '.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
				end
			else
				if v.Handle:FindFirstChild('NameEsp'..Number) then
					v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
				end
			end 
		end
	end
	for i,v in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
		if v:IsA("Tool") then
			if RealFruitESP then 
				if not v.Handle:FindFirstChild('NameEsp'..Number) then
					local bill = Instance.new('BillboardGui',v.Handle)
					bill.Name = 'NameEsp'..Number
					bill.ExtentsOffset = Vector3.new(0, 1, 0)
					bill.Size = UDim2.new(1,200,1,30)
					bill.Adornee = v.Handle
					bill.AlwaysOnTop = true
					local name = Instance.new('TextLabel',bill)
					name.Font = Enum.Font.GothamSemibold
					name.FontSize = "Size14"
					name.TextWrapped = true
					name.Size = UDim2.new(1,0,1,0)
					name.TextYAlignment = 'Top'
					name.BackgroundTransparency = 1
					name.TextStrokeTransparency = 0.5
					name.TextColor3 = Color3.fromRGB(255, 174, 0)
					name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
				else
					v.Handle['NameEsp'..Number].TextLabel.Text = (v.Name ..' '.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
				end
			else
				if v.Handle:FindFirstChild('NameEsp'..Number) then
					v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
				end
			end 
		end
	end
	for i,v in pairs(game.Workspace.BananaSpawner:GetChildren()) do
		if v:IsA("Tool") then
			if RealFruitESP then 
				if not v.Handle:FindFirstChild('NameEsp'..Number) then
					local bill = Instance.new('BillboardGui',v.Handle)
					bill.Name = 'NameEsp'..Number
					bill.ExtentsOffset = Vector3.new(0, 1, 0)
					bill.Size = UDim2.new(1,200,1,30)
					bill.Adornee = v.Handle
					bill.AlwaysOnTop = true
					local name = Instance.new('TextLabel',bill)
					name.Font = Enum.Font.GothamSemibold
					name.FontSize = "Size14"
					name.TextWrapped = true
					name.Size = UDim2.new(1,0,1,0)
					name.TextYAlignment = 'Top'
					name.BackgroundTransparency = 1
					name.TextStrokeTransparency = 0.5
					name.TextColor3 = Color3.fromRGB(251, 255, 0)
					name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
				else
					v.Handle['NameEsp'..Number].TextLabel.Text = (v.Name ..' '.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
				end
			else
				if v.Handle:FindFirstChild('NameEsp'..Number) then
					v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
				end
			end 
		end
	end
end

function UpdateIslandESP() 
        for i,v in pairs(game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren()) do
            pcall(function()
                if IslandESP then 
                    if v.Name ~= "Sea" then
                        if not v:FindFirstChild('NameEsp') then
                            local bill = Instance.new('BillboardGui',v)
                            bill.Name = 'NameEsp'
                            bill.ExtentsOffset = Vector3.new(0, 1, 0)
                            bill.Size = UDim2.new(1,200,1,30)
                            bill.Adornee = v
                            bill.AlwaysOnTop = true
                            local name = Instance.new('TextLabel',bill)
                            name.Font = "GothamBold"
                            name.FontSize = "Size14"
                            name.TextWrapped = true
                            name.Size = UDim2.new(1,0,1,0)
                            name.TextYAlignment = 'Top'
                            name.BackgroundTransparency = 1
                            name.TextStrokeTransparency = 0.5
                            name.TextColor3 = Color3.fromRGB(255, 255, 255)
                        else
                            v['NameEsp'].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
                        end
                    end
                else
                    if v:FindFirstChild('NameEsp') then
                        v:FindFirstChild('NameEsp'):Destroy()
                    end
                end
            end)
        end
    end

function UpdateFlowerChams() 
	for i,v in pairs(game.Workspace:GetChildren()) do
		pcall(function()
			if v.Name == "Flower2" or v.Name == "Flower1" then
				if FlowerESP then 
					if not v:FindFirstChild('NameEsp'..Number) then
						local bill = Instance.new('BillboardGui',v)
						bill.Name = 'NameEsp'..Number
						bill.ExtentsOffset = Vector3.new(0, 1, 0)
						bill.Size = UDim2.new(1,200,1,30)
						bill.Adornee = v
						bill.AlwaysOnTop = true
						local name = Instance.new('TextLabel',bill)
						name.Font = Enum.Font.GothamSemibold
						name.FontSize = "Size14"
						name.TextWrapped = true
						name.Size = UDim2.new(1,0,1,0)
						name.TextYAlignment = 'Top'
						name.BackgroundTransparency = 1
						name.TextStrokeTransparency = 0.5
						name.TextColor3 = Color3.fromRGB(255, 0, 0)
						if v.Name == "Flower1" then 
							name.Text = ("Blue Flower" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
							name.TextColor3 = Color3.fromRGB(0, 0, 255)
						end
						if v.Name == "Flower2" then
							name.Text = ("Red Flower" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
							name.TextColor3 = Color3.fromRGB(255, 0, 0)
						end
					else
						v['NameEsp'..Number].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
					end
				else
					if v:FindFirstChild('NameEsp'..Number) then
					v:FindFirstChild('NameEsp'..Number):Destroy()
					end
				end
			end   
		end)
	end
end

spawn(function()
    while wait() do
        pcall(function()
            if MobESP then
                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v:FindFirstChild('HumanoidRootPart') then
                        if not v:FindFirstChild("MobEap") then
                            local BillboardGui = Instance.new("BillboardGui")
                            local TextLabel = Instance.new("TextLabel")
                            BillboardGui.Parent = v
                            BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                            BillboardGui.Active = true
                            BillboardGui.Name = "MobEap"
                            BillboardGui.AlwaysOnTop = true
                            BillboardGui.LightInfluence = 1.000
                            BillboardGui.Size = UDim2.new(0, 200, 0, 50)
                            BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
                            TextLabel.Parent = BillboardGui
                            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            TextLabel.BackgroundTransparency = 1.000
                            TextLabel.Size = UDim2.new(0, 200, 0, 50)
                            TextLabel.Font = Enum.Font.GothamBold
                            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                            TextLabel.Text.Size = 35
                        end
                        local Dis = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude)
                        v.MobEap.TextLabel.Text = v.Name.." - "..Dis.." Distance"
                    end
                end
            else
                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v:FindFirstChild("MobEap") then
                        v.MobEap:Destroy()
                    end
                end
            end
        end)
    end
end)

spawn(function()
    while wait() do
        pcall(function()
            if SeaESP then
                for i,v in pairs(game:GetService("Workspace").SeaBeasts:GetChildren()) do
                    if v:FindFirstChild('HumanoidRootPart') then
                        if not v:FindFirstChild("Seaesps") then
                            local BillboardGui = Instance.new("BillboardGui")
                            local TextLabel = Instance.new("TextLabel")
                            BillboardGui.Parent = v
                            BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                            BillboardGui.Active = true
                            BillboardGui.Name = "Seaesps"
                            BillboardGui.AlwaysOnTop = true
                            BillboardGui.LightInfluence = 1.000
                            BillboardGui.Size = UDim2.new(0, 200, 0, 50)
                            BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
                            TextLabel.Parent = BillboardGui
                            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            TextLabel.BackgroundTransparency = 1.000
                            TextLabel.Size = UDim2.new(0, 200, 0, 50)
                            TextLabel.Font = Enum.Font.GothamBold
                            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                            TextLabel.Text.Size = 35
                        end
                        local Dis = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude)
                        v.Seaesps.TextLabel.Text = v.Name.." - "..Dis.." Distance"
                    end
                end
            else
                for i,v in pairs (game:GetService("Workspace").SeaBeasts:GetChildren()) do
                    if v:FindFirstChild("Seaesps") then
                        v.Seaesps:Destroy()
                    end
                end
            end
        end)
    end
end)

spawn(function()
    while wait() do
        pcall(function()
            if NpcESP then
                for i,v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                    if v:FindFirstChild('HumanoidRootPart') then
                        if not v:FindFirstChild("NpcEspes") then
                            local BillboardGui = Instance.new("BillboardGui")
                            local TextLabel = Instance.new("TextLabel")

                            BillboardGui.Parent = v
                            BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                            BillboardGui.Active = true
                            BillboardGui.Name = "NpcEspes"
                            BillboardGui.AlwaysOnTop = true
                            BillboardGui.LightInfluence = 1.000
                            BillboardGui.Size = UDim2.new(0, 200, 0, 50)
                            BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0)

                            TextLabel.Parent = BillboardGui
                            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            TextLabel.BackgroundTransparency = 1.000
                            TextLabel.Size = UDim2.new(0, 200, 0, 50)
                            TextLabel.Font = Enum.Font.GothamBold
                            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                            TextLabel.Text.Size = 35
                        end
                        local Dis = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude)
                        v.NpcEspes.TextLabel.Text = v.Name.." - "..Dis.." Distance"
                    end
                end
            else
                for i,v in pairs (game:GetService("Workspace").NPCs:GetChildren()) do
                    if v:FindFirstChild("NpcEspes") then
                        v.NpcEspes:Destroy()
                    end
                end
            end
        end)
    end
end)

function AutoHaki()
  if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
  end
end
    
function UnEquipWeapon(Weapon)
  if game.Players.LocalPlayer.Character:FindFirstChild(Weapon) then
    _G.NotAutoEquip = true
    wait(.5)
    game.Players.LocalPlayer.Character:FindFirstChild(Weapon).Parent = game.Players.LocalPlayer.Backpack
    wait(.1)
    _G.NotAutoEquip = false
  end
end
    
function EquipWeapon(ToolSe)
  if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
    local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
    if game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
      wait(.4)
      game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
    else
      UnEquipWeapon(Weapon)
    end
  end
end
    
    
function BTP(P)
  repeat wait()
    UnEquipWeapon(_G.SelectWeapon)
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(15)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = P
    UnEquipWeapon(_G.SelectWeapon)
    task.wait()
    UnEquipWeapon(_G.SelectWeapon)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = P
    UnEquipWeapon(_G.SelectWeapon)
  until (P.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1500
end

function TweenBoat(CFgo)
  local tween_s = game:service"TweenService"
  local info = TweenInfo.new((game:GetService("Workspace").Boats.PirateBrigade.VehicleSeat.CFrame.Position - CFgo.Position).Magnitude/350, Enum.EasingStyle.Linear)
  tween = tween_s:Create(game:GetService("Workspace").Boats.PirateBrigade.VehicleSeat, info, {CFrame = CFgo})
  tween:Play()
  local tweenfunc = {}
  function tweenfunc:Stop()
    tween:Cancel()
  end
  return tweenfunc
end

function topos(Pos)
    Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if game.Players.LocalPlayer.Character.Humanoid.Sit == true then game.Players.LocalPlayer.Character.Humanoid.Sit = false end
    pcall(function() tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/350, Enum.EasingStyle.Linear),{CFrame = Pos}) end)
    tween:Play()
    if Distance <= 300 then
        tween:Cancel()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
    end
    if _G.StopTween == true then
        tween:Cancel()
        _G.Clip = false
    end
end
    
spawn(
    function()
        game:GetService("RunService").Stepped:Connect(
            function()
                if not donotdixuyentuong then
                    if asasas then
                        setfflag("HumanoidParallelRemoveNoPhysics", "False") 
                        setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
                        if
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and
                                game.Players.LocalPlayer.Character.Humanoid.Sit
                         then
                            game.Players.LocalPlayer.Character.Humanoid.Sit = false
                        end
                        if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                            setfflag("HumanoidParallelRemoveNoPhysics", "False")
                            setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
                            game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
                        end
                    end
                end
                if NoClip then
                    if not game.Players.LocalPlayer.Character.Head:FindFirstChild("BodyVelocity") then
                        local ag = Instance.new("BodyVelocity")
                        ag.Velocity = Vector3.new(0, 0, 0)
                        ag.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                        ag.P = 9000
                        ag.Parent = game.Players.LocalPlayer.Character.Head
                        for r, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                    end
                elseif not NoClip and game.Players.LocalPlayer.Character.Head:FindFirstChild("BodyVelocity") then
                    game.Players.LocalPlayer.Character.Head:FindFirstChild("BodyVelocity"):Destroy()
                end
            end
        )
    end
)

function tweendenthuyen(Pos) 
    Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if game.Players.LocalPlayer.Character.Humanoid.Sit == true then game.Players.LocalPlayer.Character.Humanoid.Sit = false end
    pcall(function() tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/325, Enum.EasingStyle.Linear),{CFrame = Pos}) end)
    tween:Play()    
    if Distance <= 300 then
        tween:Cancel()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
    end
    if _G.StopTween == true then
        tween:Cancel()
    end
end

function StopTween(target)
  if not target then
    _G.StopTween = true
    wait()
    topos(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
    wait()
    if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
      game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
    end
    _G.StopTween = false
    _G.Clip = false
  end
end

spawn(
    function()
        while task.wait() do
            if tween and tween.PlaybackState == Enum.PlaybackState.Playing then
                NoClip = true
            elseif tween then
                NoClip = false
            end
        end
    end
)

getgenv().ToTargets = function(p)
    task.spawn(function()
        pcall(function()
            if game:GetService("Players").LocalPlayer:DistanceFromCharacter(p.Position) <= 250 then 
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = p
            elseif not game.Players.LocalPlayer.Character:FindFirstChild("Root")then 
                local K = Instance.new("Part",game.Players.LocalPlayer.Character)
                K.Size = Vector3.new(1,0.5,1)
                K.Name = "Root"
                K.Anchored = true
                K.Transparency = 1
                K.CanCollide = false
                K.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,20,0)
            end
            local U = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-p.Position).Magnitude
            local z = game:service("TweenService")
            local B = TweenInfo.new((p.Position-game.Players.LocalPlayer.Character.Root.Position).Magnitude/300,Enum.EasingStyle.Linear)
            local S,g = pcall(function()
            local q = z:Create(game.Players.LocalPlayer.Character.Root,B,{CFrame = p})
            q:Play()
        end)
        if not S then 
            return g
        end
        game.Players.LocalPlayer.Character.Root.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            if S and game.Players.LocalPlayer.Character:FindFirstChild("Root") then 
                pcall(function()
                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-p.Position).Magnitude >= 20 then 
                        spawn(function()
                            pcall(function()
                                if (game.Players.LocalPlayer.Character.Root.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 150 then 
                                    game.Players.LocalPlayer.Character.Root.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                else 
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players.LocalPlayer.Character.Root.CFrame
                                end
                            end)
                        end)
                    elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-p.Position).Magnitude >= 10 and(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-p.Position).Magnitude < 20 then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p
                    elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-p.Position).Magnitude < 10 then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p
                    end
                end)
            end
	    end)
    end)
    end
    
spawn(function()
  pcall(function()
    while wait() do
      for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do  
        if v:IsA("Tool") then
          if v:FindFirstChild("RemoteFunctionShoot") then 
            SelectWeaponGun = v.Name
          end
        end
      end
    end
  end)
end)
    
game:GetService("Players").LocalPlayer.Idled:connect(function()
  game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
  wait(1)
  game:GetService'VirtualUser':Button1Down(Vector2.new(0,1,0,1))
end)

spawn(function()
  game:GetService("RunService").RenderStepped:Connect(function()
    if _G.AutoClick then
      pcall(function()
        game:GetService'VirtualUser':CaptureController()
        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672), game.Workspace.CurrentCamera.CFrame)
      end)
    end
  end)
end)

function CheckColorRipIndra()
  mmb = {}
  for r, v in next, game:GetService("Workspace").Map["Boat Castle"].Summoner.Circle:GetChildren() do
    if v:IsA("Part") and v:FindFirstChild("Part") and v.Part.BrickColor.Name == "Dark stone grey" then
      mmb[v.BrickColor.Name] = v
    end
  end
  return mmb
end

function ActivateColor(cw)
  haki = {["Hot pink"] = "Winter Sky", ["Really red"] ="Pure Red", ["Oyster"] = "Snow White"}
  runnay = haki[cw]
  if runnay then
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor", runnay)
  end
end

function AutoActiveColorRip_Indra()
  for r, v in pairs(CheckColorRipIndra()) do
    ActivateColor(r)
    topos(v.CFrame)
    firetouchinterest(v.TouchInterest)
  end
end

_G.TargTrial = nil
function targettrial()
    if _G.TargTrial ~= nil then return end
    local a = nil
    local b = 450
    for i,v in pairs(game.Players:GetChildren()) do
        c = (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        if c <= b and v ~= game.Players.LocalPlayer then
            b = c 
            a = v
        end
    end
    if a == nil then return end
    if _G.TargTrial ~= nil then return end
    _G.TargTrial = a
end

function CheckPirateBoat()
    local cocailon = {"PirateBasic", "PirateBrigade"}
    for r, v in next, game:GetService("Workspace").Enemies:GetChildren() do
        if table.find(cocailon, v.Name) and v:FindFirstChild("Health") and v.Health.value > 0 then
            return v
        end
    end
end

function EquipAllWeapon()
  pcall(function()
    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
      if v:IsA('Tool') and not (v.Name == "Summon Sea Beast" or v.Name == "Water Body" or v.Name == "Awakening") then
        local ToolHumanoid = game.Players.LocalPlayer.Backpack:FindFirstChild(v.Name) 
        wait(.4)
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(ToolHumanoid) 
        wait(1)
      end
    end
  end)
end

loadSettings()

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/Tienvn123tkvn/Ziner-hub/main/zinerhubontop.txt"))()

local Window = Fluent:CreateWindow({
    Title = "Ziner-hub | version 3" ,
    SubTitle = "",
    TabWidth = 160,
    Size = UDim2.fromOffset(480, 320),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Shop = Window:AddTab({ Title = "Tab Shop", Icon = "" }),
    Statut = Window:AddTab({ Title = "Tap Status And Sever", Icon = "" }),
    LocelPlier = Window:AddTab({ Title = "Tap Local Player", Icon = "" }),
    Setting = Window:AddTab({ Title = "Tap Setting Farm", Icon = "" }),
    Fimi = Window:AddTab({ Title = "Tap Farm", Icon = "" }),
    Stack = Window:AddTab({ Title = "Tap Stack Farm", Icon = "" }),
    FimiOht = Window:AddTab({ Title = "Tap Farming Other", Icon = "" }),
}

local x2Code = {"KITTGAMING","ENYU_IS_PRO","FUDD10","BIGNEWS","THEGREATACE","SUB2GAMERROBOT_EXP1","STRAWHATMAIME","SUB2OFFICIALNOOBIE","SUB2NOOBMASTER123","SUB2DAIGROCK","AXIORE","TANTAIGAMIMG","STRAWHATMAINE","JCWK","FUDD10_V2","SUB2FER999","MAGICBIS","TY_FOR_WATCHING","STARCODEHEO","STAFFBATTLE","ADMIN_STRENGTH","DRAGONABUSE"}

Tabs.Shop:AddButton({
  Title = "Redeem All Code",
  Description = "",
  Callback = function()
    function RedeemCode(value)
      game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(value)
    end
    for i,v in pairs(x2Code) do
      RedeemCode(v)
    end
  end
})

Tabs.Shop:AddButton({
  Title = "Teleport Old World",
  Description = "",
  Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
  end
})

Tabs.Shop:AddButton({
  Title = "Teleport New World",
  Description = "",
  Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
  end
})

Tabs.Shop:AddButton({
  Title = "Teleport Third World",
  Description = "",
  Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
  end
})

Tabs.Shop:AddParagraph({
  Title = "",
  Content = "Fighting Shop"
})

Tabs.Shop:AddButton({
  Title = "Dark Step",
  Description = "",
  Callback = function() 
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
  end
})

Tabs.Shop:AddButton({
  Title = "Electro",
  Description = "",
  Callback = function() 
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
  end
})

Tabs.Shop:AddButton({
  Title = "Fishman Karate",
  Description = "",
  Callback = function() 
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
  end
})

Tabs.Shop:AddButton({
  Title = "Dragon Claw",
  Description = "",
  Callback = function() 
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","1")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
  end
})
    
Tabs.Shop:AddButton({
  Title = "Superhuman",
  Description = "",
  Callback = function() 
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
  end
})
    
Tabs.Shop:AddButton({
  Title = "Death Step",
  Description = "",
  Callback = function() 
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
  end
})
    
Tabs.Shop:AddButton({
  Title = "Sharkman Karate",
  Description = "",
  Callback = function() 
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
  end
})
    
Tabs.Shop:AddButton({
  Title = "Electric Claw",
  Description = "",
  Callback = function() 
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
  end
})
    
Tabs.Shop:AddButton({
  Title = "Dragon Talon",
  Description = "",
  Callback = function() 
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
  end
})
    
Tabs.Shop:AddButton({
  Title = "God Human",
  Description = "",
  Callback = function() 
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")
  end
})
    
Tabs.Shop:AddButton({
  Title = "Sanguine Art",
  Description = "",
  Callback = function() 
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySanguineArt")
  end
})
    
Tabs.Shop:AddParagraph({
  Title = "",
  Content = "Abilities Shop"
})
    
Tabs.Shop:AddButton({
  Title = "Sky Jumb [$ 10,000 Beli ]",
  Description = "",
  Callback = function() 
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Geppo")
  end
})
    
Tabs.Shop:AddButton({
  Title = "Buso Haki [$ 25,000 Beli]",
  Description = "",
  Callback = function() 
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Buso")
  end
})
    
Tabs.Shop:AddButton({
  Title = "Observation haki [$ 750,000 Beli]",
  Description = "",
  Callback = function() 
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk","Buy")
  end
})
    
Tabs.Shop:AddButton({
  Title = "Soru [$ 100,000 Beli]",
  Description = "",
  Callback = function() 
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Soru")
  end
})

Tabs.Shop:AddParagraph({
  Title = "",
  Content = "Misc Shop"
})
    
Tabs.Shop:AddButton({
  Title = "Reroll Race",
  Description = "",
  Callback = function() 
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Reroll","1")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Reroll","2")
  end
})
    
Tabs.Shop:AddButton({
  Title = "Reset Stat",
  Description = "",
  Callback = function() 
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Refund","1")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Refund","2")
  end
})
    
Tabs.Shop:AddButton({
  Title = "Buy Race Cyborg",
  Description = "",
  Callback = function() 
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CyborgTrainer","Buy")
  end
})
    
Tabs.Shop:AddButton({
  Title = "Buy Race Ghoul",
  Description = "",
  Callback = function() 
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm","BuyCheck",4)
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm","Change",4)
  end
})

Tabs.Statut:AddSection("Status")

local Time = Tabs.Statut:AddParagraph({
  Title = "Sever Time",
  Content = ""
})

function UpdateTime()
  local GameTime = math.floor(workspace.DistributedGameTime+0.5)
  local Hour = math.floor(GameTime/(60^2))%24
  local Minute = math.floor(GameTime/(60^1))%60
  local Second = math.floor(GameTime/(60^0))%60
  Time:SetDesc("Hours : "..Hour.. " | Minutes : "..Minute.." | Seconds : "..Second)
end

spawn(function()
  while task.wait() do
    pcall(function()
      UpdateTime()
    end)
  end
end)

local EliteStutu = Tabs.Statut:AddParagraph({
  Title = "Elite Status",
  Content = ""
})

spawn(function()
  while wait() do
    if game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") or game:GetService("ReplicatedStorage"):FindFirstChild("Urban") or game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban") then
      EliteStutu:SetDesc("Status : ✅️")
    else
      EliteStutu:SetDesc("Status : ❌️")
    end
  end
end)

local KataStutu = Tabs.Statut:AddParagraph({
  Title = "Katakuri Mobs",
  Content = ""
})

spawn(function()
  while wait() do
    pcall(function()
      if string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 88 then
        KataStutu:SetDesc("Defeat : "..string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,41) ..  "Mobs")
      elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 87 then
        KataStutu:SetDesc("Defeat : "..string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,40) ..  "Mobs")
      elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 86 then
        KataStutu:SetDesc("Defeat : "..string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,39) ..  "Mobs")
      else
        KataStutu:SetDesc("Boss Is Spawning")
      end
    end)
  end
end)

local MiraStutu = Tabs.Statut:AddParagraph({
  Title = "Mirage",
  Content = ""
})

spawn(function()
  while wait() do
    if game.Workspace._WorldOrigin.Locations:FindFirstChild('Mirage Island') then
      MiraStutu:SetDesc('✅️')
    else
      MiraStutu:SetDesc('❌️' )
    end
  end
end)

local FogenAkStutu = Tabs.Statut:AddParagraph({
  Title = "Frozen Dimension",
  Content = ""
})

spawn(function()
  while wait() do
    if game.Workspace._WorldOrigin.Locations:FindFirstChild('Frozen Dimension') then
      FogenAkStutu:SetDesc('✅️')
    else
      FogenAkStutu:SetDesc('❌️' )
    end
  end
end)

local MoonSkidBananaOld = Tabs.Statut:AddParagraph({
  Title = "Moon",
  Content = ""
})

spawn(function()
  while wait() do
    MoonSkidBananaOld:SetDesc("Moon : " .. function8() .. " | ".. CheckMoon() .. " | " .. function7())
  end
end)

local AncientSkidBananaOld = Tabs.Statut:AddParagraph({
  Title = "Anclient One Status",
  Content = ""
})

spawn(function()
  while wait() do
    AncientSkidBananaOld:SetDesc("Anclient One Status : " .. tostring(CheckAcientOneStatus()))
  end
end)

Tabs.Statut:AddSection("Sever")

local Input = Tabs.Statut:AddInput("Input", {
  Title = "Job Id",
  Default = "",
  Placeholder = "Paste Job Id",
  Numeric = false, -- Only allows numbers
  Finished = false, -- Only calls callback when you press enter
  Callback = function(Value)
    _G.Job = Value
  end
})

local Toggle = Tabs.Statut:AddToggle("MyToggle", {Title = "Spam Join Job Id", Description = "Spam until join sever" ,Default = false })
Toggle:OnChanged(function(Value)
  _G.Join = Value
end)

spawn(function()
  while wait(2) do
    if _G.Join then
      game:GetService("TeleportService"):TeleportToPlaceInstance(game.placeId,_G.Job, game.Players.LocalPlayer)
    end
  end
end)

Tabs.Statut:AddButton({
  Title = "Join Sever",
  Description = "",
  Callback = function() 
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.placeId,_G.Job, game.Players.LocalPlayer)
  end
})

Tabs.Statut:AddButton({
  Title = "Copy Jobid",
  Description = "",
  Callback = function() 
    setclipboard(tostring(game.JobId))
  end
})

Tabs.Statut:AddButton({
  Title = "Hop Sever",
  Description = "",
  Callback = function() 
    Hop()
  end
})

Tabs.Statut:AddButton({
  Title = "Hop Sever Less",
  Description = "",
  Callback = function() 
    Hop()
  end
})

Tabs.LocelPlier:AddButton({
  Title = "Show Item",
  Description = "",
  Callback = function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DuongTGMXSADCAT/Free-Source/main/show%20item.lua"))()
  end
})

Tabs.LocelPlier:AddButton({
  Title = "Open Devil Fruit Shop",
  Description = "",
  Callback = function() 
    game:GetService("Players").LocalPlayer.PlayerGui.Main.FruitShop.Visible = true
  end
})

Tabs.LocelPlier:AddButton({
  Title = "Open Title",
  Description = "",
  Callback = function() 
    game.Players.localPlayer.PlayerGui.Main.Titles.Visible = true
  end
})

Tabs.LocelPlier:AddButton({
  Title = "Open Color",
  Description = "",
  Callback = function() 
    game.Players.localPlayer.PlayerGui.Main.Colors.Visible = true
  end
})

function fpsboost()
  pcall(function()
    local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
    local g = game
    local w = g.Workspace
    local l = g.Lighting
    local t = w.Terrain
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 0
    l.GlobalShadows = false
    l.FogEnd = 9e9
    l.Brightness = 0
    settings().Rendering.QualityLevel = "Level01"
    for i, v in pairs(g:GetDescendants()) do
      if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
      elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
        v.Transparency = 1
      elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Lifetime = NumberRange.new(0)
      elseif v:IsA("Explosion") then
        v.BlastPressure = 1
        v.BlastRadius = 1
      elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
        v.Enabled = false
      elseif v:IsA("MeshPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
        v.TextureID = 10385902758728957
      end
    end
    for i, e in pairs(l:GetChildren()) do
      if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
        e.Enabled = false
      end
    end
    for i, v in pairs(game:GetService("Workspace").Camera:GetDescendants()) do
      if v.Name == ("Water;") then
        v.Transparency = 1
        v.Material = "Plastic"
      end
    end
  end)
  pcall(function()
    if not game:IsLoaded() then repeat wait() until game:IsLoaded() end
    if hookfunction and setreadonly then
      local mt = getrawmetatable(game)
      local old = mt.__newindex
      setreadonly(mt, false)
      local sda
      sda = hookfunction(old, function(t, k, v)
        if k == "Material" then
          if v ~= Enum.Material.Neon and v ~= Enum.Material.Plastic and v ~= Enum.Material.ForceField then v = Enum.Material.Plastic end
        elseif k == "TopSurface" then v = "Smooth"
        elseif k == "Reflectance" or k == "WaterWaveSize" or k == "WaterWaveSpeed" or k == "WaterReflectance" then v = 0
        elseif k == "WaterTransparency" then v = 1
        elseif k == "GlobalShadows" then v = false end
        return sda(t, k, v)
      end)
      setreadonly(mt, true)
    end
    local g = game
    local w = g.Workspace
    local l = g:GetService"Lighting"
    local t = w:WaitForChild"Terrain"
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 1
    l.GlobalShadows = false
    for i,v in pairs(game.Workspace.Map:GetDescendants()) do
      if v.Name == "Tavern" or v.Name == "SmileFactory" or v.Name == "Tree" or v.Name == "Rocks" or v.Name == "PartHouse" or v.Name == "Hotel" or v.Name == "WallPiece" or v.Name == "MiddlePillars" or v.Name == "Cloud" or v.Name == "PluginGrass" or v.Name == "BigHouse" or v.Name == "SmallHouse" or v.Name == "Detail" then
        v:Destroy()
      end
    end
    for i,v in pairs(game.ReplicatedStorage.Unloaded:GetDescendants()) do
      if v.Name == "Tavern" or v.Name == "SmileFactory" or v.Name == "Tree" or v.Name == "Rocks" or v.Name == "PartHouse" or v.Name == "Hotel" or v.Name == "WallPiece" or v.Name == "MiddlePillars" or v.Name == "Cloud" or v.Name == "BigHouse" or v.Name == "SmallHouse" or v.Name == "Detail" then
        v:Destroy()
      end
    end
    for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
      if v:IsA("Accessory") or v.Name == "Pants" or v.Name == "Shirt" then
        v:Destroy()
      end
    end
  end)
end

Tabs.LocelPlier:AddButton({
  Title = "Boost Fps",
  Description = "",
  Callback = function() 
    fpsboost()
  end
})

local SeliStat = Tabs.LocelPlier:AddDropdown("Dropdown", {
  Title = "Select Stats",
  Values = {"Melee","Defense","Sword","Fruit","Gun"},
  Multi = false,
  Default = _G.SelectStats,
})

SeliStat:OnChanged(function(Value)
  _G.SelectStats = Value
  saveSettings()
end)

local AutuStatu = Tabs.LocelPlier:AddToggle("MyToggle", {Title = "Auto Stat", Default = _G.AutoStat })
AutuStatu:OnChanged(function(Value)
  _G.AutoStat = Value
  saveSettings()
end)

spawn(function()
  while wait() do
    if _G.AutoStat then
      if _G.SelectStats == "Melee" then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint","Melee",3)
      elseif _G.SelectStats == "Defense" then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint","Defense",3)
      elseif _G.SelectStats == "Sword" then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint","Sword",3)
      elseif _G.SelectStats == "Gun" then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint","Gun",3)
      elseif _G.SelectStats == "Fruit" then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint","Demon Fruit",3)
      end
    end
  end
end)

local WhiteScren = Tabs.LocelPlier:AddToggle("MyToggle", {Title = "White Screen", Default = _G.WhiteScrean })
WhiteScren:OnChanged(function(Value)
  _G.WhiteScrean = Value
  saveSettings()
  if _G.WhiteScrean == true then
    game:GetService("RunService"):Set3dRenderingEnabled(false)
  elseif _G.WhiteScrean == false then
    game:GetService("RunService"):Set3dRenderingEnabled(true)
  end
end)

local RemoNotify = Tabs.LocelPlier:AddToggle("MyToggle", {Title = "Remove Notifications", Default = _G.RemoNotify })
RemoNotify:OnChanged(function(Value)
  _G.RemoNotify = Value
  saveSettings()
end)

spawn(function()
  while wait() do
    if _G.RemoNotify then
      game.Players.LocalPlayer.PlayerGui.Notifications.Enabled = false
    else
      game.Players.LocalPlayer.PlayerGui.Notifications.Enabled = true
    end
  end
end)

local Rejoin = Tabs.LocelPlier:AddToggle("MyToggle", {Title = "Auto Rejoin Disconnect", Default = _G.Rejoin })
Rejoin:OnChanged(function(Value)
  _G.Rejoin = Value
  saveSettings()
end)

spawn(function()
  while wait() do
    if _G.Rejoin then
      getgenv().rejoin = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
        if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
          game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
        end
      end)
    end
  end
end)

if Sea1 then
  IslandlList = {"WindMill","Marine","Middle Town","Jungle","Pirate Village","Desert","Snow Island","MarineFord","Colosseum","Sky Island 1","Sky Island 2","Sky Island 3","Prison","Magma Village","Under Water Island","Fountain City","Shank Room","Mob Island"}
elseif Sea2 then
  IslandlList = {"The Cafe","Frist Spot","Dark Area","Flamingo Mansion","Flamingo Room","Green Zone","Factory","Colossuim","Zombie Island","Two Snow Mountain","Punk Hazard","Cursed Ship","Ice Castle","Forgotten Island","Ussop Island","Mini Sky Island"}
elseif Sea3 then
  IslandlList = {"Mansion","Port Town","Great Tree","Castle On The Sea","MiniSky","Hydra Island","Floating Turtle","Haunted Castle","Ice Cream Island","Peanut Island","Cake Island","Cocoa Island","Candy Island","Tiki Outpost"}
end

local Seliailen = Tabs.LocelPlier:AddDropdown("Dropdown", {
  Title = "Select Island",
  Values = IslandlList,
  Multi = false,
  Default = _G.SelectIslant,
})

Seliailen:OnChanged(function(Value)
  _G.SelectIslant = Value
  saveSettings()
end)

local TelepiAilen = Tabs.LocelPlier:AddToggle("MyToggle", {Title = "Teleport Island", Default = _G.TelepiAilen })
TelepiAilen:OnChanged(function(Value)
  _G.TelepiAilen = Value
  saveSettings()
  if _G.TelepiAilen == true then
		    repeat wait()
		      if _G.SelectIslant == "WindMill" then
		        topos(CFrame.new(979.79895019531, 16.516613006592, 1429.0466308594))
		      elseif _G.SelectIslant == "Marine" then
		        topos(CFrame.new(-2566.4296875, 6.8556680679321, 2045.2561035156))
		      elseif _G.SelectIslant == "Middle Town" then
		        topos(CFrame.new(-690.33081054688, 15.09425163269, 1582.2380371094))
		      elseif _G.SelectIslant == "Jungle" then
		        topos(CFrame.new(-1612.7957763672, 36.852081298828, 149.12843322754))
		      elseif _G.SelectIslant == "Pirate Village" then
		        topos(CFrame.new(-1181.3093261719, 4.7514905929565, 3803.5456542969))
		      elseif _G.SelectIslant == "Desert" then
		        topos(CFrame.new(944.15789794922, 20.919729232788, 4373.3002929688))
		      elseif _G.SelectIslant == "Snow Island" then
		        topos(CFrame.new(1347.8067626953, 104.66806030273, -1319.7370605469))
		      elseif _G.SelectIslant == "MarineFord" then
		        topos(CFrame.new(-4914.8212890625, 50.963626861572, 4281.0278320313))
		      elseif _G.SelectIslant == "Colosseum" then
		        topos( CFrame.new(-1427.6203613281, 7.2881078720093, -2792.7722167969))
		      elseif _G.SelectIslant == "Sky Island 1" then
		        topos(CFrame.new(-4869.1025390625, 733.46051025391, -2667.0180664063))
		      elseif _G.SelectIslant == "Sky Island 2" then  
		        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
		      elseif _G.SelectIslant == "Sky Island 3" then
		        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
		      elseif _G.SelectIslant == "Prison" then
		        topos( CFrame.new(4875.330078125, 5.6519818305969, 734.85021972656))
		      elseif _G.SelectIslant == "Magma Village" then
		        topos(CFrame.new(-5247.7163085938, 12.883934020996, 8504.96875))
		      elseif _G.SelectIslant == "Under Water Island" then
		        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
		      elseif _G.SelectIslant == "Fountain City" then
		        topos(CFrame.new(5127.1284179688, 59.501365661621, 4105.4458007813))
		      elseif _G.SelectIslant == "Shank Room" then
		        topos(CFrame.new(-1442.16553, 29.8788261, -28.3547478))
		      elseif _G.SelectIslant == "Mob Island" then
		        topos(CFrame.new(-2850.20068, 7.39224768, 5354.99268))
		      elseif _G.SelectIslant == "The Cafe" then
		        topos(CFrame.new(-380.47927856445, 77.220390319824, 255.82550048828))
		      elseif _G.SelectIslant == "Frist Spot" then
		        topos(CFrame.new(-11.311455726624, 29.276733398438, 2771.5224609375))
		      elseif _G.SelectIslant == "Dark Area" then
		        topos(CFrame.new(3780.0302734375, 22.652164459229, -3498.5859375))
		      elseif _G.SelectIslant == "Flamingo Mansion" then
		        topos(CFrame.new(-483.73370361328, 332.0383605957, 595.32708740234))
		      elseif _G.SelectIslant == "Flamingo Room" then
		        topos(CFrame.new(2284.4140625, 15.152037620544, 875.72534179688))
		      elseif _G.SelectIslant == "Green Zone" then
		        topos( CFrame.new(-2448.5300292969, 73.016105651855, -3210.6306152344))
		      elseif _G.SelectIslant == "Factory" then
		        topos(CFrame.new(424.12698364258, 211.16171264648, -427.54049682617))
		      elseif _G.SelectIslant == "Colossuim" then
		        topos( CFrame.new(-1503.6224365234, 219.7956237793, 1369.3101806641))
		      elseif _G.SelectIslant == "Zombie Island" then
		        topos(CFrame.new(-5622.033203125, 492.19604492188, -781.78552246094))
		      elseif _G.SelectIslant == "Two Snow Mountain" then
		        topos(CFrame.new(753.14288330078, 408.23559570313, -5274.6147460938))
		      elseif _G.SelectIslant == "Punk Hazard" then
		        topos(CFrame.new(-6127.654296875, 15.951762199402, -5040.2861328125))
		      elseif _G.SelectIslant == "Cursed Ship" then
		        topos(CFrame.new(923.40197753906, 125.05712890625, 32885.875))
		      elseif _G.SelectIslant == "Ice Castle" then
		        topos(CFrame.new(6148.4116210938, 294.38687133789, -6741.1166992188))
		      elseif _G.SelectIslant == "Forgotten Island" then
		        topos(CFrame.new(-3032.7641601563, 317.89672851563, -10075.373046875))
		      elseif _G.SelectIslant == "Ussop Island" then
		        topos(CFrame.new(4816.8618164063, 8.4599885940552, 2863.8195800781))
		      elseif _G.SelectIslant == "Mini Sky Island" then
		        topos(CFrame.new(-288.74060058594, 49326.31640625, -35248.59375))
		      elseif _G.SelectIslant == "Great Tree" then
		        topos(CFrame.new(2681.2736816406, 1682.8092041016, -7190.9853515625))
		      elseif _G.SelectIslant == "Castle On The Sea" then
		        topos(CFrame.new(-5074.45556640625, 314.5155334472656, -2991.054443359375))
		      elseif _G.SelectIslant == "MiniSky" then
		        topos(CFrame.new(-260.65557861328, 49325.8046875, -35253.5703125))
		      elseif _G.SelectIslant == "Port Town" then
		        topos(CFrame.new(-290.7376708984375, 6.729952812194824, 5343.5537109375))
		      elseif _G.SelectIslant == "Hydra Island" then
		        topos(CFrame.new(5228.8842773438, 604.23400878906, 345.0400390625))
		      elseif _G.SelectIslant == "Floating Turtle" then
		        topos(CFrame.new(-13274.528320313, 531.82073974609, -7579.22265625))
		      elseif _G.SelectIslant == "Mansion" then
		        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
		      elseif _G.SelectIslant == "Haunted Castle" then
		        topos(CFrame.new(-9515.3720703125, 164.00624084473, 5786.0610351562))
		      elseif _G.SelectIslant == "Ice Cream Island" then
		        topos(CFrame.new(-902.56817626953, 79.93204498291, -10988.84765625))
		      elseif _G.SelectIslant == "Peanut Island" then
		        topos(CFrame.new(-2062.7475585938, 50.473892211914, -10232.568359375))
		      elseif _G.SelectIslant == "Cake Island" then
		        topos(CFrame.new(-1884.7747802734375, 19.327526092529297, -11666.8974609375))
		      elseif _G.SelectIslant == "Cocoa Island" then
		        topos(CFrame.new(87.94276428222656, 73.55451202392578, -12319.46484375))
		      elseif _G.SelectIslant == "Candy Island" then
		        topos(CFrame.new(-1014.4241943359375, 149.11068725585938, -14555.962890625))
		      elseif _G.SelectIslant == "Tiki Outpost" then
		        topos(CFrame.new(-16101.1885, 12.8422165, 380.942291, 0.194113985, 1.39194061e-08, -0.980978966, -9.82904691e-09, 1, 1.22443504e-08, 0.980978966, 7.26528837e-09, 0.194113985))
		      end
		    until not _G.TelepiAilen
  end
  StopTween(_G.TelepiAilen)
end)

local Mirege = Tabs.LocelPlier:AddToggle("MyToggle", {Title = "Teleport Mirage Island", Default = _G.Mirege })
Mirege:OnChanged(function(Value)
  _G.Mirege = Value
  StopTween(_G.Mirege)
  saveSettings()
end)

spawn(function()
  while wait() do
    if _G.Mirege then
      if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
        repeat task.wait()
          topos(game:GetService("Workspace").Map:FindFirstChild("MysticIsland").HumanoidRootPart.CFrame * CFrame.new(0,500,-100))
        until not game:GetService("Workspace").Map:FindFirstChild("MysticIsland") or _G.Mirege == false
      end
    end
  end
end)

local Seliweapon = Tabs.Setting:AddDropdown("Dropdown", {
  Title = "Select Stats",
  Values = {"Melee","Sword","Fruit","Gun"},
  Multi = false,
  Default = _G.SelectWeapons,
})

Seliweapon:OnChanged(function(Value)
  _G.SelectWeapons = Value
  saveSettings()
end)

task.spawn(function()
	while wait() do
		pcall(function()
			if _G.SelectWeapons == "Melee" then
				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Melee" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.SelectWeapon = v.Name
						end
					end
				end
			elseif _G.SelectWeapons == nil then
			  for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Melee" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.SelectWeapon = v.Name
						end
					end
				end
			elseif _G.SelectWeapons == "Sword" then
				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Sword" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.SelectWeapon = v.Name
						end
					end
				end
			elseif _G.SelectWeapons == "Gun" then
				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Gun" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.SelectWeapon = v.Name
						end
					end
				end
			elseif _G.SelectWeapons == "Fruit" then
				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Blox Fruit" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.SelectWeapon = v.Name
						end
					end
				end
			end
		end)
	end
end)

local SeliAtiki = Tabs.Setting:AddDropdown("Dropdown", {
  Title = "Select Attack",
  Values = {"0.175","0.15","0.1","No Cooldow"},
  Multi = false,
  Default = _G.SelectAttack,
})

SeliAtiki:OnChanged(function(Value)
  _G.SelectAttack = Value
  saveSettings()
end)

spawn(function()
    while wait(.1) do
        if _G.SelectAttack then
            pcall(function()
                if _G.SelectAttack == "0.1" then
                    _G.FastAttackDelay = 0.1
                elseif _G.SelectAttack == "0.15" then
                    _G.FastAttackDelay = 0.15
                elseif _G.SelectAttack == "0.175" then
                    _G.FastAttackDelay = 0.175
                end
            end)
        end
    end
end)

_G.FastAttack = true

spawn(function()
  while wait() do
    if _G.FastAttack then
      pcall(function()
        if not _G.SelectAttack == "No Cooldow" then
          repeat task.wait(_G.FastAttackDelay)
            AttackHit()
          until not _G.FastAttack or _G.SelectAttack == "No Cooldow"
        elseif _G.SelectAttack == "No Cooldow" then
            UseFastAttack = true
        end
      end)
    end
  end
end)

local AutuBuso = Tabs.Setting:AddToggle("MyToggle", {Title = "Auto Turn On Buso", Default = _G.AutuBuso })
AutuBuso:OnChanged(function(Value)
  _G.AutuBuso = Value
  saveSettings()
end)

spawn(function()
  while wait(.1) do
    if _G.AutuBuso then
      if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
      end
    end
  end
end)

local AutuKen = Tabs.Setting:AddToggle("MyToggle", {Title = "Auto Turn On Observation", Default = _G.AutuKen })
AutuKen:OnChanged(function(Value)
  _G.AutuKen = Value
  saveSettings()
end)

spawn(function()
  while wait() do
    pcall(function()
      if _G.AutuKen then
        repeat task.wait()
          if not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
            game:GetService('VirtualUser'):CaptureController()
            game:GetService('VirtualUser'):SetKeyDown('0x65')
            wait(2)
            game:GetService('VirtualUser'):SetKeyUp('0x65')
          end
        until game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") or not _G.AutuKen
      end
    end)
  end
end)

local AutuBatRaceVBo = Tabs.Setting:AddToggle("MyToggle", {Title = "Auto Turn On Race V3", Default = _G.AutuBatRaceVBo })
AutuBatRaceVBo:OnChanged(function(Value)
  _G.AutuBatRaceVBo = Value
  saveSettings()
end)

spawn(function()
  while wait() do
    if _G.AutuBatRaceVBo then
      game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("ActivateAbility")
    end
  end
end)

local AutuBatRaceVNam = Tabs.Setting:AddToggle("MyToggle", {Title = "Auto Turn On Race V4", Default = _G.AutuBatRaceVNam })
AutuBatRaceVNam:OnChanged(function(Value)
  _G.AutuBatRaceVNam = Value
  saveSettings()
end)

task.spawn(function()
  while task.wait() do
    task.wait()
    if _G.AutuBatRaceVNam then
      if game.Players.LocalPlayer.Character:FindFirstChild("RaceEnergy") and game.Players.LocalPlayer.Character.RaceEnergy.value >= 1 and not game.Players.LocalPlayer.Character.RaceTransformed.value then
        local be = game:service("VirtualInputManager")
        be:SendKeyEvent(true, "Y", false, game)
        task.wait()
        be:SendKeyEvent(false, "Y", false, game)
      end
    end
  end
end)

local Options = Fluent.Options

do

local BabiTePo = Tabs.Setting:AddToggle("BidienAh", {Title = "Bypass Teleport", Default = _G.BabiTePo })
BabiTePo:OnChanged(function(Value)
  _G.BabiTePo = Value
  saveSettings()
end)

local DonBabiMaThgLonf = Tabs.Setting:AddToggle("MyToggle", {Title = "Bypass Teleport",Description = "Item : God's Chalice , Fist of Darkness , Sweet Chalice" , Default = _G.DonBabiMaThgLonf })
DonBabiMaThgLonf:OnChanged(function(Value)
  _G.DonBabiMaThgLonf = Value
  saveSettings()
end)

spawn(function()
  while wait() do
    if _G.DonBabiMaThgLonf then
      if game.Players.LocalPlayer.Backpack:FindFirstChild("Fist of Darkness") or game.Players.LocalPlayer.Character:FindFirstChild("Fist of Darkness") or game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Backpack:FindFirstChild("Sweet Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("Sweet Chalice") then
        Options.BidienAh:SetValue(false)
      end
    end
  end
end)

local BringMod = Tabs.Setting:AddToggle("MyToggle", {Title = "Bring Mob", Default = true })
BringMod:OnChanged(function(Value)
  _G.BringMonster = Value
end)

task.spawn(function()
  while task.wait() do
    if _G.BringMonster then
      spawn(function()
        for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
          if not string.find(v.Name,"Boss") and v.Name == MonFarm and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 300 then
            if InMyNetWork(v.HumanoidRootPart) then
              if InMyNetWork(v.HumanoidRootPart) then
                v.HumanoidRootPart.CFrame = PosMon
                v.HumanoidRootPart.CanCollide = false
                v.HumanoidRootPart.Size = Vector3.new(1,1,1)
                if v.Humanoid:FindFirstChild("Animator") then
                  v.Humanoid.Animator:Destroy()
                end
              end
            end
          end
        end
      end)
    end
  end
end)
    
task.spawn(function()
  while task.wait() do
    if _G.BringMonster then
      spawn(function()
        CheckQuest()
        for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
          if _G.AutoFarm and StartMagnet and v.Name == Mon and (Mon == "Factory Staff" or Mon == "Monkey" or Mon == "Dragon Crew Warrior" or Mon == "Dragon Crew Archer") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 300 then
            if InMyNetWork(v.HumanoidRootPart) then
              if InMyNetWork(v.HumanoidRootPart) then
                v.HumanoidRootPart.CFrame = PosMon
                v.HumanoidRootPart.CanCollide = false
                v.HumanoidRootPart.Size = Vector3.new(1,1,1)
                if v.Humanoid:FindFirstChild("Animator") then
                  v.Humanoid.Animator:Destroy()
                end
              end
            end
          elseif _G.AutoFarm and StartMagnet and v.Name == Mon and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 325 then
            if InMyNetWork(v.HumanoidRootPart) then
              if InMyNetWork(v.HumanoidRootPart) then
                v.HumanoidRootPart.CFrame = PosMon
                v.HumanoidRootPart.CanCollide = false
                v.HumanoidRootPart.Size = Vector3.new(1,1,1)
                if v.Humanoid:FindFirstChild("Animator") then
                  v.Humanoid.Animator:Destroy()
                end
              end
            end
          end
        end
      end)
    end
  end
end)

spawn(function()
  while task.wait() do
    spawn(function()
      if _G.BringMonster then
        CheckQuest()
        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do                       
          if _G.AutoFarmFruitMastery and _G.Stimas and StartMasteryFruitMagnet then
            if v.Name == "Monkey" then
              if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 325 and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                v.HumanoidRootPart.CanCollide = false
                v.Head.CanCollide = false
                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                if v.Humanoid:FindFirstChild("Animator") then
                  v.Humanoid.Animator:Destroy()
                end
              end
            elseif v.Name == "Factory Staff" then
              if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 325 and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                v.HumanoidRootPart.CanCollide = false
                v.Head.CanCollide = false
                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                if v.Humanoid:FindFirstChild("Animator") then
                  v.Humanoid.Animator:Destroy()
                end
              end
            elseif v.Name == Mon then
              if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 325 and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                v.HumanoidRootPart.CanCollide = false
                v.Head.CanCollide = false
                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                if v.Humanoid:FindFirstChild("Animator") then
                  v.Humanoid.Animator:Destroy()
                end
              end
            end
          end
        end
      end
    end)
  end
end)

task.spawn(function()
	while true do wait()
		if setscriptable then
			setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
		end
		if sethiddenproperty then
			sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
		end
	end
end)

--//Bringmob Near
function InMyNetWork(object)
	if isnetworkowner then
		return isnetworkowner(object)
	else
		if (object.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 300 then 
			return true
		end
		return false
	end
end

    
function InMyNetWork(object)
	if isnetworkowner then
		return isnetworkowner(object)
	else
		if (object.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 300 then 
			return true
		end
		return false
	end
end

local SeliMethod = Tabs.Fimi:AddDropdown("Dropdown", {
  Title = "Select Method Farm",
  Values = {"Level","Bone","Cake Prince"},
  Multi = false,
  Default = _G.SelectMethod,
})

SeliMethod:OnChanged(function(Value)
  _G.SelectMethod = Value
  saveSettings()
end)

local IngoKata = Tabs.Fimi:AddToggle("MyToggle", {Title = "Ignore Katakuri", Default = _G.IngoKata })
IngoKata:OnChanged(function(Value)
  _G.IngoKata = Value
  saveSettings()
end)

local GetQuet = Tabs.Fimi:AddToggle("MyToggle", {Title = "Get Quest Farm [Katakuri or Bone]",Default = _G.GetQuet })
GetQuet:OnChanged(function(Value)
  _G.GetQuet = Value
  saveSettings()
end)

Tabs.Fimi:AddParagraph({
  Title = "",
  Content = "Farm Material"
})

if Sea1 then
  MaterialList = {"Magma Ore","Angel Wings","Leather","Scrap Metal","Radioactive Material"}
elseif Sea2 then
  MaterialList = {
    "Mystic Droplet","Magma Ore","Leather","Scrap Metal","Demonic Wisp","Vampire Fang","Radioactive Material"}
elseif Sea3 then
  MaterialList = {
    "Leather","Scrap Metal","Vampire Fang","Conjured Cocoa","Dragon Scale","Gunpowder","Fish Tail","Mini Tusk","Radioactive Material"}
end

local SeliMarteriel = Tabs.Fimi:AddDropdown("Dropdown", {
  Title = "Select Material",
  Values = MaterialList,
  Multi = false,
  Default = _G.SeliMarteriel,
})

SeliMarteriel:OnChanged(function(Value)
  _G.SeliMarteriel = Value
  saveSettings()
end)

local FimiMarteriu = Tabs.Fimi:AddToggle("MyToggle", {Title = "Farm Marterial",Default = _G.FimiMarteriu })
FimiMarteriu:OnChanged(function(Value)
  _G.FimiMarteriu = Value
  StopTween(_G.FimiMarteriu)
  saveSettings()
end)

spawn(function()
  while wait() do
    if _G.FimiMarteriu then
      MaterialMon()
      pcall(function()
        if game:GetService("Workspace").Enemies:FindFirstChild(MMon) then
          for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
            if v.Name == MMon then
              if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                repeat task.wait()
                  AutoHaki()
                  EquipWeapon(_G.SelectWeapon)
                  topos(v.HumanoidRootPart.CFrame * CFrame.new(PosX,30,PosZ))
                  v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                  MonFarm = v.Name
                  PosMon = v.HumanoidRootPart.CFrame
                  game:GetService'VirtualUser':CaptureController()
                  game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672), game.Workspace.CurrentCamera.CFrame)
                until _G.FimiMarteriu == false or not v.Parent or v.Humanoid.Health <= 0
              end
            end
          end
        else
          if _G.BabiTePo then
            if ((MPos).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 1500 then
              topos(MPos)
            else
              BTP(MPos)
            end
          else
            topos(MPos)
          end
        end
      end)
    end
  end
end)

Tabs.Fimi:AddParagraph({
  Title = "",
  Content = "Farming"
})

local Stifimi = Tabs.Fimi:AddToggle("MyToggle", {Title = "Start Farm",Description = "Start Farming Level or Bone Or Katakuri" ,Default = _G.Stifimi })
Stifimi:OnChanged(function(Value)
  _G.Stifimi = Value
  StopTween(_G.Stifimi)
  saveSettings()
end)

task.spawn(function()
  while wait() do
    if _G.Stifimi then
      pcall(function()
        if _G.SelectMethod == "Level" then
          _G.AutoFarm = true
          AutoBone = false
          AutoBoneQuet = false
          AutoKataNuQuest = false
          AutoKataYesQuest = false
          AnhNhoEm = false
          AnhYeuEm = false
        elseif _G.SelectMethod == "Bone" and not _G.GetQuet then
          _G.AutoFarm = false
          AutoBone = true
          AutoBoneQuet = false
          AutoKataNuQuest = false
          AutoKataYesQuest = false
          AnhNhoEm = false
          AnhYeuEm = false
        elseif _G.SelectMethod == "Bone" and _G.GetQuet then
          _G.AutoFarm = false
          AutoBone = false
          AutoBoneQuet = true
          AutoKataNuQuest = false
          AutoKataYesQuest = false
          AnhNhoEm = false
          AnhYeuEm = false
        elseif _G.SelectMethod == "Cake Prince" and not _G.GetQuet then
          _G.AutoFarm = false
          AutoBone = false
          AutoBoneQuet = false
          AutoKataNuQuest = true
          AutoKataYesQuest = false
          AnhNhoEm = false
          AnhYeuEm = false
        elseif _G.SelectMethod == "Cake Prince" and _G.GetQuet then
          _G.AutoFarm = false
          AutoBone = false
          AutoBoneQuet = false
          AutoKataNuQuest = false
          AutoKataYesQuest = true
          AnhNhoEm = false
          AnhYeuEm = false
      elseif _G.SelectMethod == "Cake Prince" and _G.GetQuet and _G.IngoKata then
        _G.AutoFarm = false
          AutoBone = false
          AutoBoneQuet = false
          AutoKataNuQuest = false
          AutoKataYesQuest = false
          AnhNhoEm = true
          AnhYeuEm = false
      elseif _G.SelectMethod == "Cake Prince" and not _G.GetQuet and _G.IngoKata then
        _G.AutoFarm = false
          AutoBone = false
          AutoBoneQuet = false
          AutoKataNuQuest = false
          AutoKataYesQuest = false
          AnhNhoEm = false
          AnhYeuEm = true
        end
      end)
    end
  end
end)

task.spawn(function()
  while wait() do
    if _G.AutoFarm and _G.Stifimi then
      pcall(function()
        local QuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
        if not string.find(QuestTitle, NameMon) then
          StartMagnet = false
          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
        end
        if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
          StartMagnet = false
          CheckQuest()
          if _G.BabiTePo then
            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude > 1500 then
              BTP(CFrameQuest)
              UnEquipWeapon(_G.SelectWeapon)
            elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude <= 1500 then
              topos(CFrameQuest)
              UnEquipWeapon(_G.SelectWeapon)
            else
              topos(CFrameQuest)
              UnEquipWeapon(_G.SelectWeapon)
            end
          else
            topos(CFrameQuest)
          end
          if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude <= 20 then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest",NameQuest,LevelQuest)
          end
          elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
          CheckQuest()
          if game:GetService("Workspace").Enemies:FindFirstChild(Mon) then
            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
              if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                if v.Name == Mon then
                    if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                      repeat task.wait()
                        EquipWeapon(_G.SelectWeapon)
                        AutoHaki()                                            
                        PosMon = v.HumanoidRootPart.CFrame
                        topos(v.HumanoidRootPart.CFrame * CFrame.new(PosX,40,PosZ))
                        v.HumanoidRootPart.CanCollide = false
                        v.Humanoid.WalkSpeed = 0
                        v.Head.CanCollide = false
                        StartMagnet = true
                      until not _G.AutoFarm or _G.Stifimi == false or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false or game.Players.LocalPlayer.Character.Humanoid.Health < 0
                  end
                end
              end
            end
          else
            topos(CFrameMon)
            StartMagnet = false
            if game:GetService("ReplicatedStorage"):FindFirstChild(Mon) then
              topos(game:GetService("ReplicatedStorage"):FindFirstChild(Mon).HumanoidRootPart.CFrame * CFrame.new(15,10,2))
            end
          end
        end
      end)
    end
  end
end)

task.spawn(function()
  while wait() do
    local boneframe = CFrame.new(-9508.5673828125, 142.1398468017578, 5737.3603515625)
    if _G.Stifimi and AutoBone and Sea3 then
      pcall(function()
        if _G.BabiTePo then
          if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - boneframe.Position).Magnitude > 2000 then
            BTP(boneframe)
            UnEquipWeapon(_G.SelectWeapon)
          elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - boneframe.Position).Magnitude < 2000 then
            topos(boneframe)
          end
        else
          topos(boneframe)
        end
        if game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy") then
          for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
            if v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy" then
              if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                repeat task.wait()
                  AutoHaki()
                  EquipWeapon(_G.SelectWeapon)
                  v.HumanoidRootPart.CanCollide = false
                  v.Humanoid.WalkSpeed = 0
                  v.Head.CanCollide = false
                  MonFarm = v.Name
                  PosMon = v.HumanoidRootPart.CFrame
                  topos(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                  game:GetService'VirtualUser':CaptureController()
                  game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672), game.Workspace.CurrentCamera.CFrame)
                until not _G.Stifimi or not AutoBone or not v.Parent or v.Humanoid.Health <= 0
              end
            end
          end
        else
          topos(CFrame.new(-9506.234375, 172.130615234375, 6117.0771484375))
          for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
            if v.Name == "Reborn Skeleton" then
              topos(v.HumanoidRootPart.CFrame * CFrame.new(2,20,2))
            elseif v.Name == "Living Zombie" then
              topos(v.HumanoidRootPart.CFrame * CFrame.new(2,20,2))
            elseif v.Name == "Demonic Soul" then
              topos(v.HumanoidRootPart.CFrame * CFrame.new(2,20,2))
            elseif v.Name == "Posessed Mummy" then
              topos(v.HumanoidRootPart.CFrame * CFrame.new(2,20,2))
            end
          end
        end
      end)
    end
  end
end)

task.spawn(function()
  while wait() do
  local CFrameQuestBone = CFrame.new(-9508.5673828125, 142.1398468017578, 5737.3603515625)
    if _G.Stifimi and AutoBoneQuet and Sea3 then
      pcall(function()
        local QuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
        if not string.find(QuestTitle, "Demonic Soul") then
          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
        end
        if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
          if _G.BabiTePo then
            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuestBone.Position).Magnitude > 1500 then
              BTP(CFrameQuestBone)
              UnEquipWeapon(_G.SelectWeapon)
            elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuestBone.Position).Magnitude <= 1500 then
              topos(CFrameQuestBone)
              UnEquipWeapon(_G.SelectWeapon)
            else
              topos(CFrameQuestBone)
              UnEquipWeapon(_G.SelectWeapon)
            end
          else
            topos(CFrameQuestBone)
          end
          if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuestBone.Position).Magnitude <= 20 then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest","HauntedQuest2",1)
          end
        elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
          if game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy") then
            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
              if v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy" then
                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                  if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Demonic Soul") then
                    repeat task.wait()
                      AutoHaki()
                      EquipWeapon(_G.SelectWeapon)
                      v.HumanoidRootPart.CanCollide = false
                      v.Humanoid.WalkSpeed = 0
                      v.Head.CanCollide = false
                      MonFarm = v.Name
                      PosMon = v.HumanoidRootPart.CFrame
                      topos(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                      game:GetService'VirtualUser':CaptureController()
                      game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672), game.Workspace.CurrentCamera.CFrame)
                    until not _G.Stifimi or not AutoBoneQuet or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                  else
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                  end
                end
              end
            end
          else
            topos(CFrame.new(-9506.234375, 172.130615234375, 6117.0771484375))
            for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
              if v.Name == "Reborn Skeleton" then
                topos(v.HumanoidRootPart.CFrame * CFrame.new(2,20,2))
              elseif v.Name == "Living Zombie" then
                topos(v.HumanoidRootPart.CFrame * CFrame.new(2,20,2))
              elseif v.Name == "Demonic Soul" then
                topos(v.HumanoidRootPart.CFrame * CFrame.new(2,20,2))
              elseif v.Name == "Posessed Mummy" then
                topos(v.HumanoidRootPart.CFrame * CFrame.new(2,20,2))
              end
            end
          end
        end
      end)
    end
  end
end)

task.spawn(function()
  while wait() do
    if _G.Stifimi and AutoKataNuQuest and Sea3 then
      pcall(function()
        if game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") then
          for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
            if v.Name == "Cake Prince" then
              if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                repeat task.wait()
                  AutoHaki()
                  EquipWeapon(_G.SelectWeapon)
                  v.HumanoidRootPart.CanCollide = false
                  v.Humanoid.WalkSpeed = 0
                  v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                  topos(v.HumanoidRootPart.CFrame * CFrame.new(PosX,40,PosZ))
                  game:GetService("VirtualUser"):CaptureController()
                  game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                until not _G.Stifimi or not AutoKataNuQuest or not v.Parent or v.Humanoid.Health <= 0
              end
            end
          end
        else
          if game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince") then
            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
          else
            if KillMob == 0 then
            end                    
            if game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 1 then
              if game:GetService("Workspace").Enemies:FindFirstChild("Cookie Crafter") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Guard") or game:GetService("Workspace").Enemies:FindFirstChild("Baking Staff") or game:GetService("Workspace").Enemies:FindFirstChild("Head Baker") then
                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                  if v.Name == "Cookie Crafter" or v.Name == "Cake Guard" or v.Name == "Baking Staff" or v.Name == "Head Baker" then
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                      repeat task.wait()
                        AutoHaki()
                        EquipWeapon(_G.SelectWeapon)
                        v.HumanoidRootPart.CanCollide = false
                        v.Humanoid.WalkSpeed = 0
                        v.Head.CanCollide = false 
                        v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                        topos(v.HumanoidRootPart.CFrame * CFrame.new(PosX,40,PosZ))
                        game:GetService("VirtualUser"):CaptureController()
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                        MonFarm = v.Name
                        PosMon = v.HumanoidRootPart.CFrame
                      until not _G.Stifimi or not AutoKataNuQuest or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 0 or game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") or KillMob == 0
                    end
                  end
                end
              else
                topos(CFrame.new(-2091.911865234375, 70.00884246826172, -12142.8359375))
                if game:GetService("ReplicatedStorage"):FindFirstChild("Cookie Crafter") then
                  topos(game:GetService("ReplicatedStorage"):FindFirstChild("Cookie Crafter").HumanoidRootPart.CFrame * CFrame.new(2,20,2)) 
                else
                  if game:GetService("ReplicatedStorage"):FindFirstChild("Cake Guard") then
                    topos(game:GetService("ReplicatedStorage"):FindFirstChild("Cake Guard").HumanoidRootPart.CFrame * CFrame.new(2,20,2)) 
                  else
                    if game:GetService("ReplicatedStorage"):FindFirstChild("Baking Staff") then
                      topos(game:GetService("ReplicatedStorage"):FindFirstChild("Baking Staff").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
                    else
                      if game:GetService("ReplicatedStorage"):FindFirstChild("Head Baker") then
                        topos(game:GetService("ReplicatedStorage"):FindFirstChild("Head Baker").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
                      end
                    end
                  end
                end                       
              end
            else
              if game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") then
                topos(game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
              else
                if game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince") then
                  topos(game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
                end
              end
            end
          end
        end
      end)
    end
  end
end)    

task.spawn(function()
  while wait() do
    if _G.Stifimi and AutoKataYesQuest and Sea3 then
      pcall(function()
        if game.ReplicatedStorage:FindFirstChild("Cake Prince") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") then
          if game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") then
            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
              if v.Name == "Cake Prince" then
                repeat task.wait()
                  AutoHaki()
                  EquipWeapon(_G.SelectWeapon)
                  v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                  v.HumanoidRootPart.CanCollide = false
                  topos(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                  game:GetService'VirtualUser':CaptureController()
                  game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672), game.Workspace.CurrentCamera.CFrame)
                until not _G.Stifimi or AutoKataYesQuest == false or not v.Parent or v.Humanoid.Health <= 0
              end
            end
          else
            topos(CFrame.new(-2009.2802734375, 4532.97216796875, -14937.3076171875))
          end
        else
        local QuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
          if not string.find(QuestTitle, "Head Baker") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
          end
          if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest","CakeQuest2",2)
          elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
            if game.Workspace.Enemies:FindFirstChild("Baking Staff") or game.Workspace.Enemies:FindFirstChild("Head Baker") or game.Workspace.Enemies:FindFirstChild("Cake Guard") or game.Workspace.Enemies:FindFirstChild("Cookie Crafter")  then
              for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if v.Name == "Cookie Crafter" or v.Name == "Cake Guard" or v.Name == "Baking Staff" or v.Name == "Head Baker" and v.Humanoid.Health > 0 then
                  if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Head Baker") then
                    repeat task.wait()
                      AutoHaki()
                      EquipWeapon(_G.SelectWeapon)
                      v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)  
                      MonFarm = v.Name
                      PosMon = v.HumanoidRootPart.CFrame
                      topos(v.HumanoidRootPart.CFrame * CFrame.new(0,40,0))
                      game:GetService("VirtualUser"):CaptureController()
                      game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                    until not _G.Stifimi or AutoKataYesQuest == false or game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince") or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                  else
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                  end
                end
              end
            else
              topos(CFrame.new(-1820.0634765625, 210.74781799316406, -12297.49609375))
            end
          end
        end
      end)
    end
  end
end)

task.spawn(function()
  while wait() do
  local CFrameAhiu = CFrame.new(-1820.0634765625, 210.74781799316406, -12297.49609375)
    if _G.Stifimi and AnhNhoEm and Sea3 then
      pcall(function()
        local QuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
        if not string.find(QuestTitle, "Head Baker") then
          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
        end
        if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
          if _G.BabiTePo then
            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameAhiu.Position).Magnitude > 1500 then
              BTP(CFrameAhiu)
              UnEquipWeapon(_G.SelectWeapon)
            elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameAhiu.Position).Magnitude <= 1500 then
              topos(CFrameAhiu)
              UnEquipWeapon(_G.SelectWeapon)
            else
              topos(CFrameAhiu)
              UnEquipWeapon(_G.SelectWeapon)
            end
          else
            topos(CFrameAhiu)
          end
          if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameAhiu.Position).Magnitude <= 30 then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest","CakeQuest2",2)
          end
        elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
          if game.Workspace.Enemies:FindFirstChild("Baking Staff") or game.Workspace.Enemies:FindFirstChild("Head Baker") or game.Workspace.Enemies:FindFirstChild("Cake Guard") or game.Workspace.Enemies:FindFirstChild("Cookie Crafter")  then
            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
              if v.Name == "Cookie Crafter" or v.Name == "Cake Guard" or v.Name == "Baking Staff" or v.Name == "Head Baker" then
                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                  if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Head Baker") then
                    repeat task.wait()
                      AutoHaki()
                      EquipWeapon(_G.SelectWeapon)
                      v.HumanoidRootPart.CanCollide = false
                      v.Humanoid.WalkSpeed = 0
                      v.Head.CanCollide = false
                      MonFarm = v.Name
                      PosMon = v.HumanoidRootPart.CFrame
                      topos(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                      game:GetService("VirtualUser"):CaptureController()
                      game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                    until not _G.Stifimi or not AnhNhoEm or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                  else
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                  end
                end
              end
            end
          else
            topos(CFrame.new(-1820.0634765625, 210.74781799316406, -12297.49609375))
          end
        end
      end)
    end
  end
end)

task.spawn(function()
  while wait() do
    local CFrameAhiu = CFrame.new(-1820.0634765625, 210.74781799316406, -12297.49609375)
    if _G.Stifimi and AnhYeuEm and Sea3 then
      pcall(function()
        if _G.BabiTePo then
          if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameAhiu.Position).Magnitude > 2000 then
            BTP(CFrameAhiu)
            UnEquipWeapon(_G.SelectWeapon)
          elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameAhiu.Position).Magnitude < 2000 then
            topos(CFrameAhiu)
          end
        else
          topos(CFrameAhiu)
        end
        if game.Workspace.Enemies:FindFirstChild("Baking Staff") or game.Workspace.Enemies:FindFirstChild("Head Baker") or game.Workspace.Enemies:FindFirstChild("Cake Guard") or game.Workspace.Enemies:FindFirstChild("Cookie Crafter")  then
          for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
            if v.Name == "Cookie Crafter" or v.Name == "Cake Guard" or v.Name == "Baking Staff" or v.Name == "Head Baker" then
              if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                repeat task.wait()
                  AutoHaki()
                  EquipWeapon(_G.SelectWeapon)
                  v.HumanoidRootPart.CanCollide = false
                  v.Humanoid.WalkSpeed = 0
                  v.Head.CanCollide = false
                  MonFarm = v.Name
                  PosMon = v.HumanoidRootPart.CFrame
                  topos(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                  game:GetService("VirtualUser"):CaptureController()
                  game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                until not _G.Stifimi or not AnhYeuEm or not v.Parent or v.Humanoid.Health <= 0
              end
            end
          end
        else
          topos(CFrame.new(-1820.0634765625, 210.74781799316406, -12297.49609375))
        end
      end)
    end
  end
end)

local TelepiToFut = Tabs.Stack:AddToggle("MyToggle", {Title = "Teleport To Fruit", Description = "Tween to fruit and take" ,Default = _G.TelepiToFut })
TelepiToFut:OnChanged(function(Value)
  _G.TelepiToFut = Value
  StopTween(_G.TelepiToFut)
  saveSettings()
end)

spawn(function()
  while wait(.1) do
    if _G.TelepiToFut then
      for i,v in pairs(game.Workspace:GetChildren()) do
        if string.find(v.Name, "Fruit") then
          topos(v.Handle.CFrame)
        end
      end
    end
  end
end)

local TelepiToFutHop = Tabs.Stack:AddToggle("MyToggle", {Title = "Teleport To Fruit [Hop]", Description = "Tween to fruit and take" ,Default = _G.TelepiToFutHop })
TelepiToFutHop:OnChanged(function(Value)
  _G.TelepiToFutHop = Value
  saveSettings()
end)

spawn(function()
  while wait(.1) do
    if _G.TelepiToFut and _G.TelepiToFutHop then
      for i,v in pairs(game.Workspace:GetChildren()) do
        if string.find(v.Name, "Fruit") then
          topos(v.Handle.CFrame)
        elseif not string.find(v.Name, "Fruit") then
          wait(6)
          Hop()
        end
      end
    end
  end
end)

local AutuFactory = Tabs.Stack:AddToggle("MyToggle", {Title = "Auto Factory", Description = "Sea 2 Function" ,Default = _G.AutuFactory })
AutuFactory:OnChanged(function(Value)
  _G.AutuFactory = Value
  StopTween(_G.AutuFactory)
  saveSettings()
end)

spawn(function()
  while wait() do
    pcall(function()
      if _G.AutoFactory and Sea2 then
        if game:GetService("Workspace").Enemies:FindFirstChild("Core") then
          for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
            if v.Name == "Core" and v.Humanoid.Health > 0 then
              repeat task.wait()
                AutoHaki()         
                EquipWeapon(_G.SelectWeapon)           
                topos(CFrame.new(448.46756, 199.356781, -441.389252))                                  
                game:GetService("VirtualUser"):CaptureController()
                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
              until v.Humanoid.Health <= 0 or _G.AutoFactory == false
            end
          end
        else
          topos(CFrame.new(448.46756, 199.356781, -441.389252))
        end
      end
    end)
  end
end)

local AutuPriteRi = Tabs.Stack:AddToggle("MyToggle", {Title = "Auto Pirate Raid", Description = "Sea 3 Function" ,Default = _G.AutuPriteRi })
AutuPriteRi:OnChanged(function(Value)
  _G.AutuPriteRi = Value
  StopTween(_G.AutuPriteRi)
  saveSettings()
end)

spawn(function()
  while wait() do
    if _G.AutuPriteRi and Sea3 then
      pcall(function()
        local CFrameBoss = CFrame.new(-5496.17432, 313.768921, -2841.53027, 0.924894512, 7.37058015e-09, 0.380223751, 3.5881019e-08, 1, -1.06665446e-07, -0.380223751, 1.12297109e-07, 0.924894512)
        if (CFrame.new(-5085.23681640625, 316.5072021484375, -3156.202880859375).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 350 then
          for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
            if _G.RaidPirate and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
              if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 350 then
                repeat wait()
                  AutoHaki()
                  EquipWeapon(_G.SelectWeapon)
                  v.HumanoidRootPart.CanCollide = false
                  v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                  topos(v.HumanoidRootPart.CFrame * CFrame.new(PosX,30,PosZ))
                  Click()
                until v.Humanoid.Health <= 0 or not v.Parent or not _G.AutuPriteRi
              end
            end
          end
        else
          if ((CFrameBoss).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 1500 then
            topos(CFrameBoss)
          else
            BTP(CFrameBoss)
          end
        end
      end)
    end
  end
end)

local AutuEliti = Tabs.Stack:AddToggle("MyToggle", {Title = "Auto Elite Hunter", Description = "Sea 3 Function" ,Default = _G.AutuEliti })
AutuEliti:OnChanged(function(Value)
  _G.AutuEliti = Value
  StopTween(_G.AutuEliti)
  saveSettings()
end)

spawn(function()
  while wait() do
    if _G.AutuEliti and Sea3 then
      pcall(function()
        if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
          if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Diablo") or string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Deandre") or string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Urban") then
            if game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban") then
              for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if v.Name == "Diablo" or v.Name == "Deandre" or v.Name == "Urban" then
                  if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                    repeat task.wait()
                      AutoHaki()
                      EquipWeapon(_G.SelectWeapon)
                      v.HumanoidRootPart.CanCollide = false
                      v.Humanoid.WalkSpeed = 0
                      v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                      topos(v.HumanoidRootPart.CFrame * CFrame.new(PosX,20,PosZ))
                      game:GetService("VirtualUser"):CaptureController()
                      game:GetService'VirtualUser':Button1Down(Vector2.new(0,1,0,1))
                    until _G.AutuEliti == false or v.Humanoid.Health <= 0 or not v.Parent
                  end
                end
              end
            else
              if game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") then
                topos(game:GetService("ReplicatedStorage"):FindFirstChild("Diablo").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
              elseif game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") then
                topos(game:GetService("ReplicatedStorage"):FindFirstChild("Deandre").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
              elseif game:GetService("ReplicatedStorage"):FindFirstChild("Urban") then
                topos(game:GetService("ReplicatedStorage"):FindFirstChild("Urban").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
              end
            end
          end
        else
          if _G.AutoEliteHunterHop and game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("EliteHunter") == "I don't have anything for you right now. Come back later." then
            hop()
          else
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
          end
        end
      end)
    end
  end
end)

local AutuTouchHaki = Tabs.Stack:AddToggle("MyToggle", {Title = "Auto Touch Pad Haki", Description = "Sea 3 Function" ,Default = _G.AutuTouchHaki })
AutuTouchHaki:OnChanged(function(Value)
  _G.AutuTouchHaki = Value
  StopTween(_G.AutuTouchHaki)
  saveSettings()
end)

spawn(function()
    if _G.AutuTouchHaki and Sea3 then
      repeat wait()
        AutoActiveColorRip_Indra()
      until not _G.AutuTouchHaki
    end
end)

local AtikiRip = Tabs.Stack:AddToggle("MyToggle", {Title = "Attack Rip Indra", Description = "Sea 3 Function" ,Default = _G.AtikiRip })
AtikiRip:OnChanged(function(Value)
  _G.AtikiRip = Value
  StopTween(_G.AtikiRip)
  saveSettings()
end)

spawn(function()
  while wait() do
    if _G.AtikiRip and Sea3 then
      pcall(function()
        if (CFrame.new(-5085.23681640625, 316.5072021484375, -3156.202880859375).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1500 then
          if game:GetService("Workspace").Enemies:FindFirstChild("rip_indra True Form") or game:GetService("Workspace").Enemies:FindFirstChild("rip_indra") then
            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
              if v.Name == "rip_indra True Form" and v.Humanoid.Health > 0 and v:IsA("Model") and v:FindFirstChild("Humanoid") or v.Name == "rip_indra" and v:FindFirstChild("HumanoidRootPart") then
                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                  repeat task.wait()
                    AutoHaki()
                    EquipWeapon(_G.SelectWeapon)
                    v.HumanoidRootPart.CanCollide = false
                    v.Humanoid.WalkSpeed = 0
                    v.HumanoidRootPart.Size = Vector3.new(80,80,80)                             
                    topos(v.HumanoidRootPart.CFrame * CFrame.new(PosX,30,PosZ))
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                  until not _G.AtikiRip or not v.Parent or v.Humanoid.Health <= 0
                end
              end
            end
          else
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-5085.23681640625, 316.5072021484375, -3156.202880859375))
          end
        elseif (CFrame.new(-5085.23681640625, 316.5072021484375, -3156.202880859375).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1500 then
          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-5085.23681640625, 316.5072021484375, -3156.202880859375))
        end
      end)
    end
  end
end)

local AtikiSoul = Tabs.Stack:AddToggle("MyToggle", {Title = "Attack Soul Reaper", Description = "Sea 3 Function" ,Default = _G.AtikiSoul })
AtikiSoul:OnChanged(function(Value)
  _G.AtikiSoul = Value
  StopTween(_G.AtikiSoul)
  saveSettings()
end)

spawn(function()
  while wait() do
    if _G.AtikiSoul and Sea3 then
      pcall(function()
        if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper") then
          for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
            if v.Name == "Soul Reaper" then
              if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                repeat task.wait()
                  AutoHaki()
                  EquipWeapon(_G.SelectWeapon)
                  v.HumanoidRootPart.CanCollide = false
                  v.Humanoid.WalkSpeed = 0
                  v.HumanoidRootPart.Size = Vector3.new(80,80,80)                             
                  topos(v.HumanoidRootPart.CFrame * CFrame.new(PosX,30,PosZ))
                  game:GetService("VirtualUser"):CaptureController()
                  game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                until not _G.AtikiSoul or not v.Parent or v.Humanoid.Health <= 0
              end
            end
          end
        else
          if game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper") then
            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper").HumanoidRootPart.CFrame * CFrame.new(5,10,2))
          end
        end
      end)
    end
  end
end)

local AtikiDoughKing = Tabs.Stack:AddToggle("MyToggle", {Title = "Attack Dough King", Description = "Sea 3 Function" ,Default = _G.AtikiDoughKing })
AtikiDoughKing:OnChanged(function(Value)
  _G.AtikiDoughKing = Value
  StopTween(_G.AtikiDoughKing)
  saveSettings()
end)

spawn(function()
  while wait() do
    if _G.AtikiDoughKing and Sea3 then
      pcall(function()
        if game:GetService("Workspace").Enemies:FindFirstChild("Dough King") then
          for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
            if v.Name == "Dough King" then
              if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                repeat task.wait()
                  AutoHaki()
                  EquipWeapon(_G.SelectWeapon)
                  v.HumanoidRootPart.CanCollide = false
                  v.Humanoid.WalkSpeed = 0
                  v.HumanoidRootPart.Size = Vector3.new(80,80,80)                             
                  topos(v.HumanoidRootPart.CFrame * CFrame.new(PosX,30,PosZ))
                  game:GetService("VirtualUser"):CaptureController()
                  game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                until not _G.AtikiDoughKing or not v.Parent or v.Humanoid.Health <= 0
              end
            end
          end
        else
          if game:GetService("ReplicatedStorage"):FindFirstChild("Dough King") then
            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Dough King").HumanoidRootPart.CFrame * CFrame.new(5,10,2))
          end
        end
      end)
    end
  end
end)

local AtikiDarkCu = Tabs.Stack:AddToggle("MyToggle", {Title = "Attack DarkBeard", Description = "Sea 2 Function" ,Default = _G.AtikiDarkCu })
AtikiDarkCu:OnChanged(function(Value)
  _G.AtikiDarkCu = Value
  StopTween(_G.AtikiDarkCu)
  saveSettings()
end)

spawn(function()
  while wait() do
    if _G.AtikiDarkCu and Sea2 then
      pcall(function()
        if game:GetService("Workspace").Enemies:FindFirstChild("Darkbeard") then
          for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
            if v.Name == "Darkbeard" then
              if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                repeat task.wait()
                  AutoHaki()
                  EquipWeapon(_G.SelectWeapon)
                  v.HumanoidRootPart.CanCollide = false
                  v.Humanoid.WalkSpeed = 0
                  v.HumanoidRootPart.Size = Vector3.new(80,80,80)                             
                  topos(v.HumanoidRootPart.CFrame * CFrame.new(PosX,30,PosZ))
                  game:GetService("VirtualUser"):CaptureController()
                  game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                until not _G.AtikiDarkCu or not v.Parent or v.Humanoid.Health <= 0
              end
            end
          end
        else
          if game:GetService("ReplicatedStorage"):FindFirstChild("Darkbeard") then
            topos(game:GetService("ReplicatedStorage"):FindFirstChild("Darkbeard").HumanoidRootPart.CFrame * CFrame.new(5,10,2))
          end
        end
      end)
    end
  end
end)

Tabs.FimiOht:AddParagraph({
  Title = "",
  Content = "Auto Chest"
})

local AutuChet = Tabs.FimiOht:AddToggle("Akiki", {Title = "Auto Chest", Description = "" ,Default = _G.AutuChet })
AutuChet:OnChanged(function(Value)
  _G.AutuChet = Value
  StopTween(_G.AutuChet)
  saveSettings()
end)

spawn(function()
while wait() do
    if _G.AutuChet then
      local ch = GetNearestChest()
      if ch then
        topos(ch)
        elseif ch == nil then
          repeat wait()
            local ch = GetNearestChest()
          until ch ~= nil
        end
    end
  end
end)

local AutuChetSafe = Tabs.FimiOht:AddToggle("MyToggle", {Title = "Tween Safe If Have Item", Description = "Tween in Caffe if Sea2 , Tween in Mansion if Sea3" ,Default = _G.AutuChetSafe })
AutuChetSafe:OnChanged(function(Value)
  _G.AutuChetSafe = Value
  StopTween(_G.AutuChetSafe)
  saveSettings()
end)

spawn(function()
  while wait() do
    if _G.AutuChetSafe then
      if game.Players.LocalPlayer.Backpack:FindFirstChild("Fist of Darkness") or game.Players.LocalPlayer.Character:FindFirstChild("Fist of Darkness") or game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice") then
        Options.Akiki:SetValue(false)
        if Sea2 then
          topos(CFrame.new(-380.47927856445, 77.220390319824, 255.82550048828))
        elseif Sea3 then
          topos(CFrame.new(-12471.169921875, 374.94024658203, -7551.677734375))
        end
      end
    end
  end
end)

end

Tabs.FimiOht:AddSection("Farming Observation")

local liviObservation = Tabs.FimiOht:AddParagraph({
  Title = "Observation Level",
  Content = ""
})

spawn(function()
  while wait() do
    liviObservation:SetDesc("Observation Range Level : "..math.floor(game:GetService("Players").LocalPlayer.VisionRadius.Value))
  end
end)

local AutuObservation = Tabs.FimiOht:AddToggle("MyToggle", {Title = "Farming Observation", Default = _G.AutuObservation })
AutuObservation:OnChanged(function(Value)
  _G.AutuObservation = Value
  StopTween(_G.AutuObservation)
  saveSettings()
end)

local AutuObservationHop = Tabs.FimiOht:AddToggle("MyToggle", {Title = "Farming Observation [Hop]", Default = _G.AutuObservationHop })
AutuObservationHop:OnChanged(function(Value)
  _G.AutuObservationHop = Value
  StopTween(_G.AutuObservationHop)
  saveSettings()
end)

spawn(function()
  while wait() do
    pcall(function()
      if _G.AutuObservation then
        repeat task.wait()
          if not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
            game:GetService('VirtualUser'):CaptureController()
            game:GetService('VirtualUser'):SetKeyDown('0x65')
            wait(2)
            game:GetService('VirtualUser'):SetKeyUp('0x65')
          end
        until game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") or not _G.AutuObservation
      end
    end)
  end
end)
    
spawn(function()
  pcall(function()
    while wait() do
      if _G.AutuObservation then
        if game:GetService("Players").LocalPlayer.VisionRadius.Value >= 5000 then
          game:GetService("StarterGui"):SetCore("SendNotification", {
            Icon = "rbxassetid://17656077747";
            Title = "Status Observation:", 
            Text = "You Have Max Points"
          })
          wait(2)
        else
          if Sea2 then
            if game:GetService("Workspace").Enemies:FindFirstChild("Lava Pirate [Lv. 1200]") then
              if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                repeat task.wait()
                  game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Lava Pirate").HumanoidRootPart.CFrame * CFrame.new(3,0,0)
                until _G.AutuObservation == false or not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
              else
                repeat task.wait()
                  game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Lava Pirate").HumanoidRootPart.CFrame * CFrame.new(0,50,0)+
                  wait(1)
                  if not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") and _G.AutuObservationHop == true then
                    game:GetService("TeleportService"):Teleport(game.PlaceId,game:GetService("Players").LocalPlayer)
                  end
                until _G.AutuObservation == false or game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
              end
            else
              topos(CFrame.new(-5478.39209, 15.9775667, -5246.9126))
            end
          elseif Sea1 then
            if game:GetService("Workspace").Enemies:FindFirstChild("Galley Captain [Lv. 650]") then
              if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                repeat task.wait()
                  game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Galley Captain").HumanoidRootPart.CFrame * CFrame.new(3,0,0)
                until _G.AutuObservation == false or not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
              else
                repeat task.wait()
                  game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Galley Captain").HumanoidRootPart.CFrame * CFrame.new(0,50,0)
                  wait(1)
                  if not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") and _G.AutuObservationHop == true then
                    game:GetService("TeleportService"):Teleport(game.PlaceId,game:GetService("Players").LocalPlayer)
                  end
                until _G.AutuObservation == false or game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
              end
            else
              topos(CFrame.new(5533.29785, 88.1079102, 4852.3916))
            end
          elseif Sea3 then
            if game:GetService("Workspace").Enemies:FindFirstChild("Giant Islander") then
              if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                repeat task.wait()
                  game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Giant Islander").HumanoidRootPart.CFrame * CFrame.new(3,0,0)
                until _G.AutuObservation == false or not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
              else
                repeat task.wait()
                  game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Giant Islander").HumanoidRootPart.CFrame * CFrame.new(0,50,0)
                  wait(1)
                  if not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") and _G.AutuObservationHop == true then
                    game:GetService("TeleportService"):Teleport(game.PlaceId,game:GetService("Players").LocalPlayer)
                  end
                until _G.AutuObservation == false or game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
              end
            else
              topos(CFrame.new(4530.3540039063, 656.75695800781, -131.60952758789))
            end
          end
        end
      end
    end
  end)
end)

Tabs.FimiOht:AddSection("Farming Boss")

local Boss = {}

for i, v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
  if string.find(v.Name, "Boss") then
    if v.Name == "Ice Admiral" then
    else
      table.insert(Boss, v.Name)
    end
  end
end

local bossCheck = {}
local bossNames = { "The Gorilla King", "Bobby", "The Saw", "Yeti", "Mob Leader", "Vice Admiral", "Warden", "Chief Warden", "Swan", "Saber Expert", "Magma Admiral", "Fishman Lord", "Wysper", "Thunder God", "Cyborg", "Greybeard", "Diamond", "Jeremy", "Fajita", "Don Swan", "Smoke Admiral", "Awakened Ice Admiral", "Tide Keeper", "Order", "Darkbeard", "Cursed Captain", "Stone", "Island Empress", "Kilo Admiral", "Captain Elephant", "Beautiful Pirate", "Longma", "Cake Queen", "Soul Reaper", "Rip_Indra", "Cake Prince", "Dough King" }

if Sea1 or Sea2 or Sea3 then
  for _, bossName in pairs(bossNames) do
    if game:GetService("ReplicatedStorage"):FindFirstChild(bossName) then
      table.insert(bossCheck, bossName)
    end
  end
end

for _, name in pairs(Boss) do
  table.insert(bossCheck, name)
end

local MultiDropdown = Tabs.FimiOht:AddDropdown("MultiDropdown", {
        Title = "Select Boss",
        Description = "You can select multiple boss.",
        Values = bossCheck,
        Multi = true,
        Default = {"seven", "twelve"},
    })
    
    MultiDropdown:OnChanged(function(Value)
    _G.SeliBoss = Value
  saveSettings()
        local Values = {}
        for Value, State in next, Value do
            table.insert(Values, Value)
        end
        print("Mutlidropdown changed:", table.concat(Values, ", "))
    end)

local SeliBoss = Tabs.FimiOht:AddDropdown("Dropdown", {
  Title = "Select Boss",
  Values = bossCheck,
  Multi = true,
  Default = "Kk",
})

SeliBoss:OnChanged(function(Value)
  _G.SeliBoss = Value
  saveSettings()
  local Values = {}
        for Value, State in next, Value do
            table.insert(Values, Value)
        end
end)

if _G.SeliBoss == nil then
  _G.SeliBoss = "Kk"
end

loadstring(game:HttpGet(('https://raw.githubusercontent.com/DuongTGMXSADCAT/Library/main/scr%20(2).txt')))()

    abc = true
    task.spawn(function()
        local a = game.Players.LocalPlayer
        local b = require(a.PlayerScripts.CombatFramework.Particle)
        local c = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
        if not shared.orl then
            shared.orl = c.wrapAttackAnimationAsync
        end
        if not shared.cpc then
            shared.cpc = b.play
        end
        if abc then
            pcall(function()
                c.wrapAttackAnimationAsync = function(d, e, f, g, h)
                    local i = c.getBladeHits(e, f, g)
                    if i then
                        b.play = function()
                        end
                        d:Play(0.1, 0.1, 0.1)
                        h(i)
                        b.play = shared.cpc
                        wait(.5)
                        d:Stop()
                    end
                end
            end)
        end
    end)

local old = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
local com = getupvalue(old, 2)
require(game.ReplicatedStorage.Util.CameraShaker):Stop()
spawn(
    function()
        game:GetService("RunService").Stepped:Connect(
            function()
                pcall(
                    function()
                        com.activeController.hitboxMagnitude = 60
                        if UseFastAttack or Config["Fast Attack Aura"] then
                            com.activeController.hitboxMagnitude = 60
                            com.activeController.active = false
                            com.activeController.blocking = false
                            com.activeController.focusStart = 0
                            com.activeController.hitSound = nil
                            com.activeController.increment = 0
                            com.activeController.timeToNextAttack = 0
                            com.activeController.timeToNextBlock = 0
                            com.activeController:attack()
                        end
                    end
                )
            end
        )
    end
)

local ply = game.Players.LocalPlayer

local Combatfram1 = debug.getupvalues(require(ply.PlayerScripts.CombatFramework))
local Combatfram2 = Combatfram1[2]

function GetCurrentBlade()
    local p13 = Combatfram2.activeController
    local ret = p13.blades[1]
    if not ret then
        return
    end
    while ret.Parent ~= game.Players.LocalPlayer.Character do
        ret = ret.Parent
    end
    return ret
end

function Caclo()
    pcall(
        function()
            local a = game.Players.LocalPlayer
            local b = getupvalues(require(a.PlayerScripts.CombatFramework))[2]
            local e = b.activeController
            for f = 1, 1 do
                local g =
                    require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
                    a.Character,
                    {a.Character.HumanoidRootPart},
                    60
                )
                local h = {}
                local i = {}
                for j, k in pairs(g) do
                    if k.Parent:FindFirstChild("HumanoidRootPart") and not i[k.Parent] then
                        table.insert(h, k.Parent.HumanoidRootPart)
                        i[k.Parent] = true
                    end
                end
                g = h
                if #g > 0 then
                    local l = debug.getupvalue(e.attack, 5)
                    local m = debug.getupvalue(e.attack, 6)
                    local n = debug.getupvalue(e.attack, 4)
                    local o = debug.getupvalue(e.attack, 7)
                    local p = (l * 798405 + n * 727595) % m
                    local q = n * 798405
                    (function()
                        p = (p * m + q) % 1099511627776
                        l = math.floor(p / m)
                        n = p - l * m
                    end)()
                    o = o + 1
                    debug.setupvalue(e.attack, 5, l)
                    debug.setupvalue(e.attack, 6, m)
                    debug.setupvalue(e.attack, 4, n)
                    debug.setupvalue(e.attack, 7, o)
                    pcall(
                        function()
                            if a.Character:FindFirstChildOfClass("Tool") and e.blades and e.blades[1] then
                                e.animator.anims.basic[1]:Play(0.01, 0.01, 0.01)
                                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer(
                                    "weaponChange",
                                    tostring(GetCurrentBlade())
                                )
                                game.ReplicatedStorage.Remotes.Validator:FireServer(
                                    math.floor(p / 1099511627776 * 16777215),
                                    o
                                )
                                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", g, f, "")
                            end
                        end
                    )
                end
            end
            b.activeController.timeToNextAttack = -math.huge
            b.activeController.attacking = false
            b.activeController.timeToNextBlock = 0
            b.activeController.humanoid.AutoRotate = 80
            b.activeController.increment = 4
            b.activeController.blocking = false
            b.activeController.hitboxMagnitude = 200
        end
    )
end
if not _G.AttackConfig then
    _G.AttackConfig = {
        ["Fast Attack Aura"] = true,
        ["Fast Attack Delay"] = 0.1,
    }
end
_G.AttackConfig["Fast Attack Delay"] = _G.AttackConfig["Fast Attack Delay"]
local LastAz = 0 
game:GetService"RunService".Heartbeat:Connect(function()
    if UseFastAttack or _G.AttackConfig["Fast Attack Aura"] then
        if tick()-LastAz >= _G.AttackConfig["Fast Attack Delay"] then 
            LastAz = tick()
            Caclo()
        end
    end
end)
