-- Fling GUI with Player Input by ChatGPT

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- UI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "FlingGui"

local frame = Instance.new("Frame", gui)
frame.Position = UDim2.new(0, 100, 0, 100)
frame.Size = UDim2.new(0, 250, 0, 120)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Fling Target Upwards"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18

local textBox = Instance.new("TextBox", frame)
textBox.PlaceholderText = "Enter player name..."
textBox.Size = UDim2.new(1, -20, 0, 30)
textBox.Position = UDim2.new(0, 10, 0, 40)
textBox.Text = ""
textBox.TextSize = 16
textBox.TextColor3 = Color3.new(1, 1, 1)
textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
textBox.BorderSizePixel = 0

local flingBtn = Instance.new("TextButton", frame)
flingBtn.Text = "FLING"
flingBtn.Size = UDim2.new(1, -20, 0, 30)
flingBtn.Position = UDim2.new(0, 10, 0, 80)
flingBtn.TextSize = 16
flingBtn.TextColor3 = Color3.new(1, 1, 1)
flingBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
flingBtn.BorderSizePixel = 0

-- Fling Function
local function flingPlayer(targetName)
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr.Name:lower():sub(1, #targetName) == targetName:lower() then
			local character = plr.Character
			if character and character:FindFirstChild("HumanoidRootPart") then
				local bodyVelocity = Instance.new("BodyVelocity")
				bodyVelocity.Velocity = Vector3.new(0, 300, 0)
				bodyVelocity.MaxForce = Vector3.new(99999, 999999, 99999)
				bodyVelocity.P = 5000
				bodyVelocity.Parent = character.HumanoidRootPart

				game.Debris:AddItem(bodyVelocity, 0.3)
			end
		end
	end
end

-- Button
flingBtn.MouseButton1Click:Connect(function()
	local nameInput = textBox.Text
	if nameInput and nameInput ~= "" then
		flingPlayer(nameInput)
	end
end)
