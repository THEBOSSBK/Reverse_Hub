--Gui
local ReverseHub = loadstring(game:HttpGet('https://raw.githubusercontent.com/THEBOSSBK/Reverse_Hub/refs/heads/main/Gui_editor_KuyliIsus.lua'))()
local Window = ReverseHub:CreateWindow({
   Name = "ReverseHub_Fisch",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Loading...",
   LoadingSubtitle = "by THEBOSS_K1Y",
   Theme = "Green", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = true, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "ReverseHub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "ReverseHub",
      Subtitle = "Key System",
      Note = "The key is 'Admin' ", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Admin"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

------------แมพตกปลาfish
local Tab = Window:CreateTab("Main", 4483362458) -- Title, Image
local Label = Tab:CreateLabel("Auto fishing", "crown")
local Player = game:GetService("Players")
local LocalPlayer = Player.LocalPlayer
local Char = LocalPlayer.Character
local Humanoid = Char.Humanoid
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuiService = game:GetService("GuiService")

equipitem = function(v)
if LocalPlayer.Backpack:FindFirstChild(v) then
    local a = LocalPlayer.Backpack:FindFirstChild(v)
        Humanoid:EquipTool(a)
    end
end

--หน้าที่1
local Toggle = Tab:CreateToggle({
    Name = "AutoFishing",
    CurrentValue = false,
    Flag = "AutoFishing",
    Callback = function(Value)
        _G.AutoFishing = Value -- กำหนดค่าให้ _G.AutoFishing

        if Value then
            -- Spawn สำหรับการสวมใส่เบ็ดตกปลาอัตโนมัติ
            spawn(function()
                while _G.AutoFishing do
                    wait()
                    pcall(function()
                        for i, v in pairs(LocalPlayer.Backpack:GetChildren()) do
                            if v:IsA("Tool") and v.Name:lower():find("rod") then
                                equipitem(v.Name)
                            end
                        end
                    end)
                end
            end)

            -- Spawn สำหรับการตกปลา
            spawn(function()
                pcall(function()
                    while _G.AutoFishing do
                        task.wait(1.5)
                        local Rod = Char:FindFirstChildOfClass("Tool") -- ค้นหาเบ็ดตกปลา
                        if Rod and Rod:FindFirstChild("events") then
                            Rod.events.cast:FireServer(100, 1) -- ใช้งาน cast
                           else
                        end
                    end
                end)
            end)
        end
    end
})

-- หน้าที่ 1: AutoShake
local Toggle2 = Tab:CreateToggle({
    Name = "AutoShake",
    CurrentValue = false,
    Flag = "AutoShake",
    Callback = function(Value)
        _G.AutoShake = Value
        if Value then
            pcall(function()
                while _G.AutoShake do
                    task.wait(0.05)
                    local PlayerGUI = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
                    local shakeUI = PlayerGUI:FindFirstChild("shakeui")
                    if shakeUI and shakeUI.Enabled then
                        local safezone = shakeUI:FindFirstChild("safezone")
                        if safezone then
                            local button = safezone:FindFirstChild("button")
                            if button and button:IsA("ImageButton") and button.Visible then
                                GuiService.SelectedObject = button
                                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                            end
                        end
                    end
                end
            end)
        end
    end
})

local Toggle3 = Tab:CreateToggle({
    Name = "AutoReel",
    CurrentValue = false,
    Flag = "AutoReel",
    Callback = function(Value)
        _G.AutoReel = Value -- กำหนดค่าให้ _G.AutoReel

        if Value then
            spawn(function()
                pcall(function()
                    while _G.AutoReel do
                        wait()
                        for _, gui in pairs(LocalPlayer.PlayerGui:GetChildren()) do
                            if gui:IsA("ScreenGui") and gui.Name == "reel" then
                                if gui:FindFirstChild("bar") then
                                    wait(0.15)
                                    ReplicatedStorage.events.reelfinished:FireServer(100, true)
                                end
                            end
                        end
                    end
                end)
            end)
        end
    end
})



   --หน้าที่2
local Tab2 = Window:CreateTab("Teleport", "plane")
local Label2 = Tab2:CreateLabel("Island", "plane")
local Dropdown = Tab2:CreateDropdown({
   Name = "Select Island",
   Options = {"None", "Ancient Isle", "Archeological Site", "Birch Cay", "Desolate Deep", "Earmark Island", "Forsaken Shore", "Haddock Rock", "Harvesters Spike", "Moosewood", "Mushgrove Swamp", "Northern Expedition", "Roslit Bay", "Snowcap Island", "Statue of Sovereignty", "Sunstone Island", "Terrapin Island", "The Arch", "Vertigo"},
   CurrentOption = "None",
   MultipleOptions = false,
   Callback = function(Option)
        if Option == "Moosewood" then
            local player = game:GetService("Players").LocalPlayer
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(
                    384.00119, 134.000031, 228.162277, 
                    -0.0660171658, -5.48803207e-08, 0.99781847, 
                    -6.97687454e-08, 1, 5.03842976e-08, 
                    -0.99781847, -6.6290319e-08, -0.0660171658
                )
                print("ผู้เล่นถูกวาร์ปไปยัง Moosewood")
            end
        end
   end,
})



  --หน้าที่3
local Tab3 = Window:CreateTab("Player", "user-2")
local Label3 = Tab3:CreateLabel("Remove Oxygen", "droplets")
local ToggleOxygen = Tab3:CreateToggle({
    Name = "Remove Oxygen",
    CurrentValue = false,
    Flag = "RemoveOxygen",
    Callback = function(Value)
        _G.RemoveOxygen = Value -- กำหนดค่าให้ _G.RemoveOxygen
        if Value then
            spawn(function()
                while _G.RemoveOxygen do
                    wait(5) -- หน่วงเวลาเล็กน้อย
                    local player = game:GetService("Players").LocalPlayer
                    local client = workspace:FindFirstChild(player.Name) and workspace[player.Name]:FindFirstChild("client")
                    if client then
                        -- ลบ oxygen
                        if client:FindFirstChild("oxygen") then
                            client.oxygen:Destroy()
                        end
                        -- ลบ oxygen(peaks)
                        if client:FindFirstChild("oxygen(peaks)") then
                            client["oxygen(peaks)"]:Destroy()
                        end
                        -- ลบ temperature
                        if client:FindFirstChild("temperature") then
                            client.temperature:Destroy()
                        end
                     else
                    end
                end
            end)
        end
    end,
})




