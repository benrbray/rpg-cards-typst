# README


* You can add new spell cards to `card-descriptions.typ` using the provided examples as a guide.  Make sure to add your cards to the `cards` array so that they appear when printed. 

* `template-fold-us-letter.typ` is the print template.  It imports the `cards` list from `card-descriptions.typ` and lays them out in a grid.  There is a crease line in the center of the page.  Card fronts appear above the line, with card backs below.  Fold on the crease line to align the fronts and backs.  Print double-sided so that the black rectangles on even-numbered pages appear on the _inside_ surface of each card.  This keeps the cards opaque when held up against bright light.

* I used US Letter-sized linen paper for my own cards, so that is the default size.  If you change the paper size to A4, you may need to make some minor adjustments to the layout. 

* When printing, it is important that you disable auto-scaling.  The PDF is exactly the correct size already!  Auto-scaling may cause alignment issues.