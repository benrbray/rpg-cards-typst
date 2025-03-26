#let icons = (
  duration: "/icons/icon-duration.svg",
  advantage: "/icons/icon-advantage.svg",
  disadvantage: "/icons/icon-disadvantage.svg",
  action: "/icons/icon-action.svg",
  bonusAction: "/icons/icon-bonus-action.svg",
  reaction: "/icons/icon-reaction.svg",
  hitpoints: "/icons/icon-hitpoints.svg",
  tempHitpoints: "/icons/icon-temp-hitpoints.svg",
  immune: "/icons/icon-immune.svg",
  damage: (
    weapon: "/icons/icon-damage-weapon.svg",
    spell: "/icons/icon-damage-spell.svg",
    any: "/icons/icon-damage-any.svg"
  ),
  attack: (
    weapon: "/icons/icon-attack-weapon.svg",
    spell: "/icons/icon-attack-spell.svg",
    any: "/icons/icon-attack-any.svg"
  ),
  save: (
    any: "/icons/icon-save-any.svg"
  ),
  armorClass: "/icons/icon-armor-class.svg",
  channelDivinity: "/icons/icon-channel-divinity.svg"
)

#let inlineIcon(imgPath) = {
  box(
    height: 1.2em,
    // stroke: (thickness: 0.5pt, paint: blue),
    baseline: 0.25em,
    image(height: 100%, imgPath)
  )
}