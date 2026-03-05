
#let activities = (
  "exercise",
  "deep work",
  "light work",
  "chores",
  "commute",
  "eating",
  "cooking",
  "sleep",
)
#let backgrounds = (
  "silence",
  "socializing",
  "music",
  "podcast / youtube",
  "audiobook",
  "radio",
)


#let cell = it => {
  let content = it
  let color = white
  if type(it) == int {
    let colors = (
      red,
      orange,
      yellow,
      green,
      blue,
    )
    color = colors.at(it - 1).opacify(20%)
    content = text(30pt, fill: white, weight: "bold", str(it))
  }
  box(
    width: 1in,
    height: 1in,
    stroke: 0.1pt,
    fill: color,
    align(center + horizon, content),
  )
}

#let extract-scores = body => context {
  let parse-actions(body) = {
    let extract(it) = {
      ""
      if it == [ ] {
        " "
      } else if type(it) == type(3) {
        str(it)
      } else if it.func() == text {
        it.text
      } else if it.func() == [].func() {
        it.children.map(extract).join()
      }
    }
    extract(body).clusters().map(lower)
  }

  let cells = ([], ..activities)
  let chars = parse-actions(body).filter(it => it in ("1", "2", "3", "4", "5")).map(int)
  let chars-index = 0
  for b in backgrounds {
    cells.push(b)
    for i in range(activities.len()) {
      if chars-index < chars.len() {
        cells.push(chars.at(chars-index))
        chars-index += 1
      } else {
        cells.push([])
      }
    }
  }
  let render = grid(
    rows: backgrounds.len() + 1,
    columns: activities.len() + 1,
    gutter: 0em,
    ..cells.map(cell)
  )
  set page(..measure(render), margin: 0em)
  render
}



#show: extract-scores;



12345

