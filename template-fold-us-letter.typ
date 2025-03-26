#let pageMargin = 5mm

#set page(
  paper: "us-letter",
  flipped: true,
  margin: pageMargin
)

#let template(doc) = [
  #doc
]

#let rotated = rotate

#import "@preview/cetz:0.3.0"
#import cetz.draw: *
#import "./design/icons.typ": icons, inlineIcon

#import "/card-descriptions.typ": cards
#import "/design/card-template.typ" as template
#import "/design/d20.typ" as d20

////////////////////////////////////////////////////////////////////////////////

#let rectZeroCentered(width,height, ..rest) = {
  rect((-width/2, -height/2), (width/2, height/2), ..rest)
}

////////////////////////////////////////////////////////////////////////////////

#let cardGuides(cardWidth, cardHeight, cardGapX) = {
  group({
    let strokeWidth = 0.5pt
    stroke((paint: luma(50%), thickness: strokeWidth))
    let strokeWidthCompensation = strokeWidth/2
    let cuttingMachineCompensation = 1mm
    let margin = 2mm
    let allowance = strokeWidthCompensation + cuttingMachineCompensation + margin
    let a = cardWidth / 2 + allowance
    let b = cardHeight / 2 + allowance
    let sx = cardGapX / 2
    let sy = 4mm
    // vert guides
    let left = -a
    let leftMin = left - cardGapX/2 + allowance + 0.3mm
    let leftMax = left + sx
    let right = -left
    let rightMin = -leftMin
    let rightMax = -leftMax

    let bottom = -b
    let bottomMin = bottom - sy/2
    let bottomMax = bottom + sy
    let top = -bottom
    let topMin = -bottomMin
    let topMax = -bottomMax
    
    // vert guides
    line((left, topMin), (left, topMax))
    line((right, topMin), (right, topMax))
    line((left, bottomMin), (left, bottomMax))
    line((right, bottomMin), (right, bottomMax))
    // horiz guides
    line((leftMin, top), (leftMax, top))
    line((leftMin, bottom), (leftMax, bottom))
    line((rightMin, top), (rightMax, top))
    line((rightMin, bottom), (rightMax, bottom))

    rect((-cardWidth/2 - margin, -cardHeight/2 - margin), (cardWidth/2 + margin, cardHeight/2 + margin))

    content((left, bottom), ((right, bottom - 1em)), box(inset: 0.2em, par[#text(8pt, gray)[cut guide #margin.mm()mm margin]]))
  })
}

#let cardTemplatePage(
  cardWidth,
  cardHeight,
  frontBackPairs
) = {
  context {
    let numCards = frontBackPairs.len()
    let width = page.height - pageMargin*2  // width of printable area
    let height = page.width - pageMargin*2  // height of printable area

    let cardGapX  = 8mm                      // distance between cards
    let cardGapY  = 10mm                     // distance from center line to card

    let cardXstep = cardWidth + cardGapX                                   // difference between centerX of adjacent cards
    let allCardsWidth  = numCards * cardWidth + (numCards - 1) * cardGapX  // width of all cards side-to-side, including gaps
    let cardXmin = -allCardsWidth/2 + cardWidth/2                          // centerX of the first card

    box(
      cetz.canvas({
        // global layout
        rectZeroCentered(width, height)    // page border, origin centered
        line((-width/2, 0), (width/2, 0))  // crease line

        // space cards evenly along crease line
        for (i, (front,back)) in frontBackPairs.enumerate() {
          let centerX = cardXmin + i * cardXstep
          let centerYfront = -(cardGapY + cardHeight/2)
          let centerYback  = -centerYfront

          group(name: "frontback", {
            translate((centerX, 0)) // move origin to centerX of card, along crease line

            // front
            group(name: "card-front", {
              translate((0, -centerYfront)) // move origin to (centerX, centerY) of front face
              rectZeroCentered(cardWidth, cardHeight, stroke: none, name: "card")
              content((name: "card"), box(clip: true, width: cardWidth, height: cardHeight, align(center+horizon)[#front]))

              cardGuides(cardWidth, cardHeight, cardGapX)
            })

            // back
            group(name: "card-back", {
              rotate(180deg)
              translate((0, -centerYfront)) // move origin to (centerX, centerY) of front face
              rectZeroCentered(cardWidth, cardHeight, stroke: none, name: "card")
              content((name: "card"), rotated(180deg, box(clip: true, width: cardWidth, height: cardHeight, align(center + horizon)[#back])))

              cardGuides(cardWidth, cardHeight, cardGapX)
            })
          })
        }
      })
    )

    pagebreak()

    box(
      cetz.canvas({
        // global layout
        rectZeroCentered(width, height)    // page border, origin centered
        line((-width/2, 0), (width/2, 0))  // crease line

        rect((-width/2,0), (width/2, -height/2), fill: black)
      })
    )
  }
}

#for cs in cards.chunks(4) {
  cardTemplatePage(
    template.cardWidth,
    template.cardHeight,
    cs.map(c => {
      (front: c.front, back: d20.d20back(c.cardColor))
    })
  )
}