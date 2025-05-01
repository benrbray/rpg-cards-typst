#import "/design/card-template.typ" as template
#import "/design/card-template.typ": distance, damage, attack, defense, duration, heal, save, condition
#import "/design/icons.typ": inlineIcon, icons
#import "/design/colors.typ" as colors

////////////////////////////////////////////////////////////////////////////////

#let vampiricStrike = (
  cardColor: colors.damageCardColor,
  front: template.frontTemplate(
    [Vampiric Strike],
    [Gulthias Staff],
    cardColor: colors.damageCardColor,
    cardSymbol: "action",
    cardBody: [
      The _Gulthias Staff_ serves as a magic quarterstaff.

      #template.sectionHeading([upon successful melee hit])
      By expending one charge,
      #template.effectTable(
        (icon: icons.hitpoints, effect: [Regain #heal[hitpoints] equal to the damage dealt.]),
        (icon: icons.condition, effect: [You must succeed a #(save.wisdom)(12) save or suffer short-term #condition.madness.])
      )
    ]
  )
);

#let cruelty = (
  cardColor: colors.damageCardColor,
  front: template.frontTemplate(
    [Cruelty],
    [Feat (Tal'Dorei)],
    cardColor: colors.damageCardColor,
    cardSymbol: "action",
    cardBody: [
      Per long rest, you have a number of *cruelty dice* equal to your proficiency.

      Expending a die grants one of the following effects:

      #template.sectionHeading([when attack deals damage])
      #template.effectTable(
        (icon: icons.damage.any, effect: [Add #damage[+1d6] damage.]),
      )

      #template.sectionHeading([upon critical hit])
      #template.effectTable(
        (icon: icons.hitpoints, effect: [Restore #heal[+1d6] hitpoints.]),
      )

      #template.sectionHeading([ability checks])
      #template.effectTable(
        (icon: icons.advantage, effect: [Gain advantage on *Intimidation* checks which inflict pain.]),
      )
    ]
  )
);

#let summonPoe = (
  cardColor: colors.damageCardColor,
  front: template.frontTemplate(
    [Poe the Quasit],
    [Find Familiar],
    cardSubtitle: [AC 13, HP 7, Speed 40ft],
    cardColor: colors.damageCardColor,
    cardSymbol: "action",
    cardBody: [
      #v(-0.6em)
      #{
      set text(size: 0.8em)
      let label(s) = text(rgb("#333"), 0.8em, s)
      let labelMod = label(smallcaps[mod])
      let labelSave = label(smallcaps[save])

      let STR = { smallcaps[str] }
      let DEX = { smallcaps[dex] }
      let CON = { smallcaps[con] }
      let INT = { smallcaps[int] }
      let WIS = { smallcaps[wis] }
      let CHA = { smallcaps[cha] }
      let HP = { smallcaps[hp] }
      let AC = { smallcaps[ac] }
      let DC = { smallcaps[dc] }

      let ATTR = (
        STR : 5,
        DEX : 17,
        CON : 10,
        INT : 7,
        WIS : 10,
        CHA : 10
      )

      let PROFICIENCY = (
        STR : false,
        DEX : false,
        CON : false,
        INT : false,
        WIS : true,
        CHA : true
      )

      // first calculate attribute modifiers
      let MODIFIER = {
        let calcModifier(x) = calc.floor((x - 10)/2)
        (
          STR : calcModifier(ATTR.STR),
          DEX : calcModifier(ATTR.DEX),
          CON : calcModifier(ATTR.CON),
          INT : calcModifier(ATTR.INT),
          WIS : calcModifier(ATTR.WIS),
          CHA : calcModifier(ATTR.CHA)
        )
      }

      // next calculate derived modifiers
      let MODIFIER = (
        ..MODIFIER,
        STR_SAVE : MODIFIER.STR + (if PROFICIENCY.STR { 2 } else { 0 }),
        DEX_SAVE : MODIFIER.DEX + (if PROFICIENCY.DEX { 2 } else { 0 }),
        CON_SAVE : MODIFIER.CON + (if PROFICIENCY.CON { 2 } else { 0 }),
        INT_SAVE : MODIFIER.INT + (if PROFICIENCY.INT { 2 } else { 0 }),
        WIS_SAVE : MODIFIER.WIS + (if PROFICIENCY.WIS { 2 } else { 0 }),
        CHA_SAVE : MODIFIER.CHA + (if PROFICIENCY.CHA { 2 } else { 0 }),
      )

      let signed(x) = {
        if x >= 0 { [+#x] }
        else      { [#x] }
      }
      
      table(
        columns: 6,
        stroke: none,
        inset: 0.25em,
        fill: (x,y) => {
          if      calc.rem(x, 3) == 2 { luma(200) }
          // else if calc.rem(x, 4) == 3 { luma(230) }
          else { none }
        },
        none, none, labelMod,
        none, none, labelMod,
        align: center,
        [#{STR}], [#ATTR.STR], signed(MODIFIER.STR),
        [#{DEX}], [#ATTR.DEX], signed(MODIFIER.DEX),
        [#{CON}], [#ATTR.CON], signed(MODIFIER.CON),
        [#{INT}], [#ATTR.INT], signed(MODIFIER.INT),
        [#{WIS}], [#ATTR.WIS], signed(MODIFIER.WIS),
        [#{CHA}], [#ATTR.CHA], signed(MODIFIER.CHA),
      )
    }

      *Resists* lightning, cold, fire; nonmagic pierce, slash, and bludg., *Immune* to poison.  Advantage on spell saves.

      *Telepathy* within 100ft., use bonus action to see or hear.  Familiar may use reaction to *deliver* your _touch_ spells.

      Once daily, #condition.frighten target in 20ft. failing #(save.wisdom)(10) save.

      Turn Invisibile.  Darkvision.
    ]
  )
);

#let findFamiliar = (
  cardColor: colors.damageCardColor,
  front: template.frontTemplate(
    [Poe the Quasit],
    [Find Familiar],
    cardSubtitle: [],
    cardColor: colors.damageCardColor,
    cardSymbol: "action",
    cardBody: [
      The _Gulthias Staff_ serves as a magic quarterstaff.

      #template.sectionHeading([skills])
      By expending one charge,
      #template.effectTable(
        (icon: icons.hitpoints, effect: [Regain #heal[hitpoints] equal to the damage dealt.]),
        (icon: icons.condition, effect: [You must succeed a #(save.wisdom)(12) save or suffer short-term #condition.madness.])
      )
    ]
  )
);

#let armorAgathys = (
  cardColor: colors.healCardColor,
  front: template.frontTemplate(
    [#text(size: 0.9em, [Armor of Agathys])],
    [Warlock Spell],
    cardSubtitle: [VSM / Self / Abjuration],
    cardColor: colors.healCardColor,
    cardSymbol: "bonus_action",
    bottomText: [#inlineIcon(icons.duration) 1 hour],
    cardBody: [
      #template.sectionHeading([upon activation])
      #template.effectTable(
        (icon: icons.tempHitpoints, effect: [Receive #heal[+5 temp HP] per Warlock Spell Level.]),
      )

      #template.sectionHeading([while active])
      #template.effectTable(
        (icon: icons.damage.any, effect: [When hit by a melee attacker, deal #damage[5 cold] damage per Warlock Spell Level.]),
      )
      
      #template.sectionHeading([when temp HP depleted])
      The spell ends.
    ]
  )
);

#let mageArmor = (
  cardColor: colors.protectCardColor,
  front: template.frontTemplate(
    [Mage Armor],
    [Warlock Spell],
    cardSubtitle: [VSM / Touch / Abjuration],
    cardColor: colors.protectCardColor,
    cardSymbol: "action",
    bottomText: [#inlineIcon(icons.duration) 8 hours],
    cardBody: [
      Touch a willing creature not wearing armor.
      #template.sectionHeading([while active])
      #template.effectTable(
        (icon: icons.armorClass, effect: [The target's base armor class becomes #defense[13+#smallcaps[DEX]].]),
      )
    ]
  )
);

#let formOfDread = (
  cardColor: colors.healCardColor,
  front: template.frontTemplate(
    [Form of Dread],
    [Warlock (Undead Patron)],
    cardColor: colors.healCardColor,
    cardSymbol: "bonus_action",
    bottomText: [#inlineIcon(icons.duration) 1 minute],
    cardBody: [
      #template.sectionHeading([upon activation])
      Receive #heal[temp HP] equal to
      #v(-0.5em)
      #template.effectTable(
        (icon: icons.tempHitpoints, effect: [#heal[1d10 + Warlock Level]]),
      )

      #template.sectionHeading([while active])
      #template.effectTable(
        (icon: icons.immune, effect: [You are immune to the #condition.frightened condition.]),
      )

      #template.sectionHeading([once per turn])
      On a successful #attack[attack] roll, target failing #(save.wisdom)[] save becomes #condition.frightened until the end of your next turn.
    ]
  )
);

#let conditionMadnessShort = (
  cardColor: colors.conditionCardColor,
  front: template.frontTemplate(
    [#text(size: 0.9em, [Madness (Short)])],
    [Condition],
    bottomText: [#inlineIcon(icons.duration) 1d10 minutes],
    cardColor: colors.conditionCardColor,
    cardBody: [
      #grid(
        columns: (auto, 1fr),
        inset: (bottom: 0.5em),
        // inset: (0pt, (top: 0.2em, bottom: 0.2em)),
        gutter: .25em,
        // stroke: 0.5pt + black,
        align: (left + top, left + top),
        [#text(top-edge: 0.8em, size: 0.8em, font: "Liberation Mono", [#hide[0]1-20 ])], [_Paralyzed_],
        [#text(top-edge: 0.8em, size: 0.8em, font: "Liberation Mono", [21-30 ])], [_Incapacitated_ due to extreme emotions],
        [#text(top-edge: 0.8em, size: 0.8em, font: "Liberation Mono", [31-40 ])], [_Frightened_, must flee],
        [#text(top-edge: 0.8em, size: 0.8em, font: "Liberation Mono", [41-50 ])], [babbling impedes speech, spellcasting],
        [#text(top-edge: 0.8em, size: 0.8em, font: "Liberation Mono", [51-60])], [must attack nearest creature with action],
        [#text(top-edge: 0.8em, size: 0.8em, font: "Liberation Mono", [61-70])], [hallucinate, disadv. to all ability checks],
        [#text(top-edge: 0.8em, size: 0.8em, font: "Liberation Mono", [71-75])], [obey all commands],
        [#text(top-edge: 0.8em, size: 0.8em, font: "Liberation Mono", [76-80])], [irresistable hunger for unusual things],
        [#text(top-edge: 0.8em, size: 0.8em, font: "Liberation Mono", [81-90])], [_Stunned_],
        [#text(top-edge: 0.8em, size: 0.8em, font: "Liberation Mono", [91-100])], [_Unconscious_],
      )
  ]
  )
)

////////////////////////////////////////////////////////////////////////////////

#import "/cards/conditions.typ" as conditionCards

// the cards listed here will appear in the final document
// if you want multiple copies of a card, add multiple entries to the list
#let cards = (
  vampiricStrike,
  cruelty,
  summonPoe,
  armorAgathys,
  mageArmor,
  formOfDread,
  conditionMadnessShort,
  conditionCards.conditionFrightened,
  conditionCards.conditionIncapacitated,
  conditionCards.conditionInvisible,
  conditionCards.conditionParalyzed,
  conditionCards.conditionStunned,
  conditionCards.conditionUnconscious
)