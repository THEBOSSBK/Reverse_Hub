local function notify(title, message)
    -- ใช้ระบบแจ้งเตือนพื้นฐาน
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title;  -- ชื่อหัวข้อ
        Text = message; -- ข้อความ
        Duration = 5;   -- ระยะเวลาการแจ้งเตือน (วินาที)
    })
end
--map--
local fisch

if game.PlaceId == 16732694052 then
    fisch = loadstring(game:HttpGet("https://raw.githubusercontent.com/THEBOSSBK/Reverse_Hub/refs/heads/main/ReverseHub_Bit100.lua"))()
else
    notify("ไม่พบแมพในระบบ", "ต้องการโหลดแบบทั่วไปไหม?")
end
