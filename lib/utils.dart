import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData(
    fontFamily: GoogleFonts.montserrat().fontFamily,
    primaryColor: Colors.green);

final darkTheme = ThemeData(
    primaryColor: Colors.green,
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.montserrat().fontFamily);

final data = {
  'apple': {
    'Apple Scab': {
      'image': 'assets/images/test/apple/Apple Scab.JPG',
      'info':
          '''A serious disease of apples and ornamental crabapples, apple scab (Venturia inaequalis) attacks both leaves and fruit. The fungal disease forms pale yellow or olive-green spots on the upper surface of leaves. Dark, velvety spots may appear on the lower surface. Severely infected leaves become twisted and puckered and may drop early in the summer.''',
      'remedies': [
        '''Bonide® Sulfur Plant Fungicide, a finely ground wettable powder, is used in pre-blossom applications and must go on before rainy or spore discharge periods. Apply from pre-pink through cover (2 Tbsp/ gallon of water), or use in cover sprays up to the day of harvest.''',
        '''Organocide® Plant Doctor is an earth-friendly systemic fungicide that works its way through the entire plant to combat a large number of diseases on ornamentals, turf, fruit and more. Apply as a soil drench or foliar spray (3-4 tsp/ gallon of water) to prevent and attack fungal problems''',
        '''For best control, spray liquid copper soap early, two weeks before symptoms normally appear. Alternatively, begin applications when disease first appears, and repeat at 7 to 10 day intervals up to blossom drop.''',
        '''Containing sulfur and pyrethrins, Bonide® Orchard Spray is a safe, one-hit concentrate for insect attacks and fungal problems. For best results, apply as a protective spray (2.5 oz/ gallon) early in the season. If disease, insects or wet weather are present, mix 5 oz in one gallon of water. Thoroughly spray all parts of the plant, especially new shoots''',
      ]
    },
    'Apple Black Rot': {
      'image': 'assets/images/test/apple/Apple Black Rot.JPG',
      'info':
          '''Black rot is a disease of apples that infects fruit, leaves, and bark caused by the fungus Botryosphaeria obtusa. It can also jump to healthy tissue on pear or quince trees but is typically a secondary fungus of weak or dead tissues in other plants. Begin checking your apple trees for signs of infection about a week after the petals fall from your apple blossoms.''',
      'remedies': [
        '''Treating black rot on apple trees starts with sanitation. Because fungal spores overwinter on fallen leaves, mummified fruits, dead bark, and cankers, it’s important to keep all the fallen debris and dead fruit cleaned up and away from the tree.''',
        '''During the winter, check for red cankers and remove them by cutting them out or pruning away the affected limbs at least six inches (15 cm.) beyond the wound. Destroy all infected tissue immediately and keep a watchful eye out for new signs of infection. ''',
        '''Once black rot disease is under control in your tree and you’re again harvesting healthy fruits, make sure to remove any injured or insect-invaded fruits to avoid re-infection. Although general-purpose fungicides, like copper-based sprays and lime sulfur, can be used to control black rot, nothing will improve apple black rot like removing all sources of spores.''',
      ]
    },
    'Cedar Apple Rust': {
      'image': 'assets/images/test/apple/Cedar Apple Rust.JPG',
      'info':
          '''Cedar apple rust (Gymnosporangium juniperi-virginianae) is a fungal disease that requires juniper plants to complete its complicated two year life-cycle. Spores overwinter as a reddish-brown gall on young twigs of various juniper species. In early spring, during wet weather, these galls swell and bright orange masses of spores are blown by the wind where they infect susceptible apple and crab-apple trees. The spores that develop on these trees will only infect junipers the following year. From year to year, the disease must pass from junipers to apples to junipers again; it cannot spread between apple trees.''',
      'remedies': [
        '''Apply preventative, disease-fighting fungicides labeled for use on apples weekly, starting with bud break, to protect trees from spores being released by the juniper host. This occurs only once per year, so additional applications after this springtime spread are not necessary.''',
        '''On juniper, rust can be controlled by spraying plants with a copper solution (0.5 to 2.0 oz/ gallon of water) at least four times between late August and late October. ''',
        '''Safely treat most fungal and bacterial diseases with SERENADE Garden. This broad spectrum bio-fungicide uses a patented strain of Bacillus subtilis that is registered for organic use. Best of all, SERENADE is completely non-toxic to honey bees and beneficial insects. ''',
        '''Containing sulfur and pyrethrins, Bonide® Orchard Spray is a safe, one-hit concentrate for insect attacks and fungal problems. For best results, apply as a protective spray (2.5 oz/ gallon) early in the season. If disease, insects or wet weather are present, mix 5 oz in one gallon of water. Thoroughly spray all parts of the plant, especially new shoots. ''',
      ]
    },
  },
  'corn': {
    'Cercospora Leaf Spot': {
      'image': 'assets/images/test/corn/Cercospora Leaf Spot.JPG',
      'info':
          '''Pathogen-caused leaf spot diseases, particularly those of stone fruit trees and such vegetables as corn, tomato, pepper and lettuce are of two types, those caused by bacteria and those caused by fungus. Leaf spotting of either kind is generally similar in appearance and effect. Prevention and treatment of both kinds often involve the same practices.''',
      'remedies': [
        '''Spraying with a baking soda solution (a tablespoon of baking soda, 2 1/2 tablespoons of vegetable oil, a teaspoon of liquid soap, not detergent, to one gallon of water), or neem oil (do not use when pollinating insects including bees or other beneficial insects are present). Baking soda may burn some plant leaves. Spray only a few and then check for a reaction before applying applications every two weeks. ''',
        '''Apply sulfur sprays or copper-based fungicides weekly at first sign of disease to prevent its spread. These organic fungicides will not kill leaf spot, but prevent the spores from germinating. ''',
        '''Safely treat most fungal and bacterial diseases with SERENADE Garden. This broad spectrum bio-fungicide uses a patented strain of Bacillus subtilis that is registered for organic use. Best of all, SERENADE is completely non-toxic to honey bees and beneficial insects. ''',
        '''Containing copper and pyrethrins, Bonide® Garden Dust is a safe, one-step control for many insect attacks and fungal problems. For best results, cover both the tops and undersides of leaves with a thin uniform film or dust. Depending on foliage density, 10 oz will cover 625 sq ft. Repeat applications every 7-10 days, as needed. ''',
      ]
    },
    'Northern Leaf Blight': {
      'image': 'assets/images/test/corn/Northern Leaf Blight.JPG',
      'info':
          '''Northern corn leaf blight (NCLB) is caused by the fungus Setosphaeria turcica. Symptoms usually appear first on the lower leaves. Leaf lesions are long (1 to 6 inches) and elliptical, gray-green at first but then turn pale gray or tan. Under moist conditions, dark gray spores are produced, usually on the lower leaf surface, which give lesions a "dirty" gray appearance. Entire leaves on severely blighted plants can die, so individual lesions are not visible. Lesions may occur on the outer husk of ears, but the kernels are not infected. On hybrids that contain an Ht gene for resistance to the fungus, lesions are smaller, chlorotic, and may develop into linear streaks. These lesions rarely produce spores.''',
      'remedies': [
        '''Control of this disease is often focused on management and prevention. First, choose corn varieties or hybrids that are resistant or at least have moderate resistance to northern corn leaf blight. ''',
        '''When you grow corn, make sure it does not stay wet for long periods of time. The fungus that causes this infection needs between six and 18 hours of leaf wetness to develop. Plant corn with enough space for airflow and water in the morning so leaves can dry throughout the day. ''',
        '''The fungus overwinters in plant material, so it is also important to manage infected plants. Tilling the corn into the soil is one strategy, but with a small garden it may make more sense to just remove and destroy the affected plants. ''',
        '''Treating northern corn leaf blight involves using fungicides. For most home gardeners this step isn’t needed, but if you have a bad infection, you may want to try this chemical treatment. The infection usually begins around the time of silking, and this is when the fungicide should be applied. ''',
      ]
    },
    'Common Rust': {
      'image': 'assets/images/test/corn/Common Rust.JPG',
      'info':
          '''Common rust (Phragmidium spp.) is a fungal disease that attacks corn, roses, hollyhocks, snapdragons, daylilies, beans, tomatoes and lawns. It is most often found on mature plants where symptoms appear primarily on the surfaces of lower leaves.''',
      'remedies': [
        '''Apply copper sprays or sulfur powders to prevent infection of susceptible plants. For best results, apply early or at first sign of disease. Spray all plant parts thoroughly and repeat every 7-10 days up to the day of harvest. ''',
        '''Effectively treat fungal diseases with SERENADE Garden. This broad spectrum bio-fungicide uses a patented strain of Bacillus subtilis and is approved for organic gardening. Best of all, it’s safe to use — you can treat and pick crops the same day! ''',
        '''Containing sulfur and pyrethrins, Bonide® Orchard Spray is a safe, one-hit concentrate for insect attacks and fungal problems. For best results, apply as a protective spray (2.5 oz/ gallon) early in the season. If disease, insects or wet weather are present, mix 5 oz in one gallon of water. Thoroughly spray all parts of the plant, especially new shoots. ''',
        '''Use a thick layer of mulch or organic compost to cover the soil after you have raked and cleaned it well. Mulch will prevent the disease spores from splashing back up onto the leaves. ''',
      ]
    },
  },
  'grape': {
    'Esca(Black_Measles)': {
      'image': 'assets/images/test/grape/Esca(Black_Measles).JPG',
      'info':
          '''Esca, Botryosphaeria dieback, Eutypa dieback, and Phomopsis dieback make up a complex of "trunk diseases" caused by different wood-infecting fungi. The foliar symptom of Esca is an interveinal "striping". The "stripes", which start out as dark red in red cultivars and yellow in white cultivars, dry and become necrotic. Foliar symptoms may occur at any time during the growing season, but are most prevalent during July and August. They are often restricted to an individual shoot or to shoots originating from the same spur or cane. Symptomatic leaves can dry completely and drop prematurely. On berries, small, round, dark spots each bordered by a brown-purple ring, may occur.  ''',
      'remedies': [
        ''' ''',
        ''' ''',
        ''' ''',
        ''' ''',
      ]
    },
    'Leaf Blight(Isariopsis Leaf Spot)': {
      'image': 'assets/images/test/grape/Leaf Blight(Isariopsis Leaf Spot).JPG',
      'info':
          '''A prominent leaf spot disease was found to occur on V. rupestris in Kırıkhan district of Hatay province in Turkey. A leaf spotting hyphomycete, P. vitis, was isolated, identified and proved to be pathogenic on grapevine. ''',
      'remedies': [
        '''Keeping vines healthy, destroying crop residues and spraying with standard fungicides (mid to late season) are recommended to perform in the case of severe attacks of the disease.   '''
      ]
    },
    'Black Rot': {
      'image': 'assets/images/test/grape/Black Rot.JPG',
      'info':
          '''Grape black rot is a fungal disease caused by an ascomycetous fungus, Guignardia bidwellii, that attacks grape vines during hot and humid weather. “Grape black rot originated in eastern North America, but now occurs in portions of Europe, South America, and Asia. It can cause complete crop loss in warm, humid climates, but is virtually unknown in regions with arid summers. ''',
      'remedies': [
        '''Black rot can be very difficult control and there is no one method, including the use of fungicides, that will control it alone. You need to develop and use an integrated disease control program that uses some very important cultural practices combined with the application of effective fungicides. If you think that fungicides alone will provide complete control without the use of cultural practices, you will probably not be successful in controlling this disease. For example, if your vines are located in the shade where they do not dry rapidly, and you do not remove mummies and other infected tissues from the vines during the dormant season, your chances of effectively controlling black rot are not good, even with the use of effective fungicides. ''',
      ]
    },
  },
  'pepper': {
    'Bacterial Spot': {
      'image': 'assets/images/test/pepper/Bacterial Spot.JPG',
      'info':
          '''Bacterial leaf spot (BLS) is the most common, and one of the two most destructive diseases of peppers. Leaf spots are water-soaked initially, then turn brown and irregularly shaped. Affected leaves tend to turn yellow  and drop . Yield is reduced because raised, scab-like spots may develop on fruit and because affected leaves drop off plants, thereby reducing plant productivity and exposing fruit to potential sun scald . Complete crop failure has occurred.''',
      'remedies': [
        '''Crop rotation can help prevent bacterial leaf spot. Do not plant peppers or tomatoes in a location where either of these crops has been grown in the past four or five years. ''',
        '''At the end of the season, remove all crop debris from the garden and destroy it. Do not compost plant debris that may contain the disease. Once the area is clean of all visible debris, till the soil or turn it with a shovel to bury any remaining bacteria. ''',
        '''The bacterium is spread by splattering damp soil onto the leaves. Reduce the splatter by using a soaker hose and avoiding overhead watering. Stay out of the garden on wet days to avoid spreading disease on your hands and clothes. ''',
        '''Bacterial leaf spot is also spread through infected seeds. Buy certified disease-free seeds and seedlings. It’s best not to save your own seeds if you’ve ever had a problem with bacterial leaf spot on peppers.''',
      ]
    },
  },
  'strawberry': {
    'Leaf Scorch': {
      'image': 'assets/images/test/strawberry/Leaf Scorch.JPG',
      'info':
          '''Diplocarpon earlianum is a fungus that causes leaf scorch, one of the most common leaf diseases of strawberry. This ascomycete produces disk-shaped, dark brown to black apothecia (0.25-1 mm) on advanced-stage lesions on strawberry leaves and leaf residues (Heidenreich and Turechek).''',
      'remedies': [
        '''Remove foliage and crop residues after picking or at renovation to remove inoculum and delay disease increase in late summer and fall.  ''',
        '''Fungicide treatments are effective during the flowering period, and during late summer and fall.''',
      ]
    },
  },
  'potato': {
    'Early Blight': {
      'image': 'assets/images/test/potato/Early Blight.JPG',
      'info':
          '''Early blight of potato is caused by the fungal pathogen Alternaria solani. The disease affects leaves, stems and tubers and can reduce yield, tuber size, storability of tubers, quality of fresh-market and processing tubers and marketability of the crop.''',
      'remedies': [
        '''treatment of early blight includes prevention by planting potato varieties that are resistant to the disease; late maturing are more resistant than early maturing varieties. ''',
        '''Avoid overhead irrigation and allow for sufficient aeration between plants to allow the foliage to dry as quickly as possible.''',
      ]
    },
    'Late Blight': {
      'image': 'assets/images/test/potato/Late Blight.JPG',
      'info':
          '''Phytophthora infestans is an oomycete or water mold, a microorganism that causes the serious potato and tomato disease known as late blight or potato blight. Early blight, caused by Alternaria solani, is also often called "potato blight". Late blight was a major culprit in the 1840s European, the 1845 - 1852 Irish, and the 1846 Highland potato famines. The organism can also infect some other members of the Solanaceae. The pathogen is favored by moist, cool environments: sporulation is optimal at 12–18 °C (54–64 °F) in water-saturated or nearly saturated environments, and zoospore production is favored at temperatures below 15 °C (59 °F). Lesion growth rates are typically optimal at a slightly warmer temperature range of 20 to 24 °C (68 to 75 °F).''',
      'remedies': [
        '''•	The severe late blight can be effectively managed with prophylactic spray of mancozeb at 0.25% followed by cymoxanil+mancozeb or dimethomorph+mancozeb at 0.3% at the onset of disease and one more spray of mancozeb at 0.25% seven days after application of systemic fungicides.''',
      ]
    },
  },
  'peach': {
    'Bacterial Spot': {
      'image': 'assets/images/test/peach/Bacterial Spot.JPG',
      'info':
          '''Bacterial spot is an important disease of peaches caused by Xanthomonas campestris pv. pruni. Symptoms of this disease include fruit spots, leaf spots, and twig cankers. Fruit symptoms include pitting, cracking, gumming, and water soaked tissue, which can make the fruit more susceptible to brown rot, rhizopus, and other fungal infections. Severe leaf spot infections can cause early defoliation. Severe defoliation can result in reduced fruit size, and sunburn and cracking of fruit. Early defoliated trees are reduced in vigor and winter hardiness.''',
      'remedies': [
        '''Resistance to bacterial spot should be a primary consideration in peach varietal selection. Some of the more resistant varieties include Bell of Georgia, Biscoe, Harken, Loring, Madison, Ranger, Redhaven, Redskin and Sunhaven. Very susceptible varieties include Elberta, July Elberta, Halehaven, Rio-Oso-Gem and Sunhigh.''',
        '''Vigorous trees are less susceptible to the disease than weak, neglected trees. Fertilize according toa soil test, to maintain vigorous, but not excessive,shoot growth.''',
        '''Allow for good air circulation by avoiding low-lying orchard sites and by adhering to correct pruning practices. Prune during dry weather in the latter part of the dormant season.''',
        '''Chemical spray applications may provide some suppression of bacterial spot. Use dodine 65 WP plus Captan 50 WP (1/2 lb. plus 1 lb. per 100 gal. water). Observe label precautions, as this mixture can cause injury under certain conditions. Mycoshield at 12 oz. per 100 gal. is probably a more effective treatment. Mycoshield should be tank mixed with sulphur (6 lbs. per 100 gal.) or Captan (2 lb. per 100 gal.) for broad spectrum disease control. Bacterial spot sprays should be initiated at shuck-split and repeated at seven-day intervals through cover sprays. Observe harvest restrictions.''',
      ]
    },
  },
  'cherry': {
    'Powdery Mildew': {
      'image': 'assets/images/test/cherry/Powdery Mildew.JPG',
      'info':
          '''Common on many plants and easily recognized, powdery mildew is a fungal disease found throughout. It is caused by a variety of closely related fungal species, each with a limited host range. (The fungi attacking your roses are unlikely to spread to your lilacs). Low soil moisture combined with high humidity levels at the plant surface favors this disease.''',
      'remedies': [
        '''Prune or stake plants to improve air circulation. Make sure to disinfect your pruning tools (one part bleach to 4 parts water) after each cut.''',
        '''Use a thick layer of mulch or organic compost to cover the soil after you have raked and cleaned it well. Mulch will prevent the disease spores from splashing back up onto the leaves.''',
        '''Milk sprays, made with 40% milk and 60% water, are an effective home remedy for use on a wide range of plants. For best results, spray plant leaves as a preventative measure every 10-14 days.''',
        '''Wash foliage occasionally to disrupt the daily spore-releasing cycle. Neem oil and PM Wash, used on a 7 day schedule, will prevent fungal attack on plants grown indoors.''',
      ]
    },
  },
  'tomato': {
    'Bacterial Spot': {
      'image': 'assets/images/test/tomato/Bacterial Spot.JPG',
      'info':
          '''Bacterial spot can affect all above ground parts of a tomato plant, including the leaves, stems, and fruit. Bacterial spot appears on leaves as small (less than ⅛ inch), sometimes water-soaked (i.e., wet-looking) circular areas. Spots may initially be yellow-green, but darken to brownish-red as they age.''',
      'remedies': [
        '''Once leaf spot has infected your plants, spray with copper fungicide for seven to 10 days. After that, continue to treat every 10 days when weather is dry or every five to seven days when weather is wet. ''',
        '''Copper fungicide can also be used preventively after sowing seeds but before moving plants into the garden.''',
      ]
    },
    'Early Blight': {
      'image': 'assets/images/test/tomato/Early Blight.JPG',
      'info':
          '''Early blight is one of the most common tomato diseases, occurring nearly every season wherever tomatoes are grown. It affects leaves, fruits and stems and can be severely yield limiting when susceptible cultivars are used and weather is favorable. Severe defoliation can occur and result in sun scald on the fruit.''',
      'remedies': [
        '''Rotate Your Crops, Purge Nightshades and Volunteer Tomato Plants.''',
        '''Keep Your Plants Dry, Stake Your Plants and Remove Infected Plants.''',
      ]
    },
    'Leaf Mold': {
      'image': 'assets/images/test/tomato/Leaf Mold.JPG',
      'info':
          '''Cladosporium fulvum is an Ascomycete called Passalora fulva, a non-obligate pathogen that causes the disease on tomato known as the Tomato leaf mold. P. fulva only attacks tomato plants, especially the foliage, and it is a common disease in greenhouses, but can also occur in the field.''',
      'remedies': [
        '''When treating tomato plants with fungicide, be sure to cover all areas of the plant that are above the soil, especially the underside of leaves, where the disease often forms.''',
        '''Calcium chloride-based sprays are recommended for treating leaf mold issues. Organic fungicide options are also available.''',
      ]
    },
    'Late Blight': {
      'image': 'assets/images/test/tomato/Late Blight.JPG',
      'info':
          '''Late blight is a potentially devastating disease of tomato and potato, infecting leaves, stems and fruits of tomato plants. The disease spreads quickly in fields and can result in total crop failure if untreated. Late blight of potato was responsible for the Irish potato famine''',
      'remedies': [
        '''For the home gardener, fungicides that contain maneb, mancozeb, chlorothanolil or fixed copper can help protect plants from late tomato blight. ''',
        '''Repeated applications are necessary throughout the growing season as the disease can strike at any time.''',
      ]
    },
    'Septoria Leaf Spot': {
      'image': 'assets/images/test/tomato/Septoria Leaf Spot.JPG',
      'info':
          '''Septoria leaf spot is caused by a fungus, Septoria lycopersici. It is one of the most destructive diseases of tomato foliage and is particularly severe in areas where wet, humid weather persists for extended periods. Septoria leaf spot usually appears on the lower leaves after the first fruit sets.''',
      'remedies': [
        '''Organic fungicides can go a long way towards treating and preventing fungal infections like septoria leaf spot. ''',
        '''Fungicides containing copper and potassium bicarbonate will help contain the fungal disease and keep it from spreading. Start spraying as soon as you notice symptoms of septoria leaf spot.''',
      ]
    },
    'Spider Mites': {
      'image': 'assets/images/test/tomato/Spider Mites.JPG',
      'info':
          '''The tomato red spider mites are pale-orange to red and feed on the underside of leaves. They cannot be seen easily with the naked eye. Feeding damage caused by sucking sap appears as many shiny pale yellow marks on the top of the tomato leaf (see lower photo). Eventually the leaves turn brown and die or fall off.''',
      'remedies': [
        '''In case of minor infestation, simply wash off the mites and remove the affected leaves. ''',
        '''Use preparations based on rapeseed, basil, soybean and neem oils to spray leaves thoroughly and reduce populations of T. urticae. ''',
        '''Also try garlic tea, nettle slurry or insecticidal soap solutions to control the population.''',
      ]
    },
    'Yellow Leaf Curl Virus': {
      'image': 'assets/images/test/tomato/Yellow Leaf Curl Virus.JPG',
      'info':
          '''Tomato yellow leaf curl virus (TYLCV) is a DNA virus from the genus Begomovirus and the family Geminiviridae. TYLCV causes the most destructive disease of tomato, and it can be found in tropical and subtropical regions causing severe economic losses. This virus is transmitted by an insect vector from the family Aleyrodidae and order Hemiptera, the whitefly Bemisia tabaci, commonly known as the silverleaf whitefly or the sweet potato whitefly. The primary host for TYLCV is the tomato plant, and other plant hosts where TYLCV infection has been found include eggplants, potatoes, tobacco, beans, and peppers. Due to the rapid spread of TYLCV in the last few decades, there is an increased focus in research trying to understand and control this damaging pathogen. Some interesting findings include virus being sexually transmitted from infected males to non-infected females (and vice versa), and an evidence that TYLCV is transovarially transmitted to offspring for two generations.''',
      'remedies': [
        '''Maintain good weed control in the field and surrounding areas. Prevent the spread of any whiteflies to healthy plants.  ''',
        '''Tomato and pepper fields should be cleaned up immediately after harvest. Also destroy crop residues of melons and cotton immediately after harvest to reduce whitefly migration.''',
      ]
    },
    'Target Spot': {
      'image': 'assets/images/test/tomato/Target Spot.JPG',
      'info':
          '''Widespread. In tropical countries. Asia, Africa, North, South and Central America, the Caribbean, Europe, Oceania. It is recorded on tomato from Fiji, Niue, Samoa, Solomon Islands, Tonga, and Vanuatu.''',
      'remedies': [
        '''The products to use are chlorothalonil, copper oxy chloride or mancozeb. ''',
        '''Treatment should start when the first spots are seen and continue at 10-14-day intervals until 3-4 weeks before last harvest. It is important to spray both sides of the leaves.''',
      ]
    },
    'Mosaic Virus': {
      'image': 'assets/images/test/tomato/Mosaic Virus.JPG',
      'info':
          '''Plant viruses can be difficult to detect as symptoms look similar to many nutrient deficiencies and vary depending on the age of the plant when infection occurs. Look for:

1. Yellow, white or green stripes/ streaks/ spots on foliage

2. Wrinkled, curled or small leaves

3. Pronounced yellowing only of veins

4. Stunted growth and reduced yields

5. Infected fruit appears mottled and develops raised “warty” areas

Mosaic virus overwinters on perennial weeds and is spread by insects that feed on them. Aphids, leafhoppers, whiteflies and cucumber beetles are common garden pests that can transmit this disease.
''',
      'remedies': [
        '''There are no cures for viral diseases such as mosaic once a plant is infected. As a result, every effort should be made to prevent the disease from entering your garden.''',
        '''Fungicides will NOT treat this viral disease.''',
        '''Plant resistant varieties when available or purchase transplants from a reputable source.''',
        '''Spot treat with least-toxic, natural pest control products, such as Safer Soap, Bon-Neem and diatomaceous earth, to reduce the number of disease carrying insects.''',
      ]
    },
  },
};
