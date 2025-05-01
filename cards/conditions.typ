#import "/design/card-template.typ" as template
#import "/design/card-template.typ": distance, damage, attack, defense, duration, heal, save, condition, terms
#import "/design/icons.typ": inlineIcon, icons
#import "/design/colors.typ" as colors

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

#let conditionIncapacitated = (
  cardColor: colors.conditionCardColor,
  front: template.frontTemplate(
    [Incapacitated],
    [Condition],
    cardColor: colors.conditionCardColor,
    cardBody: [
      An incapacitated creature cannot take actions, bonus actions, or reactions.

      (The creature can still move, provided it suffers no other conditions which restrict movement.)

      #template.effectTable(
        (icon: icons.disadvantage, effect: [An incapacitated creature makes #terms.initiative rolls with disadvantage.]),
      )
    ]
  )
)

#let conditionInvisible = (
  cardColor: colors.conditionCardColor,
  front: template.frontTemplate(
    [Invisible],
    [Condition],
    cardColor: colors.conditionCardColor,
    cardBody: [
      Invisible creatures cannot be seen without the aid of magic or a special sense.
      
      The creature’s location can still be detected by sounds it makes or tracks it leaves.
      
      // For the purposes of hiding, invisibility is considered #text(weight: "semibold", [heavy obscurement]).

      #template.effectTable(
        (icon: icons.disadvantage, effect: [Attacks against invisible creatures have disadvantage.]),
        (icon: icons.advantage, effect: [Invisible creatures have advantage when attacking.]),
        (icon: icons.advantage, effect: [Invisible creatures make #terms.initiative rolls with advantage.]),
      )
    ]
  )
)

#let conditionParalyzed = (
  cardColor: colors.conditionCardColor,
  front: template.frontTemplate(
  [Paralyzed],
  [Condition],
  cardColor: colors.conditionCardColor,
  cardBody: [
    A paralyzed creature is #condition.incapacitated and can’t move or speak.

    #template.effectTable(
      (icon: icons.advantage, effect: [Attack rolls against paralyzed creatures have advantage.]),
      (icon: icons.save.any, effect: [Paralyzed creatures automatically fail #linebreak() #(save.strength)(none) and #(save.dexterity)(none) saves.]),
      (icon: icons.attack.any, effect: [Any attack that hits a paralyzed creature becomes #text(weight: "semibold", [critical]) if the attacker is within #distance[5ft].]),
    )
  ]
)
)

#let conditionStunned = (
  cardColor: colors.conditionCardColor,
  front: template.frontTemplate(
    [Stunned],
    [Condition],
    cardColor: colors.conditionCardColor,
    cardBody: [
    A stunned creature is #condition.incapacitated, can't move, and can speak only falteringly.

      #template.effectTable(
        (icon: icons.advantage, effect: [Attack rolls against stunned creatures have advantage.]),
        (icon: icons.save.any, effect: [Stunned creatures automatically fail #linebreak() #(save.strength)(none) and #(save.dexterity)(none) saves.]),
      )
    ]
  )
)

#let conditionUnconscious = (
  cardColor: colors.conditionCardColor,
  front: template.frontTemplate(
    [Unconscious],
    [Condition],
    cardColor: colors.conditionCardColor,
    cardBody: [
      An unconscious creature is #condition.incapacitated, can’t move or speak, and is unaware of its surroundings.

      The creature drops any items it is holding and #linebreak() falls #condition.prone.

      #template.effectTable(
        (icon: icons.advantage, effect: [Attack rolls against unconscious creatures have advantage.]),
        (icon: icons.save.any, effect: [Automatically fail #linebreak() #(save.strength)(none) and #(save.dexterity)(none) saves.]),
        (icon: icons.attack.any, effect: [Any attack that hits the creature becomes #text(weight: "semibold", [critical]) if the attacker is within #distance[5ft].]),
      )
    ]
  )
)