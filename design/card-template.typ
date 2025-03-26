#import "@preview/cetz:0.3.0"
#import cetz.draw: rect, content

#import "./colors.typ" as colors
#import "./icons.typ": icons, inlineIcon

#let cardWidth = 58mm
#let cardHeight = 88mm

#let makeSymbol(c) = [
  #if c == "action" {
    image(icons.action, height: 5mm)
  } else if c == "condition" {
    // todo: reaction or condition
    image(icons.reaction)
  } else if c == "bonus_action" {
    image(icons.bonusAction, height: 5mm)
  } else if c == "channel_divinity" {
    image(icons.channelDivinity, height: 5mm)
  } else if c != none {
    c
  }
]


#let frontTemplate(
  cardTitle,
  cardSideSubtitle,
  cardBody: [],
  cardSubtitle: none,
  cardSymbol: none,
  cardColor: none,
  bottomText: none,
) = {
  let cardMargin = 2mm
  let contentMargin = 1mm
  let cardColor = if cardColor == none { colors.regularCardColor } else { cardColor }
  cetz.canvas({
    // bounding rect
    rect(stroke: none, (0,0), (cardWidth, cardHeight))

    let textColor = white

    // side rect
    let sideWidth  = 1cm
    let sideHeight = cardHeight - cardMargin*2 
    rect(
      (cardMargin,             cardMargin             ),
      (cardMargin + sideWidth, cardMargin + sideHeight),
      // fill: rgb("53b4b1"),
      fill: cardColor,
      stroke: none,
      radius: 2mm,
      name: "side"
    )
    content((name: "side"), angle: 90deg, box([
      #par(justify: false)[
        #text(textColor, 16pt, weight: "bold", font: "Calistoga", cardTitle)
        #linebreak()
      ]
      #v(-3.5mm)
      #par(justify: false)[
        #text(textColor, 9.5pt, font: "P052", cardSideSubtitle)
      ]
      ],
      // stroke: 1pt,
      width: sideHeight,
      height: sideWidth,
      inset: (top: 1.5mm, left: 1.5mm),
    ))
    content((name: "side"), box(
      width: sideWidth,
      height: sideHeight,
      inset: 2.0mm,
      grid(
        columns: (1fr),
        rows: auto,
        align: center + horizon,
        gutter: 0.5em,
        [#makeSymbol(cardSymbol)],
      )
    ))

    // body rect
    let bodyWidth = cardWidth - (cardMargin*2 + contentMargin + sideWidth)
    let bodyHeight = cardHeight - contentMargin - cardMargin
    let bodyLeft = cardMargin + sideWidth + contentMargin
    let bodyRight = bodyLeft + bodyWidth
    let bodyTop  = cardHeight - cardMargin
    let bodyBottom = bodyTop - bodyHeight
    
    rect(
      (bodyLeft, bodyTop),
      (bodyRight, bodyBottom),
      stroke: none,
      name: "body"
    )
    content((name: "body"), angle: 0deg, box(
      [
        // card title
        #par(justify: false, leading: 0.2em, spacing: 0em, text(16pt, weight: "bold", font: "Calistoga", [#cardTitle]))

        // card subtitle
        #if cardSubtitle != none {
          par(leading: 0.2em, spacing: 0.6em, text(9.5pt, colors.lightGray, cardSubtitle))
        }
        // card body
        #block({
          show regex("\badvantage\b"): text.with(colors.darkGreen, weight: "semibold")
          show regex("\bdisadvantage\b"): text.with(colors.darkRed, weight: "semibold")
          text(font: "P052", 9.5pt, cardBody)
        })
        #place(bottom + end, box(inset: (right: 1mm))[#text(0.8em, colors.lightGray, bottomText)])
      ],
      // stroke: 1pt,
      width: bodyWidth,
      height: bodyHeight - 2mm,
      inset: (top: 1.5mm, left: 1.5mm),
    ))
  })
}

#let sectionHeading(c) = block(below: 0.5em)[
  #set text(colors.lightGray, font: "Calistoga")
  #c
]

#let duration(c) = [
  #inlineIcon(icons.duration) #c
]
#let damage(c) = text(colors.darkRed, weight: "semibold", c)
#let heal(c) = text(colors.healColor, weight: "semibold", c)
#let attack(c) = text(colors.darkBlue, weight: "semibold", c)
#let defense(c) = text(colors.darkGreen, weight: "semibold", c)
#let distance(c) = text(colors.darkGreen, weight: "semibold", c)
#let quality(c) = text(colors.darkPurple, weight: "semibold", c)
#let conditionText(c) = text(colors.darkPurple, weight: "semibold", c)
#let emphasis(c) = text(weight: "semibold", c)

#let terms = (
  initiative: emphasis[initiative]
)

#let condition = (
  frightened: conditionText[frightened],
  incapacitated: conditionText[incapacitated],
  prone: conditionText[prone]
)

#let save = (
  wisdom:        (c) => defense[#smallcaps[Wis]#c],
  constitution:  (c) => defense[#smallcaps[Con]#c],
  dexterity:     (c) => defense[#smallcaps[Dex]#c],
  intelligrence: (c) => defense[#smallcaps[Int]#c],
  strength:      (c) => defense[#smallcaps[Str]#c],
  charisma:      (c) => defense[#smallcaps[Cha]#c],
  death:         (c) => defense[#smallcaps[Death]#c],
)

#let effectTable(..rows) = {

  let entries = rows.pos().map(row => {
    (
      // [#box(
      //   height: 1.2em,
      //   // stroke: (thickness: 0.5pt, paint: blue),
      //   baseline: 0.25em,
      //   image(height: 100%, row.icon)
      // )],
      [#box(
        height: 1.2em,
        // stroke: (thickness: 0.5pt, paint: blue),
        // baseline: 0.25em,
        image(height: 100%, row.icon)
      )],
      [#row.effect]
    )
  })

  grid(
    columns: (auto, 1fr),
    inset: (0pt, (top: 0.2em, bottom: 0.2em)),
    gutter: .5em,
    // stroke: 0.5pt + black,
    align: (right + top, left + horizon),
    ..entries.flatten()
  )
}