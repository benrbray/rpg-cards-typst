#let pageMargin = 5mm

#set page(
  paper: "us-letter",
  flipped: true,
  margin: pageMargin
)

#let template(doc) = [
  #doc
]

#import "/lady-lenore/card-descriptions.typ": cards
#import "/template-fold-us-letter.typ": cardTemplatePage
#import "/design/card-template.typ" as template
#import "/design/d20.typ" as d20


#for cs in cards.chunks(4) {
  cardTemplatePage(
    template.cardWidth,
    template.cardHeight,
    cs.map(c => {
      (front: c.front, back: d20.d20back(c.cardColor))
    })
  )
}