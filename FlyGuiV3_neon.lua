local main = Instance.new("ScreenGui")
local Outer = Instance.new("Frame")
local Inner = Instance.new("Frame")
local UICornerOuter = Instance.new("UICorner")
local UICornerInner = Instance.new("UICorner")
local OuterStroke = Instance.new("UIStroke")
local glow = Instance.new("ImageLabel")

local up = Instance.new("TextButton")
local down = Instance.new("TextButton")
local plus = Instance.new("TextButton")
local mine = Instance.new("TextButton")
local speed = Instance.new("TextLabel")
local onof = Instance.new("TextButton")
local title = Instance.new("TextLabel")
local colorToggle = Instance.new("TextButton")
local closebutton = Instance.new("TextButton")
local mini = Instance.new("TextButton")
local mini2 = Instance.new("TextButton")

-- root
main.Name = "main"
main.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
main.ResetOnSpawn = false

-- Outer frame (neon border)
Outer.Name = "Outer"
Outer.Parent = main
Outer.BackgroundTransparency = 1
Outer.Position = UDim2.new(0.12, 0, 0.36, 0)
Outer.Size = UDim2.new(0, 380, 0, 160)

-- glow Image behind to simulate neon bloom (use a simple rounded rectangle PNG if available)
-- fallback: use an ImageLabel with BackgroundColor and big corner radius
glow.Name = "Glow"
glow.Parent = Outer
glow.BackgroundTransparency = 1
glow.Size = UDim2.new(1, 0, 1, 0)
glow.Position = UDim2.new(0, 0, 0, 0)
-- if you have a bloom image, set glow.Image = "rbxassetid://..." else we keep it transparent

-- Outer stroke (neon outline)
OuterStroke.Parent = Outer
OuterStroke.Thickness = 6
OuterStroke.LineJoinMode = Enum.LineJoinMode.Round
OuterStroke.Color = Color3.fromRGB(102, 204, 255) -- default light neon blue

UICornerOuter.Parent = Outer
UICornerOuter.CornerRadius = UDim.new(0, 18)

-- Inner dark panel (80% transparent)
Inner.Name = "Inner"
Inner.Parent = Outer
Inner.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Inner.BackgroundTransparency = 0.8
Inner.Position = UDim2.new(0, 12, 0, 12)
Inner.Size = UDim2.new(1, -24, 1, -24)
Inner.BorderSizePixel = 0

UICornerInner.Parent = Inner
UICornerInner.CornerRadius = UDim.new(0, 12)

-- Title
title.Parent = Inner
title.BackgroundTransparency = 1
title.Position = UDim2.new(0.02, 0, 0.06, 0)
title.Size = UDim2.new(0.5, 0, 0.18, 0)
title.Font = Enum.Font.SourceSansBold
title.Text = "FLY GUI V3"
title.TextColor3 = Color3.fromRGB(170, 240, 255)
title.TextScaled = true

-- Color toggle small button top-right of inner panel
colorToggle.Name = "colorToggle"
colorToggle.Parent = Inner
colorToggle.Size = UDim2.new(0, 36, 0, 24)
colorToggle.Position = UDim2.new(0.85, 0, 0.06, 0)
colorToggle.Font = Enum.Font.SourceSans
colorToggle.Text = "Color"
colorToggle.TextSize = 12
colorToggle.BackgroundTransparency = 0.6
colorToggle.BackgroundColor3 = Color3.fromRGB(0,0,0)
colorToggle.TextColor3 = Color3.fromRGB(200, 230, 255)

-- Close / minimize buttons (kept small)
closebutton.Name = "Close"
closebutton.Parent = Inner
closebutton.Size = UDim2.new(0, 34, 0, 24)
closebutton.Position = UDim2.new(0.02, 0, 0.78, 0)
closebutton.Text = "X"
closebutton.TextSize = 16
closebutton.BackgroundTransparency = 0.6
closebutton.Font = Enum.Font.SourceSans

mini.Name = "minimize"
mini.Parent = Inner
mini.Size = UDim2.new(0, 34, 0, 24)
mini.Position = UDim2.new(0.12, 0, 0.78, 0)
mini.Text = "-"
mini.TextSize = 16
mini.BackgroundTransparency = 0.6
mini.Font = Enum.Font.SourceSans

mini2.Name = "minimize2"
mini2.Parent = Inner
mini2.Size = UDim2.new(0, 34, 0, 24)
mini2.Position = UDim2.new(0.12, 0, 0.78, 0)
mini2.Text = "+"
mini2.TextSize = 16
mini2.Visible = false
mini2.BackgroundTransparency = 0.6
mini2.Font = Enum.Font.SourceSans

-- Buttons layout to mimic image
-- left column + / - stacked
plus.Name = "plus"
plus.Parent = Inner
plus.Size = UDim2.new(0, 60, 0, 48)
plus.Position = UDim2.new(0.03, 0, 0.2, 0)
plus.Font = Enum.Font.SourceSansBold
plus.Text = "+"
plus.TextSize = 22
plus.BackgroundTransparency = 0
plus.TextColor3 = Color3.fromRGB(12,12,12)

mine.Name = "mine"
mine.Parent = Inner
mine.Size = UDim2.new(0, 60, 0, 48)
mine.Position = UDim2.new(0.03, 0, 0.48, 0)
mine.Font = Enum.Font.SourceSansBold
mine.Text = "-"
mine.TextSize = 22
mine.BackgroundTransparency = 0
mine.TextColor3 = Color3.fromRGB(12,12,12)

-- center speed label (long rectangle)
speed.Name = "speed"
speed.Parent = Inner
speed.Size = UDim2.new(0, 180, 0, 48)
speed.Position = UDim2.new(0.22, 0, 0.34, 0)
speed.Font = Enum.Font.SourceSans
speed.Text = "1"
speed.TextScaled = true
speed.TextColor3 = Color3.fromRGB(12,12,12)
speed.BackgroundTransparency = 0

-- fly button on right
onof.Name = "onof"
onof.Parent = Inner
onof.Size = UDim2.new(0, 110, 0, 56)
onof.Position = UDim2.new(0.72, 0, 0.28, 0)
onof.Font = Enum.Font.SourceSansBold
onof.Text = "fly"
onof.TextSize = 22
onof.BackgroundTransparency = 0
onof.TextColor3 = Color3.fromRGB(12,12,12)

-- Style helper to add neon stroke + gradient to interactive elements
local function styleNeo(btn)
    local stroke = Instance.new("UIStroke")
    stroke.Parent = btn
    stroke.Thickness = 2.2
    stroke.LineJoinMode = Enum.LineJoinMode.Round
    stroke.Color = Color3.fromRGB(102, 204, 255) -- default neon

    local grad = Instance.new("UIGradient")
    grad.Parent = btn
    grad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 220, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 140, 210)),
    }
    grad.Rotation = 0

    local corner = Instance.new("UICorner")
    corner.Parent = btn
    corner.CornerRadius = UDim.new(0, 6)
end

-- Apply styling to buttons/labels (except title)
styleNeo(plus)
styleNeo(mine)
styleNeo(speed)
styleNeo(onof)

-- make inner background a bit darker and semi transparent
Inner.BackgroundTransparency = 0.8

-- variables for dynamic neon color
local neonIsLight = true
local function setNeonColor(light)
    if light then
        OuterStroke.Color = Color3.fromRGB(102, 204, 255) -- light
        for _, v in pairs({plus, mine, speed, onof}) do
            for _, child in pairs(v:GetChildren()) do
                if child:IsA("UIStroke") then child.Color = Color3.fromRGB(102,204,255) end
                if child:IsA("UIGradient") then
                    child.Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(10,220,255)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(0,140,210)),
                    }
                end
            end
        end
    else
        OuterStroke.Color = Color3.fromRGB(0, 102, 170) -- darker blue
        for _, v in pairs({plus, mine, speed, onof}) do
            for _, child in pairs(v:GetChildren()) do
                if child:IsA("UIStroke") then child.Color = Color3.fromRGB(0,102,170) end
                if child:IsA("UIGradient") then
                    child.Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(0,140,210)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(0,70,140)),
                    }
                end
            end
        end
    end
end

-- initial neon color
setNeonColor(true)

-- Color toggle behavior
colorToggle.MouseButton1Click:Connect(function()
    neonIsLight = not neonIsLight
    setNeonColor(neonIsLight)
end)

-- Close / minimize behavior
closebutton.MouseButton1Click:Connect(function() main:Destroy() end)
mini.MouseButton1Click:Connect(function()
    plus.Visible = false
    mine.Visible = false
    speed.Visible = false
    onof.Visible = false
    title.Visible = false
    colorToggle.Visible = false
    mini.Visible = false
    mini2.Visible = true
    Inner.BackgroundTransparency = 1
end)
mini2.MouseButton1Click:Connect(function()
    plus.Visible = true
    mine.Visible = true
    speed.Visible = true
    onof.Visible = true
    title.Visible = true
    colorToggle.Visible = true
    mini.Visible = true
    mini2.Visible = false
    Inner.BackgroundTransparency = 0.8
end)

-- keep references for flight logic (names expected by original code)
-- map new names to old ones: up/down were used earlier for move up/down; here we use plus/mine for +/- and provide invisible up/down buttons for compatibility
local up_compat = Instance.new("TextButton")
up_compat.Name = "up"
up_compat.Parent = main
up_compat.Visible = false

local down_compat = Instance.new("TextButton")
down_compat.Name = "down"
down_compat.Parent = main
down_compat.Visible = false

-- Expose variables expected by logic
local speeds = 1
local speaker = game:GetService("Players").LocalPlayer
local chr = speaker.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
local nowe = false

-- Notification (same as original)
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "FLY GUI V3";
    Text = "BY Kru_alien";
    Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150"
})

-- === Original flight logic pasted below ===

Duration = 5; Frame.Active = true -- main = gui
Frame = Inner -- align names for logic compatibility if needed
Frame.Draggable = true
onof.MouseButton1Down:connect(function()
    if nowe == true then
        nowe = false
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
        speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
    else
        nowe = true
        for i = 1, speeds do
            spawn(function()
                local hb = game:GetService("RunService").Heartbeat
                tpwalking = true
                local chr = game.Players.LocalPlayer.Character
                local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                    if hum.MoveDirection.Magnitude > 0 then
                        chr:TranslateBy(hum.MoveDirection)
                    end
                end
            end)
        end
        game.Players.LocalPlayer.Character.Animate.Disabled = true
        local Char = game.Players.LocalPlayer.Character
        local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")
        for i,v in next, Hum:GetPlayingAnimationTracks() do v:AdjustSpeed(0) end
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
        speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
    end

    if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
        local plr = game.Players.LocalPlayer
        local torso = plr.Character.Torso
        local flying = true
        local deb = true
        local ctrl = {f = 0, b = 0, l = 0, r = 0}
        local lastctrl = {f = 0, b = 0, l = 0, r = 0}
        local maxspeed = 50
        local speedv = 0
        local bg = Instance.new("BodyGyro", torso)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = torso.CFrame
        local bv = Instance.new("BodyVelocity", torso)
        bv.velocity = Vector3.new(0,0.1,0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        if nowe == true then plr.Character.Humanoid.PlatformStand = true end
        while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
            game:GetService("RunService").RenderStepped:Wait()
            if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                speedv = speedv+.5+(speedv/maxspeed)
                if speedv > maxspeed then speedv = maxspeed end
            elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speedv ~= 0 then
                speedv = speedv-1
                if speedv < 0 then speedv = 0 end
            end
            if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speedv
                lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
            elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speedv ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speedv
            else bv.velocity = Vector3.new(0,0,0) end
            -- game.Players.LocalPlayer.Character.Animate.Disabled = true
            bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speedv/maxspeed),0,0)
        end
        ctrl = {f = 0, b = 0, l = 0, r = 0}
        lastctrl = {f = 0, b = 0, l = 0, r = 0}
        speedv = 0
        bg:Destroy()
        bv:Destroy()
        plr.Character.Humanoid.PlatformStand = false
        game.Players.LocalPlayer.Character.Animate.Disabled = false
        tpwalking = false
    else
        local plr = game.Players.LocalPlayer
        local UpperTorso = plr.Character.UpperTorso
        local flying = true
        local deb = true
        local ctrl = {f = 0, b = 0, l = 0, r = 0}
        local lastctrl = {f = 0, b = 0, l = 0, r = 0}
        local maxspeed = 50
        local speedv = 0
        local bg = Instance.new("BodyGyro", UpperTorso)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = UpperTorso.CFrame
        local bv = Instance.new("BodyVelocity", UpperTorso)
        bv.velocity = Vector3.new(0,0.1,0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        if nowe == true then plr.Character.Humanoid.PlatformStand = true end
        while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
            wait()
            if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                speedv = speedv+.5+(speedv/maxspeed)
                if speedv > maxspeed then speedv = maxspeed end
            elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speedv ~= 0 then
                speedv = speedv-1
                if speedv < 0 then speedv = 0 end
            end
            if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speedv
                lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
            elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speedv ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speedv
            else bv.velocity = Vector3.new(0,0,0) end
            bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speedv/maxspeed),0,0)
        end
        ctrl = {f = 0, b = 0, l = 0, r = 0}
        lastctrl = {f = 0, b = 0, l = 0, r = 0}
        speedv = 0
        bg:Destroy()
        bv:Destroy()
        plr.Character.Humanoid.PlatformStand = false
        game.Players.LocalPlayer.Character.Animate.Disabled = false
        tpwalking = false
    end
end)

-- up/down compatibility (if other parts rely on these)
up_compat.MouseButton1Down:connect(function()
    -- move up while hovered (kept for compatibility)
end)

down_compat.MouseButton1Down:connect(function()
    -- move down while hovered (kept for compatibility)
end)

-- plus / mine behavior to change speeds and update displayed number
plus.MouseButton1Down:connect(function()
    speeds = speeds + 1
    speed.Text = speeds
end)

mine.MouseButton1Down:connect(function()
    if speeds == 1 then
        speed.Text = 'cannot be less than 1'
        wait(1)
        speed.Text = speeds
    else
        speeds = speeds - 1
        speed.Text = speeds
    end
end)

-- toggle fly via onof button (also handled above)
onof.MouseButton1Down:Connect(function() 
    -- trigger the same handler used earlier (simulate click)
    pcall(function() onof.MouseButton1Down:Fire() end)
end)
