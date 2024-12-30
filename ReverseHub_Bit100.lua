game.StarterGui: SetCore ("SendNotification", {
    Title = "Reverse_Hud";
    Text = "Checking Map";
    Icon = "rbxassetid://12316561489";
    Duration = "7";
  })
wait(5)
If game.PlaceId 16732694052 then
    loadstring(game:HttpGet("https://github.com/THEBOSSBK/Reverse_Hub/raw/refs/heads/main/ReverseHub_Bit100_Fisch.lua"))()
end
