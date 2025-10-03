local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
if not player then return end

-- nếu đã có GUI cũ, remove để tránh trùng
local existing = player:FindFirstChild("PlayerGui") and player.PlayerGui:FindFirstChild("TeleportGui")
if existing then
	pcall(function() existing:Destroy() end)
end

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeleportGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Main frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "Main"
mainFrame.Size = UDim2.new(0, 240, 0, 140)
mainFrame.Position = UDim2.new(0.4, 0, 0.35, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Title bar
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 28)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.Text = "Teleport Panel"
title.TextColor3 = Color3.fromRGB(200, 200, 255)
title.TextScaled = true
title.Parent = mainFrame

-- Teleport Button
local tpBtn = Instance.new("TextButton")
tpBtn.Name = "TPButton|byKru"
tpBtn.Size = UDim2.new(0, 200, 0, 46)
tpBtn.Position = UDim2.new(0.5, -100, 0.4, 0)
tpBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
tpBtn.TextColor3 = Color3.fromRGB(1,1,1)
tpBtn.Font = Enum.Font.SourceSansBold
tpBtn.TextScaled = true
tpBtn.Text = "Start Auto-TP (2s)"
tpBtn.Parent = mainFrame

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "Close"
closeBtn.Size = UDim2.new(0, 28, 0, 20)
closeBtn.Position = UDim2.new(1, -32, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(1,1,1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextScaled = true
closeBtn.Parent = mainFrame

-- Status label
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "Status"
statusLabel.Size = UDim2.new(1, -12, 0, 18)
statusLabel.Position = UDim2.new(0, 6, 0.82, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.SourceSans
statusLabel.TextScaled = true
statusLabel.TextColor3 = Color3.fromRGB(170, 220, 255)
statusLabel.Text = "Status: Stopped"
statusLabel.Parent = mainFrame

-- Internal state
local autoTP = false
local loopThread = nil

-- Utility: safe find WinPart
local function findWinPart()
	local ok, END = pcall(function() return workspace:FindFirstChild("END") end)
	if not ok or not END then return nil, "Không tìm thấy folder 'END' trong Workspace" end
	local win = END:FindFirstChild("WinPart")
	if not win then return nil, "Không tìm thấy 'WinPart' trong END" end
	return win
end

-- Teleport attempt (safe)
local function doTeleportTo(part)
	if not part then return false end
	local char = player.Character
	if not char or not char.Parent then return false end
	local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
	if not hrp then return false end
	-- pcall to be safe if something weird happens
	pcall(function()
		hrp.CFrame = part.CFrame + Vector3.new(0, 5, 0)
	end)
	return true
end

-- The auto-teleport loop
local function startLoop()
	if loopThread then return end -- already running
	loopThread = task.spawn(function()
		while autoTP do
			local winPart, err = findWinPart()
			if not winPart then
				-- show warning on status but keep trying
				statusLabel.Text = "Status: Missing WinPart"
			else
				local success = doTeleportTo(winPart)
				if success then
					statusLabel.Text = "Status: Teleported at "..os.date("%X")
				else
					statusLabel.Text = "Status: Teleport failed"
				end
			end
			-- wait 2 seconds between attempts; use task.wait for executors compatibility
			task.wait(2)
		end
		loopThread = nil
		statusLabel.Text = "Status: Stopped"
	end)
end

local function stopLoop()
	autoTP = false
	-- loopThread will clear itself
end

-- Button behavior: toggle autoTP
tpBtn.MouseButton1Click:Connect(function()
	autoTP = not autoTP
	if autoTP then
		tpBtn.Text = "Stop Auto-TP"
		statusLabel.Text = "Status: Starting..."
		startLoop()
	else
		tpBtn.Text = "Start Auto-TP (2s)"
		statusLabel.Text = "Status: Stopping..."
		stopLoop()
	end
end)

-- Close button behavior
closeBtn.MouseButton1Click:Connect(function()
	autoTP = false
	if loopThread then
		-- allow loop to finish naturally
	end
	screenGui:Destroy()
end)

-- Ensure GUI persists / reconnect after respawn
player.CharacterAdded:Connect(function(char)
	-- optional: if autoTP is on, keep it running (loop uses current player.Character reference)
	-- ensure HumanoidRootPart exists before any immediate teleport attempt
end)

-- End of script
