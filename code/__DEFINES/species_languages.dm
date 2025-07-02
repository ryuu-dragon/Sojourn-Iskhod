// Species Flags
#define NO_BLOOD          0x1    // Vessel var is not filled with blood, cannot bleed out.
#define NO_BREATHE        0x2    // Cannot suffocate or take oxygen loss.
#define NO_SCAN           0x4    // Cannot be scanned in a DNA machine/genome-stolen. Doesn't work with new genetics.
#define NO_PAIN           0x8    // Cannot suffer halloss/recieves deceptive health indicator.
#define NO_SLIP           0x10   // Cannot fall over.
#define NO_POISON         0x20   // Cannot not suffer toxloss.
#define IS_PLANT          0x40   // Is a treeperson.
#define NO_MINOR_CUT      0x80   // Can step on broken glass with no ill-effects. Either thick skin, cut resistant (slimes) or incorporeal (shadows)
// unused: 0x8000 - higher than this will overflow

// Species Spawn Flags
#define IS_WHITELISTED    0x1    // Must be whitelisted to play.
#define CAN_JOIN          0x2    // Species is selectable in chargen.
#define IS_RESTRICTED     0x4    // Is not a core/normally playable species. (castes, mutantraces)

// Species Appearance Flags
#define HAS_SKIN_TONE     0x1    // Skin tone selectable in chargen. (0-255)
#define HAS_SKIN_COLOR    0x2    // Skin color selectable in chargen. (RGB)
#define HAS_LIPS          0x4    // Lips are drawn onto the mob icon. (lipstick)
#define HAS_UNDERWEAR     0x8    // Underwear is drawn onto the mob icon.
#define HAS_EYE_COLOR     0x10   // Eye color selectable in chargen. (RGB)
#define HAS_HAIR_COLOR    0x20   // Hair color selectable in chargen. (RGB)

// General Languages
#define LANGUAGE_COMMON     "English Common"
#define LANGUAGE_CYRILLIC   "Interslavic"
#define LANGUAGE_ILLYRIAN   "Illyrian"
#define LANGUAGE_JIVE       "Jive"
#define LANGUAGE_EURO       "Eurolang"
#define LANGUAGE_JANA       "Jana"
#define LANGUAGE_LATIN      "Latin"
#define LANGUAGE_ROMANA     "Lingua Romana"
#define LANGUAGE_YASSARI    "Yassari"

// Alien and Species-Specific Languages
#define LANGUAGE_ROBOT      "Robot Talk"
#define LANGUAGE_OPIFEXEE   "Opifexee"
#define LANGUAGE_CHTMANT    "Chthive"
#define LANGUAGE_KRIOSAN    "Kriosan"
#define LANGUAGE_AKULA      "Akula"
#define LANGUAGE_MARQUA     "Marqua"
#define LANGUAGE_PLANT      "Native Plant"
#define LANGUAGE_SYNTHETIC  "Technical Cant"
#define LANGUAGE_MERP       "Narad Pidgin"
#define LANGUAGE_BLORP      "Aulvae Sonet"
#define LANGUAGE_WEH        "Cindarite Voc"
#define LANGUAGE_SABLEKYNE  "Crinos"

// Special and Antagonist Languages
#define LANGUAGE_MONKEY     "Chimpanzee"
#define LANGUAGE_DRONE      "Drone Talk"
#define LANGUAGE_XENOMORPH  "Xenomorph"
#define LANGUAGE_HIVEMIND   "Hivemind"
#define LANGUAGE_CORTICAL   "Cortical Link"
#define LANGUAGE_CULT       "Cult"
#define LANGUAGE_OCCULT     "Occult Projection"
#define LANGUAGE_BLITZ      "Blitzshell Communique"

// Language Flags
#define WHITELISTED  1      // Language is available if the speaker is whitelisted.
#define RESTRICTED   2      // Language can only be acquired by spawning or an admin.
#define NONVERBAL    4      // Language has a significant non-verbal component. Speech is garbled without line-of-sight.
#define SIGNLANG     8      // Language is completely non-verbal. Speech is displayed through emotes for those who can understand.
#define HIVEMIND     16     // Broadcast to all mobs with this language.
#define NONGLOBAL    32     // Do not add to general languages list.
#define INNATE       64     // All mobs can be assumed to speak and understand this language. (audible emotes)
#define NO_SPEAK     128    // Language can be understood, but not spoken.
#define NO_TALK_MSG  256    // Do not show the "\The [speaker] talks into \the [radio]" message
#define NO_STUTTER   512    // No stuttering, slurring, or other speech problems
#define NO_TRANSLATE 1024   // Prevents translation with omni translators
