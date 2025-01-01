local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/THEBOSSBK/Reverse_Hub/refs/heads/main/Gui_editor_KuyliIsus.lua'))()
local Window = Rayfield:CreateWindow({
   Name = "Reverse_Hub",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Checking Map.....",
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
If game.PlaceId 16732694052 then
   local Tab = Window:CreateTab("หน้าหลัก", 4483362458) -- Title, Image
   local Player = game:GetService("Players")
   local LocalPlayer = Player.LocalPlayer
   local Char = LocalPlayer.Character
   local Humanoid = Char.Humanoid
   local VirtualInputManager = game:GetService("VirtualInputManager")
   local ReplicatedStorage = game:GetService("ReplicatedStorage")
   local GuiService = game:GetService("GuiService")
   --หน้าที่1
   local Toggle = Tab:CreateToggle({
           Name = "AutoFishing",
           CurrentValue = false,
           Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
           Callback = function(Value)
               print(Value)
           end,
       })
   --หน้าที่2
   local Tab1 = Window:CreateTab("ผู้เล่น", "user-2")
else Rayfield:Destroy(),
   print "Destory"
