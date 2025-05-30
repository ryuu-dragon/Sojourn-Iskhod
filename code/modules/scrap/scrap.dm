GLOBAL_LIST_EMPTY(scrap_base_cache)

#define SAFETY_COOLDOWN 100

/obj/structure/scrap
	name = "scrap pile"
	desc = "A pile of industrial debris."
	appearance_flags = TILE_BOUND | DEFAULT_APPEARANCE_FLAGS
	anchored = TRUE
	opacity = FALSE
	density = FALSE
	var/loot_generated = 0
	var/icontype = "general"
	icon_state = "small"
	icon = 'icons/obj/structures/scrap/base.dmi'
	var/obj/item/storage/internal/updating/loot	//the visible loot
	var/loot_min = 6
	var/loot_max = 12
	var/list/loot_list = list(
		/obj/random/material,
		/obj/item/stack/rods/random,
		/obj/item/material/shard,
		/obj/random/gun_parts,
		/obj/random/junk/nondense = 2,
		/obj/random/pack/rare = 0.4
	)
	var/dig_amount = 4
	var/parts_icon = 'icons/obj/structures/scrap/trash.dmi'
	var/base_min = 5	//min and max number of random pieces of base icon
	var/base_max = 8
	var/base_spread = 12 //limits on pixel offsets of base pieces
	var/big_item_chance = 40
	var/obj/big_item
	var/list/ways = list("pokes around in", "searches", "scours", "digs through", "rummages through", "goes through","picks through")
	var/beacon = FALSE // If this junk pile is getting pulled by the junk beacon or not.
	//sanity_damage = 0.1	// no fuck you that's dumb
	var/rare_item_chance = 33
	var/rare_item = FALSE

/obj/structure/scrap/proc/make_cube()
	var/obj/container = new /obj/structure/scrap_cube(loc, loot_max)
	forceMove(container)

/obj/structure/scrap/Initialize()
	. = ..()
	update_icon(TRUE)

/obj/structure/scrap/examine(var/mob/user)
	.=..()
	if (isliving(user))
		try_make_loot() //Make the loot when examined so the big item check below will work
	to_chat(user, SPAN_NOTICE("You could sift through it with a shoveling tool to uncover more contents"))
	if (big_item && big_item.loc == src)
		to_chat(user, SPAN_DANGER("You can make out the corners of something large buried in here. Keep digging and removing things to uncover it"))

/obj/effect/scrapshot
	name = "This thing shoots scrap everywhere with a delay"
	desc = "no data"
	invisibility = 101
	anchored = 1
	density = 0

/obj/effect/scrapshot/Initialize(mapload, severity = 1)
	..()
	switch(severity)
		if(1)
			for(var/i in 1 to 12)
				var/projtype = pick(/obj/item/stack/rods, /obj/item/material/shard)
				var/obj/item/projectile = new projtype(loc)
				projectile.throw_at(locate(loc.x + rand(40) - 20, loc.y + rand(40) - 20, loc.z), 81, pick(1,3,80,80))
		if(2)
			for(var/i in 1 to 4)
				var/projtype = pick(subtypesof(/obj/item/trash))
				var/obj/item/projectile = new projtype(loc)
				projectile.throw_at(locate(loc.x + rand(10) - 5, loc.y + rand(10) - 5, loc.z), 3, 1)
	return INITIALIZE_HINT_QDEL

/obj/structure/scrap/ex_act(severity)
	set waitfor = FALSE
	if(prob(25))
		new /obj/effect/effect/smoke(src.loc)
	switch(severity)
		if(1)
			new /obj/effect/scrapshot(src.loc, 1)
			dig_amount = 0
		if(2)
			new /obj/effect/scrapshot(src.loc, 2)
			dig_amount = dig_amount / 3
		if(3)
			dig_amount = dig_amount / 2
	if(dig_amount < 4)
		qdel(src)
	else
		update_icon(1)

/obj/structure/scrap/proc/make_big_loot()
	if(prob(big_item_chance))
		var/obj/randomcatcher/CATCH = new /obj/randomcatcher(src)
		if(beacon)
			big_item = CATCH.get_item(/obj/random/pack/junk_machine/beacon)
		else
			big_item = CATCH.get_item(/obj/random/pack/junk_machine)
		if(big_item) //Sanity check in case big_item is a null, as it may sometimes do.
			big_item.forceMove(src)
			if(prob(66))
				big_item.make_old()
		qdel(CATCH)

/obj/structure/scrap/proc/try_make_loot()
	if(loot_generated)
		return
	loot_generated = TRUE
	if(!big_item)
		make_big_loot()

	var/amt = rand(loot_min, loot_max)
	for(var/x in 1 to amt)
		var/loot_path = pickweight(loot_list)
		new loot_path(src)

	for(var/obj/item/loot in contents)
		if(prob(66))
			loot.make_old()
		if(istype(loot, /obj/item/reagent_containers/snacks))
			var/obj/item/reagent_containers/snacks/S = loot
			S.junk_food = TRUE
			if(prob(20))
				S.reagents.add_reagent("toxin", rand(2, 5))

	loot = new(src)
	loot.max_w_class = ITEM_SIZE_HUGE
	shuffle_loot()

/obj/structure/scrap/Destroy()
	for(var/obj/item in loot)
		qdel(item)
	if(big_item)
		QDEL_NULL(big_item)
	QDEL_NULL(loot)
	return ..()

//stupid shard copypaste
/obj/structure/scrap/Crossed(atom/movable/AM)
	..()
	if(isliving(AM))
		var/mob/M = AM

		if(M.buckled) //wheelchairs, office chairs, rollerbeds
			return

		playsound(loc, 'sound/effects/glass_step.ogg', 50, 1) // not sure how to handle metal shards with sounds
		if(ishuman(M))
			var/mob/living/carbon/human/H = M

			if(H.species.siemens_coefficient < 0.5) //Thick skin.
				return

			if(H.shoes)
				return

			to_chat(M, SPAN_DANGER("You step on \the [src]!"))

			var/list/check = list(BP_L_LEG, BP_R_LEG)
			while(check.len)
				var/picked = pick(check)
				var/obj/item/organ/external/affecting = H.get_organ(picked)
				if(affecting)
					if(BP_IS_ROBOTIC(affecting))
						return
					if(affecting.take_damage(5, 0))
						H.UpdateDamageIcon()
					H.reagents.add_reagent("toxin", pick(prob(50);0,prob(50);5,prob(10);10,prob(1);25))
					H.updatehealth()
					if(!((H.species.flags & NO_PAIN) || (PAIN_LESS in H.mutations)))
						H.Weaken(3)
					return
				check -= picked

/obj/structure/scrap/proc/shuffle_loot()
	try_make_loot()
	loot.close_all()

	for(var/A in loot)
		loot.remove_from_storage(A,src)

	var/total_storage_space = 0

	if(contents.len)
		contents = shuffle(contents)
		var/num = rand(2, loot_min)
		for(var/obj/item/O in contents)
			if(!num)
				break
			if(O == loot || O == big_item)
				continue
			total_storage_space += O.get_storage_cost()
			O.forceMove(loot)
			num--
	loot.max_storage_space = max(10, total_storage_space)
	update_icon()

/obj/structure/scrap/proc/randomize_image(image/I)
	I.pixel_x = rand(-base_spread,base_spread)
	I.pixel_y = rand(-base_spread,base_spread)
	var/matrix/M = matrix()
	M.Turn(pick(0,90,180,270))
	I.transform = M
	return I

/obj/structure/scrap/update_icon(rebuild_base=0)
	if(clear_if_empty())
		return

	if(rebuild_base)
		var/ID = rand(40)
		if(!GLOB.scrap_base_cache["[icontype][icon_state][ID]"])
			var/num = rand(base_min,base_max)
			var/image/base_icon = image(icon, icon_state = icon_state)
			for(var/i in 1 to num)
				var/image/I = image(parts_icon,pick(icon_states(parts_icon)))
				I.color = pick("#996633", "#663300", "#666666", "")
				base_icon.add_overlay(randomize_image(I))
			GLOB.scrap_base_cache["[icontype][icon_state][ID]"] = base_icon
		add_overlay(GLOB.scrap_base_cache["[icontype][icon_state][ID]"])
	if(loot_generated)
		underlays.Cut()
		for(var/obj/O in loot.contents)
			var/image/I = image(O.icon,O.icon_state)
			I.color = O.color
			underlays |= randomize_image(I)
	if(big_item)
		var/image/I = image(big_item.icon,big_item.icon_state)
		I.color = big_item.color
		underlays |= I



/obj/structure/scrap/proc/hurt_hand(mob/user)
	if(prob(15))
		if(!ishuman(user))
			return FALSE
		var/mob/living/carbon/human/victim = user
		if(victim.species.flags & NO_MINOR_CUT)
			return FALSE
		if(victim.gloves)
			return FALSE
		var/obj/item/organ/external/BP = victim.get_organ(victim.hand ? BP_L_ARM : BP_R_ARM)
		if(!BP)
			return FALSE
		if(BP_IS_ROBOTIC(BP))
			return FALSE
		to_chat(user, "<span class='danger'>Ouch! You cut yourself while picking through \the [src].</span>")
		BP.take_damage(5, BRUTE, TRUE, TRUE, "Sharp debris")
		victim.reagents.add_reagent("toxin", pick(prob(50);0,prob(50);5,prob(10);10,prob(1);25))
		if((victim.species.flags & NO_PAIN) || (PAIN_LESS in victim.mutations)) // So we still take damage, but actually dig through.
			return FALSE
		return TRUE
	return FALSE

/obj/structure/scrap/attack_hand(mob/user)
	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	if(hurt_hand(user))
		return
	try_make_loot()
	loot.open(user)
	playsound(src, "rummage", 50, 1)
	.=..()

/obj/structure/scrap/attack_generic(mob/user, damage, attack_message, damagetype = BRUTE, attack_flag = ARMOR_MELEE, sharp = FALSE, edge = FALSE)
	if (isliving(user) && loot)
		loot.open(user)
	.=..()


/obj/structure/scrap/proc/dig_out_lump(newloc = loc)
	if(dig_amount > 0)
		dig_amount--
		//new /obj/item/scrap_lump(src) //Todo: uncomment this once purposes and machinery for scrap are implemented
		return TRUE


/obj/structure/scrap/proc/clear_if_empty()
	if (dig_amount <= 0)
		for (var/obj/item/i in contents)
			if ((i != big_item) && (i != loot)) //These two dont stop the pile from being cleared
				return FALSE

		//Anything in the internal storage prevents deletion
		if (loot)
			for (var/obj/item/i in loot.contents)
				return FALSE

		clear()
		return TRUE
	return FALSE

/obj/structure/scrap/proc/clear()
	visible_message("<span class='notice'>\The [src] is cleared out!</span>")
	if(big_item)
		visible_message("<span class='notice'>\A hidden [big_item] is uncovered from beneath the [src]!</span>")
		big_item.forceMove(get_turf(src))
		big_item = null
	else if(rare_item && prob(rare_item_chance))
		var/obj/O = pickweight(RANDOM_RARE_ITEM - /obj/item/stash_spawner)
		O = new O(get_turf(src))
		visible_message("<span class='notice'><span style='color:orange'>\A rare [O.name] is found beneath the [src]!</span>")
	else if(rare_item && prob(50))
		new /obj/item/stack/material/refined_scrap/random(src.loc)
		visible_message("<span class='notice'><span style='color:orange'>A pile of refined scrap is found beneath the [src]!</span>")
	qdel(src)

/obj/structure/scrap/attackby(obj/item/W, mob/living/carbon/human/user)
	if(user.a_intent != I_HURT)
		user.setClickCooldown(DEFAULT_QUICK_COOLDOWN)
		var/list/usable_qualities = list(QUALITY_SHOVELING, QUALITY_HAMMERING)
		var/tool_type = W.get_tool_type(user, usable_qualities, src)
		switch(tool_type)
			if(QUALITY_SHOVELING)
				if(W.use_tool(user, src, WORKTIME_NORMAL, QUALITY_SHOVELING, FAILCHANCE_VERY_EASY, required_stat = STAT_ROB, forced_sound = "rummage"))
					user.visible_message(SPAN_NOTICE("[user] [pick(ways)] \the [src]."))
					user.do_attack_animation(src)
					if(user.stats.getPerk(PERK_JUNKBORN))
						rare_item = TRUE
					else
						rare_item = FALSE
					dig_out_lump(user.loc, 0)
					shuffle_loot()
					clear_if_empty()
			if(QUALITY_HAMMERING)
				if(W.use_tool(user,src, WORKTIME_EXTREMELY_LONG, QUALITY_HAMMERING, FAILCHANCE_HARD, required_stat = STAT_ROB, forced_sound = "rummage"))
					user.visible_message(SPAN_NOTICE("[user] compacts \the [src] into a solid mass!"))
					make_cube()

/obj/structure/scrap/large
	name = "large scrap pile"
	desc = "A large pile of industrial debris."
	opacity = TRUE
	density = TRUE
	icon_state = "big"
	loot_min = 9
	loot_max = 18
	dig_amount = 6
	base_min = 9
	base_max = 14
	base_spread = 16

/obj/structure/scrap/medical
	icontype = "medical"
	name = "medical refuse pile"
	desc = "A pile of medical refuse. Watch out for sharp instruments."
	parts_icon = 'icons/obj/structures/scrap/medical_trash.dmi'
	loot_list = list(
		/obj/random/medical = 4,
		/obj/random/surgery_tool,
		/obj/item/stack/rods/random,
		/obj/item/material/shard,
		/obj/random/junk/nondense,
		/obj/random/pack/rare = 0.3,
		/obj/random/pack/prosthesis/low_chance = 0.05
	)

/obj/structure/scrap/vehicle
	icontype = "vehicle"
	name = "industrial debris pile"
	desc = "A pile of used machinery. Some of it is stained with fuel."
	parts_icon = 'icons/obj/structures/scrap/vehicle.dmi'
	loot_list = list(
		/obj/random/pack/tech_loot = 3,
		/obj/random/pouch,
		/obj/item/stack/material/steel/random,
		/obj/item/stack/material/plasteel/random = 0.6,
		/obj/item/stack/rods/random,
		/obj/item/material/shard,
		/obj/random/junk/nondense,
		/obj/random/material_ore,
		/obj/random/pack/rare = 0.3,
		/obj/random/tool_upgrade = 1,
		/obj/random/mecha_equipment = 2,
		/obj/random/pack/prosthesis/low_chance = 0.05
	)

/obj/structure/scrap/food
	icontype = "food"
	name = "food trash pile"
	desc = "A pile of expired food and drink. Some of it smells funny."
	parts_icon = 'icons/obj/structures/scrap/food_trash.dmi'
	loot_list = list(
		/obj/random/junkfood = 5,
		/obj/random/booze,
		/obj/random/soft_drink,
		/obj/random/drinking_glasses = 0.5,
		/obj/item/material/shard,
		/obj/random/junk/nondense,
		/obj/random/pack/rare = 0.3
	)

/obj/structure/scrap/guns
	icontype = "guns"
	name = "armaments refuse pile"
	desc = "A pile of military supply refuse. Who thought it was a clever idea to throw that out?"
	parts_icon = 'icons/obj/structures/scrap/guns_trash.dmi'
	loot_min = 9
	loot_max = 13
	loot_list = list(
		/obj/random/pack/gun_loot = 8,
		/obj/random/powercell,
		/obj/random/mecha_equipment = 2,
		/obj/item/material/shard = 0.2,
		/obj/item/stack/material/steel/random = 0.4,
		/obj/item/stack/material/plasteel/random = 0.6,
		/obj/random/junk/nondense,
		/obj/random/pack/rare = 0.3,
		/obj/random/gun_parts/frames = 2,
		/obj/random/gun_parts = 1,
		/obj/random/pouch/hardcase_ammo = 0.3 //Can spawn some really good ammo.
	)

/obj/structure/scrap/science
	icontype = "science"
	name = "scientific trash pile"
	desc = "A pile of technical refuse. Some of it still glows and hums faintly."
	parts_icon = 'icons/obj/structures/scrap/science.dmi'
	loot_list = list(
		/obj/random/pack/tech_loot = 4,
		/obj/random/powercell,
		/obj/random/circuitboard,
		/obj/random/science,
		/obj/random/material_ore,
		/obj/random/common_oddities = 0.5,
		/obj/random/pack/rare,//No weight on this, rare loot is pretty likely to appear in scientific scrap
		/obj/random/tool_upgrade,
		/obj/random/mecha_equipment)

/obj/structure/scrap/cloth
	icontype = "cloth"
	name = "cloth pile"
	desc = "A pile of ruined and discarded clothing."
	parts_icon = 'icons/obj/structures/scrap/cloth.dmi'
	loot_list = list(/obj/random/pack/cloth = 4,
		/obj/random/cigarettes = 0.5,
		/obj/random/pack/rare = 0.1,
		/obj/random/gun_parts/frames = 0.1,
		/obj/random/gun_parts = 0.3,
		/obj/item/storage/wallet = 0.2,
		/obj/item/storage/wallet/random = 0.1,
		/obj/random/pack/prosthesis/low_chance = 0.2,
		/obj/random/pouch/hardcase = 0.2)

/obj/structure/scrap/poor
	icontype = "poor"
	name = "mixed rubbish"
	desc = "A pile of mixed rubbish. Useless and rotten, mostly."
	parts_icon = 'icons/obj/structures/scrap/all_mixed.dmi'
	loot_list = list(
		/obj/random/lowkeyrandom = 5,
		/obj/random/junk/nondense = 4,
		/obj/item/stack/rods/random = 3,
		/obj/random/common_oddities = 0.5,
		/obj/random/cigarettes = 0.3,
		/obj/random/material_ore,
		/obj/item/material/shard,
		/obj/random/pack/rare = 0.3,
		/obj/random/pack/prosthesis/low_chance = 0.05,
		/obj/random/pouch/hardcase = 0.8 //Can be quite good
	)

/obj/structure/scrap/poor/large
	name = "large mixed rubbish"
	desc = "A large pile of mixed rubbish. Useless and rotten, mostly."
	opacity = TRUE
	density = TRUE
	icon_state = "big"
	loot_min = 11
	loot_max = 18
	base_min = 9
	base_max = 14
	big_item_chance = 75

/obj/structure/scrap/poor/large/beacon
	beacon = TRUE
	big_item_chance = 45

/obj/structure/scrap/vehicle/large
	name = "large industrial debris pile"
	desc = "A large pile of used machinery. Some of it is stained with fuel."
	opacity = TRUE
	density = TRUE
	icon_state = "big"
	loot_min = 11
	loot_max = 18
	base_min = 9
	base_max = 14
	base_spread = 16
	big_item_chance = 80

/obj/structure/scrap/vehicle/large/beacon
	beacon = TRUE
	big_item_chance = 60

/obj/structure/scrap/food/large
	name = "large food trash pile"
	desc = "A large pile of expired food and drink. Some of it smells funny."
	opacity = TRUE
	density = TRUE
	icon_state = "big"
	loot_min = 13
	loot_max = 20
	base_min = 9
	base_max = 14
	base_spread = 16
	big_item_chance = 50

/obj/structure/scrap/food/large/beacon
	beacon = TRUE
	big_item_chance = 20

/obj/structure/scrap/medical/large
	name = "large medical refuse pile"
	desc = "A large pile of medical refuse. Watch out for sharp instruments. "
	opacity = TRUE
	density = TRUE
	icon_state = "big"
	loot_min = 7
	loot_max = 18
	base_min = 9
	base_max = 14
	base_spread = 16
	big_item_chance = 60

/obj/structure/scrap/medical/large/beacon
	beacon = TRUE
	big_item_chance = 30

/obj/structure/scrap/guns/large
	name = "large armaments refuse pile"
	desc = "A large pile of military supply refuse. Who thought it was a clever idea to throw that out?"
	opacity = TRUE
	density = TRUE
	icon_state = "big"
	loot_min = 10
	loot_max = 18
	base_min = 9
	base_max = 14
	base_spread = 16
	big_item_chance = 50

/obj/structure/scrap/guns/large/beacon
	beacon = TRUE
	big_item_chance = 25

/obj/structure/scrap/science/large
	name = "large scientific trash pile"
	desc = "A large pile of technical refuse. Some of it still glows and hums faintly."
	opacity = TRUE
	density = TRUE
	icon_state = "big"
	loot_min = 11
	loot_max = 18
	base_min = 9
	base_max = 14
	base_spread = 16
	big_item_chance = 80

/obj/structure/scrap/science/large/beacon
	beacon = TRUE
	big_item_chance = 60

/obj/structure/scrap/cloth/large
	name = "large cloth pile"
	desc = "A large pile of ruined and discarded clothing."
	opacity = TRUE
	density = TRUE
	icon_state = "big"
	loot_min = 7
	loot_max = 16
	base_min = 9
	base_max = 14
	base_spread = 16
	big_item_chance = 65

/obj/structure/scrap/cloth/large/beacon
	beacon = TRUE
	big_item_chance = 35

/obj/structure/scrap/poor/structure
	name = "large mixed rubbish"
	opacity = TRUE
	density = TRUE
	icon_state = "med"
	loot_min = 4
	loot_max = 7
	dig_amount = 3
	base_min = 3
	base_max = 6
	big_item_chance = 80

/obj/structure/scrap/poor/structure/beacon
	beacon = TRUE
	big_item_chance = 65


/obj/structure/scrap/poor/structure/update_icon() //make big trash icon for this
	..()
	if(!loot_generated)
		underlays += image(icon, icon_state = "underlay_big")

