#import "@preview/cetz:0.3.1": canvas, draw, vector, matrix

#set page(width: auto, height: auto, margin: .5cm)

//https://math.stackexchange.com/a/2174667

#let phi = (1 + calc.sqrt(5.0))/2
#let defaultRadius = calc.sqrt(phi + 2)

#let a = 1
#let b = a * phi

#let verts = (
  (0,  -a,  b),
  (b,  0,  a),
  (b,  0,  -a),
  (-b,  0,  -a),
  (-b,  0,  a),
  (-a,  b,  0),
  (a,  b,  0),
  (a,  -b,  0),
  (-a,  -b,  0),
  (0,  -a,  -b),
  (0,  a,  -b),
  (0,  a,  b)
)
#let faces = (
  (2,  3,  7),
  (2,  8,  3),
  (4,  5,  6),
  (5,  4,  9),
  (7,  6,  12),
  (6,  7,  11),
  (10,  11,  3),
  (11,  10,  4),
  (8,  9,  10),
  (9,  8,  1),
  (12,  1,  2),
  (1,  12,  5),
  (7,  3,  11),
  (2,  7,  12),
  (4,  6,  11),
  (6,  5,  12),
  (3,  8,  10),
  (8,  2,  1),
  (4,  10,  9),
  (5,  9,  1),
)

#let renderD20(radius, rx: 0, ry: 0, rz: 0) = {
  import draw: *

  let scale = radius / defaultRadius

  ortho(
    x: 0deg,
    y: 0deg,
    z: 0deg,
    cull-face: "cw",
    {
      rotate(x: rx, y: ry, z: rz)

      // rotate 3d model so top vertex points upwards
      rotate(x: 54deg)
      rotate(y: 54deg)
      rotate(z: 20deg)

      // visualize xyz axes
      // line(stroke: red, (-1,0,0), (1,0,0))
      // line(stroke: blue, (0,-1,0), (0,1,0))
      // line(stroke: green, (0,0,-1), (0,0,1))
      
      // rotate(x: theta, y: rho) // ORIGINAL
      // rotate(x: theta, y: rho)
      stroke((join: "round", cap: "round"))
      for f in faces {
        let vs = f.map(i => verts.at(i - 1).map(v => v * scale))
        merge-path(fill: none, line(close: true, ..vs))
      }
  })
}

#let d20back(
  fillColor,
  secondaryColor: none
) = {
  canvas({
    import draw: *

    if secondaryColor == none {
      secondaryColor = fillColor.lighten(40%)
    }

    // background rounded rect
    rect(fill: secondaryColor, stroke: none, radius: 2mm, (2mm, 2mm), (56mm,86mm))
    rect(fill: fillColor, stroke: none, radius: 2mm, (3.5mm, 3.5mm), (54.5mm,84.5mm))

    // d20 pattern
    let sepX = 1.52
    let sepY = sepX * (calc.sqrt(3) / 2)
    stroke((paint: secondaryColor, thickness: 1.3pt))

    let j = 0
    while j < 8 {
      group({
      rotate(z: 18deg)
      translate(x: 6.5mm, y: -10.6mm)
        translate(y: j * sepY)
        if(calc.rem(j, 2) == 1) {
          translate(x: sepX / 2)
        }
        let i = 0
        while i < 5 {
          group({
            translate((i * sepX, 0, 0))
            renderD20(0.67, rx: i*36deg + j * 36deg, ry: i * 72deg)

            // renderD20(0.75, rx: (i+j)*55deg, ry: i*60deg)
            // renderD20(0.70, rx: i*205deg + j * 55deg, ry: i * 135deg)
            // renderD20(0.70, rx: i*205deg + j * 55deg, ry: i * 135deg, rz: i * 25deg)
            // renderD20(0.70, theta: 0deg + j * 0deg, rho: i * 9deg)
          })
          i += 1
        }
      })
      j += 1
    }

    // white margin, since cetzt doesn't support clip masks
    group({
      fill(white)
      stroke(none)
      let w = 58mm
      let h = 88mm
      let margin = 2.5mm
      rect((0, 0), (w, margin))
      rect((0, h - margin), (w, h))
      rect((0, 0), (margin, h))
      rect((w - margin, 0), (w, h))
    })

    // colored border
    rect(fill: none, stroke: (paint: fillColor, thickness: 1mm), radius: 2mm, (2mm,2mm), (56mm,86mm))

    // card boundary (do not print)
    // rect(fill: none, stroke: (paint: black, thickness: 1pt), (0,0), (58mm,88mm))

    // need a large rect containing everything so that the card is perfectly centered
    let margin = 2.5cm
    rect(fill: none, stroke: (paint: red, thickness: 1pt), (-margin, -margin), (58mm + margin,88mm + margin))
  })
}

#d20back(rgb("53b4b1"))