/mob/living/simple/hostile/carp
	name = "space carp"
	desc = "A ferocious, fang-bearing creature that resembles a fish."
	icon = 'icons/mob/mobs-monster.dmi'
	icon_state = "carp"
	icon_gib = "carp_gib"
	speak_chance = 0
	turns_per_move = 5
	meat_type = /obj/item/reagent_containers/snacks/meat/carp
	response_help = "pets the"
	response_disarm = "gently pushes aside the"
	response_harm = "hits the"
	speed = 4
	maxHealth = 25 * CARP_HEALTH_MOD
	health = 25

	armor = list(melee = 1, bullet = 2, energy = 12, bomb = 25, bio = 100, rad = 25) //Lasers dont work on scales


	harm_intent_damage = 8
	melee_damage_lower = 8
	melee_damage_upper = 12
	attacktext = "bitten"
	attack_sound = 'sound/weapons/bite.ogg'

	//Space carp aren't affected by atmos.
	needs_environment = FALSE

	break_stuff_probability = 4
	inherent_mutations = list(MUTATION_EPILEPSY, MUTATION_DEAF, MUTATION_BAROTRAUMA)
	faction = "carp"

/mob/living/simple/hostile/carp/baby
	name = "space carp spawn"
	desc = "A ferocious, fang-bearing creature that resembles a fish. This one is quite young."
	icon_state = "babycarp"
	icon_gib = "carp_gib"
	maxHealth = 10 * CARP_HEALTH_MOD
	health = 10 * CARP_HEALTH_MOD

	harm_intent_damage = 8
	melee_damage_lower = 4
	melee_damage_upper = 6

/mob/living/simple/hostile/carp/pike
	name = "space carp pike"
	desc = "A bigger, angrier cousin of the space carp."
	icon = 'icons/mob/spaceshark.dmi'
	icon_state = "shark"
	meat_amount = 6
	turns_per_move = 3
	move_to_delay = 3
	mob_size = MOB_LARGE

	//pixel_x = -16

	health = 75 * CARP_HEALTH_MOD
	maxHealth = 75 * CARP_HEALTH_MOD
	has_special_parts = TRUE
	special_parts = list(/obj/item/animal_part/wolf_tooth)
	harm_intent_damage = 5
	melee_damage_lower = 20
	melee_damage_upper = 25

	break_stuff_probability = 100

/mob/living/simple/hostile/carp/shark
	name = "space shark"
	desc = "A large carp with sets of sharp teeth and armored scales to be even more deadly."
	icon = 'icons/mob/mobs-monster.dmi'
	icon_state = "neocarp"
	meat_amount = 8
	turns_per_move = 3
	move_to_delay = 3
	mob_size = MOB_LARGE

	health = 150 * CARP_HEALTH_MOD
	maxHealth = 150 * CARP_HEALTH_MOD
	has_special_parts = TRUE
	special_parts = list(/obj/item/animal_part/wolf_tooth,/obj/item/animal_part/carp_fang)
	melee_damage_lower = 25
	melee_damage_upper = 30
	inherent_mutations = list(MUTATION_GIGANTISM, MUTATION_EPILEPSY, MUTATION_DEAF, MUTATION_BAROTRAUMA)

	break_stuff_probability = 100

/mob/living/simple/hostile/carp/greatwhite
	name = "great white carp"
	desc = "A very rare breed of carp and a very aggressive one."
	icon = 'icons/mob/64x64.dmi'
	icon_state = "megacarp"
	icon_dead = "megacarp_dead"
	maxHealth = 245  * CARP_HEALTH_MOD//WHITE WHALE
	health = 245 * CARP_HEALTH_MOD  //HOLY GRAIL
	//attack_same = 1 We no longer attack are yonger less rare of breeds
	speed = 1
	meat_amount = 10
	melee_damage_lower = 55
	melee_damage_upper = 65
	old_y = -16
	pixel_y = -16
	leather_amount = 10 //The amount of leather sheets dropped.
	bones_amount = 10 //The amount of bone sheets dropped.//Thanks Captain Obvious.
	mob_size = MOB_LARGE
	inherent_mutations = list(MUTATION_GIGANTISM, MUTATION_EPILEPSY, MUTATION_DEAF, MUTATION_BAROTRAUMA)
	has_special_parts = TRUE
	special_parts = list(/obj/item/animal_part/wolf_tooth,
						 /obj/item/animal_part/carp_fang,
						 /obj/item/animal_part/carp_fang) //HOLY GRAIL

	armor = list(melee = 6, bullet = 2, energy = 16, bomb = 25, bio = 100, rad = 25) //Lasers dont work on scales


/mob/living/simple/hostile/carp/allow_spacemove()
	return 1	//No drifting in space for space carp!	//original comments do not steal

/mob/living/simple/hostile/carp/FindTarget()
	. = ..()
	if(.)
		visible_emote("nashes at [.].")

/mob/living/simple/hostile/carp/AttackingTarget()
	. =..()
	var/mob/living/L = .
	if(istype(L))
		if(L.stats.getPerk(PERK_ASS_OF_CONCRETE) || L.stats.getPerk(PERK_BRAWN))
			return
		if(prob(15))
			L.Weaken(3)
			L.visible_message(SPAN_DANGER("\the [src] knocks down \the [L]!"))
