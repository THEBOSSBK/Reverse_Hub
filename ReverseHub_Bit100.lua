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
        ["Ancient_Isle"] = CFrame.new(0, 5, 0),
        ["Archeological_Site"] = CFrame.new(10, 5, 0),
        ["Birch_Cay"] = CFrame.new(20, 5, 0),
        ["Desolate_Deep"] = CFrame.new(30, 5, 0),
        ["Earmark_Island"] = CFrame.new(40, 5, 0),
        ["Forsaken_Shore"] = CFrame.new(50, 5, 0),
        ["Haddock_Rock"] = CFrame.new(60, 5, 0),
        ["Harvesters_Spike"] = CFrame.new(70, 5, 0),
        ["Moosewood"] = CFrame.new(80, 5, 0),
        ["Mushgrove_Swamp"] = CFrame.new(90, 5, 0),
        ["Northern_Expedition"] = CFrame.new(100, 5, 0),
        ["Roslit_Bay"] = CFrame.new(110, 5, 0),
        ["Snowcap_Island"] = CFrame.new(120, 5, 0),
        ["Statue_of_Sovereignty"] = CFrame.new(130, 5, 0),
        ["Sunstone_Island"] = CFrame.new(140, 5, 0),
        ["Terrapin_Island"] = CFrame.new(150, 5, 0),
        ["The_Arch"] = CFrame.new(160, 5, 0),
        ["Vertigo"] = CFrame.new(170, 5, 0),
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
    Options = {"None","Ancient_Isle","Archeological_Site","Birch_Cay","Desolate_Deep","Earmark_Island","Forsaken_Shore","Haddock_Rock","Harvesters_Spike","Moosewood","Mushgrove_Swamp","Northern_Expedition","Roslit_Bay","Snowcap_Island","Statue_of_Sovereignty","Sunstone_Island","Terrapin_Island","The_Arch","Vertigo"},
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




