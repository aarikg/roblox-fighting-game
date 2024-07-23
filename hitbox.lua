

local Players = game:GetService("Players")
local rs = game:GetService("ReplicatedStorage")

local function onCharacterAdded(character)

	local hitbox = rs.Hitbox:Clone()

	


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


Players.LocalPlayer.CharacterAdded:Connect(onCharacterAdded)


if Players.LocalPlayer.Character then
	onCharacterAdded(Players.LocalPlayer.Character)
end
