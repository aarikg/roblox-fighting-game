local replicatedStorage = game:GetService("ReplicatedStorage")
local playerService = game:GetService("Players")

local actionEvent = replicatedStorage:FindFirstChild("ActionEvent")
if not actionEvent then
	actionEvent = Instance.new("RemoteEvent", replicatedStorage)
	actionEvent.Name = "ActionEvent"
end

local blockedPlayers = {}

local function handleBlock(player)
	blockedPlayers[player.Character] = true
	task.wait(2)
	blockedPlayers[player.Character] = nil
end

local function checkHitboxForHits(hitbox, player, duration)
	local hitPlayer = nil

	local connection
	local endTime = tick() + duration

	connection = hitbox.Touched:Connect(function(hit)

		local target = hit.Parent
		
		if target then
			hitPlayer = target
			
			
		end
	end)

	while tick() < endTime do
		if hitPlayer then break end
		task.wait() 
	end

	if connection.Connected then
		connection:Disconnect()
	end

	return hitPlayer
end

actionEvent.OnServerEvent:Connect(function(player, actionType)
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")

	if not humanoid then return end

	if actionType == "Left Jab" or actionType == "Right Jab" then
		local hitbox = character["Hitbox"]
		print(0)
		if hitbox then
			print(1)
			local hitPlayer = checkHitboxForHits(hitbox, player, 0.5)
			print(hitPlayer)
			if hitPlayer then
				local hitHumanoid = hitPlayer:FindFirstChildOfClass("Humanoid")
				print(hitHumanoid)
				if not hitHumanoid and hitPlayer.Parent then
					hitHumanoid = hitPlayer.Parent:FindFirstChildOfClass("Humanoid")
				end
				local isBlocking = blockedPlayers[hitPlayer]

				if isBlocking then
					print("Blocked")
				else
					hitHumanoid.Health -= 20
					player.leaderstats.Hits.Value += 1
					if  hitHumanoid.Health <= 0 then
						player.leaderstats.Kills.Value += 1
						local playerFromCharacter = playerService:GetPlayerFromCharacter(hitPlayer)
						playerFromCharacter.leaderstats.Deaths.Value += 1
					end
				end
			end
		end
	elseif actionType == "Block" then
		handleBlock(player)
	end
end)
