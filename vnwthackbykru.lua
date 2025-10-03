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
frame.Size = UDim2.new(0, 200, 0, 120)
frame.Position = UDim2.new(0.5, -100, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 2
frame.Parent = screenGui
frame.Active = true
frame.Draggable = true

-- Hiệu ứng viền neon
local uiStroke = Instance.new("UIStroke")
uiStroke.Parent = frame
uiStroke.Thickness = 3
uiStroke.Color = Color3.fromRGB(0, 255, 128)

-- Tween đổi màu viền
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
tpButton.Size = UDim2.new(0, 140, 0, 40)
tpButton.Position = UDim2.new(0.5, -70, 0.5, -25)
tpButton.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tpButton.TextScaled = true
tpButton.Text = "Start Auto TP"
tpButton.Parent = frame

-- Dòng chữ by Kru_alien
local credit = Instance.new("TextLabel")
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 1, -20)
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.fromRGB(0, 255, 255)
credit.TextScaled = true
credit.Text = "by Kru_alien"
credit.Parent = frame

-- Auto Teleport logic
local autoTP = false
local tpLoop

tpButton.MouseButton1Click:Connect(function()
	autoTP = not autoTP
	if autoTP then
		tpButton.Text = "Stop Auto TP"
		tpLoop = task.spawn(function()
			while autoTP do
				if winPart and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					player.Character.HumanoidRootPart.CFrame = winPart.CFrame + Vector3.new(0, 5, 0)
				end
				task.wait(2) -- delay giữa mỗi lần TP
			end
		end)
	else
		tpButton.Text = "Start Auto TP"
	end
end)
