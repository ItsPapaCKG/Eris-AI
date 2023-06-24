--[[
    Modified Version created by PapaCKG
--]]

local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("Defend");
COMMAND.tip = "Rolls a die using Grit. Used to protect against attacks.";
COMMAND.optionalArguments = 1;

modifierTable = {
    ["level_two_a_armor"] = 5,
    ["level_two_armor"] = 8,
    ["level_three_a_armor"] = 10,
    ["level_three_armor"] = 14,
    ["level_four_armor"] = 18
};

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)

        local atb1 = Clockwork.attributes:Fraction(player, ATB_GRIT, 10);
        local itemModifier = 0;
        local itemModifierType = "";
        local modifier = tonumber(arguments[1]) or 0;
        local batb = atb1;
        local roll = math.random(1,20);
        local mod = tostring(batb);

        for k, v in pairs(modifierTable)
        do
            if (player:HasItemByID(k)) then
                itemModifier = v;
                itemModifierType = "(with item type "..k..")";
                modifier = modifier + itemModifier;
                break;
            end;
        end;

        if (modifier != 0) then
               if (modifier < 0) then
                      mod = mod..tostring(modifier);
               else
                      mod = mod.."+"..tostring(modifier);
               end;
        end;

        local finalRoll = roll + batb + modifier;

        Clockwork.kernel:PrintLog(LOGTYPE_GENERIC, player:Name().." has rolled "..finalRoll.." for Defend. ("..mod..") "..itemModifierType);
        Clockwork.chatBox:AddInRadius(player, "roll", " has rolled ".. finalRoll .. " out of 20 for Defend. ("..mod..") "..itemModifierType, 
            player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 2)
end;

COMMAND:Register();