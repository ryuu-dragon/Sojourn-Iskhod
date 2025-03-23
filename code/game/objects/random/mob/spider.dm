/obj/random/mob/spiders
	name = "random spider"
	icon_state = "hostilemob-black"
	alpha = 128
	mobs = list(/mob/living/carbon/superior/spider = 35,\
				/mob/living/carbon/superior/spider/nurse = 30,\
				/mob/living/carbon/superior/spider/nurse/midwife = 15,\
				/mob/living/carbon/superior/spider/nurse/cave_spider = 15,\
				/mob/living/carbon/superior/spider/nurse/orb_weaver = 14,\
				/mob/living/carbon/superior/spider/hunter = 35,\
				/mob/living/carbon/superior/spider/hunter/cloaker = 20,\
				/mob/living/carbon/superior/spider/hunter/viper = 15,\
				/mob/living/carbon/superior/spider/hunter/shocker = 15,\
				/mob/living/carbon/superior/spider/hunter/pepper = 10,\
				/mob/living/carbon/superior/spider/fortress = 10,\
				/mob/living/carbon/superior/spider/fortress/pit = 8,\
				/mob/living/carbon/superior/spider/fortress/burrowing = 6
				)

/obj/random/mob/spiders/item_to_spawn()
	if(GLOB.chaos_level > 0) //Higher weights as chaose increase
		mobs += list(/mob/living/carbon/superior/spider/nurse/carrier = (8 * GLOB.chaos_level))
		mobs += list(/mob/living/carbon/superior/spider/nurse/recluse = (4 * GLOB.chaos_level))
		mobs += list(/mob/living/carbon/superior/spider/fortress/ogre = (6 * GLOB.chaos_level))
	if(GLOB.chaos_level > 1)
		mobs += list(/mob/living/carbon/superior/spider/plasma = (2 * GLOB.chaos_level))
		mobs += list(/mob/living/carbon/superior/spider/nurse/queen = (2 * GLOB.chaos_level))
	if(GLOB.chaos_level > 2)
		mobs += list(/mob/living/carbon/superior/spider/fortress/emperor = (1 * GLOB.chaos_level))
	return pickweight(mobs)

/obj/random/mob/spiders/low_chance
	name = "low chance random spider"
	icon_state = "hostilemob-black-low"
	spawn_nothing_percentage = 60

/obj/random/cluster/spiders
	name = "cluster of spiders"
	icon_state = "hostilemob-black-cluster"
	alpha = 128
	min_amount = 1
	max_amount = 5
	spread_range = 0

/obj/random/cluster/spiders/item_to_spawn()
	return /obj/random/mob/spiders

/obj/random/cluster/spiders/low_chance
	name = "low chance cluster of spiders"
	icon_state = "hostilemob-black-cluster-low"
	spawn_nothing_percentage = 60

/obj/random/mob/spiders/spider_ling //just sont have carrer
	name = "random spiderling spider"
	icon_state = "hostilemob-black"
	alpha = 128
	mobs = list(/mob/living/carbon/superior/spider = 35,\
				/mob/living/carbon/superior/spider/nurse = 30,\
				/mob/living/carbon/superior/spider/nurse/midwife = 15,\
				/mob/living/carbon/superior/spider/nurse/cave_spider = 15,\
				/mob/living/carbon/superior/spider/nurse/orb_weaver = 14,\
				/mob/living/carbon/superior/spider/hunter = 35,\
				/mob/living/carbon/superior/spider/hunter/cloaker = 20,\
				/mob/living/carbon/superior/spider/hunter/viper = 15,\
				/mob/living/carbon/superior/spider/hunter/shocker = 15,\
				/mob/living/carbon/superior/spider/hunter/pepper = 10,\
				/mob/living/carbon/superior/spider/fortress = 10,\
				/mob/living/carbon/superior/spider/fortress/pit = 8,\
				/mob/living/carbon/superior/spider/fortress/burrowing = 6
				)

/obj/random/mob/spiders/spider_ling/item_to_spawn()
	if(GLOB.chaos_level > 0)
		mobs += list(/mob/living/carbon/superior/spider/nurse/recluse = (4 * GLOB.chaos_level))
		mobs += list(/mob/living/carbon/superior/spider/fortress/ogre = (6 * GLOB.chaos_level))
	if(GLOB.chaos_level > 1)
		mobs += list(/mob/living/carbon/superior/spider/plasma = (2 * GLOB.chaos_level))
		mobs += list(/mob/living/carbon/superior/spider/nurse/queen = (2 * GLOB.chaos_level))
	if(GLOB.chaos_level > 2)
		mobs += list(/mob/living/carbon/superior/spider/fortress/emperor = (1 * GLOB.chaos_level))

	return pickweight(mobs)
