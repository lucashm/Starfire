local assets =
{
	Asset( "ANIM", "anim/starfire.zip" ),
	Asset( "ANIM", "anim/ghost_starfire_build.zip" ),
	Asset( "ANIM", "anim/starfire_transform.zip" ),
}

local skins =
{
	transform_skin = "starfire_transform",
	normal_skin = "starfire",
	ghost_skin = "ghost_starfire_build",
}

local base_prefab = "starfire"

local tags = {"ESCTEMPLATE", "CHARACTER"}

return CreatePrefabSkin("starfire_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	tags = tags,
	
	skip_item_gen = true,
	skip_giftable_gen = true,
})