// Abort Check
#define ABORT_CHECK                     -1

// Tool Use Outcomes
#define TOOL_USE_FAIL                   -1
#define TOOL_USE_CANCEL                 0
#define TOOL_USE_SUCCESS                1

// Mechanical Qualities
#define QUALITY_BOLT_TURNING            "bolt turning"
#define QUALITY_PULSING                 "pulsing"
#define QUALITY_PRYING                  "prying"
#define QUALITY_WELDING                 "welding"
#define QUALITY_SCREW_DRIVING           "screw driving"
#define QUALITY_WIRE_CUTTING            "wire cutting"
#define QUALITY_SHOVELING               "shoveling"
#define QUALITY_DIGGING                 "digging"
#define QUALITY_EXCAVATION              "excavation"
#define QUALITY_ADHESIVE                "adhesive"
#define QUALITY_SEALING                 "sealing"
#define QUALITY_HAMMERING               "hammering"

// Biological Qualities
#define QUALITY_CLAMPING                "clamping"
#define QUALITY_CAUTERIZING             "cauterizing"
#define QUALITY_RETRACTING              "retracting"
#define QUALITY_DRILLING                "drilling"
#define QUALITY_SAWING                  "sawing"
#define QUALITY_BONE_SETTING            "bone setting"
#define QUALITY_CUTTING                 "cutting"
#define QUALITY_LASER_CUTTING           "laser cutting"     // Laser scalpels and e-swords - bloodless cutting
#define QUALITY_BONE_GRAFTING           "bone grafting"

// Other Qualities
#define QUALITY_WEAVING                 "weaving"
#define QUALITY_ELECTROCUTION           "electroshock"
#define QUALITY_ARMOR                   "armor"
#define QUALITY_HEATING                 "heating"           // Used absure crafting

// Work Time (basic time - tool level - stat check). Basic tools give -30 on time, and people on the right job should give -20 at least
#define WORKTIME_INSTANT                0
#define WORKTIME_NEAR_INSTANT           30
#define WORKTIME_FAST                   60
#define WORKTIME_QUICK                  75
#define WORKTIME_NORMAL                 90
#define WORKTIME_DELAYED                105
#define WORKTIME_SLOW                   120
#define WORKTIME_LONG                   170
#define WORKTIME_EXTREMELY_LONG         250

// Fail Chance (basic chance - tool level - stat check). Basic gives -30% on fail chance, and people with the right job should have -20% at least
#define FAILCHANCE_ZERO                 0
#define FAILCHANCE_VERY_EASY            30
#define FAILCHANCE_EASY                 50
#define FAILCHANCE_NORMAL               60
#define FAILCHANCE_HARD                 80
#define FAILCHANCE_CHALLENGING          90
#define FAILCHANCE_VERY_HARD            120
#define FAILCHANCE_IMPOSSIBLE           150

// Tool Work Sounds
#define NO_WORKSOUND                    -1
#define WORKSOUND_CIRCULAR_SAW          'sound/weapons/circsawhit.ogg'
#define WORKSOUND_SIMPLE_SAW            'sound/items/saw.ogg'
#define WORKSOUND_WRENCHING             'sound/items/Ratchet.ogg'
#define WORKSOUND_WIRECUTTING           'sound/items/Wirecutter.ogg'
#define WORKSOUND_WELDING               "weld"                                  // #TODO-MIRAI - Link this to an .ogg file
#define WORKSOUND_PULSING               'sound/items/multitool_pulse.ogg'
#define WORKSOUND_SCREW_DRIVING         'sound/items/Screwdriver.ogg'
#define WORKSOUND_EASY_CROWBAR          'sound/items/Crowbar.ogg'
#define WORKSOUND_HAMMER                'sound/items/hammer.ogg'
#define WORKSOUND_REMOVING              'sound/items/Deconstruct.ogg'
#define WORKSOUND_DRIVER_TOOL           'sound/items/e_screwdriver.ogg'
#define WORKSOUND_PICKAXE               'sound/items/pickaxe.ogg'
#define WORKSOUND_HARD_SLASH            'sound/weapons/bladeslice.ogg'
#define WORKSOUND_CHAINSAW              'sound/items/chainsaw.ogg'
#define WORKSOUND_TAPE                  'sound/items/duct_tape.ogg'
#define WORKSOUND_HONK                  'sound/items/bikehorn.ogg'