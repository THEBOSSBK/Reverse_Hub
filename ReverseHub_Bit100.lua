--Gui
local ReverseHub = loadstring(game:HttpGet('https://raw.githubusercontent.com/THEBOSSBK/Reverse_Hub/refs/heads/main/Gui_editor_KuyliIsus.lua'))()
local Window = ReverseHub:CreateWindow({
   Name = "ReverseHub_Fisch",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Loading...",
   LoadingSubtitle = "by THEBOSS_K1Y",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

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
local Tab = Window:CreateTab("หน้าหลัก", 4483362458) -- Title, Image
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
        _G.AutoFishing = Value
        _G.AutoShake = Value

        -- AutoFishing
        if Value then
            pcall(function()
                while _G.AutoFishing do
                    task.wait()
                    local Rod = Char:FindFirstChildOfClass("Tool")
                    if Rod and Rod:FindFirstChild("events") then
                        Rod.events.cast:FireServer(100, 1)
                    end
                end
            end)
        end

        -- AutoShake
        if Value then
            pcall(function()
                while _G.AutoShake do
                    task.wait(0.01)
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


   --หน้าที่2
local Tab1 = Window:CreateTab("ผู้เล่น", "user-2")
