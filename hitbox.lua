local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function onCharacterAdded(character)
	local hitbox = ReplicatedStorage:FindFirstChild("Hitbox"):Clone()

	local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("UpperTorso")
	if rootPart then
		hitbox.CFrame = rootPart.CFrame
		hitbox.Parent = character

		local weld = Instance.new("WeldConstraint")
		weld.Part0 = rootPart
		weld.Part1 = hitbox
		weld.Parent = rootPart
	end
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(onCharacterAdded)
	if player.Character then
		onCharacterAdded(player.Character)
	end
end)


for _, player in pairs(Players:GetPlayers()) do
	player.CharacterAdded:Connect(onCharacterAdded)
	if player.Character then
		onCharacterAdded(player.Character)
	end
end
