//these are probably broken

/obj/machinery/floodlight
	name = "emergency floodlight"
	icon = 'icons/obj/machines/floodlight.dmi'
	icon_state = "flood00"
	density = 1
	var/on = 0
	var/obj/item/cell/large/cell = null
	var/use = 200 // 200W light
	var/unlocked = 0
	var/open = 0
	var/brightness_on = 8		//can't remember what the maxed out value is
	light_power = 2

/obj/machinery/floodlight/Initialize()
	. = ..()
	cell = new /obj/item/cell/large(src)

/obj/machinery/floodlight/get_cell()
	return cell

/obj/machinery/floodlight/handle_atom_del(atom/A)
	..()
	if(A == cell)
		cell = null
		update_icon()

/obj/machinery/floodlight/update_icon()
	cut_overlays()
	icon_state = "flood[open ? "o" : ""][open && cell ? "b" : ""]0[on]"

/obj/machinery/floodlight/Process()
	if(!on)
		return

	if(!cell || (cell.charge < (use * CELLRATE)))
		turn_off(1)
		return

	// If the cell is almost empty rarely "flicker" the light. Aesthetic only.
	if((cell.percent() < 10) && prob(5))
		set_light(brightness_on/2, brightness_on/4)
		spawn(20)
			if(on)
				set_light(brightness_on, brightness_on/2)

	cell.use(use*CELLRATE)


// Returns 0 on failure and 1 on success
/obj/machinery/floodlight/proc/turn_on(var/loud = 0)
	if(!cell)
		return 0
	if(cell.charge < (use * CELLRATE))
		return 0

	on = 1
	set_light(brightness_on, brightness_on / 2)
	update_icon()
	if(loud)
		visible_message("\The [src] turns on.")
	return 1

/obj/machinery/floodlight/proc/turn_off(var/loud = 0)
	on = 0
	set_light(0, 0)
	update_icon()
	if(loud)
		visible_message("\The [src] shuts down.")

/obj/machinery/floodlight/attack_ai(mob/user as mob)
	if(isrobot(user) && Adjacent(user))
		return attack_hand(user)

	if(on)
		turn_off(1)
	else
		if(!turn_on(1))
			to_chat(user, "You try to turn on \the [src] but it does not work.")


/obj/machinery/floodlight/attack_hand(mob/user)
	if(open && cell)
		cell.forceMove(get_turf(src))
		if(ishuman(user))
			if(!user.get_active_hand())
				user.put_in_hands(cell)

		cell.add_fingerprint(user)
		cell.update_icon()

		src.cell = null
		on = 0
		set_light(0)
		to_chat(user, "You remove the power cell")
		update_icon()
		return

	if(on)
		turn_off(1)
	else
		if(!turn_on(1))
			to_chat(user, "You try to turn on \the [src] but it does not work.")

	update_icon()


/obj/machinery/floodlight/attackby(obj/item/I, mob/user)

	var/list/usable_qualities = list(QUALITY_SCREW_DRIVING)
	if(unlocked)
		usable_qualities.Add(QUALITY_PRYING)

	var/tool_type = I.get_tool_type(user, usable_qualities, src)
	switch(tool_type)

		if(QUALITY_PRYING)
			if(unlocked)
				if(I.use_tool(user, src, WORKTIME_NORMAL, tool_type, FAILCHANCE_HARD, required_stat = STAT_MEC))
					if(open)
						open = 0
						cut_overlays()
						to_chat(user, SPAN_NOTICE("You crowbar the battery panel in place."))
					else
						if(unlocked)
							open = 1
							to_chat(user, SPAN_NOTICE("You remove the battery panel."))
					update_icon()
				return
			return

		if(QUALITY_SCREW_DRIVING)
			var/used_sound = unlocked ? 'sound/machines/Custom_screwdriveropen.ogg' :  'sound/machines/Custom_screwdriverclose.ogg'
			if(I.use_tool(user, src, WORKTIME_NEAR_INSTANT, tool_type, FAILCHANCE_VERY_EASY, instant_finish_tier = 30, forced_sound = used_sound))
				unlocked = !unlocked
				to_chat(user, SPAN_NOTICE("You [unlocked ? "unscrew" : "screw"] the battery panel of \the [src] with [I]."))
				update_icon()
				return
			return

		if(ABORT_CHECK)
			return

	if (istype(I, /obj/item/cell/large))
		if(open)
			if(cell)
				to_chat(user, SPAN_WARNING("There is a power cell already installed."))
			else
				user.drop_item()
				I.forceMove(src)
				cell = I
				to_chat(user, SPAN_NOTICE("You insert the power cell."))
		update_icon()
