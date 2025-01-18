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

--ตัวแปรการวาป
getgenv().SelectedOption = nil

function doStuff()
    local locations = {
        ["None"] = nil,
        ["Ancient_Isle"] = CFrame.new(6064.54688, 194.980164, 312.77887, 0.998178661, 7.10222992e-08, -0.0603267364, -6.87813255e-08, 1, 3.9223881e-08, 0.0603267364, -3.50030867e-08, 0.998178661),
        ["Archeological_Site"] = CFrame.new(10, 5, 0),
        ["Birch_Cay"] = CFrame.new(20, 5, 0),
        ["Desolate_Deep"] = CFrame.new(30, 5, 0),
        ["Enchant_Area"] = CFrame.new(1310.70935, -802.427002, -84.9216995, -0.970154405, -1.2805276e-08, 0.242488071, -2.96510261e-09, 1, 4.0944979e-08, -0.242488071, 3.90039503e-08, -0.970154405),
        ["Forsaken_Shore"] = CFrame.new(-2495.02173, 133.250015, 1554.58215, 0.538006961, 4.56431906e-08, -0.84294039, -4.43592576e-08, 1, 2.58352806e-08, 0.84294039, 2.34926496e-08, 0.538006961),
        ["Haddock_Rock"] = CFrame.new(60, 5, 0),
        ["Harvesters_Spike"] = CFrame.new(70, 5, 0),
        ["Moosewood"] = CFrame.new(384.00119, 134.000031, 228.162277, -0.0660171658, -5.48803207e-08, 0.99781847, -6.97687454e-08, 1, 5.03842976e-08, -0.99781847, -6.6290319e-08, -0.0660171658),
        ["Mushgrove_Swamp"] = CFrame.new(2486.60132, 131.000031, -643.128967, 0.990038693, 7.54940732e-09, -0.140795544, -4.31052749e-09, 1, 2.33091093e-08, 0.140795544, -2.2470017e-08, 0.990038693),
        ["Northern_Expedition"] = CFrame.new(100, 5, 0),
        ["Roslit_Bay"] = CFrame.new(-1502.13208, 136.000015, 701.323975, -0.0114548216, 9.95772638e-08, -0.999934375, 1.80769515e-08, 1, 9.93767202e-08, 0.999934375, -1.69374239e-08, -0.0114548216),
        ["Roslit_Volcano"] = CFrame.new(-1890.41418, 167.782425, 320.549744, 0.802569211, 1.56462114e-08, 0.596559048, -3.53638763e-09, 1, -2.14698197e-08, -0.596559048, 1.51213531e-08, 0.802569211),
        ["Snowcap_Island"] = CFrame.new(2684.26978, 152.563171, 2391.84399, -0.596695781, 4.61462086e-08, -0.802467525, 4.15205578e-11, 1, 5.74745158e-08, 0.802467525, 3.42614825e-08, -0.596695781),
        ["Statue_of_Sovereignty"] = CFrame.new(-30.354311, 136.492218, -1123.58142, -0.907281041, -2.36758275e-08, 0.420524865, -4.25602664e-08, 1, -3.55229766e-08, -0.420524865, -5.0126971e-08, -0.907281041),
        ["Sunstone_Island"] = CFrame.new(-926.07373, 132.921814, -1118.5658, -0.744835556, -1.06535488e-07, 0.66724807, -5.37780025e-08, 1, 9.96326861e-08, -0.66724807, 3.83266965e-08, -0.744835556),
        ["Terrapin_Island"] = CFrame.new(-157.890625, 145.014496, 1939.98169, 0.305243313, 2.18692575e-09, 0.952274382, 4.17725188e-09, 1, -3.635511e-09, -0.952274382, 5.08760545e-09, 0.305243313),
        ["The_Arch"] = CFrame.new(993.076416, 131.320251, -1236.35254, -0.998920202, 2.38470554e-09, -0.0464590788, 2.7276883e-09, 1, -7.31907424e-09, 0.0464590788, -7.43789697e-09, -0.998920202),
        ["The_Depths"] = CFrame.new(951.672302, -711.662048, 1245.03406, -0.709650695, 6.08799766e-08, 0.704553723, 2.78244041e-08, 1, -5.83835842e-08, -0.704553723, -2.18281624e-08, -0.709650695),
        ["Vertigo"] = CFrame.new(-111.910866, -515.299377, 1044.38477, -0.998817682, -7.30476373e-08, -0.0486136861, -7.61575336e-08, 1, 6.21193408e-08, 0.0486136861, 6.57481962e-08, -0.998817682),
    }

    local selectedCFrame = locations[getgenv().SelectedOption]

    if selectedCFrame then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = selectedCFrame
        print("ผู้เล่นถูกวาร์ปไปยัง: " .. getgenv().SelectedOption)
    else
        print("Option ไม่มีผลลัพธ์ หรือไม่มีการกำหนดค่า: " .. tostring(getgenv().SelectedOption))
    end
end


-- หน้าที่ 2
local Tab2 = Window:CreateTab("Teleport", "plane")
local Label2 = Tab2:CreateLabel("Island", "plane")
local Dropdown = Tab2:CreateDropdown({
    Name = "Select Island",
    Options = {"None","Ancient_Isle","Archeological_Site","Birch_Cay","Desolate_Deep","Enchant_Area","Forsaken_Shore","Haddock_Rock","Harvesters_Spike","Moosewood","Mushgrove_Swamp","Northern_Expedition","Roslit_Bay","Roslit_Volcano","Snowcap_Island","Statue_of_Sovereignty","Sunstone_Island","Terrapin_Island","The_Arch","The_Depths","Vertigo"},
    CurrentOption = "None",
    MultipleOptions = false,
    Callback = function(Option)
    if type(Option) == "table" then -- ตรวจสอบว่า Option เป็น table หรือไม่
        for _, value in pairs(Option) do -- วนลูปผ่านค่าภายใน table
            print(value) -- แสดงค่าของแต่ละรายการใน table
            getgenv().SelectedOption = value -- กำหนดค่าให้ SelectedOption
            doStuff() -- เรียกใช้งานฟังก์ชัน doStuff
        end
    else
        print(Option) -- แสดงค่าถ้า Option เป็น string
        getgenv().SelectedOption = Option -- กำหนดค่าให้ SelectedOption
        doStuff() -- เรียกใช้งานฟังก์ชัน doStuff
    end
end,
})

local Dropdown3 = Tab2:CreateDropdown({
   Name = "Dropdown Example",
   Options = {"Option 1","Option 2"},
   CurrentOption = {"Option 1"},
   MultipleOptions = false, -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Option)
        if type(Option) == "table" then
            for _, value in pairs(Option) do
                print(value) -- แสดงค่าจาก table
            end
        else
            print(Option) -- แสดงค่าถ้าเป็น string
        end
    end,
})


  --หน้าที่3
local Tab3 = Window:CreateTab("Player", "user-2")
local Label3 = Tab3:CreateLabel("Remove Oxygen", "droplets")
local Button1 = Tab3:CreateButton({
    Name = "Remove Oxygen",
    Callback = function()
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
    end,
})




