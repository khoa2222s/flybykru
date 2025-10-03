-- TeleportGuiClient.lua
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Tìm WinPart trong Workspace.END
local winPart = game.Workspace:WaitForChild("END"):WaitForChild("WinPart")

-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeleportGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame chính
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 180, 0, 100)
frame.Position = UDim2.new(0.5, -90, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 2
frame.Parent = screenGui
frame.Active = true
frame.Draggable = true

-- Hiệu ứng viền neon
local uiStroke = Instance.new("UIStroke")
uiStroke.Parent = frame
uiStroke.Thickness = 3
uiStroke.Color = Color3.fromRGB(0, 255, 128) -- xanh nhạt ban đầu

-- Tween đổi màu viền liên tục
task.spawn(function()
	while task.wait(1) do
		local tween = TweenService:Create(uiStroke, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, true), {
			Color = Color3.fromRGB(0, 200, 0)
		})
		tween:Play()
		tween.Completed:Wait()
	end
end)

-- Nút Teleport
local tpButton = Instance.new("TextButton")
tpButton.Size = UDim2.new(0, 120, 0, 40)
tpButton.Position = UDim2.new(0.5, -60, 0.5, -20)
tpButton.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tpButton.TextScaled = true
tpButton.Text = "TP"
tpButton.Parent = frame

-- Khi ấn nút -> sau 2 giây auto teleport
tpButton.MouseButton1Click:Connect(function()
	tpButton.Text = "Teleporting..."
	task.wait(2)
	if winPart and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		player.Character.HumanoidRootPart.CFrame = winPart.CFrame + Vector3.new(0, 5, 0)
		tpButton.Text = "TP Done!"
		task.wait(1)
		tpButton.Text = "TP"
	end
end)
