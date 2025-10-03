-- Teleport GUI Script
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeleportGui"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Tạo Frame chính
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 150)
mainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 2
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Thanh tiêu đề
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 25)
titleBar.BackgroundColor3 = Color3.fromRGB(255, 220, 0)
titleBar.Parent = mainFrame

-- Nút Close
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 1, 0)
closeBtn.Position = UDim2.new(1, -25, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Parent = titleBar

-- Nút Minimize
local miniBtn = Instance.new("TextButton")
miniBtn.Size = UDim2.new(0, 25, 1, 0)
miniBtn.Position = UDim2.new(1, -50, 0, 0)
miniBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 50)
miniBtn.Text = "-"
miniBtn.TextColor3 = Color3.new(1,1,1)
miniBtn.Parent = titleBar

-- Nút Maximize
local maxBtn = Instance.new("TextButton")
maxBtn.Size = UDim2.new(0, 25, 1, 0)
maxBtn.Position = UDim2.new(1, -75, 0, 0)
maxBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 200)
maxBtn.Text = "□"
maxBtn.TextColor3 = Color3.new(1,1,1)
maxBtn.Parent = titleBar

-- Nút Auto TP
local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(0, 160, 0, 40)
tpBtn.Position = UDim2.new(0.5, -80, 0.5, -20)
tpBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
tpBtn.Text = "Start Auto TP"
tpBtn.TextColor3 = Color3.new(1,1,1)
tpBtn.Parent = mainFrame

-- Nút Stop TP
local stopBtn = Instance.new("TextButton")
stopBtn.Size = UDim2.new(0, 160, 0, 40)
stopBtn.Position = UDim2.new(0.5, -80, 0.5, 30)
stopBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
stopBtn.Text = "Stop Auto TP"
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Parent = mainFrame

-- Trạng thái Auto TP
local autoTP = false

-- Nút Close
closeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)

-- Nút Minimize
miniBtn.MouseButton1Click:Connect(function()
	if mainFrame.Size.Y.Offset > 30 then
		mainFrame.Size = UDim2.new(mainFrame.Size.X.Scale, mainFrame.Size.X.Offset, 0, 30)
	else
		mainFrame.Size = UDim2.new(0, 220, 0, 150)
	end
end)

-- Nút Maximize
maxBtn.MouseButton1Click:Connect(function()
	mainFrame.Size = UDim2.new(0, 400, 0, 240)
end)

-- Bật Auto TP
tpBtn.MouseButton1Click:Connect(function()
	if autoTP then return end
	autoTP = true
	tpBtn.Text = "Auto TP Running..."
	
	spawn(function()
		while autoTP do
			local char = player.Character or player.CharacterAdded:Wait()
			local hrp = char:WaitForChild("HumanoidRootPart")

			local endFolder = workspace:FindFirstChild("END")
			if endFolder then
				local winPart = endFolder:FindFirstChild("WinPart")
				if winPart then
					hrp.CFrame = winPart.CFrame + Vector3.new(0,5,0)
				else
					warn("⚠ Không tìm thấy WinPart trong END")
				end
			else
				warn("⚠ Không tìm thấy Folder END trong workspace")
			end
			task.wait(2)
		end
	end)
end)

-- Tắt Auto TP
stopBtn.MouseButton1Click:Connect(function()
	autoTP = false
	tpBtn.Text = "Start Auto TP"
end)
