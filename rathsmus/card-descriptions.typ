#import "/design/card-template.typ" as template
#import "/design/card-template.typ": distance, damage, attack, defense, duration, heal
#import "/design/icons.typ": inlineIcon, icons
#import "/design/colors.typ" as colors

////////////////////////////////////////////////////////////////////////////////

#let innerRadiance = (
  cardColor: colors.radiantCardColor,
  front: template.frontTemplate(
    [Inner Radiance],
    [Aasimar Trait],
    cardSubtitle: [Celestial Revelation],
    cardColor: colors.radiantCardColor,
    cardSymbol: "bonus_action",
    bottomText: [#inlineIcon(icons.duration) 1 min.],
    cardBody: [
      #template.sectionHeading([while active])
      Searing light radiates from your mouth and eyes.  Emit #distance[10ft] bright + #distance[10ft] dim light.
      #template.sectionHeading([once per turn])
      Increase damage of one spell or weapon attack by:
      #template.effectTable(
        (icon: icons.damage.any, effect: damage[+2 radiant]),
      )
      #template.sectionHeading([after each turn])
      Deal #damage[2 radiant] damage to #linebreak() all creatures within #distance[10ft].
    ]
  )
);

#let aid = (
  cardColor: colors.healCardColor,
  front: template.frontTemplate(
    [Aid],
    [Paladin Spell / Oath of Devotion],
    cardSubtitle: [Rank II / VSM / 30ft],
    cardSymbol: "action",
    cardColor: colors.healCardColor,
    bottomText: [#duration[8 hours]],
    cardBody: [
      Bolsters the hitpoints of up to three targets.
  
      #template.sectionHeading([upon activation])
      #template.effectTable(
        (icon: icons.hitpoints, effect: [Restore #heal[+5] hitpoints.]),
      )
  
      #template.sectionHeading([while active])
      #template.effectTable(
        (icon: icons.hitpoints, effect: [Hitpoint maximum increases by #heal[5].]),
      )
    ]
  )
)

#let shieldOfFaith = (
  cardColor: rgb("#7eb36a"),
  front: template.frontTemplate(
    [Shield of Faith],
    [Paladin Spell / Oath of Devotion],
    cardSubtitle: [Rank I / VSM / 60ft],
    cardSymbol: "bonus_action",
    bottomText: [concentration #inlineIcon(icons.duration) 10 min.],
    cardColor: rgb("#7eb36a"),
    cardBody: [
      A shimmering protective field surrounds the target.
  
      #template.sectionHeading([while active])
      Boosts target armor class.
      #template.effectTable(
        (icon: icons.armorClass, effect: defense[+2 AC]),
      )
    ]
  )
)

#let beaconOfHope = (
  cardColor: colors.healCardColor,
  front: template.frontTemplate(
    [Beacon of Hope],
    [Paladin / Oath of Devotion],
    cardSubtitle: [Rank III / VS / 30ft],
    cardSymbol: "action",
    cardColor: colors.healCardColor,
    bottomText: [concentration #inlineIcon(icons.duration) 1 min.],
    cardBody: [
      Bestows hope and vitality to arbitrarily many targets.
  
      #template.sectionHeading([saving throws])
      #template.effectTable(
        (icon: icons.advantage, effect: [#(template.save.wisdom)(none) save advantage]),
        (icon: icons.advantage, effect: [#(template.save.death)(none) save advantage])
      )
  
      #template.sectionHeading([when healed])
      #template.effectTable(
        (icon: icons.hitpoints, effect: [Restore maximum hit points from #template.heal[heal] dice.]),
      )
    ]
  )
)

#let conditionFrightened = (
  cardColor: colors.conditionCardColor,
  front: template.frontTemplate(
    [Frightened],
    [Condition],
    cardColor: colors.conditionCardColor,
    cardBody: [
      A frightened creature can't willingly move closer to the source of its fear.
  
      While the source of fright is within line of sight,
      #template.effectTable(
        (icon: icons.disadvantage, effect: [A frightened creature has disadvantage on #linebreak() all attack rolls.]),
        (icon: icons.disadvantage, effect: [A frightened creature has disadvantage on #linebreak() all ability checks.]),
      )
  ]
  )
)

////////////////////////////////////////////////////////////////////////////////

// the cards listed here will appear in the final document
// if you want multiple copies of a card, add multiple entries to the list
#let cards = (
  innerRadiance,
  innerRadiance,
  aid,
  beaconOfHope,
  shieldOfFaith,
  conditionFrightened,
)