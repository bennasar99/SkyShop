function Initialize( Plugin )

	Plugin:SetName( "SkyShop" )
	Plugin:SetVersion( 1 )

	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_RIGHT_CLICK, OnPlayerRightClick);
	cPluginManager:AddHook(cPluginManager.HOOK_UPDATING_SIGN, OnUpdatingSign);


	LOG( "Initialized " .. Plugin:GetName() .. " v." .. Plugin:GetVersion() )

	return true

end

function OnPlayerRightClick(Player, BlockX, BlockY, BlockZ, BlockFace, CursorX, CursorY, CursorZ)
    if (BlockType == E_BLOCK_SIGN) then
        Read, Line1, Line2, Line3, Line4 = Player:GetWorld():GetSignLines( BlockX, BlockY, BlockZ , "", "", "", "" )
        if Line1 == "[SkyShop]" then
            Item1 = cItem()
            split = StringSplit(Line2, " ")
            StringToItem(split[2], Item1)
            Item1.m_ItemCount = split[1]
            Item2 = cItem()
            split2 = StringSplit(Line4, " ")
            StringToItem(split2[2], Item2)
            Item2.m_ItemCount = split2[1]
            inventory = Player:GetInventory()
            if inventory:GetEquippedItem().m_ItemType == Item2.m_ItemType and inventory:GetEquippedItem().m_ItemCount == Item2.m_ItemCount then
                Player:GetInventory():SetHotbarSlot(Player:GetInventory():GetEquippedSlotNum(), Item1)
                Player:SendMessageSuccess("Enjoy your new item!")
            else
                Player:SendMessageFailure("Not the correct item (or item amount)")
            end
            return true
        end
    end
end

function OnUpdatingSign(World, BlockX, BlockY, BlockZ, Line1, Line2, Line3, Line4, Player)
    if Line1 == "[SkyShop]" then
        if (not(Player:HasPermission("skyshop.create") == true)) then
            return true
        end
    end
end

