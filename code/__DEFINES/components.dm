/// Used to trigger signals and call procs registered for that signal
/// The datum hosting the signal is automaticaly added as the first argument
/// Returns a bitfield gathered from all registered procs
/// Arguments given here are packaged in a list and given to _SendSignal
#define SEND_SIGNAL(target, sigtype, arguments...) ( !target.comp_lookup || !target.comp_lookup[sigtype] ? NONE : target._SendSignal(sigtype, list(target, ##arguments)) )

//Simular to the above but this one is done by eris
#define ERIS_SEND_SIGNAL(target, sigtype, arguments...) ( !target.comp_lookup || !target.comp_lookup[sigtype] ? NONE : target._SendSignal(sigtype, list(##arguments)) )

/// Depreciated. Use SEND_SIGNAL instead. This only exists for compatability.
#define LEGACY_SEND_SIGNAL(target, sigtype, arguments...) ( !target?.comp_lookup || !target?.comp_lookup[sigtype] ? NONE : target?._SendSignal(sigtype, list(##arguments)) )

#define SEND_GLOBAL_SIGNAL(sigtype, arguments...) ( SEND_SIGNAL(SSdcs, sigtype, ##arguments) )

/// Signifies that this proc is used to handle signals.
/// Every proc you pass to RegisterSignal must have this.
#define SIGNAL_HANDLER SHOULD_NOT_SLEEP(TRUE)

//shorthand
#define GET_COMPONENT_FROM(varname, path, target) var##path/##varname = ##target.GetComponent(##path)
#define GET_COMPONENT(varname, path) GET_COMPONENT_FROM(varname, path, src)

#define COMPONENT_INCOMPATIBLE 1
#define COMPONENT_NOTRANSFER 2
#define COMPONENT_TRANSFER 3

// How multiple components of the exact same type are handled in the same datum

#define COMPONENT_DUPE_HIGHLANDER		0		//old component is deleted (default)
#define COMPONENT_DUPE_ALLOWED			1	//duplicates allowed
#define COMPONENT_DUPE_UNIQUE			2	//new component is deleted
#define COMPONENT_DUPE_UNIQUE_PASSARGS	4	//old component is given the initialization args of the new

// All signals. Format:
// When the signal is called: (signal arguments)
// All signals send the source datum of the signal as the first argument

// global signals
// These are signals which can be listened to by any component on any parent
// start global signals with "!", this used to be necessary but now it's just a formatting choice
//Example #define COMSIG_GLOB_NEW_Z "!new_z"								//from base of datum/controller/subsystem/mapping/proc/add_new_zlevel(): (list/args)
#define COMSIG_GLOB_FABRIC_NEW "!fabric_new"					//(image/fabric)

//////////////////////////////////////////////////////////////////

// /zone signals

#define COMSIG_ZAS_TICK "z_tick"
#define COMSIG_ZAS_DELETE "z_del"

// /datum signals
#define COMSIG_COMPONENT_ADDED "component_added"				//when a component is added to a datum: (/datum/component)
#define COMSIG_COMPONENT_REMOVING "component_removing"			//before a component is removed from a datum because of RemoveComponent: (/datum/component)
#define COMSIG_PARENT_PREQDELETED "parent_preqdeleted"			//before a datum's Destroy() is called: (force), returning a nonzero value will cancel the qdel operation
#define COMSIG_PARENT_QDELETING "parent_qdeleting"			  // just before a datum's Destroy() is called: (force), at this point none of the other components chose to interrupt qdel and Destroy will be called
#define COMSIG_PARENT_QDELETED "parent_qdeleted"				//after a datum's Destroy() is called: (force, qdel_hint), at this point none of the other components chose to interrupt qdel and Destroy has been called

#define COMSIG_QDELETING_NEW "parent_qdeleting_new"

#define COMSIG_SHUTTLE_SUPPLY "shuttle_supply"  //form sell()
#define COMSIG_TRADE_BEACON "trade_beacon"

#define COMSIG_RITUAL "ritual"
#define COMSIG_TRANSATION "transation"          //from transfer_funds()

/// from datum ui_act (usr, action)
#define COMSIG_UI_ACT "COMSIG_UI_ACT"

// /datum/mecha signals
#define COMSIG_HUD_DELETED "hud_deleted"

// /client signals
/// from base of client/Click(): (atom/target, atom/location, control, params, mob/user)
#define COMSIG_CLIENT_CLICK "atom_client_click"

// /atom signals
#define COMSIG_EXAMINE "examine"								//from atom/examine(): (mob/user, distance)
#define COMSIG_ATOM_UPDATE_OVERLAYS "atom_update_overlays"  //update_overlays()
#define COMSIG_ATOM_UNFASTEN "atom_unfasten" // set_anchored()
#define COMSIG_CLICK_ALT "alt_click"//from atom/AltClick(): (/mob)
#define COMSIG_CLICK_CTRL "ctrl_click"//from atom/CtrlClick(): (/mob)
#define COMSIG_SHIFTCLICK "shiftclick" // used for ai_like_control component
#define COMSIG_CTRLCLICK "ctrlclick" // used for ai_like_control component
#define COMSIG_ALTCLICK "altclick" // used for ai_like_control component

// /area signals
#define COMSIG_AREA_SANCTIFY "sanctify_area"

// /turf signals
#define COMSIG_TURF_LEVELUPDATE "turf_levelupdate" //levelupdate()
#define COMSIG_TURF_CHANGE "turf_change"

// /atom/movable signals
#define COMSIG_MOVABLE_MOVED "movable_moved"					//from base of atom/movable/Moved(): (/atom, origin_loc, new_loc)
#define COMSIG_MOVABLE_Z_CHANGED "movable_z_moved"				//from base of atom/movable/onTransitZ(): (oldz, newz)
#define COMSIG_MOVABLE_PREMOVE "moveable_boutta_move"
// /mob signals
#define COMSIG_MOB_LIFE  "mob_life"							 //from mob/Life()
#define COMSIG_MOB_LOGIN "mob_login"							//from mob/Login()
///from base of /mob/Logout(): ()
#define COMSIG_MOB_LOGOUT "mob_logout"
#define COMSIG_MOB_DEATH "mob_death"							//from mob/death()

#define COMSIG_TRACE_IMPACT "trace_impact" //Soj edit

// /mob/living signals
#define COMSIG_LIVING_STUN_EFFECT "stun_effect_act"			 //mob/living/proc/stun_effect_act()
#define COMSIG_CARBON_HAPPY   "carbon_happy"				   //drugs o ethanol in blood

// /mob/living/carbon signals
#define COMSIG_CARBON_ELECTROCTE "carbon_electrocute act"	   //mob/living/carbon/electrocute_act()
#define COMSING_NSA "current_nsa"							   //current nsa
#define COMSIG_CARBON_ADICTION "new_chem_adiction"			  //from check_reagent()

// /mob/living/carbon/human signals
#define COMSIG_HUMAN_ACTIONINTENT_CHANGE "action_intent_change"
#define COMSIG_HUMAN_WALKINTENT_CHANGE "walk_intent_change"
#define COMSIG_HUMAN_ODDITY_LEVEL_UP "human_oddity_level_up"
#define COMSIG_EMPTY_POCKETS "human_empty_pockets"
#define COMSIG_HUMAN_SAY "human_say"							//from mob/living/carbon/human/say(): (message)
#define COMSIG_HUMAN_ROBOTIC_MODIFICATION "human_robotic_modification"
#define COMSIG_STAT "current_stat"							   //current stat
#define COMSIG_HUMAN_BREAKDOWN "human_breakdown"
#define COMSING_AUTOPSY "human_autopsy"						  //from obj/item/weapon/autopsy_scanner/attack()
#define COMSIG_HUMAN_LEVEL_UP "human_level_up"
#define COMSING_HUMAN_EQUITP "human_equip_item"				   //from human/equip_to_slot()
#define COMSIG_HUMAN_HEALTH "human_health"					   //from human/updatehealth()
#define COMSIG_HUMAN_SANITY "human_sanity"						//from /datum/sanity/proc/onLife()
#define COMSIG_HUMAN_INSTALL_IMPLANT "human_install_implant"

// /mob/living/carbon/superior signals
#define COMSIG_SUPERIOR_FIRED_PROJECTILE "superior_fired_projectile"
#define COMSIG_ATTACKED "attacked" // Soj edit, feel free to adapt this to other types

// /datum/species signals

// /obj signals
#define COMSIG_OBJ_HIDE	"obj_hide"
#define COMSIG_OBJ_TECHNO_TRIBALISM "techno_tribalism"
#define COMSIG_OBJ_FACTION_ITEM_DESTROY "faction_item_destroy"
#define SWORD_OF_TRUTH_OF_DESTRUCTION "sword_of_truth"

//machinery
#define COMSIG_AREA_APC_OPERATING "area_operating"  //from apc process()
#define COMSIG_AREA_APC_DELETED "area_apc_gone"
#define COMSIG_AREA_APC_POWER_CHANGE "area_apc_power_change"
#define COMSING_DESTRUCTIVE_ANALIZER "destructive_analizer"
#define COMSIG_TURRENT "create_turrent"

// /obj/item signals
#define COMSIG_IATTACK "item_attack"									//from /mob/ClickOn(): (/atom, /src, /params) If any reply to this returns TRUE, overrides attackby and afterattack
#define COMSIG_ATTACKBY "attack_by"										//from /mob/ClickOn():
#define COMSIG_APPVAL "apply_values"									//from /atom/refresh_upgrades(): (/src) Called to upgrade specific values
#define COMSIG_ADDVAL "add_values" 										//from /atom/refresh_upgrades(): (/src) Called to add specific things to the /src, called before COMSIG_APPVAL
#define COMSIG_REMOVE "uninstall"
#define COMSIG_ITEM_DROPPED	"item_dropped"					//from  /obj/item/weapon/tool/attackby(): Called to remove an upgrade
#define COMSIG_ITEM_PICKED "item_picked"
#define COMSIG_ODDITY_USED "used_oddity"                    //from /datum/sanity/proc/oddity_stat_up(): called to notify the used oddity it was used.
// /obj/item/clothing signals
#define COMSIG_CLOTH_DROPPED "cloths_missing"
#define COMSIG_CLOTH_EQUIPPED "cloths_recovered"
#define COMSIG_GLASS_LENSES_REMOVED "lenses_removed" // lenses.dm
// /obj/item/implant signals

// /obj/item/pda signals
#define COMSIG_MESSAGE_SENT "radio_message_sent"
#define COMSIG_MESSAGE_RECEIVED "radio_message_received"
// /obj/item/radio signals

//obj/item/gun signals
#define COMSIG_GUN_POST_FIRE "gun_post_fire"	//from base of /obj/item/gun/proc/handle_post_fire(): (atom/target, pointblank, reflex)

// Internal organ signals
#define COMSIG_IORGAN_REFRESH_SELF "internal_organ_self_refresh"
#define COMSIG_IORGAN_REFRESH_PARENT "internal_organ_parent_refresh"
#define COMSIG_IORGAN_APPLY "internal_organ_apply_modifiers"
#define COMSIG_IORGAN_ADD_WOUND "add_internal_wound"
#define COMSIG_IORGAN_REMOVE_WOUND "remove_internal_wound"
#define COMSIG_IORGAN_WOUND_COUNT "count_internal_wounds"

// Internal wound signals
#define COMSIG_IWOUND_EFFECTS "internal_wound_effects"
#define COMSIG_IWOUND_LIMB_EFFECTS "internal_wound_limb_effects"
#define COMSIG_IWOUND_FLAGS_ADD "internal_wound_flags_add"
#define COMSIG_IWOUND_FLAGS_REMOVE "internal_wound_flags_remove"
#define COMSIG_IWOUND_DAMAGE "internal_wound_damage"
#define COMSIG_IWOUND_TREAT "internal_wound_autodoc"

// ABERRANT signals
#define COMSIG_ABERRANT_INPUT "aberrant_input"
#define COMSIG_ABERRANT_PROCESS "aberrant_process"
#define COMSIG_ABERRANT_OUTPUT "aberrant_output"
#define COMSIG_ABERRANT_SECONDARY "aberrant_secondary"
#define COMSIG_ABERRANT_COOLDOWN "aberrant_cooldown"

// Note that this is only defined for actions because this could be a good bit expensive otherwise
/// From base of /atom/movable/screen/movable/action_button/MouseWheel(src, delta_x, delta_y, location, control, params)
#define COMSIG_ACTION_SCROLLED "action_scrolled"

/*******Component Specific Signals*******/
//Janitor

// /datum/component/storage signals
#define COMSIG_STORAGE_INSERTED "item_inserted"
#define COMSIG_STORAGE_TAKEN "item_taken"
#define COMSIG_STORAGE_OPENED "new_backpack_who_dis"

// /datum/component/heat signals
#define COMSIG_HEAT_SPECIAL "heat_special"
#define COMSIG_HEAT_OVERHEAT "heat_overheated"
#define COMSIG_HEAT_VENT "heat_venting"

// OVERMAP
#define COMSIG_SHIP_STILL "ship_still" // /obj/effect/overmap/ship/Process() && is_still()

/*******Non-Signal Component Related Defines*******/
