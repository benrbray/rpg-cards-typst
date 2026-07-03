#import "/design/card-template-special.typ" as template
#import "/design/card-template-special.typ": distance, damage, attack, quality, defense, duration, heal, save, condition
#import "/design/icons.typ": inlineIcon, icons
#import "/design/colors.typ" as colors

////////////////////////////////////////////////////////////////////////////////

#let spellAttractor = (
  cardColor: colors.damageCardColor,
  front: template.frontTemplate(
    [Blinsky's Spell\ A-Ttractor],
    [Spellcasting Focus],
    cardColor: colors.damageCardColor,
    cardSymbol: "action",
    cardBody: [
      _Spellcasting Focus_

      A one-of-a-kind toy imported from far-off Barovia made by the legendary toymaster himself!
      
      Symbolizing all that is mighty -- four wheels!  Hydraulic... valves?  Levers!  Axles!  And other things that tractors have!

      This tiny device will help you attract powerful magic and steer it towards your foes, helping you reap just what you sow!  

      You know what they say:  

      *Is no Blinsky?  Is no fun!*
      // The _Gulthias Staff_ serves as a magic quarterstaff.  Has a maximum of *10 charges*.

      // #template.sectionHeading([upon successful melee hit])
      // By expending one charge,
      // #template.effectTable(
      //   (icon: icons.hitpoints, effect: [Regain #heal[hitpoints] equal to the damage dealt.]),
      //   (icon: icons.condition, effect: [You must succeed a #(save.wisdom)(12) save or suffer short-term #condition.madness.])
      // )

      // #template.sectionHeading([daily at dusk])
      // Replenish *1d6 + 4* charges.
    ]
  )
);

#let hatOfLearnedTheHardWay = (
  cardColor: colors.damageCardColor,
  front: template.frontTemplate(
    [Hat of Learned\ the Hard Way],
    [Gulthias Staff],
    cardColor: colors.damageCardColor,
    cardSymbol: "action",
    cardBody: [
      There are many ways to learn a lesson (this way, that way...).
      
      This hat contains the crystalized wisdom that can only be gained through painful trial-and-error (the fire and desire of youth, for instance).
      
      Once donned, this hat cannot be removed by anyone besides the wearer. It looks damn snazzy, too.

      #template.sectionHeading([*while donned*])
      #template.effectTable(
        (icon: icons.immune, effect: defense[+2 Wisdom]),
      )
    ]
  )
);

#let bladeOfBlamelessness = (
  cardColor: colors.damageCardColor,
  front: template.frontTemplate(
    [Blade of Blamelessness],
    [Gulthias Staff],
    cardColor: colors.damageCardColor,
    cardSymbol: "action",
    cardBody: [
      _Rare Rapier_, _Light Weapon_, _Proficient_

      *1d8* / *2d10* against fiends, undead.

      No one knows whether this blade was forged in heaven or hell, but one thing is certain -- it was designed to be driven straight through the heart. 
      
      An ultra-light weapon that still does impressive damage; if you play your part, this blade will play no games.

      While you hold the drawn sword, it creates an aura in a *10-foot* radius around you. You and all friendly creatures in the aura have advantage on saving throws against spells and other magical effects. 
    ]
  )
);

#let shieldOfLove = (
  cardColor: colors.damageCardColor,
  front: template.frontTemplate(
    [Shield of Love],
    [Gulthias Staff],
    cardColor: colors.damageCardColor,
    cardSymbol: "action",
    cardBody: [
      This shield is nigh-unbreakable when held by a true believer.  For one who believes in a thing called love will surely find protection in it.
      
      This shield has a mind of its own, and will only appear to those who truly know its worth.

      #template.sectionHeading([*while held*])
      #template.effectTable(
        (icon: icons.armorClass, effect: defense[+2 AC]),
        (icon: icons.immune, effect: [Immunity to *necrotic* damage])
      )
    ]
  )
);

////////////////////////////////////////////////////////////////////////////////


// the cards listed here will appear in the final document
// if you want multiple copies of a card, add multiple entries to the list
#let cards = (
  spellAttractor,
  hatOfLearnedTheHardWay,
  bladeOfBlamelessness,
  shieldOfLove,
)