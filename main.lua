-- Services
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

-- GUI Setup
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "FlingGui"

local inputBox = Instance.new("TextBox", screenGui)
inputBox.Size = UDim2.new(0, 200, 0, 30)
inputBox.Position = UDim2.new(0, 10, 0, 10)
inputBox.PlaceholderText = "Enter player name"
inputBox.Text = ""
inputBox.ClearTextOnFocus = false
inputBox.TextColor3 = Color3.new(1, 1, 1)
inputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
inputBox.Font = Enum.Font.SourceSans
inputBox.TextSize = 16

local checkFlingPossible = function(targetCharacter)
	if not targetCharacter then return false end
	local testPart = Instance.new("Part", workspace)
	testPart.Anchored = false
	testPart.CanCollide = false
	testPart.Size = Vector3.new(1, 1, 1)
	testPart.Position = targetCharacter:GetPivot().Position + Vector3.new(0, 5, 0)

	local bodyVelocity = Instance.new("BodyVelocity", testPart)
	bodyVelocity.Velocity = Vector3.new(0, 300, 0)
	bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)

	wait(0.3)
	local moved = testPart.Position.Y - targetCharacter:GetPivot().Position.Y > 2
	testPart:Destroy()
	return moved
end

-- Fling function
local function flingPlayer(playerName)
	local target = nil
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Name:lower():find(playerName:lower()) then
			target = player
			break
		end
	end

	if not target then
		StarterGui:SetCore("SendNotification", {
			Title = "Fling Tool",
			Text = "Player not found!",
			Duration = 3,
		})
		return
	end

	if not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
		StarterGui:SetCore("SendNotification", {
			Title = "Fling Tool",
			Text = "Target has no character",
			Duration = 3,
		})
		return
	end

	-- Check fling possibility
	local canFling = checkFlingPossible(target.Character)
	if not canFling then
		StarterGui:SetCore("SendNotification", {
			Title = "Fling Tool",
			Text = "Fling not allowed in this game.",
			Duration = 5,
		})
		return
	end

	-- Fling upwards
	local bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.Velocity = Vector3.new(0, 300, 0)
	bodyVelocity.MaxForce = Vector3.new(1e6, 1e6, 1e6)
	bodyVelocity.Parent = target.Character:FindFirstChild("HumanoidRootPart")

	StarterGui:SetCore("SendNotification", {
		Title = "Fling Tool",
		Text = "Flinging " .. target.Name .. " upward!",
		Duration = 3,
	})

	wait(1.5)
	bodyVelocity:Destroy()
end

-- Trigger fling on Enter key
inputBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		flingPlayer(inputBox.Text)
	end
end)
