local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Xóa GUI cũ nếu đã tồn tại để tránh trùng lặp
if player:FindFirstChild("PlayerGui"):FindFirstChild("TeleportGui") then
	player.PlayerGui.TeleportGui:Destroy()
end

-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeleportGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Tạo Frame chính
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 120)
mainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- đen đậm
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 2
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Thanh tiêu đề
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 25)
titleBar.BackgroundColor3 = Color3.fromRGB(255, 220, 0) -- vàng
titleBar.Parent = mainFrame

-- Nút Close (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 1, 0)
closeBtn.Position = UDim2.new(1, -25, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextScaled = true
closeBtn.Parent = titleBar

-- Nút Minimize (-)
local miniBtn = Instance.new("TextButton")
miniBtn.Size = UDim2.new(0, 25, 1, 0)
miniBtn.Position = UDim2.new(1, -50, 0, 0)
miniBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 50)
miniBtn.Text = "-"
miniBtn.TextColor3 = Color3.new(1,1,1)
miniBtn.Font = Enum.Font.SourceSansBold
miniBtn.TextScaled = true
miniBtn.Parent = titleBar

-- Nút Maximize (□)
local maxBtn = Instance.new("TextButton")
maxBtn.Size = UDim2.new(0, 25, 1, 0)
maxBtn.Position = UDim2.new(1, -75, 0, 0)
maxBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 200)
maxBtn.Text = "□"
maxBtn.TextColor3 = Color3.new(1,1,1)
maxBtn.Font = Enum.Font.SourceSansBold
maxBtn.TextScaled = true
maxBtn.Parent = titleBar

-- Nút Teleport
local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(0, 160, 0, 40)
tpBtn.Position = UDim2.new(0.5, -80, 0.5, -20)
tpBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 255) -- xanh dương
tpBtn.Text = "Teleport|by kru"
tpBtn.TextColor3 = Color3.new(1,1,1)
tpBtn.Font = Enum.Font.SourceSansBold
tpBtn.TextScaled = true
tpBtn.Parent = mainFrame

-- Chức năng nút Close
closeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)

-- Chức năng nút Minimize
miniBtn.MouseButton1Click:Connect(function()
	if mainFrame.Size.Y.Offset > 30 then
		mainFrame.Size = UDim2.new(mainFrame.Size.X.Scale, mainFrame.Size.X.Offset, 0, 30)
	else
		mainFrame.Size = UDim2.new(0, 200, 0, 120)
	end
end)

-- Chức năng nút Maximize
maxBtn.MouseButton1Click:Connect(function()
	mainFrame.Size = UDim2.new(0, 400, 0, 240)
end)

-- Chức năng nút TP
tpBtn.MouseButton1Click:Connect(function()
	local char = player.Character or player.CharacterAdded:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")

	local endFolder = workspace:FindFirstChild("END")
	if endFolder and endFolder:FindFirstChild("WinPart") then
		local winPart = endFolder.WinPart
		hrp.CFrame = winPart.CFrame + Vector3.new(0,5,0) -- TP lên cao 5 đơn vị
	else
		warn("Không tìm thấy WinPart trong END")
	end
end)
