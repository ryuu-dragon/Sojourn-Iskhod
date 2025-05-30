/* Utility Closets
 * Contains:
 *		Emergency Closet
 *		Fire Closet
 *		Tool Closet
 *		Radiation Closet
 *		Bombsuit Closet
 *		Hydrant
 *		First Aid
 */

/*
 * Emergency Closet
 */
/obj/structure/closet/emcloset
	name = "emergency closet"
	desc = "It's a storage unit for emergency breathmasks and o2 tanks."
	icon_state = "emergency"

/obj/structure/closet/emcloset/populate_contents()
	if(populated_contents)
		return
	populated_contents = TRUE
	switch(pickweight(list("small" = 55, "aid" = 25, "tank" = 10, "both" = 10)))
		if ("small")
			new /obj/item/tank/emergency_oxygen(src)
			new /obj/item/tank/emergency_oxygen(src)
			new /obj/item/clothing/mask/breath(src)
			new /obj/item/clothing/mask/breath(src)
			new /obj/item/clothing/suit/space/emergency(src)
			new /obj/item/clothing/head/helmet/space/emergency(src)
		if ("aid")
			new /obj/item/tank/emergency_oxygen(src)
			new /obj/item/storage/toolbox/emergency(src)
			new /obj/item/clothing/mask/breath(src)
			new /obj/item/storage/firstaid/o2(src)
			new /obj/item/clothing/suit/space/emergency(src)
			new /obj/item/clothing/head/helmet/space/emergency(src)
		if ("tank")
			new /obj/item/tank/emergency_oxygen/engi(src)
			new /obj/item/clothing/mask/breath(src)
			new /obj/item/tank/emergency_oxygen/engi(src)
			new /obj/item/clothing/mask/breath(src)
		if ("both")
			new /obj/item/storage/toolbox/emergency(src)
			new /obj/item/tank/emergency_oxygen/engi(src)
			new /obj/item/clothing/mask/breath(src)
			new /obj/item/storage/firstaid/o2(src)
			new /obj/item/clothing/suit/space/emergency(src)
			new /obj/item/clothing/suit/space/emergency(src)
			new /obj/item/clothing/head/helmet/space/emergency(src)
			new /obj/item/clothing/head/helmet/space/emergency(src)

/obj/structure/closet/emcloset/legacy/populate_contents()
	if(populated_contents)
		return
	populated_contents = TRUE
	new /obj/item/tank/oxygen(src)
	new /obj/item/clothing/mask/gas(src)

/*
 * Fire Closet
 */
/obj/structure/closet/firecloset
	name = "fire-safety closet"
	desc = "It's a storage unit for fire-fighting supplies."
	icon_state = "fire"

/obj/structure/closet/firecloset/populate_contents()
	if(populated_contents)
		return
	populated_contents = TRUE
	new /obj/item/clothing/suit/fire(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/tank/oxygen/red(src)
	new /obj/item/extinguisher(src)
	new /obj/item/clothing/head/hardhat/red(src)
	new /obj/item/clothing/gloves/thick(src)
	new /obj/item/inflatable/door(src)
	new /obj/item/stack/medical/ointment(src)

/*
 * Tool Closet
 */
/obj/structure/closet/toolcloset
	name = "tool closet"
	desc = "It's a storage unit for tools."
	icon_state = "eng"
	icon_door = "eng_tool"

/obj/structure/closet/toolcloset/populate_contents()
	if(populated_contents)
		return
	populated_contents = TRUE
	if(prob(40))
		new /obj/item/clothing/suit/storage/hazardvest(src)
	if(prob(70))
		new /obj/item/device/lighting/toggleable/flashlight(src)
	if(prob(70))
		new /obj/item/tool/screwdriver(src)
	if(prob(70))
		new /obj/item/tool/wrench(src)
	if(prob(70))
		new /obj/item/tool/weldingtool(src)
	if(prob(70))
		new /obj/item/tool/crowbar(src)
	if(prob(50))
		new /obj/item/tool/wirecutters(src)
	if(prob(50))
		new /obj/item/tool/wirecutters/pliers(src)
	if(prob(70))
		new /obj/item/device/t_scanner(src)
	if(prob(20))
		new /obj/item/storage/belt/utility(src)
	if(prob(30))
		new /obj/item/stack/cable_coil/random(src)
	if(prob(30))
		new /obj/item/stack/cable_coil/random(src)
	if(prob(30))
		new /obj/item/stack/cable_coil/random(src)
	if(prob(20))
		new /obj/item/tool/multitool(src)
	if(prob(5))
		new /obj/item/clothing/gloves/insulated(src)
	if(prob(5))
		new /obj/item/storage/pouch/engineering_tools(src)
	if(prob(5))
		new /obj/item/storage/hcases/parts(src)
	if(prob(5))
		new /obj/item/storage/hcases/engi(src)
	if(prob(1))
		new /obj/item/storage/pouch/engineering_supply(src)
	if(prob(40))
		new /obj/item/clothing/head/hardhat(src)
	new /obj/random/tool_upgrade(src)
	new /obj/random/tool_upgrade(src)
	//Every tool closet contains a couple guaranteed toolmods

/*
 * Radiation Closet
 */
/obj/structure/closet/radiation
	name = "radiation suit closet"
	desc = "It's a storage unit for rad-protective suits."
	icon_state = "eng"
	icon_door = "eng_rad"

/obj/structure/closet/radiation/populate_contents()
	if(populated_contents)
		return
	populated_contents = TRUE
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/clothing/head/radiation(src)
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/clothing/head/radiation(src)

/*
 * Bombsuit closet
 */
/obj/structure/closet/bombcloset
	name = "\improper EOD closet"
	desc = "It's a storage unit for explosion-protective suits."
	icon_state = "bomb"

/obj/structure/closet/bombcloset/populate_contents()
	if(populated_contents)
		return
	populated_contents = TRUE
	new /obj/item/clothing/suit/space/bomb(src)
	new /obj/item/clothing/under/color/black(src)
	new /obj/item/clothing/shoes/color/black(src)
	new /obj/item/clothing/head/helmet/space/bomb(src)

/obj/structure/closet/bombcloset/security/populate_contents()
	if(populated_contents)
		return
	populated_contents = TRUE
	new /obj/item/clothing/suit/space/bomb(src)
	new /obj/item/clothing/under/rank/security(src)
	new /obj/item/clothing/shoes/color/brown(src)
	new /obj/item/clothing/head/helmet/space/bomb(src)
